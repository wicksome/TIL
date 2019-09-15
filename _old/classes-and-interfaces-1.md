---
title: 이펙티브자바 4장. 클래스와 인터페이스 - 1
date: 2017-03-29 10:00:00
tags:
- java
- effective java
desc: chapter 4. classes and interfaces in effective java
---

[규칙 13](../../../../2017/03/29/classes-and-interfaces-1/#13-클래스와-맴버의-접근-권한을-최소화하라) - 클래스와 맴버의 접근 권한을 최소화하라
[규칙 14](../../../../2017/03/29/classes-and-interfaces-1/#14-public-클래스-안에는-public-필드를-두지-말고-접근자-메서드를-사용하라) - public 클래스 안에는 public 필드를 두지 말고 접근자 메서드를 사용하라
[규칙 15](../../../../2017/03/29/classes-and-interfaces-1/#15-변경-가능성을-최소화하라) - 변경 가능성을 최소화하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 13. 클래스와 맴버의 접근 권한을 최소화하라

- 소프트웨어 설계의 기본적인 원칙 중 하나 - 정보 은닉~information hiding~, 캡슐화~encapsulation~
- 접근 권한은 가능한 낮춰라.
- public static final 필드를 제외한 어떤 필드도 public 필드로 선언하지 마라
- public static final 필드가 참조하는 객체는 변경 불가능 객체로 만들어라

#### 정보 은닉, 캡슐화

- 시스템을 구성하는 모듈 사이의 *의존성을 낮춤~decouple~*
- 성능을 보장하는 것은 아니지만, 효과적인 성능 튜닝을 가능하게 한다. 어떤 모듈이 성능 문제를 일으키는지 프로파일링~profiling~ 하기 용이하기 때문([규칙 55](#item55))
- 소프트웨어의 재사용 가능성을 높인다.
- 대규모 시스템 개발 과정의 리스트를 낮춘다.
- 접근 제어~access control~ 메커니즘은 클래스와 인터페이스, 그리고 그 멤버들의 접근 권한~accessibility~을 규정한다([JLS, 6.6](https://docs.oracle.com/javase/specs/jls/se8/html/jls-6.html#jls-6.6))
- **각 클래스와 멤버는 가능한 한 접근 불가능하도록 만들라는 것** - 가장 낮은 접근 권한 설정
- **객체 필드~instance field~는 절대로 public으로 선언하면 안 된다**([규칙 14](#item14)).
- **변경 가능 public 필드를 가진 클래스는 다중 스레드에 안전하지 않다.**
- 예외적으로 어떤 상수들이 클래스로 추상화된 결과물의 핵심적 부분을 구성한다고 판단되는 경우, 해당 상수들을 `public static final` 필드들로 선언하여 공개할 수 있다. 이런 필드들은 관습적으로 대문자로 구성된 이름을 가지며, 이름을 구성하는 단어들은 밑줄 기호로 구분한다([규칙 56](#item56)). 이런 필드들은 반드시 기본 자료형 값들을 갖거나, 변경 불가능 객체를 참조해야 한다([규칙 15](#item15)).
- 길이가 0 아닌 배열은 언제나 변경 가능하므로, **public static final 배열 필드를 두거나, 배열 필드를 반환하는 접근자~accessor~를 정의하면 안 된다.** - 보안문제 유발

	```java
	// AS-IS: 보안 문제를 초래할 수 있는 코드
	public static final Thing[] VAUES = {...};

	// TO-BE: (1) 변경 불가능 public 리스트 사용
	private static final Thing[] PRIVATE_VALUES = {...};
	public static final List<Thing> VALUES = Collections.unmodifiableList(Arrays.asList(PRIVATE_VALUES));

	// TO-BE: (2) 복사해서 반환하는 메서드 추가
	private static final Thing[] PRIVATE_VALUES = {...};
	public static final Thing[] values() {
		return PRIVATE_VALUES.clone();
	}
	```

---

## 14. public 클래스 안에는 public 필드를 두지 말고 접근자 메서드를 사용하라

- **getter/setter(접근자 메서드)를 사용하자**
	- 캡슐화의 이점
	- 불변식 가능
	- 필드 사용시 다른 동작 가능
	- (+) boilerplate code를 줄이기 위해서 lombok의 `@Data`, `@Value` 활용
- 원칙을 어긴 Java 클래스 - `Point.class`, `Dimension.class`
	- 이런 클래스는 참고하지 않는 것이 좋다.
	- Dimension 클래스가 내부 표현을 공개한 것은 아직까지도 해결되지 않고 있는 심각한 성능 문제 때문이다([규칙 55](#item55)에 설명).

---

## 15. 변경 가능성을 최소화하라

#### 요약

- Mutable Class로 만들 타당한 이유가 없다면, 반드시 Immutable Class로 만들어야 한다
	- 모든 getter 마다 그에 대응하는 setter를 두는 것은 피하라
	- 유일한 장점은 특정 상황에서 성능 문제가 생길 수 있다는 것이다
	- 작은 객체는 반드시 immutable로 만들어라
- Immutable Class로 만들 수 없다면, 변경 가능성을 최대한 제한하라
- 특별한 이유가 없다면 모든 필드는 final로 선언하라
	- 특별한 이유가 없다면, 생성자 이외에 public 초기화 메서드나 정적 팩터리 메서드를 제공하지 마라
	- 재 초기화 메서드도 제공하지 마라. 코드 복잡성만 늘어나고, 성능 향상에 도움 되는 경우는 거의 없다

#### 변경 불가능~immutable~ 클래스 생성 규칙

- 객체 상태를 변경하는 메서드(수정자~mutator~ 메서드 등)를 제공하지 않는다.
- 계승할(상속 받을) 수 없도록 한다. - e.g. `public final class { ... }`
- 모든 필드는 final로 선언한다.
	- 프로그래머의 의도가 분명해짐
	- 자바 *메모리 모델*에 명시된 바와 같이[[JLS, 17.5](https://docs.oracle.com/javase/specs/jls/se7/html/jls-17.html#jls-17.5)], 새로 생성된 객체에 대한 참조가 동기화 없이 다른 스레드로 전달되어도 안전
- 모든 필드를 private로 선언한다.
- 변경 가능 컴포넌트에 대한 독점적 접근권을 보장한다.
	- 변경 가능 객체에 대한 참조를 클라이언트는 획득할 수 없어야 한다.
	- 그런 필드는 클라이언트가 제공하는 객체로 초기화해서는 안되고, 접근자~accessor~ 또한 그런 필드를 반환해서는 안 된다.
	- 생성자나 접근다, readObject 메서드([규칙 76](#item76))안에서는 *방어적 복사본~defensive copy~*을 만들어야 한다([규칙 39](#item39)).

#### Immutable Object 특징

- **변경 불가능 객체는 단순하다. 생성될 때 부여된 한 가지 상태만 갖는다.**
- **변경 불가능 객체는 스레드에 안전(thread-safe)할 수밖에 없다. 어떤 동기화도 필요 없으며,** 여러 스레드가 동시에 사용해도 상태가 훼손될 일이 없다.
- **변경 불가능 객체는 자유롭게 공유할 수 있다.** 방어적 복사본([규칙 39](#item39))을 만들 필요가 없단 뜻이기도 하다.
- **변경 불가능 객체는 그 내부도 공유할 수 있다.**
- **변경 불가능 객체는 다른 객체의 구성요소로도 훌륭하다.**
- **변경 불가능 객체의 유일한 단점은 값마다 별도의 객체를 만들어야 한다는 점이다.** 따라서 객체 생성 비용이 높을 가능성이 있다.

#### Immutable Object 생성하는 다른 방법

모든 생성자를 private이나 package-private로 선언하고 public 생성자 대신 public 정적 팩터리 제공([규칙 1](#item1)) - 장점은 규칙 1 확인
