---
title: 이펙티브자바 6장. 열거형과 어노테이션 - 1
date: 2017-08-05 10:00:00
tags:
- java
- effective java
desc: chapter 6. Enums and Annotations in effective java
---

[규칙 30](../../../../2017/08/05/enums-and-annotations-1/#규칙-30-int-상수-대신-enum을-사용하라) - int 상수 대신 enum을 사용하라
[규칙 31](../../../../2017/08/05/enums-and-annotations-1/#규칙-31-ordinal-대신-객체-필드를-사용하라) - ordinal 대신 객체 필드를 사용하라
[규칙 32](../../../../2017/08/05/enums-and-annotations-1/#규칙-32-비트-필드-bit-field-대신-EnumSet을-사용하라) - 비트 필드(bit field) 대신 EnumSet을 사용하라
[규칙 33](../../../../2017/08/05/enums-and-annotations-1/#규칙-33-ordinal을-배열-첨자로-사용하는-대신-EnumMap을-이용하라) - ordinal을 배열 첨자로 사용하는 대신 EnumMap을 이용하라
[규칙 34](../../../../2017/08/05/enums-and-annotations-1/#규칙-34-확장-가능한-enum을-만들어야-한다면-인터페이스를-이용하라) - 확장 가능한 enum을 만들어야 한다면 인터페이스를 이용하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 규칙 30. int 상수 대신 enum을 사용하라

```java
public static final int APPLE_FUJI = 0;
public static final int APPLE_PIPPIN = 1;
```

예전처럼 int/String enum 패턴을 사용하면,

- 상수의 값이 바뀌면 클라이언트도 다시 컴파일 해야한다
- 디버깅이 어렵다(문자열로 변환해야하는 번거로움)

#### enum 자료형

```java
public enum Apple { FUJI, PIPPIN }
```

- 자료형의 개체 수는 엄격히 통제된다(규칙 1)
- 싱글턴 패턴을 일반화한 것이다(규칙 3)
- 형안정 enum 패턴(typesafe enum pattern)을 자바 문법에 포함시킨 것이다(규칙 21)
- 임의의 메서드나 필드도 추가할 수 있다
- 임의의 인터페이스를 구현할 수 있다
- Object에 정의된 모든 헤서드들이 포함되어 있다(3장 내용 전부)
- Comparable 인터페이스와(규칙 12) Serializable 인터페이스(11장)가 구현되어 있다
- 직렬화 형식은 enum 자료형상의 변화 대부분을 견딜 수 있도록 설계되어 있다
- 문자열로 쉽게 변환할 수 있다
- enum 자료형은 상수 묶음에서 출발해서 점차로 완전한 기능을 갖춘 추상화 단위로 진화해 나갈 수 있다
- enum은 원래 변경 불가능하므로 모든 필드는 final로 선언되어야 한다(규칙 15)
- 필드는 private로 선언하고 public 접근자를 두는 편이 더 낫다(규칙 14)
- 특정한 클래스에서만 쓰인다면 해당 클래스의 맴버클래스로 선언하라(규칙 22)
- 외부(external) enum 자료형 상수별로 달리 동작하는 코드를 만들어야 할 때는 enum 상수에 switch문을 적용하면 좋다
- 일반적으로 enum은 int 상수와 성능면에서 비등하다
- **고정된 상수 집합이 필요할 때 enum을 사용하라**

#### 활용

- 상수별 클래스 몸체안에 메서드 재정의: 상수별 메서드 구현(constant-specific method impelementation)
- 전략 enum(strategy enum)

---

## 규칙 31. ordinal 대신 객체 필드를 사용하라

- 모든 `enum`에는 `ordinal()`이 있음.
- `ordinal()`은 자료형 안에서 `enum`상수의 위치를 나타내는 정수값을 반환하는 메서드.

#### as-is

```java
public enum Medal {
  GOLD, SILVER, BRONZE;

  public int getRank() {
    return ordinal() + 1;
  }
}
```

상수로 사용할 값은 `ordinal()`를 사용하지 말고, 객체 필드(instance field)에 저장하라.

#### to-be

```java
public enum Medal {
  GOLD(1), SILVER(2), BRONZE(3);

  private final int rank;

  Medal(int rank) {
    this.rank = rank;
  }

  public int getRank() {
    return rank;
  }
}
```

```java
// lombok
@AllArgsConstructor
public enum Medal {
  GOLD(1), SILVER(2), BRONZE(3);

  @Getter
  private final int rank;
}
```

자바의 `Enum` 관련 명세에 `ordinal()`에 대해 이렇게 설명되어 있다.

> 대부분의 프로프래머는 이 메서드를 사용할 일이 없을 것이다. `EnumSet`이나 `EnumMap`처럼 일반적인 용도의 enum 기반 자료 구조에서 사용할 목적으로 설계한 메서드다.

---

## 규칙 32. 비트 필드(bit field) 대신 EnumSet을 사용하라

#### as-is

```java
public class Text {
  public static final int BOLD          = 1 << 0; // 0001
  public static final int ITALIC        = 1 << 1; // 0010
  public static final int UNDERLINE     = 1 << 2; // 0100
  public static final int STRIKETHROUGH = 1 << 3; // 1000

  public void applyStyles(int style) {
    ...
  }
}
```

```java
text.applyStyles(Text.BOLD | Text.ITALIC);
```

**장점**

- 비트 필드로 나타내면 비트 단위 산술 연산을 통해 집합 연산을 효율적으로 실행할 수 있다.

**단점**

- int enum 패턴과 똑같은 단점(규칙 30)
- 비트 필드를 출력한 결과는 int enum 상수를 출력한 결과보다 이해하기 어려움
- 비트 필드에 포함된 모든 요소를 순차적으로 살펴보기도 어려움

#### to-be

`EnumSet`을 사용하자.

```java
public class Text {
  public enum Style { BOLD, ITALIC, UNDERLINE, STRIKETHROUGH }

  // 어느 Set 객체도 인자로 전달할 수 있으나, EnumSet이 분명 최선
  public void applyStyles(Set<Style> styles) {
    ...
  }
}
```

```java
text.applyStyles(EnumSet.of(Style.BOLD, Style.ITALIC));
```

**장점**

- `Set` 인터페이스를 구현하기 때문에 `Set`의 기능 제공
- 형 안전성, 다른 Set 구현들과 같은 수준의 상호운용성(interoperability) 제공
- 내부적으로 bit vector 사용
  - enum 갯수가 64 이하인 경우 `EnumSet`은 long 값 하나만 사용. 그러므로, 비트 필드에 필적하는 성능이 나옴.
  - `removeAll()`이나 `retainAll()` 같은 일괄 연산도 비트 단위 산술 연산을 통해 구현

**특징**

- 인자가 Set을 받도록 선언
  - 인자의 자료형으로는 클래스보다 인터페이스가 좋다(규칙 52) > 다형성
  - 클래스를 사용하면 특정한 구현에 종속
  - 인터페이스를 자료형으로 쓰는 습관을 들이면 프로그램은 더욱 유연해짐
  - 적당한 인터페이스가 없는 경우에는 객체를 클래스로 참조하는 것이 당연

**단점**

- 자바 1.6에서는 immutable EnumSet 객체를 만들 수 없음
  - Collections.unmodifiableSet으로 포장하거나, Guava 라이브러리(Google) 사용

---

## 규칙 33. ordinal을 배열 첨자로 사용하는 대신 EnumMap을 이용하라

**as-is**

```java
Herb[] garden = ...;
Set<Herb>[] herbsByType = (Set<Herb>[]) new Set[Herb.Type.values().length];

// 배열 초기화
for (int i = 0; i < herbsByType.length; i++) {
  herbsByType[i] = new HashSet<Herb>();
}

for (Herb h : garden) {
  herbsByType[h.type.ordinal()].add(h);
}

for (int i = 0; i < herbsByType.length; i++) {
  System.out.println(Herb.Type.values()[i] + ": " + herbsByType[i];
}
```

- `ordinal()`를 그냥 왠만하면 사용하지 말자.

**to-be**

```java
Map<Herb.Type, Set<Herb>> herbsByType = new EnumMap<Herb.Type, Set<Herb>>(Herb.Type.class);

// 배열 초기화
for (Herb.Type t : Herb.Type.values()) {
  herbsByType.pyt(t, new HashSet<Herb>());
}

for (Herb h : garden) {
  herbsByType.get(h.type).add(h);
}

System.out.println(herbsByType);
```

- 속도면에서도 별 차이 없음
- `EnumMap` 생성자는 키워 자료형을 나타내는 Class 객체를 인자로 받음
  - 이런 Class 객체를 한정적 자료형 토큰(bounded type token)이라 부르는데, 실행시점 제네릭 자료형 정보를 제공한다(규칙 29).
- `ordinal()` 값을 배열 인덱스로 사용하지 말고, `EnumMap`을 쓰자

---

## 규칙 34. 확장 가능한 enum을 만들어야 한다면 인터페이스를 이용하라

- 계승 가능 enum 자료형은 만들 수 없지만, 인퍼테이스를 만들고 그 인터페이스를 구현하는 기본 enum 자료형을 만들면 흉내낼 수 있다.
- 많은 부분이 까다로워지지만, 연산 코드(opcode)를 만들어야 할 때 사용하기 좋다.