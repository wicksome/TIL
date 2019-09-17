---
title: 이펙티브자바 8장. 일반적인 프로그래밍 원칙들 - 1
date: 2017-09-16 10:00:00
tags:
- java
- effective java
desc: chapter 8. gerneral programming in effective java
---

[규칙 45](../../../../2017/09/16/general-programming-1/#45-지역-변수의-유효범위를-최소화하라) - 지역 변수의 유효범위를 최소화하라
[규칙 46](../../../../2017/09/16/general-programming-1/#46-for문보다는-for-each문을-사용하라) - for문보다는 for-each문을 사용하라
[규칙 47](../../../../2017/09/16/general-programming-1/#47-어떤-라이브러리가-있는지-파악하고-적절히-활용하라) - 어떤 라이브러리가 있는지 파악하고 적절히 활용하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 45. 지역 변수의 유효범위를 최소화하라

#### 처음 사용하는 곳에서 선언하라

- 사용하기 전에(처음 사용하는 곳 말고 이전에) 선언하면 실제 사용될 때쯤 그 변수의 자료형과 초깃값이 무엇이었는지 잊어버린다
- 너무 빨리 선언하면 유효범위가 너무 커진다.

#### 거의 모든 지역 변수 선언에는 초깃값(initalizer)이 표함되어야 한다

- while문보다는 for문을 쓰는 것이 좋다. -> 순환문 변수(loop variable)을 사용할 수 있기 때문
- `try-catch`: 특정값이 catch에서 초기화해야 하는 경우와 같은 코드에서는 예외

**유효범위를 최소화하는 숙어**

```java
for (int i = 0; n = expensiveComputation(); i < n; i++>) {
    doSomthing(i);
}
```

- 두 개의 순환문 변수가 사용됨, `i`와 `n`의 유효범위는 정확히 for문으로 제한
- `expensiveComputation()`의 비용이 크고, 매번 안에서 재계산할 필요가 없어짐

#### 메서드의 크기를 줄이고 특정한 기능에 집중하라

- 두 가지 서로 다른 기능을 넣지 말자
- 각 기능을 나눠서 별도 메서드로 구현하자

#### i.e

- 지역 변수의 유효범위를 최소화하면 가독성(readability)과 유지보수성(maintainability)이 좋아지고, 오류 발생 가능성도 줄어든다.

---

## 46. for문보다는 for-each문을 사용하라

```java
// 컬렉션이나 배열을 순회할 때는 이 숙어를 따르자
for (Element e : elements) {
    doSomething(e);
}
```

- java 1.5부터 도입된 for-each문은 성가신 코드를 제거하고 반복자나 첨자 변수를 제거해서 오류 가능성을 없앤다
- for-each에서 `:` 기호는 "in"이라고 읽는다
- for문에 비해 명료하고 버그 발생 가능성도 적으며, 성능도 for문에 뒤지지 않는다.
- for-each의 장점은 여러 컬렉션에 중첩되는 순환문을 만들어야 할 때 더 빛이 난다.

    ```java
    // 굉장히 간결하다
    for (Suit suit : suits) {
        for (Rank rank : ranks) {
            deck.add(new Card(suit, rank));
        }
    }
    ```

- Iterable 인터페이스를 구현하면 for-each를 사용할 수 있다.

    ```java
    public interface Iterable<E> {
        // 이 Iterable 안에 있는 원소들에 대한 반복자 반환
        Iteraor<E> iterator();
    }
    ```

**for-each를 적용할 수 없는 경우**

1. Filtering: 순회하다가 특정 원소를 삭제하기 위해 `remove()`를 호출해야하므로
2. Transforming: 원소 일부의 값을 변환하기 위해 리스트 반복자나 배열 첨자가 필요하므로
3. Parallel iteration: 병렬적으로 순회해야 하고 모든 반복자나 첨자 변수가 발맞춰 나아가도록 구현해야 한다면 반복자나 첨자 변수를 명시적으로 제어할 필요가 있을 것이므로

---

## 47. 어떤 라이브러리가 있는지 파악하고 적절히 활용하라

> 바퀴를 다시 발명하지 말라(Don't reinvent the wheel)

표준 라이브러리를 사용하면,

- 일과 큰 관련성 없는 문제에 대한 해결 방법을 구현하는데 시간을 소비하지 않는다
- 별다른 노력을 하지 않아도 그 성능은 점차 개선된다
- 새로운 기능이 추가된다
- 팀원과 같은 코드를 사용하게 되기 때문에 가독성, 유지보수, 재사용성이 높아진다

표준 라이브러리를 사용하기 위해,

- 중요한 새 릴리즈가 나올 때마다 어떤 기능이 추가되었는지 알아두자
- 다 공부할 순 없지만 핵심 혹은 개발 관련 라이브러리는 알아두자(`java.lang`, `java.util.*`, `java.util.collections`, `java.util.concurrent`, ...)