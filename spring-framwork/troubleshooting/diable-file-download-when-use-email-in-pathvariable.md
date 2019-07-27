# Problem

- `@PathVariable`에 email을 받고 싶은데,
- email의 .(dot)에서 짤리는 문제가 있어서 [이렇게]() 해결했는데, `/{id:.+}`
- `.com`으로 받으니 spring view resolver가 파일 다운로드를 하는 문제가 발생
  - spring의 누가 파일다운로드를 하는지 파악할 것

# Solution

```java
public class ServletConfig extends WebMvcConfigurerAdapter {
  @Override
  public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
    configurer.favorPathExtension(false); // default로 true, 리턴 포맷의 판단 기준을 url을 보고 mediaType을 구한뒤 리턴
    configurer.mediaTypes(new HashMap<String, MediaType>() {
      {
        // URL 끝에 파일 확장자가 있으면 mediaType 생성
        // 없을 경우, Accept 헤더를 보고 mediaType 생성
        put("jpg", MediaType.IMAGE_JPEG);
      }
    });
  }
}
```

TODO:

- 처리 순서
- 동작 원리
- 각 옵션





# 관련 링크

- https://github.com/resthub/resthub-spring-stack/issues/217
- https://spring.io/blog/2013/05/11/content-negotiation-using-spring-mvc
- http://blog.netgloo.com/2015/05/19/spring-boot-avoid-pathvariable-parameters-getting-truncated-on-dots/
- [Spring Framework의 ContentNegotiatingViewResolver에 대하여... (1)](http://zgundam.tistory.com/16)
- [ContentNegotiatingViewResolver vs HttpMessageConverter+ResponseBody Annotation](http://hillert.blogspot.kr/2011/01/rest-with-spring-contentnegotiatingview.html)
