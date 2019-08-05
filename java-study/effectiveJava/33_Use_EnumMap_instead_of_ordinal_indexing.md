# *ordinal*을 배열 첨자로 사용하는 대신 *EnumMap*을 이용하라

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