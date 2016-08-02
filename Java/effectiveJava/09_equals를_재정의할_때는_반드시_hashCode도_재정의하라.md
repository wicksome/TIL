>   equals 메서드를 재정의하는 클래스는 반드시 hashCode 메서드도 재정의 해야 한다

# 해시 관련 규약

- equals메서드가 같다고 판정한 두 객체의 hashCode 값은 같아야 함
- equals에서드가 다르다고 판정한 두 객체의 hashCode 값은 반드시 다를 필요는 없음, 그러나 서로 다를 수록 해시 테이블의 성능 향상

# 해시 메서드 만드는 방법

lombok의 `@EqualsAndHashCode` 사용([링크](https://projectlombok.org/features/EqualsAndHashCode.html))

# 주의할 점

- 성능을 개선하려고 객체의 중요 부분을 해시 코드 계산 과정에서 생략하면 안됨
