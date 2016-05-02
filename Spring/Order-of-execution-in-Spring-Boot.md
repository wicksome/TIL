# 외부 톰캣 사용시

클래스명은 프로젝트마다 다를 수 있다.

1. **_WebApplicationInitializer_**: `onStartup`
```java
public class WebConfig implements WebApplicationInitializer {
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        ...
    }
}
```

2. **_SpringBootServletInitializer_**: `configure`
```java
@SpringBootApplication
public class Application extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        ...
    }
    ...
```

3. **_WebMvcConfigurerAdaper_**: `configureContectNegotiation`
```java
public class ServletConfig extends WebMvcConfigurerAdaper {
    @Override
    public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
        ...
    }
}
```

4. **_WebSecurityConfigurerAdapter_**: `configure`
```java
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        ...
    }
    ...
}
```

5. RequestMapping