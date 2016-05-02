# 1. Maven dependency

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

# 2. Update web config files

`web.xml`을 수정하면 되지만, 여기서는 java 기반으로 `webConfig.java`를 만들어 설정한다.

```java
public class WebConfig implements WebApplicationInitializer {
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(Config.class);

        // root application context의 생명주기를 관리
        servletContext.addListener(new ContextLoaderListener(rootContext));

        this.addDispatcherServlet(servletContext);
        this.addSecurityFilter(servletContext);
    }

    /**
     * Dispatcher Servlet 을 추가한다.
     * @param servletContext
     */
    private void addDispatcherServlet(ServletContext servletContext) {
        AnnotationConfigWebApplicationContext applicationContext = new AnnotationConfigWebApplicationContext();
        applicationContext.register(ServletConfig.class);

        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", new DispatcherServlet(applicationContext));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");
    }

    /**
     * DelegatingFilterProxy를 설정한다.
     * @param servletContext
     */
    private void addSecurityFilter(ServletContext servletContext) {
        FilterRegistration.Dynamic filter = servletContext.addFilter("springSecurityFilterChain", DelegatingFilterProxy.class);
        filter.addMappingForUrlPatterns(null, false, "/*");
    }
}
```

> **DelegatingFilterProxy 설정**

> ![DelegatingFilterProxy](http://pds24.egloos.com/pds/201202/25/49/d0144949_4f48133da9fd9.png)

> `DelegatingFilterProxy`를 설정하기 위해 `AbstractSecurityWebApplicationInitializer`를 상속받은 클래스를 생성하는 방법과, `WebApplicationInitializer`을 상속받고 코드로 설정하는 방법이 있다. 

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
> [spring boot security](http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-security)

_Question_
> Q. `AbstractSecurityWebApplicationInitializer`은 `WebApplicationInitializer`을 구현하고 있는데, 그렇다면 하나만 만들어야하는가? 아니면 따로따로 만들어야 하는가?

> Q. `AbstractAnnotationConfigDispatcherServletInitializer`를 상속받아 `getRootConfigClasses()`에서 root application context를 선언하면 에러가 발생하는 이유?

> A. spring boot는 root application context, DelegatingFilterProxy를 만들어준다. 그렇기 때문에 따로 선언하지 않는다. 

# 3. Update spring config files

```java
@Configuration
@EnableWebMvc // mvc:annotation-driven
public class ServletConfig extends WebMvcConfigurerAdapter {
	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
        configurer.favorPathExtension(false) //
            .favorParameter(true) //
            .parameterName("format") //
            .ignoreAcceptHeader(true) //
            .useJaf(false) //
            .defaultContentType(MediaType.APPLICATION_JSON) //
            .mediaType("xml", MediaType.APPLICATION_XML) //
            .mediaType("json", MediaType.APPLICATION_JSON);
    }
}
```


# 참고
- [Pre-Authentication Scenarios](https://docs.spring.io/spring-security/site/docs/3.0.x/reference/preauth.html)
- [Spring 3 Security Siteminder Pre-authentication Example](http://howtodoinjava.com/spring/spring-security/spring-3-security-siteminder-pre-authentication-example/)
- [DelegatingFilterProxy 참고](http://egloos.zum.com/springmvc/v/504862)