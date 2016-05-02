# 외부 톰캣 사용시

클래스명은 프로젝트마다 다를 수 있다.

1. `configure`
```java
@SpringBootApplication
public class Application extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        ...
    }
    ...
```
2. `configureContectNegotiation`
```java
public class WebConfig extends WebMvcConfigurerAdaper {
    @Override
    public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
        ...
    }
}
```
3. `configure`
```java
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        ...
    }
    ...
}
```
4. RequestMapping