---
title: 이펙티브자바 8장. 일반적인 프로그래밍 원칙들 - 3
date: 2017-10-27 10:50:00
tags:
- java
- effective java
desc: chapter 8. gerneral programming in effective java
---

[규칙 51](../../../../2017/10/27/general-programming-3/#51-문자열-연결-시-성능에-주의하라) - 문자열 연결 시 성능에 주의하라
[규칙 52](../../../../2017/10/27/general-programming-3/#52-객체를-참조할-때는-그-인터페이스를-사용하라) - 객체를 참조할 때는 그 인터페이스를 사용하라
[규칙 53](../../../../2017/10/27/general-programming-3/#53-리플렉션-대신-인터페이스를-이용하라) - 리플렉션 대신 인터페이스를 이용하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 51. 문자열 연결 시 성능에 주의하라

- 문자열을 연결할 때는 `String`보다 `StringBuilder`의 `append()`를 사용하라.
- n개의 문자열에 연결 연산자를 반복 적용해서 연결하는 데 드는 시간은 n<sup>2</sup>에 비례한다 - 문자열은 변경 불가능하기 때문(규칙 15)
- http://www.pellegrino.link/2015/08/22/string-concatenation-with-java-8.html

---

## 52. 객체를 참조할 때는 그 인터페이스를 사용하라

- 적당한 인터페이스나 자료형이 있다면 Parameter, Return value, Variable, Field의 자료형은 클래스 대신 인터페이스로 선언하자.
- 인터페이스를 자료형으로 쓰는 습관을 들이면 프로그램은 더욱 유연해진다.
    - 구현체를 변경할 경우, 인터페이스의 일반 규약에 없는 특별한 기능을 제공하고 있었고, 그것을 코드에서 사용하고 있었다면 새로운 구현체에도 같은 기능을 제공해야 한다.
    - 특별한 기능을 이용하도록 코드를 작성했다면, 변수를 선언할 때 그 사실을 주석으로 남겨야 한다.
- 적당한 인터페이스가 없는 경우에는 객체를 클래스로 참조하는 것이 당연하다.
- 클래스 기반 프레임워크(class-based framework)에 속한 객체는, 구현 클래스 대신에 보통 abstract인 기반 클래스(base class)로 참조하는 것이 바람직하다(e.g. java.util.TimerTask).

---

## 53. 리플렉션 대신 인터페이스를 이용하라

#### 리플렉션의 단점

-  type checking, exception checking 불가능
- 가독성 떨어짐
- 성능이 떨어짐

#### 핵심

- 객체 생성은 리플렉션으로 하고 객체 참조는 인터페이스나 상위클래스를 통하라
- 일반적인 프로그램은 런타임중에 리플렉션을 통해 객체를 이용하려 하지말아라.
- NoArgsConstructor를 호출할때는 java.lang.relect를 이용할 필요도 없다. Class.newInstance()를 호출하는 것으로 충분하다.
- 리플렉션을 아주 제한적으로만 사용하면 오버헤드는 피하면서도 리플렉션의 다양한 장점을 누릴 수 있다.

```java
public static void main(String[] args) {
    Class<?> cl = null;
    try {
        cl = Class.forName(args[0]);
    } catch(ClassNotFoundException e) {
        System.err.println(“Class not found.”);
    }

    Set<String> s = null;
    try {
        s = (Set<String>) cl.newInstance();
    } catch(IllegalAccessException | InstantiationException a) {
        // ...
    }

    s.addAll(Arrays.asList(args).subList(1, args.length));
    System.out.println(s);
}
```

- 객체 사용은 인터페이스인 Set을 사용하고, 객체는 리플렉션으로 생성한다.
- Set의 구현체에 따라 정렬을 달리 사용할 수 있다.