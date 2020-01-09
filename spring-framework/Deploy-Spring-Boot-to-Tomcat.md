# 외부 톰캣 연동하기

`pom.xml`에서 `jar`를 `war`로 변경하고, 플러그인을 추가한다. 그리고 `Application` 클래스는 `SpringBootServletInitializer`을 상속받고 `configure`를 오버라이딩한다.

**pom.xml**
```xml
<packaging>war</packaging>
...
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-tomcat</artifactId>
        <scope>provided</scope>
    </dependency>
    ...
</dependencies>
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```

**Application.java**
```java
...
@SpringBootApplication
public class Application extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(Application.calss);
    }
    ...
}
```

# 내장 톰캣을 사용할 경우 버전 문제

**내장 톰캣 버전**

| spring boot | tomcat |
|-------------|--------|
|  1.2.4 이상  |    8   |
|  1.2.4 이하  |    7   |

**pom.xml**
```xml
<properties>
    <tomcat.version>8.0.8</tomcat.version>
</properties>
```

# 참고
- http://docs.spring.io/spring-boot/docs/1.1.12.RELEASE/reference/htmlsingle/#howto-use-tomcat-8