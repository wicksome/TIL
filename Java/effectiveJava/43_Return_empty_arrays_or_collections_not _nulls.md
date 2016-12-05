# null 대신 빈 배열이나 컬렉션을 반환하라

```java
// as-is
if (values != null && Arrays.asList(values).contains(Value.IMAGE)) {}
// to-be
if (Arrays.asList(values).contains(Value.IMAGE)) {}
```

- 반환값이 null인 경우를 항상 대비해야한다.

- 빈 배열이나 컬렉션 대신 null을 반환하는 메서드는 구현하기도 더 까다롭다.

- 배열 할당 비용을 피할 수 있으니 null을 반환해야 한다?

  - 프로파일링 결과로 해당 메서드가 성능 저하의 주범이라는 것이 밝혀지지 않는 한, 그런 수준까지 성능 걱정을 하는 것은 바람직하지 않다(규칙 55 - 신중하게 최적화하라).

    > **모든 프로그래머가 알아둬야 하는 최적화 관련 격언 세 가지**
    >
    > *"맹목적인 어리석음을 비롯한 다른 어떤 이유보다도, 효율성이라는 이름으로 저질러지는 죄악이 더 많다(효율성을 반드시 성취하는 것도 아니면서 말이다)."*
    > 윌리엄 울프(William A. Wulf[Wulf72])
    >
    > *"작은 효율성(small efficiency)에 대해서는, 말하자면 97% 정도에 대해서는, 잊어버려라. 석부른 최적화(premature optimzation)은 모든 악의 근원이다."*
    > 도널드 커누스(Donald E. Knuth)[Kunth74]
    >
    > *"최적화를 할 때는 아래의 두 규칙을 따르라.*
    > *규칙 1: 하지마라.*
    > *규칙 2: (전문가들만 따를 것) 아직은 하지 마라 - 완벽히 명료한, 최적화되지 않은 해답을 얻을 때까지는."*
    > M. A. 잭슨(M. A. Jackson)[Jackson75]

  - 길이가 0인 배열은 변경이 불가능하므로 아무 제약 없이 재사용할 수 있다(규칙 15).

    >**컬렉션에서 배열을 만들어 반환하는 올바른 방법**
    >
    >```java
    >private final List<Cheese> cheeseInStock = ...;
    >private static final Cheese[] EMPTY_CHEESE_ARRAY = new Cheese[0];
    >
    >public Cheese[] getCheese() {
    >  return cheeseInStock.toArray(EMPTY_CHEESE_ARRAY);
    >}
    >```
    >
    >  위 코드에서 `toArray()`에 전달되는 빈 매열 상수는 반환값의 자료형을 명시하는 구실을 한다. 보통 `toArray()`는 반환되는 원소가 담길 배열을 스스로 할당하는데, 컬렉션이 비어 있는 경우에는 인자로 주어진 빈 배열을 쓴다. 그리고 인자로 주어진 배열이 컬렉션의 모든 원소를 담을 정도로 큰 경우에는 해당 배열을 반환값으로 사용한다. 따라서 위의 숙어대로 하면 빈 배열은 절대로 자동 할당되지 않는다.
    >
    >*ArrayList.java*
    >
    >```java
    >public <T> T[] toArray(T[] a) {
    >   if (a.length < size)
    >     // Make a new array of a's runtime type, but my contents:
    >     return (T[]) Arrays.copyOf(elementData, size, a.getClass());
    >   System.arraycopy(elementData, 0, a, 0, size);
    >   if (a.length > size)
    >	   a[size] = null;
    >   return a;
    >}
    >```

    > **컬렉션 복사본을 반환하는 올바른 방법**
    >
    >   컬렉션을 반환하는 메서드도 빈 컬렉션을 반환해야 할 때마다 동일한 변경 불가능 빈 컬렉션 객체를 반환하도록 구현할 수 있다. `Collections.emptySet()`, `Collections.emptyList()`, `Collections.emptyMap()`가 그런 용도로 사용된다.
    >
    > ```java
    > public List<Cheese> getCheeseList() {
    >   if (cheeseInSrock.isEmpty())
    >     return Collections.emptyList(); // 언제나 같은 리스트 반환
    >   else 
    >     return new ArrayList<Cheese>(cheeseInStock);
    > }
    > ```



**null 대신에 빈 배열이나 빈 컬렉션을 반환하자.** null 값을 반환하는 것은 C 언어에서 전해진 관습으로, C에서는 배열의 길이가 배열과 따로 반환된다. 길이 0인 배열을 할당해서 반환하더라도 아무 이득이 없다.

