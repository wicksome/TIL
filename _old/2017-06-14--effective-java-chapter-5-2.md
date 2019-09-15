---
title: 이펙티브자바 5장. 제네릭 (2)
layout: post
date: "2017-06-14T10:00:00+09:00"
path: /blog/effective-java-chapter-5-2
tags: java, effective java
desc: chapter 5. Generics in effective java
draft: false
---

- [규칙 26](#26-가능하면-제네릭-자료형으로-만들-것) - 가능하면 제네릭 자료형으로 만들 것
- [규칙 27](#27-가능하면-제네릭-메서드로-만들-것) - 가능하면 제네릭 메서드로 만들 것
- [규칙 28](#28-한정적-와일드카드를-써서-API-유연성을-높여라) - 한정적 와일드카드를 써서 API 유연성을 높여라
- [규칙 29](#29-) - 형 안전 다형성 컨테이너를 쓰면 어떨지 따져보라

> 아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.
>
> - 조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.
---

## 26. 가능하면 제네릭 자료형으로 만들 것

**제네릭화~gernerification~**

선언부에 type parameter 추가, 관습적으로 자료형을 나타내는 이름 E(규칙 56)

**배열을 사용하는 제네릭 자료형에서 발생하는 오류를 피하는 방법**

실체화 불가능 자료형으로는 배열을 생성할 수 없다(규칙 25).

```java
Stack.java:8 generic array creation
    elements = new E[DEFAULT_INITIAL_CAPACITY];
```

1. Object 배열을 만들어서 제네릭 배열 자료형으로 형변환(cast)

    ```java
    Stack.java:8: warning: [unchecked] unchecked cast
    found   : Object[], required: E[]
            elements = (E[]) new Object[DEFAULT_INITIAL_CAPACITY];
    ```

    cast를 활용하면 컴파일 오류대신 경고가 발생한다. 문법적으로 문제는 없지만, 일반적으로 형 안전성을 보장하는 방법이 아니다.
    하지만 해당 형변환이 프로그램의 형 안전성을 해치지 않는다면 무점검 형변환(unchecked cast)을 한다. 무점검 형전황이 안전함을 증명했다면, 경고를 억제하되 범위는 최소한으로 줄여야 한다(규칙 24).

2. elements의 자료형을 E[]에서 Object[]로 바꾸는 것이다.

    사용하는 곳마다 Object를 E로 cast 해준다.

제네릭 배열 생성 오류를 피하는 방법중 어떤 것을 쓸지는 취향 문제다. 배열을 사용하는 코드가 클래스 이곳저곳에 흩어져 있다면 첫번째 방법으로는 한번만 형변환하면 되지만, 두 번째는 여기저기서 형변환해야 한다. 그래서 첫 번째 방법이 좀 더 보편적으로 쓰인다[Naftalin07, 6.7]

**기타**

- 형인자 자료형에 primitive type은 사용할 수 없다. 자바 제네릭 자료형 시스템의 근본적 한계 때문이다. 이런 제약을 피하려면 개체화된 기본 자료형(boxed primitive type)을 사용하면 된다([규칙 49]()).
- 시간 있을 때마다 기존 자료형을 제네릭 자료형으로 변환하라. 기존 클라이언트 코드를 깨지 않ㄷ고도 새로운 사용자에게 더 좋은 API를 제공할 수 있게 될 것이다([규칙 23]()).
- 형인자를 제한하는 자료형: 아래 코드에서 E를 한정적 형인자(bounded type parameter)라 한다.

    ```java
    <E extends String>
    ```

---

## 27. 가능하면 제네릭 메서드로 만들 것

> 형인자를 선언하는 type parameter list는 메서드의 수정자(modifier)와 반환값 자료형 사이에 둔다.

```java
public static <E> Set<E> union(Set<E> s1, Set<E> s2) {
    Set<E> result = new HashSet<E>(s1);
    result.addAll(s2);
    return result;
}
```

제네릭 메서드를 호출할 때는 형인자는 전달할 필요가 없다. 컴파일러가 메서드에 전해진 인자의 자료형을 보고 형인자의 값을 알아낸다. 이 과정을 자료형 유추(type inference)라 한다.

#### Generic Singleton pattern

**변경이 불가능하지만 많은 자료형에 적용 가능한 객체를 만들어야 할 때 사용.**

제네릭은 자료형 삭제(erasure) 과정을 통해 구현되므로([규칙 25]()) 모든 필요한 형인자화(type parameterization) 과정에 동일 객체를 활용할 수 있는데, 그러려면 우선 필요한 형인자화 과정마다 같은 객체를 나눠주는 정적 팩터리 메서드를 자성해야 한다. 이 패턴은 Collections.reverseOrder 같은 함수 객체([규칙 23]()) 구현에 가장 널리 사용되지만, Collections.emptySet과 같은 컬렉션에도 쓰인다.

```java
public interface UnaryFunction<T> {
    T apply(T arg);
}
```

항등함수: 받은것 그대로 반환하는 함수
제네릭 정적 팰터리 메서드를 사용하면 중복되는 형인자를 제거하여 간결한 코드를 만들 수 있다.

```java
// 제네릭 싱글턴 팩터리 패턴
private static UnaryFunction<Object> IDENTIFY_FUNCTION = new UnaryFunction<Object>() {
    public Object apply(Object arg) {
        return arg;
    }
}

// IDENTIFY_FUNCTION은 무상태 객체고 형인자는 비한정 인자이므로(unbounded)
// 모든 자료형이 같은 객체를 공유해도 안전하다.
@SuppressWarnings("unchecked")
public static <T> UnaryFunction<T> identityFunction() {
    return (UnaryFunction<T>) IDENTIFY_FUNCTION;
}
```

#### Recursive type bound

```java
<T extends Comarable<T>>
```

위 코드처럼 Type parameter의 범위에 자기자신이 포험된 표현으로, 그 범위가 선언되는 것을 말한다.

---

## 28. 한정적 와일드카드를 써서 API 유연성을 높여라

**요약**

- `Comparable`과 `Comparator`는 소비자이다.
- 유연성을 최대화하려면, 객체 생산자~producer~나 소비자~consumer~ 구실을 하는 메서드 인자의 자료형은 와일드 카드 자료형으로 해라.

    ```
    PECS (Produce - Extends, Consumer - Super)
    ```

- 클래스 사용자가 와일드카드 자료형에 대해 고민하게 된다면, 그것은 아마도 클래스 API가 잘못 설계된 탓을 것이다.


*에러가 발생하는 코드*

```java
Stack<Number> numberStack = new Stack<>();
Iterable<Integer> integers = ...;
numberStack.pushAll(integers); // throw exception
```

*해결방안*

```java
public void pushAll(Iterable<? extends E> src) {
    for (E e : src) {
        push(e);
    }
}

public void popAll(Collection<? super E> dst) {
    while (!isEmpty()) {
        dst.add(pop());
    }
}
```

- 모든 자료형은 자기 자신의 *하위 자료형*이다.
- 모든 자료형 E는 자기 자신의 상위 자료형이다([JLS, 4.10]).

**이원성(duality)**

```java
// swap메서드를 선언하는 두 가지 방법
public static <E> void swap(List<E> list, int i, int j);
public static void swap(List<?> list, int i, int j);
```

- 간단한 두번째 방법이 더 바람직하다.
- `List<?>`에는 null 이외의 어떤 값도 넣을 수 없다.


```java
public static void swap(List<?> list, int i, int j) {
    swapHelper(list, i, j);
}

// 와일드카드 자료형을 포착하기 위한 private helper 메서드
private static <E> void swapHelper(List<E> list, int i, int j) {
    list.set(i, list.set(j, list.get(i)));
}
```

---

## 29. 형 안전 다형성 컨테이너를 쓰면 어떨지 따져보라

```java
// 형 안전 다형성(heterogeneous) 컨테이너 패턴 - API
public class Favorites {
    public <T> void putFavorite(Class<T> type, T instance);
    public <T> T getFavority(Class<T> type);
}
```

보통 형인자는 각 키/값에 대해서 하나씩 필요하다. 하지만 `Class` 객체로 좀 더 유연하게 사용할 수 있다. 그런 class 리터럴을 *자료형 토큰(type token)*이라 부른다[Bracha04].

Favorites 객체는 형 안전성을 보장한다. 또한 다형성(heterogeneous)을 갖고 있다. 일반적인 맵과 달리, 모든 키의 자료형이 서로 다르다. 따라서 이러한 클래스를 *형 안전 다형성 컨테이너(typesafe heterogeneous container)*라 부른다.

```java
// 형 안전 다형성(heterogeneous) 컨테이너 패턴 - 구현
public class Favorites {
    private Map<Class<?>, Object> favorites = new HashMap<>();

    public <T> void putFavorite(Class<T> type, T instance) {
        if (type == null) throw new NullPointerException("Type is null");
        favorites.put(type, type.cast(instance)); // 값에 동적형변환을 하는 이유: 형 안전성 확보
    }

    public <T> T getFavority(Class<T> type) {
        return type.cast(favorites.get(type));
    }
}
```

- Favorites 객체는 내부적으로 `private Map<Class<?>, Object>` 형의 favorites 필드를 이용한다. 그런데 비한정적 와일드카드 자료형을 사용했으니 이 맵에는 아무것도 넣을 수 없을 것 같지만, 와일드카드 자료형이 쓰인 곳은 맵이 아니라 키다. 다형성이 드러나는 곳이 이곳이다.
- favorites 맵의 값 자료형이 Object인데, 키와 값 사이의 자료형이 일치되는 것을 보장하지 않는다. 하지만 실제로는 자료형이 같다는 것을 알고 있으므로, 저장된 객체를 꺼낼 때 그 사실을 이용할 수 있다. -> 동적 형변환(dynamic cast)

- Favorites 클래스의 단점으로 실체화 불가능 자료형(non-reifiable type)에는 쓰일 수 없다(규칙 25). 따라서 `String`이나 `String[]`은 저장할 수 있으나 `List<String>`은 저장할 수 없다. 이유는 `List<String>`의 Class 객체를 얻을 수 없기 때문이다.
