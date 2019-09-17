---
title: 이펙티브자바 5장. 제네릭(1)
layout: post
date: "2017-05-21T10:00:00+09:00"
path: /blog/effective-java-chapter-5-1
tags: java, effective java
desc: chapter 5. Generics in effective java
draft: false
---

- [규칙 23](#23-새-코드에는-무인자-제네릭-자료형을-사용하지-마라) - 새 코드에는 무인자 제네릭 자료형을 사용하지 마라
- [규칙 24](#24-무점검-경고-unchecked-warning-를-제거하라) - 무점검 경고(unchecked warning)를 제거하라
- [규칙 25](#25-배열-대신-리스트를-써라) - 배열 대신 리스트를 써라

> 아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.
>
> - 조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.

#### 제네릭 관련 규칙 목록

용어                                       | 예                                  | 규칙
---------------------------------------- | ---------------------------------- | ------
형인자 자료형~parameterized type~              | `List<String>`                     | 23
실 형인자~actual type parameter~             | `String`                           | 23
제네릭 자료형~generic type~                    | `List<E>`                          | 23, 26
형식 형인자~formal type parameter~            | `E`                                | 23
비한정적 와일드 카드 자료형~unbounded wildcard type~ | `List<?>`                          | 23
무인자 자료형~row type~                        | `List`                             | 23
한정적 형인자~bounded type parameter~          | `<E extends Number>`               | 276
재귀적 형 한정~recursive type bound~           | `<T extends Comparable<T>>`        | 27
한정적 와일드카드 자료형~bounded wildcard type~     | `List<? extends Number>`           | 28
제네릭 메서드~generic method~                  | `static <E> List<E> asList(E[] a)` | 27
자료형 토큰~type token~                       | `String.class`                     | 29

---

## 23. 새 코드에는 무인자 제네릭 자료형을 사용하지 마라

> Java 1.5부터 사용

#### 제네릭~generic~ 클래스/인터페이스 = 제네릭 자료형~generic type~

```java
public interface List<E> {}
```

- 선언부에 형인자~type parameter~가 포함된 클래스나 인터페이스를 말한다[JLS, 8.1.2, 9.1.2].
- "E의 리스트"라고 읽는다.

#### 형인자 자료형~parameterized type~

```java
private final List<String> stringList = ...;
```

- 각 제네릭 자료형은 *형인자 자료형* 집합을 정의한다.
- 이 집합은 이름 뒤에 < 와 > 기호로 감싼 *실 형인자* 목록이 붙은 클래스나 인터페이스 들로 구성되는데, 이 실 인자들은 제네릭 자료형의 *형식 형인자* 각각에 대응된다[JLS, 4.4, 4.5].
- 컴파일 할 때 어떤 경고도 뜨지 않아야(또는, suppressing 경고가 없어야 - 규칙 24 참조) 한다.

#### 무인자 자료형~raw type~

```java
private final List stringList = ...;
```

- 무인자 자료형은 실 형인자 없이 사용되는 제네릭 자료형이다[JLS, 4.8].
- 위 코드에서 `List`가 무인자 자료형(stringList는 String 객체만 보관되는데 형인자 자료형을 정의하지 않음)
    <div class="tip">
        <b><code>List</code> vs <code>List&lt;Object&gt;</code></b>
        <ul>
            <li><code>List</code>: 형 검사 절차를 완전히 생략</li>
            <li><code>List&lt;Object&gt;</code>: 아무 객체나 넣을 수 있다는 것을 컴파일에게 알림</li>
        </ul>
    </div>
- **이렇게 사용하지 말자**(엉뚱한 자료형의 객체를 넣어도 컴파일 시에는 문제가 없다).
- 무인자 자료형을 쓰면 형 안전성이 사라지고, 제네릭의 장점 중 하나인 표현력~expreesiveness~ 측면에서 손해를 보게 된다.
    - 이전 호환성~migration compatibility~으로 알려지니 이 요구사항 때문에 무인자 자료형을 지원할 뿐

#### 비한정적 와일드카드 자료형~unbounded wildcard type~

```java
static int numElementsInCommon(Set<?> s1, Set<?> s2) {
    int result = 0;
    for (Object o1: s1)
        if (s2.contains(o1))
            result++;
    return result;
}
```

- 제네릭 자료형을 쓰고 싶으나 실제 형 인자가 무엇인지 모르거나 신경 쓰고 싶지 않을 때 '?' 사용
- 그러나, Collection<?>에는 null 이외의 어떤 원소도 넣을 수 없다
    - (옮긴이) 어떤 자료형의 객체를 담는 컬렉션인지 알 방법이 없기 때문이다.
    - TODO: 자세한 내용 확인해볼 것

#### 예외

제네릭 자료형 정보가 프로그램이 실행될 때는 지워지기 때문에(타입소거~type erasure~) 생긴 예외들(규칙 25)

**클래스 리터럴~class literal~에는 반드시 무인자 자료형을 사용해야 한다.**

```java
// 가능
List.class
String[].class // 배열 자료형 가능
int.class // 기본 자료형 가능

// 불가능
List<String>.class
List<?>.class
```

- 자바 표준에 따르면, 클래스 리터럴에는 형인자 자료형을 쓸 수 없다[JLS, 15.8.2].

**제네릭 자료형에 instanceof 연산자를 적용할 때는 다음과 같이 하는 것이 좋다.**

```java
if (o instanceof Set) {     // 무인자 자료형
    Set<?> m = (Set<?>) o;  // 와일드카드 자료형
}
```

- 실행시 타입소거되기 때문에, instanceof 연산자를 비한정적 와일드 카드 자료형이 이외의 형인자 자료형에 적용할 수 없다.
- 무인자 자료형 대신 비한정적 와일드카드 자료형을 쓴다고 해서 instanceof 연산자가 다르게 동작하는 것은 아니다.
- 따라서 <?>를 붙혀봐야 코드만 지저분해질 뿐이다.

---

## 24. 무점검 경고(unchecked warning)를 제거하라

> 무점검 경고~unchecked warning~는 중요하다. 무시하지 마라.

- 모든 무점검 경고는 가능하다면 없애야 한다.
    - 전부 없애고 나면 코드의 형 안전서이 보장되는 것
    - 실행 도중 ClassCastException이 발생하지 않을 것
- 제거할 수 없는 경고 메시지는 형 안전성이 확실할 때만 @SupressWarnings("unchecked") 어노테이션을 사용해 억제한다
    - SupressWarnings 어노테이션은 가능한 작은 범위에 적용하라.
    - SupressWarnings 어노테이션은 return 문에는 붙일 수 없는데, 선언문이 아니기 떄문이다[[JLS, 9.7](https://docs.oracle.com/javase/specs/jls/se8/html/jls-9.html#jls-9.7)].
- @SupressWarnings("unchecked") 어노테이션을 사용할 때마다, 왜 형 안정성을 위반하지 않는지 밝히는 주석을 반드시 붙여라

---

## 25. 배열 대신 리스트를 써라

#### 배열 vs 제네릭 자료형

- 배열은 *공변 자료형~covariant~*: `class Sub extends Super {}`일 때, `Sub[]`도 `Super[]`의 하위 자료형이다.
- 제네릭은 *불변 자료형~invariant~*: `List<Sub>`은 `List<Super>`의 하위 자료형이 될 수 없다.

아래 코드와 같이, 배열의 경우에는 문법적으로는 문제가 없어 실행중에 예외가 발생하고, 제네릭은 컴파일이 되지 않는다. 즉, 제네릭보다 배열이 취약하다(컴파일시에 문제를 발견하는 편이 더 낫다).

```java
// 실행중에 예외 발생
Object[] objectArray = new Long[1];
objectArray[0] = "I dont's fit in"; // ArrayStoreException 발생

// 컴파일 되지 않는 코드
List<Object> ol = new ArrayList<Long>(); // 자료형 불일치
ol.add("I don't fit in");
```

- 배열은 *실체화~reification~* 되는 자료형이다[[JLS, 4.7](https://docs.oracle.com/javase/specs/jls/se8/html/jls-4.html#jls-4.7)].
    - 즉, 배열의 각 원소의 자료형은 실행시간에 결정
- 제네릭은 삭제~erasure~ 과정을 통해 구현된다[[JLS, 4.6](https://docs.oracle.com/javase/specs/jls/se8/html/jls-4.html#jls-4.6)].

#### generic array creation 오류

```java
new List<E>[]
new List<String>[]
new E[]
```

위 코드는 전부 컴파일되지 않는다. 컴파일하려고 하면 `getneric array creation` 오류가 발생할 것이다.
