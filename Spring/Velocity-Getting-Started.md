# Velocity 적용하기

## 1. Maven dependency

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-velocity</artifactId>
</dependency>
```

## 2. Add ViewResolver

```java
@ComponentScan
@Configuration
@EnableWebMvc
public class ServletConfig extends WebMvcConfigurerAdapter {
    @Bean(name = "velocityViewResolver")
    public VelocityViewResolver velocityViewResolver(VelocityProperties properties) {
        VelocityViewResolver resolver = new VelocityViewResolver();
        properties.setContentType(MediaType.TEXT_HTML);
        // properties.setCharset(Charset.forName("UTF-8"));
        properties.setDateToolAttribute("dateTool");
        properties.setNumberToolAttribute("numberTool");
        properties.setResourceLoaderPath("/WEB-INF/velocity");
        properties.setProperties(new HashMap<String, String>() {{
            put("input.encoding", "UTF-8");
            put("output.encoding", "UTF-8");
        }});

        properties.applyToViewResolver(resolver);
        return resolver;
    }
}
```

## 3. Update Controller

```java
@RestController
public class DemoController {
    @Value("${application.message:Hello 월드}")
    private String message = "Hello World";

    @RequestMapping("/velocity")
    public ModelAndView velocity() {
        ModelAndView mav = new ModelAndView("welcome");
        mav.addObject("time", new Date());
        mav.addObject("message", this.message);
        return mav;
    }
}
```

# 참고
- http://blog.woniper.net/233