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

  - 반사성: `x.equals(x)`는 `true`
  - 대칭성: `x.equals(y)`가 `true`일 때, `y.equals(x)`도 `true`
  - 추이성: `x.equals(y)`가 `true`이고, `y.equals(z)`가 `true`이면 `x.equals(z)`도 `true`
  - 일관성: 값이 변화가 없다면 `x.equals(y)`는 호출 횟수에 상관없이 항상 같아야 함
  - `null`이 아닌 참조 x에 대해서 `x.equals(null)`은 항상 `false`
    
# equlas 메서드를 구현하기 위해 따라야 할 지침

1. === 연산자를 사용하여 equals의 인자가 자기 자신인지 검사
  > 같다면 true, 성능 최적화를 위한 것, 객체 비교 오버헤드가 클 경우 유용
2. instanceof 연산자를 사용하여 인자의 자료형이 정확한지 검사
3. equals의 인자를 정확한 자료형으로 변환
4. 각각의 필드가 일치하는지 검사
5. 대칭성, 추이성, 일관성의 세 속성이 만족하는지 검토

