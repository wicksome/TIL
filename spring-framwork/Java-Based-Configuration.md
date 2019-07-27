# Java Based Configuration

## 1. Maven dependency
1) `spring-context`와 `spring-webmvc`를 사용한다. spring-boot를 사용하는 경우 `spring-boot-starter-web` 하위에 있기 때문에 따로 추가하지 않아도 된다.

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

2) Java Config를 사용하기 위해서는 서블릿 3.0 이상의 스펙이 필요하다.

```xml
<servlet-api.version>3.0.1</servlet-api.version>
...
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>${servlet-api.version}</version>
</dependency>
```

3) maven-war-plugin 하위에 failOnMissingWebXml을 false로 설정한다.

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-war-plugin</artifactId>
    <version>2.6</version>
    <configuration>
        <failOnMissingWebXml>false</failOnMissingWebXml>
    </configuration>
</plugin>
```

## 2. `servlet-context.xml` 없애기

- `mvc:annotation-driven`은 `@EnableWebMvc`, `task:annotation-driven`은 `@EnableAsync`로 대신한다.
- 빈으로 등록될 오브젝트를 리턴하는 메소드를 만든 후, `@Bean`을 붙여준다.
- 인터셉터를 등록하기 위해서는 `WebMvcConfigurerAdapter`을 상속받아 `addInterceptors()`를 오버라이딩한다.

```java
@Configuration
@EnableWebMvc
@EnableAsync // @Async 어노테이션을 사용하기 위함
@ComponentScan(
    basePachages="com.test",
    excludeFilters=@ComponentScan.Filter(Configuration.class)
)
public class ServletConfig extends WebMvcConfigurerAdapter { // 인터셉터를 추가하기위해 상속
    @Bean
    public ViewResolver viewResolver() {
        ...
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new CorsInterceptor());
    }
    ...
}
```

## 3. `web.xml` 없애기

- `WebApplicationInitializer`를 구현한 `web.xml`을 대신하는 클래스이다.
- [Spring docs-WebApplicationInitialzer](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/WebApplicationInitializer.html)를 참고한다.

```java
public class WebConfig implements WebApplicationInitializer {
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        // 'root' Spring application context를 생성한다.
        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(Config.class);

        // root application context의 생명주기를 관리
        servletContext.addListener(new ContextLoaderListener(rootContext));

        this.addDispatcherServlet(servletContext);
        this.addUtf8CharacterEncodingFilter(servletContext);
    }

    /**
     * Dispatcher Servlet 을 추가한다.
     * @param servletContext
     */
    private void addDispatcherServlet(ServletContext servletContext) {
        AnnotationConfigWebApplicationContext applicationContext = new AnnotationConfigWebApplicationContext();
        //applicationContext.getEnvironment().addActiveProfile("production");
        applicationContext.register(ServletConfig.class);

        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", new DispatcherServlet(applicationContext));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");
        dispatcher.setInitParameter("dispatchOptionsRequest", "true"); // CORS 를 위해서 option request 도 받아들인다.
    }

    /**
     * UTF-8 캐릭터 인코딩 필터를 추가한다.
     * @param servletContext
     */
    private void addUtf8CharacterEncodingFilter(ServletContext servletContext) {
        FilterRegistration.Dynamic filter = servletContext.addFilter("CHARACTER_ENCODING_FILTER", CharacterEncodingFilter.class);
        filter.setInitParameter("encoding", "UTF-8");
        filter.setInitParameter("forceEncoding", "true");
        filter.addMappingForUrlPatterns(null, false, "/*");
    }
}
```

# 참고
- [Spring 3 – XML 없이 Java만 사용해서 설정하기](https://breadmj.wordpress.com/2013/08/04/spring-3-only-java-config-without-xml/)
- [Spring - Java Based Configuration](http://www.tutorialspoint.com/spring/spring_java_based_configuration.htm)
- [스프링 MVC 설정하기](https://blog.outsider.ne.kr/904)