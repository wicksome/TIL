---
title: 이펙티브자바 4장. 클래스와 인터페이스 - 2
date: 2017-04-12 10:00:00
updated: 2017-04-12 10:00:00
tags:
- java
- effective java
desc: chapter 4. classes and interfaces in effective java
---

[규칙 16](../../../../2017/04/15/classes-and-interfaces-2/#16-계승하는-대신-구성하라) - 계승하는 대신 구성하라
[규칙 17](../../../../2017/04/15/classes-and-interfaces-2/#17-계승을-위한-설계와-문서를-갖추거나-그럴-수-없다면-계승을-금지하라) - 계승을 위한 설계와 문서를 갖추거나, 그럴 수 없다면 계승을 금지하라
[규칙 18](../../../../2017/04/15/classes-and-interfaces-2/#18-추상-클래스-대신-인터페이스를-사용하라) - 추상 클래스 대신 인터페이스를 사용하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 16. 계승하는 대신 구성하라

- 즉, 클래스에 대해서 `extends` 하지 말고 `필드`로 선언하라.
- 메서드 호출과 달리, 계승은 캡슐화 원칙을 위반한다.
- `IS-A` 관계일 때 계승하고, `HAS-A` 관계는 구성하라.

---

## 17. 계승을 위한 설계와 문서를 갖추거나, 그럴 수 없다면 계승을 금지하라

- 재정의 가능 메서드를 내부적으로 어떻게 사용하는지 반드시 문서에 남겨라.
	- 관습적으로, 재정의 가능 메서드를 어떤 식으로 호출하는지는 메서드 주석문 마지막에 명시한다.

---

## 18. 추상 클래스 대신 인터페이스를 사용하라

- 이미 있는 클래스를 개조해서 새로운 인터페이스를 구현하도록 하는 것은 간단하다.
- 인터페이스는 믹스인~mixin~을 정의하는 데 이상적이다.
    > 믹스인은 클래스가 "주 자료형~primary type~" 이외에 추가로 구현할 수 있는 자료형으로, 어떤 선택적 기능을 제공한다는 사실을 선언하기 위해 쓰인다. (e.g. Comparable)

- 인터페이스는 비 계층적인(nonhierarchical) 자료형 프레임워크를 만들 수 있도록 한다.

	```java
	public interface SingerSongwriter extends Singer, Songwriter {
		AudioClip strum();
		void actSensitive();
	}
	```

	- 인터페이스를 쓰지 않으려면 필요한 속성 조합마다 별도의 클래스를 만들어 거대한 클래스 계층을 만들어야 한다. 필요한 속성이 n개가 있다면 지원해야 하는 조합의 가짓수는 2^n^개에 달한 것이다. 이런 문제는 <em>조합 폭증~combinatorial explosion~</em>이라는 이름으로 알려져 있다.
- 인터페이스를 사용하면 <em>포장 클래스 숙어~wrapper class idiom~</em>를 통해([규칙 16](#item16)) 안전하면서도 강력한 기능 개선이 가능하다.
- <em>추상 골격 구현 클래스~abstract skeletal implementation~</em>를 중요 인터페이스마다 두면, 인터페이스의 장점과 추상 클래스의 장점을 결합할 수 있다.
	- 인터페이스로는 자료형을 정의하고, 구현하는 일은 골격 구현 클래스에 맡기면 된다.
	- 관습적으로 골격 구현 클래스의 이름은 Abstract*Interface*와 같이 정한다.
		(e.g. Collection Framework에는 인터페이스별로 골격 구현 클래스들이 하나씩 제공된다. `AbstractCollection`, `AbstractSet`, `AbstractList`, `AbstractMap`)
	- 골격 구현 클래스를 적절히 정의하기만 하면, 프로그래머는 쉽게 인터페이스를 구현할 수 있다.
- 추상클래스의 장점으로 인터페이스보다 추상 클래스가 발전시키기 쉽다. 하지만 java 1.8에서는 인터페이스에 default 메서드를 추가할 수 있다(하지만 인터페이스당 한 개의 default 메서드).
- 인터페이스가 공개되고 널리 구현된 다음에는, 인터페이스 수정이 거의 불가능하다. 그러므로, public 인터페이스는 극도로 주의해서 설계해야 하며 실제로 여러 구현을 만들어 보면서 광범위하게 테스트해야 한다.