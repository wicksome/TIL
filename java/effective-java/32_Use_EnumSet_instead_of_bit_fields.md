# 비트 필드(bit field) 대신 *EnumSet*을 사용하라

**as-is**

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




**to-be**

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

  - enum 갯수가 64 이하인 경우 `EnumSet`은 long 값 하나만 사용.

    그러므로, 비트 필드에 필적하는 성능이 나옴.

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