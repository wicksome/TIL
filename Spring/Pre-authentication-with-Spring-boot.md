# Pre-authentication with Spring boot

> spring boot에서 pre-authentication을 받는 것으로, 기존의 방법에서 설정하는 방법과 다를 수 있다.

## 1. Maven dependency

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

## 2. Update config files

**Config.java**

```java
@Configuration
@ComponentScan("com.naver.memo.mobile")
public class Config {
    // root config
}
```

**WebConfig.java**

```java
@Configuration
public class WebConfig {

}
```

**SecurityConfig.java**

```java
@ComponentScan("com.naver.memo.mobile")
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

**ServletConfig.java**

```java
@ComponentScan("com.naver.memo.mobile")
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

## 2. Create Filter, UserDetailsService files

`AbstractPreAuthenticatedProcessingFilter`를 상속받아 구현한다. `getPreAuthenticatedPrincipal()`에서 현재 요청으로부터의 주요한 정보를 가져오기 위해 오버라이드한다.

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

```java
@Component
public class CustomUserDetailsService implements AuthenticationUserDetailsService {
    @Override
    public UserDetails loadUserDetails(Authentication authentication) throws UsernameNotFoundException {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        SimpleGrantedAuthority authority = new SimpleGrantedAuthority("ROLE_USER");
        authorities.add(authority);


        String username = authentication.getName();
        UserDetails user = new org.springframework.security.core.userdetails.User(username, "password", authorities);
        return user;
    }
}

```

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