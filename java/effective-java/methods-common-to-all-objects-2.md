---
title: 이펙티브자바 3장. 모든 객체의 공통 메서드 - 2
date: 2017-03-22 10:00:00
tags:
- java
- effective java
desc: chapter 3. Methods Common To All Objects in effective java
---

[규칙 11](../../../../2017/03/22/methods-common-to-all-objects-2/#규칙-11-clone을-재정의할-때는-신중하라) - clone을 재정의할 때는 신중하라
[규칙 12](../../../../2017/03/22/methods-common-to-all-objects-2/#규칙-12-Comparable-구현을-고려하라) - Comparable 구현을 고려하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 규칙 11. clone을 재정의할 때는 신중하라

#### Cloneable 인터페이스

- 어떤 객체가 clone을 허용한다는 사실을 알리는 데 쓰려고 고안된 *mixin 인터페이스*([규칙 18](#item18))
	- clone 메서드가 없으며, Object의 clone 메서드는 potected로 선언되어 있다.
- protected로 선언된 Object의 clone 메서드가 어떻게 동작할지 정한다.
	- 어떤 클래스가 Cloneable을 구현하면, Object의 clone 메서드는 해당 객체를 필드 단위로 복사한 객체를 반환
	- 어떤 클래스가 Cloneable을 구현하지 않으면 CloneNotSupportedExceptiond을 던짐
- 인터페이스를 괴상하게 이용한 사례
	- 일반적으로 인터페이스를 구현한다는 것은 클래스가 무슨 일을 할 수 있는지 클라이언트에게 알리는 것
	- Clonealed은 상위 클래스의 protected 맴버가 어떻게 동작할지 규정하는 용도
- Cloneable을 구현해서 어떤 결과를 얻으려면, 해당 클래스뿐 아니라 그 모든 상위 클래스들은 복잡한 데다 강제할 수 없고(unenforceable) 문서도 부족한 프로토콜을 따라야 한다. 그리고 그렇게 하면 언어 외적인(ectralinguistic) 객체 생성 메커니즘이 탄생한다. 생성자 호출 없이도 객체를 생성할 수 있게 되는 것이다.

#### java.lang.Object.clone() 일반 규약

- 객체의 복사본을 만들어서 반환
- "복사"의 정확한 의미는 클래스마다 다르며, 일반적으로 다음과 같은 조건이 충족되어야 한다.
	- True: `x.clone() != x`
	- True 그러나 반드시 True여야 하는 것은 아님:
		- ① `x.clone().getClass() == x.getClass()`
		- `x.cline().equals(x)`
- 내부 자료구조까지 복사해야 될 수도 있다.
- ② 어떤 생성자도 호출되지 않는다.

#### clone() 규약의 문제점

- ② 규정은 너무 심하다.
	- clone이 만드는 복사본의 내부 객체는 생성자로 만들 수도 있다.
	- 클래스가 final로 선언되어 있다면, 생성자로 만든 객체를 반환하도록 clone을 구현할 수도 있다.
- ① 규정은 너무 느슨하다.

#### 중점?

- 비-final 클래스에 clone을 재정의할 때는 반드시 super.clone을 호출해 얻은 객체를 반환해야 한다.
- 실질적으로 Cloneable 인터페이스를 구현하는 클래스는 제대로 동작하는 public clone 메서드를 제공해야 한다.
- 라이브러리가 할 수 있는 일을 클라이언트에게 미루지 말라.
- 사실상, clone 메서드는 또 다른 형태의 생성자다. 원래 객체를 손상시키는 일이 없도록 해야 하고, 복사본의 불변식<sub>invariant</sub>도 제대로 만족시켜야 한다.
- clone의 아키텍처는 변경 가능한 객체를 참조하는 final 필드의 일반적 용볍과 호환되지 않는다.
- 객체를 복사할 대안을 제공하거나, 아예 복제 기능을 제공하지 않는 것이 낫다.
- 객체 복제를 지원하는 좋은 방법은 *복사 생성자<sub>copy constructor</sub>*나 *복사 팩터리<sub>copy factory</sub>*를 제공하는 것이다.

---

## 규칙 12. Comparable 구현을 고려하라

```java
public interface Comparable<T> {
	int compareTo(T t);
}
```

- `compareTo()`는 *Comparable* 인터페이스에 포함된 유일한 메서드. equals()와 비슷하지만, 단순한 동치성 검사 이외에 순서 비교가 가능하며, 좀 더 일반적.
- Comparable 인터페이스를 구현하는 클래의 객체들은 *자연적 순서<sub>natural ordering</sub>*를 갖게 됨 - `Arrays.sort(a)`로 정렬 가능
- `compateTo()`의 일반 규약(equals와 비슷)
	- 객체와 인자로 주어진 객체 비교
	- 이 객체의 값이 인자로 주어진 객체보자 작으면 음수, 같으면 0, 크면 양수
	- 인자로 전달된 객체의 자료형이 이 객체와 비교 불가능할 경우 *ClassCastException* 예외 던짐
	- 모든 x와 y에 대해 `sgn(x.compareTo(y)) == -sgn(y.compareTo(x))`가 만족되도록 해야 한다. (`y.compareTo(x)`가 예외를 발생시킨다면 `x.compareTo(y)`도 그래야 하고, 그 역도 성립해야 한다.)
	- 추이성<sub>transitivity</sub>이 만족되도록 해야 한다. 즉, `(x.compareTo(y) > 0 && y.compareTo(z) > 0)`이면 `x.compareTo(z) > 0`이어야 한다.
	- `x.compareTo(y) == 0` 이면 `sgn(x.compareTo(z)) === sgn(y.compareTo(z))`이다.
	- 강력히 추천하지만 절대적 요구사항은 아닌 조건 하나는 `(x.compareTo(y) == 0) == (x.equals(y))`이다. 이 조건을 만족하지 않는 클래스는 반드시 그 사실을 명시해야 한다.

		```java
		// 주의: 이 클래스의 객체들은 equals에 부합하지 않는 자연적 순서를 따른다.
		```

- 규약을 준수하지 않는 클래스는 비교 연산에 기반한 클래스들을 오동작시킬 수 있다. - TreeSet·TreeMap 같은 sorted collection, Arrays·Collections 같은 유틸리티 클래스, 탐색과 정렬 알고리즘을 포함하는 클래스
- compareTo()의 필드 비교 방식은 동치성 검사라기보단 순서 비교다.
- 클래스에 선언된 중요 필드가 여러 개인 경우, 필드 비교 순서가 중요하다. 가장 중요한 필드부터 시작해서 차례로 비교해야 한다.
- compareTo()를 구현하면서 값 비교할때 오버플로우를 조심 -> 이런 문제는 대부분 정상동작하기 때문에 디버깅하기 어렵다.
