# Spirng Security

## 스프링 MVC 웹 보안 활성화
`@EnableWebSecurity` 로 웹 보안을 활성화한다. 애너테이션과 함께, 스프링 시큐리티가 `WebSecurityConfigurer`를 구현하거나, `WebSecurityConfigurerAdapoter`(자주 쓰이는 방법)를 확장한 빈으로 설정되어야 한다.

**pom.xml**
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

**SecurityConfig.java**
```java
...
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
...
}
```

> **~~@EnableWebMvcSecurity~~**보다 **@EnableWebSecurity** 권장

> `@EnableWebMvcSecurity`는 스프링 MVC 인수 결정자를 설정하며, 핸들러 메소드가 `@AuthenticationPrincipal`이 붙은 인자를 사용하여 인증한 사용자 주체를 받는다. 또한 자동으로 숨겨진 사이트 간 요청 위조(CSRF, Cross-Site Request Forgery) 토큰 필드를 스프링의 폼 바인딩 태그 라이브러리를 사용하여 추가하는 빈을 설정한다. 하지만, 스프링 시큐리티 4.0부터는 `@EnableWebSecurity`만으로도 가능하기 때문에 `@EnableWebSecurity`을 사용을 권장한다.

`WebSecurityConfigurerAdapter`의 세 가지 `configurer()` 오버라이딩을 통해 설정을 변경할 수 있다.

|                메소드                   |             설명                     |
|---------------------------------------|-------------------------------------|
|configure(WebSecurity)                 | 스프링 시큐리티의 필터 연결을 설정           |
|configure(httpSecutiry                 | 인터셉터로 요청을 안전하게 보호하는 방법을 설정 |
|configure(AuthenticationManagerBuilder)| 사용자 세부 서비스를 설정                 |

_작성중_

# 참고
- [Getting Started · Securing a Web Application](https://spring.io/guides/gs/securing-web/)
- [Code Base Spring Security 기본](http://netframework.tistory.com/entry/Code-Base-Spring-Security-%EA%B8%B0%EB%B3%B8)
- [](https://docs.spring.io/spring-security/site/docs/current/reference/html/mvc.html)
- [Pre-Authentication Scenarios](https://docs.spring.io/spring-security/site/docs/3.0.x/reference/preauth.html)