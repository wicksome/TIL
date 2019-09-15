# Velocity 적용하기

## 1. Maven dependency

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-velocity</artifactId>
</dependency>
```

## 2. Add ViewResolver

`VelocityViewResolver`를 등록한다. `configureViewResolvers`를 오버라이드해서 파라미터인 `ViewResolverRegistry`의 `velocity()`를 호출해도 되지만, 좀 더 명확해서 사용하고자 리졸버를 등록했다. <small>(사실 `velocity()` 하나로 뚝딱 다 해결될까나 싶었지만.. 역시나 직접 설정하는데 속편하다..)</small>

`setDateToolAttribute()`, `setNumberToolAttribute()`는 velocity의 `DateTool`, `NumberTool`을 사용하기위함이다. 각각의 컨트롤러의 Object에 `put("dateTool", new DateTool())`로 추가하는 방법도 있다.

charset은 기본값이 UTF-8로 되어있어 주석처리하였다. `input.encoding`, `output.encoding`는 한글이 깨지지않도록 하는 것이라고 해서 추가했는데 모르겠다. 나중에 필요없으면 지울 예정.

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

## 4. Create view file

```html
<!DOCTYPE html>
<html lang="ko">
## 주석 테스트
<body>
<span>시간:</span>
<ul>
    <li>From controller: $time</li>
    <li>From velocity: $dateTool</li>
    <li>date getYear: $dateTool.getYear()</li>
</ul>
<span>메시지: $message</span>
<span>numberTool: $numberTool.integer(13.4)</span>
</body>

</html>
```

# 참고
- http://blog.woniper.net/233