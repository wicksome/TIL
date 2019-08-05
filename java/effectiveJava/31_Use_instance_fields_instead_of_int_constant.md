# *ordinal* 대신 객체 필드를 사용하라.

* 모든 `enum`에는 `ordinal()`이 있음.
* `ordinal()`은 자료형 안에서 `enum`상수의 위치를 나타내는 정수값을 반환하는 메서드.



**as-is**

```java
public enum Medal {
  GOLD, SILVER, BRONZE;
  
  public int getRank() {
    return ordinal() + 1;
  }
}
```

상수로 사용할 값은 `ordinal()`를 사용하지 말고, 객체 필드(instance field)에 저장하라.



**to-be**

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

