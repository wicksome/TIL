# Pre-authentication with Spring boot

> spring boot에서 pre-authentication을 받는 것으로, 기존의 방법에서 설정하는 방법과 다를 수 있다.

> 다시 확인해보니까 잘못된 부분(헤더로 검사하는 것인지, pre-auth가 제대로 되고 있는건지 확인)이 있는것 같다. 다시 확인해보고 보완할 것.

## 1. Maven dependency

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

## 2. Update config files

각 설정을들 `xml`로 지정할 수 있지만, 나는 `java config`로 설정하겠다<small>(삽질의 시작)</small>. 

**_Config.java_**

`Config.java`는 `root-config`로 공통적으로 사용할 config들을 모아놓을 곳이다.

```java
@Configuration
@ComponentScan
public class Config {
    // root config
}
```

**_WebConfig.java_**

`WebConfig.java`는 `web.xml`을 대신할 용도로 사용할 것이다. 원래는 `WebApplicationInitializer`을 확장해서 디스패처, 맵핑 등 설정을 하지만 spring-boot에서는 알아서 해주므로 아무것도 상속,구현하지 않고 필요할때 `bean` 등록해서 사용할 것이다.

```java
@Configuration
public class WebConfig {

}
```

**_SecurityConfig.java_**

Spring Security의 핵심적인 config파일이다. pre-authentication하기 위해서 필터를 등록한다.

```java
@ComponentScan
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Bean
    public RequestHeaderAuthenticationFilter siteminderFilter() throws Exception {
        RequestHeaderAuthenticationFilter filter = new RequestHeaderAuthenticationFilter();
        filter.setAuthenticationManager(authenticationManager());
        filter.setPrincipalRequestHeader("SM_USER");
        return filter;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.addFilterBefore(new PreAuthenticatedFilter(), AbstractPreAuthenticatedProcessingFilter.class);
        http.addFilterBefore(siteminderFilter(), RequestHeaderAuthenticationFilter.class);

        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        http.authorizeRequests().anyRequest().authenticated();
    }
}
```

**_ServletConfig.java_**

`servlet-context.xml`을 대신할 java config 파일이다.

```java
@ComponentScan
@Configuration
@EnableWebMvc
public class ServletConfig extends WebMvcConfigurerAdapter {
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.enableContentNegotiation(new JstlView());
        registry.jsp("/WEB-INF/jsp/", ".jsp");
    }
}
```

> pre-authentication을 위해서 여러 설정(`web.xml`, conf files)을 해야하지만, Spring boot를 사용하면 알아서 해준다.
예를 들어, `web.xml`에서 root-context 등록, 리스너 등록, 디스패처 등록, `DelegatingFilterProxy` 설정 등을 할 필요가 없고, `DelegatingFilterProxy`를 설정하기 위한 여러 방법(java config, `WebApplicationInitializer`, `AbstractSecurityWebApplicationInitializer`) 모두 필요 없다. <small>(이틀동안의 삽질..)</small>

## 2. Extend PreAuth-Filter file

`AbstractPreAuthenticatedProcessingFilter`를 상속받아 구현한다. `getPreAuthenticatedPrincipal()`에서 현재 요청으로부터의 원하는 정보를 가져오기 위해 오버라이드한다. 

> TODO: `AuthenticationManager`, `Provider` 등 어떻게 실행되고, 어떤 구조로 이루어져 있는지 알아보자

```java
public class PreAuthenticatedFilter extends AbstractPreAuthenticatedProcessingFilter {
    @Override
    protected Object getPreAuthenticatedPrincipal(HttpServletRequest request) {
        PreAuthenticatedAuthenticationProvider provider = new PreAuthenticatedAuthenticationProvider();
        provider.setPreAuthenticatedUserDetailsService(new CustomUserDetailsService());
        setAuthenticationManager(new ProviderManager(Arrays.asList(new AuthenticationProvider[] {provider})));

        Object user = request.getHeader("SM_USER");
        return user;
    }

    @Override
    protected Object getPreAuthenticatedCredentials(HttpServletRequest request) {
        return "";
    }
}
```

## 3. Implement UserDetailsService file

`PreAuthenticatedFilter`에서 등록한 `UserDetailsService`이다.

> TODO: `AuthenticationUserDetailsService`의 `loadUserDetails()`를 구현하는 것과, `UserDetailsService`의 `loadUserByUsername()`을 구현하는 것의 차이점을 알아보자.

```java
@Component
public class CustomUserDetailsService implements AuthenticationUserDetailsService {
    @Override
    public UserDetails loadUserDetails(Authentication authentication) throws UsernameNotFoundException {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        SimpleGrantedAuthority authority = new SimpleGrantedAuthority("ROLE_USER");
        authorities.add(authority);

        String username = authentication.getName();
        UserDetails user = new User(username, "password", authorities);
        return user;
    }
}

```

## 4. Test

PostMan으로 `Headers`에 아무 값도 없는 요청과, `SM_USER`을 넣은 요청을 보내보자.

> 테스트하고 돌아가는 것을 확인했다. 하지만 솔직히 제대로 돌아가는 것인지 모르겠다. 엄청난 삽질을 하면서 얻은 결과이지만, 아직 완벽하게 이해한 코드는 아니기 때문이다...ㅠㅠ 우선 기록해놓고 나중에 다른 부분이 있으면 수정하자..

# 호출 순서

- `FilterChainProxy` 내부
 - `doFilter`: 등록된 필터의 `doFilter()` 호출
- `AbstractPreAuthenticatedProcessingFilter` 내부
 - `doAuthenticate()` 호출
 - `AuthenticationManager`의 `authenticate()` 호출
- `ProviderManager`에서 `AuthenticationProvider`의 `authenticate()` 호출(`ProviderManager`는 `AuthenticationManager`의 구현체)
- 



# 참고

## DelegatingFilterProxy 설정

> `DelegatingFilterProxy`를 설정하기 위해 `AbstractSecurityWebApplicationInitializer`를 상속받은 클래스를 생성하는 방법과, `WebApplicationInitializer`을 상속받고 코드로 설정하는 방법이 있다. 

> ![DelegatingFilterProxy](http://pds24.egloos.com/pds/201202/25/49/d0144949_4f48133da9fd9.png)

> 하지만, spring boot는 다~ 필요없다.

> _방법 1_
> ```java
public class WebConfig implements WebApplicationInitializer {
@Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        ...
        this.addSecurityFilter(servletContext);
    }
    private void addSecurityFilter(ServletContext servletContext) {
        FilterRegistration.Dynamic filter = servletContext.addFilter("springSecurityFilterChain", DelegatingFilterProxy.class);
        filter.addMappingForUrlPatterns(null, false, "/*");
    }
    ...
}
> ```

> _방법 2_
> ```java
public class SecurityInitializer extends AbstractSecurityWebApplicationInitializer {
    ...
}
> ```

## addFilterBefore vs addFilterAfter

## 사이트
- [Pre-Authentication Scenarios](https://docs.spring.io/spring-security/site/docs/4.0.x/reference/html/preauth.html#abstractpreauthenticatedprocessingfilter)
- [Spring Security Pre-Authentication and Authorization using Java Configurations](http://www.learningthegoodstuff.com/2014/12/spring-security-pre-authentication-and.html)
- [Spring 3 Security Siteminder Pre-authentication Example](http://howtodoinjava.com/spring/spring-security/spring-3-security-siteminder-pre-authentication-example/)
- [DelegatingFilterProxy 참고](http://egloos.zum.com/springmvc/v/504862)
- [Spring Security Session Management](http://www.baeldung.com/spring-security-session)