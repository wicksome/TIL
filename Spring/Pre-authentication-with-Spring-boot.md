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
@Slf4j
public class Config {
    // root config
}
```

**WebConfig.java**

```java
@Configuration
@Slf4j
public class WebConfig {

}
```

**SecurityConfig.java**

```java
@ComponentScan("com.naver.memo.mobile")
@EnableWebSecurity
@Slf4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        super.configure(http);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.inMemoryAuthentication()
            .withUser("user").password("password").roles("USER").and()
            .withUser("admin").password("password").roles("USER", "ADMIN");
    }
}
```

**ServletConfig.java**

```java
@ComponentScan("com.naver.memo.mobile")
@Configuration
@EnableWebMvc
@Slf4j
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

## 2. Filter 구현

`AbstractPreAuthenticatedProcessingFilter`를 상속받아 구현한다.



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

## 사이트
- [Pre-Authentication Scenarios](https://docs.spring.io/spring-security/site/docs/4.0.x/reference/html/preauth.html#abstractpreauthenticatedprocessingfilter)
- [Spring Security Pre-Authentication and Authorization using Java Configurations](http://www.learningthegoodstuff.com/2014/12/spring-security-pre-authentication-and.html)
- [Spring 3 Security Siteminder Pre-authentication Example](http://howtodoinjava.com/spring/spring-security/spring-3-security-siteminder-pre-authentication-example/)
- [DelegatingFilterProxy 참고](http://egloos.zum.com/springmvc/v/504862)