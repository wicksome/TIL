# 재정의 하지 않는 경우

1. 각각의 객체가 고유할 때
2. 논리적 동일성 검사 방법이 상관 없을 때
  `Random` 클래스를 설계할 때 값 비교를 사용안할 것 같아서 구현하지 않는 것처럼 필요 없을 경우
3. 상위 클래스에서 정의한 equals가 하위 클래스에서 사용 가능할 때
4. 클래스가 private, package-private로 선언되었고, equals를 호출할 일이 없을 때
 
  ```java
  @Override
  public Boolean equals(Object obj) {
    throw new AssertionError(); // 호출되면 안 되는 메서드를 호출했다는 뜻
  }
  ```

# 재정의하는 경우

1. 논리적 동일성의 개념을 지원하는 클래스일 때

# equals 메서드를 정의할 때 준수해야 하는 일반 규약

1. 동치 관계 구현
  1.1 반사성: `x.equals(x)`는 `true`
  1.2 대칭성: `x.equals(y)`가 `true`일 때, `y.equals(x)`도 `true`
  1.3 추이성: `x.equals(y)`가 `true`이고, `y.equals(z)`가 `true`이면 `x.equals(z)`도 `true`
