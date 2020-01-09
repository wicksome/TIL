---
title: 이펙티브자바 7장. 메서드 - 2
date: 2017-08-12 11:00:00
tags:
- java
- effective java
desc: chapter 7. Methods
---

[규칙 41](../../../../2017/08/12/methods-2/#규칙-41-오버로딩할-때는-주의하라) - 오버로딩할 때는 주의하라
[규칙 42](../../../../2017/08/12/methods-2/#규칙-42-varargs는-신중히-사용하라) - varargs는 신중히 사용하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 규칙 41. 오버로딩할 때는 주의하라

- 오버로딩: 동일한 이름의 메서드나 생성자를 정의하고, 파라미터의 타입과 갯수만 다르게 정의하는 것
- 오버라이딩: 상위 클래스의 메서드를 재정의하는 것

> **요약**
>
> - 인자 갯수가 같은 오버로딩 메서드를 추가하는 것은 일반적으로 피함
> - 같은 인자를 넘겨 호출했을 때 모든 오버로딩 메서드가 똑같이 동작하도록 해야 한다

*e.g. overloading code*

```java
public class CollectionClassifier {
    public static String classify(Set<?> s) { return "Set"; }
    public static String classify(List<?> lis) { return "List"; }
    public static String classify(Collection<?> c) { return "Unknown Collection"; }

    public static void main(String[] args) {
        Collection<?>[] collections = {
                new HashSet<String>(),
                new ArrayList<BigInteger>(),
                new HashMap<String, String>().values()
        };

        for (Collection<?> c : collections)
            System.out.println(classify(c));
    }
}
```

```java
Unknown Collection
Unknown Collection
Unknown Collection
```

*e.g. override code*

```java
class Wine {
    String name() { return "wine"; }
}

class SparklingWine extends Wine {
    @Override String name() { return "sparkling wine"; }
}

class Champagne extends SparklingWine {
    @Override String name() { return "champagne"; }
}

public class Overriding {
    public static void main(String[] args) {
        Wine[] wines = { new Wine(), new SparklingWine(), new Champagne() };

        for (Wine wine : wines)
            System.out.println(wine.name());
    }
}
```

```java
wine
sparkling wine
champagne
```

**"두 코드의 결과와 차이점은 무엇일까?"**

- 오버로딩된 메서드 가운데 어떤 것이 호출될지는 컴파일 시점에 결정된다.

    위 코드(*overloading code*)에서 각 인자의 실행시점 자료형은 전부 다르겠지만, 선택 과정에는 영향을 끼치지 못한다.

- 오버로딩된 메서드는 static으로 선택되지만, 오버라이딩된 메서드는 dynamic으로 선택된다.
- 오버로딩을 사용할 때는 혼란스럽지 않게 사용할 수 있도록 주의해야 한다.

**"혼란스러운 상황?"**

- 혼란을 피하는 안전하고 보수적인 전략은, 같은 수의 인자를 갖는 두 개의 오버로딩 메서드를 API에 포함시키지 않는 것

**"그럼 작명 패턴을 쓰는 것이 더 낫지 않은가?"**

- 각 메서드에 대응되는 메서드를 정의할 수 있다.

**"생성자에서는?"**

- 정적 팩터리 메서드 사용

#### 또 다른 문제점(autoboxing 도입 후)

```java
public class SetList {
    public static void main(String[] args) {
        Set<Integer> set = new TreeSet<>();
        List<Integer> list = new ArrayList<>();

        for (int i = -3; i < 3; i ++) {
            set.add(i);
            list.add(i);
        }

        for (int i = 0; i < 3; i ++) {
            set.remove(i);
            list.remove(i);
        }
        System.out.println(set + " " + list);
    }
}
```

```java
[-3, -2, -1] [-2, 0, 2]
```

- `list.remove(int)`는 인덱스의 위치를 삭제.
- `list.remove((Integer) i)`로 형변환을 해야 오버로딩된 메서드가 실행된다.
- 이런 상황을 고려하며 코드를 작성하자.

---

## 규칙 42. varargs는 신중히 사용하라

```java
static int sum(int... args){
    for (int arg : args) { ... }
    return result;
}
```

- Java1.5부터 가변 인자 메서드(variable arity method)라고 부르는 varargs 메서드가 추가되었다[JLS, 8.4.1].
- 하나 이상을 받는 메서드를 구현하려면 아래와 같이 사용한다.

    ```java
    static int min(int firstArg, int... remainingArgs) {
        ...
    }
    ```

- 마지막 인자가 배열이라고 해서 무조건 뜯어고칠 생각은 버려라. vaarargs는 정말로 임의 갯수의 인자를 처리할 수 있는 메서드를 만들어야 할 때만 사용하라.
- 성능이 중요한 환경이라면 varargs 사용에 더욱 신중해야 한다. 인자 갯수가 3개 보다 클때 varargs 를 활용하고 나머지는 오버로딩을 하는 것이 좋다.

    ```java
    public void foo() {}
    public void foo(int a1) {}
    public void foo(int a1, int a2) {}
    public void foo(int a1, int a2, int a3) {}
    public void foo(int a1, int a2, int a3, int... rest) {}
    ```
