# WebClient 로깅방법

## 1. 로깅 옵션 추가

`application.yaml`에 아래와 같이 추가하면 로그 출력

```yaml
logging.level.org.springframework.web.reactive.function.client.ExchangeFunctions=DEBUG
```

```
2020-04-24 15:54:31.166 TRACE 74534 --- [] [    Test worker] o.s.w.r.f.client.ExchangeFunctions  : [c0965a3] HTTP POST http://www.naver.com, headers={masked}
2020-04-24 15:54:31.895 TRACE 74534 --- [] [ctor-http-nio-1] o.s.w.r.f.client.ExchangeFunctions  : [c0965a3] Response 200 OK, headers={masked}
```

## 2. `{masked}` 변환하기

`enableLoggingRequestDetails` 값을 `true`로 설정

```kt
var client = WebClient.builder()
  .codecs { it.defaultCodecs().enableLoggingRequestDetails(true) }
  .baseUrl("http://$_talktalkHostUrl")
  .build()
```

```
2020-04-24 15:59:09.739 TRACE 77660 --- [] [    Test worker] o.s.w.r.f.client.ExchangeFunctions       : [76459f60] HTTP POST http://www.naver.com, headers=[Content-Type:"application/json", Accept:"application/json"]
2020-04-24 15:59:10.673 TRACE 77660 --- [] [ctor-http-nio-1] o.s.w.r.f.client.ExchangeFunctions       : [76459f60] Response 200 OK, headers=[Server:"nginx", Date:"Fri, 24 Apr 2020 06:59:10 GMT", Content-Type:"application/json;charset=UTF-8", Transfer-Encoding:"chunked"]
```


## 참고

- https://docs.spring.io/spring/docs/current/spring-framework-reference/web-reactive.html#webflux-logging-sensitive-data
- https://stackoverflow.com/questions/46154994/how-to-log-spring-5-webclient-call
