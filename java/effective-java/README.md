# Effective Java, 2nd Edition

> by Joshua Bloch

스터디하면서 정리하고 공부한 것들 기록.

## 목차

### 객체의 생성과 소멸

01) <a name="1"></a>[생성자 대신 static factory 메서드 사용을 고려하자](./01_Consider_static_factory_methods_istead_of_constructors.md)

02) <a name="2"></a>[생성자의 매개변수가 많을 때는 builder를 고려하자](./02_Consider_a_builder_when_faced_with_many_constructor_parameters.md)

03) <a name="3"></a>private 생성자나 enum 자료형은 싱글턴 패턴을 따르도록 설계하라

04) <a name="4"></a>객체 생성을 막을 때는 private 생성자를 사용하라

05) <a name="5"></a>불필요한 객체는 만들지 말라

06) <a name="6"></a>유효기간이 지난 객체 참조는 폐기하라

07) <a name="7"></a>종료자 사용을 피하라

### 모든 객체의 공통 메서드

08) <a name="8"></a>equals를 재정의할 때는 일반 규약을 따르라

09) <a name="9"></a>equals를 재정의할 때는 반드시 hashCode도 재정의하라

10) <a name="10"></a>toString은 항상 재정의하라

11) <a name="11"></a>clone을 재정할 때는 신중하라

12) <a name="12"></a>Complarable 구현을 고려하라

### 클래스와 인터페이스

13) <a name="13"></a>클래스와 멤버의 접근 권한을 최소화하라

14) <a name="14"></a>public 클래스 안에는 public 필드를 두지 말고 접근자 메서드를 사용하라

15) <a name="15"></a>qusrud rksmdtjddmf chlthghkgkfk

16) <a name="16"></a>계승하는 대신 구성하라

17) <a name="17"></a>계승을 위한 설계와 문서를 갖추거나, 그럴 수 없다면 계승을 금지하라

18) <a name="18"></a>추상 클래스 대신 인터페이스를 사용하라

19) <a name="19"></a>인터페이스는 자료형을 정의할 때만 사용하라

20) <a name="20"></a>태그 달린 클래스 대신 클래스 계층을 활용하라

21) <a name="21"></a>전략을 표현하고 싶을 때는 함수 객체를 사용하라

22) <a name="22"></a>멤버 클래스는 가능하면 static으로 선언하라

### 제네릭

23) <a name="23"></a>클래스와 맴버의 접근 권한을 최소화하라.

24) <a name="24"></a>public 클래스 안에는 public 필드를 두지 말고 접근자 메서드를 사용하라

25) <a name="25"></a>배열 대신 리스트를 써라

26) 가능하면 제네릭 자료형으로 만들 것

27) 가능하면 제네릭 메서드로 만들 것

28) 한정적 와일드카드를 써서 API 유연성을 높여라

29) 형 한전 다형성 컨테이너를 쓰면 어떨지 따져보라

### 열거형(enum)과 어노테이션

### 메서드

### 일반적인 프로그래밍 원칙들

45)

46)

47)

48)

49)

50)

51)

52)

53)

54)

55)

56)


### 예외

57) [예외는 예외적 상황에만 사용하라](./57_Use_exceptions_only_for_exceptional_confitions.md)

58) [복구 가능 상태에는 점검지정 예외를 사용하고, 프로그래밍 오류에는 실행지점 예외를 이용하라](./58_Use_checked_exceptions_for_recoverable_conditions_and_runtime_exceptions_for_programming_errors.md)

59) [불필요한 점검지정 예외 사용은 피하라](./59_Avoid_unnecessary_use_of_checked_exceptions.md)

### 병행성
### 직렬화
