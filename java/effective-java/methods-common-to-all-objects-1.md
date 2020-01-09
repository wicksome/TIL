---
title: 이펙티브자바 3장. 모든 객체의 공통 메서드 - 1
date: 2017-03-11 10:00:00
tags:
- java
- effective java
desc: chapter 3. Methods Common To All Objects in effective java
---

[규칙 8](../../../../2017/03/11/methods-common-to-all-objects-1/#규칙-8-equals를-재정의할-때는-일반-규약을-따르라) - equals를 재정의할 때는 일반 규약을 따르라
[규칙 9](../../../../2017/03/11/methods-common-to-all-objects-1/#규칙-9-equals-메서드를-재정의하는-클래스는-반드시-hashCode-메서드도-재정의-해야-한다) - equals 메서드를 재정의하는 클래스는 반드시 hashCode 메서드도 재정의 해야 한다
[규칙 10](../../../../2017/03/11/methods-common-to-all-objects-1/#규칙-10-toString은-항상-재정의하라) - toString은 항상 재정의하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 규칙 8. equals를 재정의할 때는 일반 규약을 따르라

#### Override 상황

###### Override 하지 않는 경우

1. 각각의 객체가 고유할 때
	값~value~ 대신 활성 개체~active entity~를 나타내는 *Thread* 같은 클래스.
2. 논리적 동일성~logical equality~ 검사 방법이 상관 없을 때
	*Random* 클래스를 설계할 때 값 비교를 사용안할 것 같아서 구현하지 않는 것처럼 필요 없을 경우
3. 상위 클래스에서 정의한 equals가 하위 클래스에서 사용 가능할 때
4. 클래스가 private, package-private로 선언되었고, equals를 호출할 일이 없을 때

	> 필자는 이런 상황에서는 반드시 equals를 재정의해야 한다고 본다. 실수로 equals를 호출할 수도 있기 때문.

  ```java
  @Override
  public Boolean equals(Object obj) {
		throw new AssertionError(); // 호출되면 안 되는 메서드를 호출했다는 뜻
  }
  ```

###### Override 하는 경우

1. *논리적 동일성~logical equality~*의 개념을 지원하는 클래스일 때
2. 상위 클래스의 equals가 하위 클래스의 필요를 충족하지 못할 때

###### Override 할 필요가 없는 경우

1. 개체 통제([규칙 1](#item1)) 기능으로 하나의 객체만 존재하는 클래스(e.g. 싱글톤, enum([규칙 30](#item30)))

#### Override 규약, 주의

###### equals 메서드를 정의할 때 준수해야 하는 일반 규약~general contract~

> *Object* 클래스 명세(specification)[JavaSE6]

*동치 관계~equivalence relation~* 구현, 다음과 같은 관계를 동치 관계라 한다.

- **반사성~Reflexivity~**: `x.equals(x)`는 `true`
- **대칭성~Symmetry~**: `x.equals(y)`가 `true`일 때, `y.equals(x)`도 `true`

	*e.g. 대칭성 위반 코드*

	```java
	public class CustomString {
		private final String str;

		@Override
		public boolean equals(Object o) {
			if (o instanceof CustomString) {
				return str.equalsIgnoreCase(((CustomString) o).getStr());
			}
			if (o instanceof String) { // 대칭성 위반
				return str.equalsIgnoreCase((String) o);
			}
			return false;
		}
	}
	```

	```java
	CustomString cs = new CustomString("string");
	String s = "string";

	cs.equals(s); // true
	s.equals(cs); // false

	List<CustomString> list = new ArrayList<>();
	...
	// JVM에 따라 결과가 달라진다.
	list.contains(s);
	```

	> equals가 따라야 할 규약을 어기면, 그 객체를 만난 다른 객체들이 어떻게 행동할지 예측할 수 없게 된다.

- **추이성~Transitivity~**: `x.equals(y)`가 `true`이고, `y.equals(z)`가 `true`이면 `x.equals(z)`도 `true`

	*e.g. 하위 클래스에서 새로운 값 컴포넌트~value component~를 추가하는 상황.*

	*ColorPoint 클래스*(하위 클래스)의 `equals()`에서 새로운 값 color를 비교하는 로직을 추가할 경우, 대칭성에 위반

	```java
	@AllArgsConstructor
	public class Point {
		private final int x, y;

		@Override
		public boolean equals(Object obj) {
			if (!(obj instanceof Point)) { return false; }
			Point p = (Point)obj;
			return p.x == x && p.y == y;
		}
	}

	public class ColorPoint extends Point {
		private final Color color;

		public ColorPoint(int x, int y, Color color) {
			super(x, y);
			this.color = color;
		}

		// 대칭성 위반
		@Override
		public boolean equals(Object obj) {
			if (!(obj instanceof ColorPoint)) { return false; }
			return super.equals(obj) && ((ColorPoint)obj).color == color;
		}
	}
	```

	```java
	Point p1 = new Point(1, 2);
	Point p2 = new ColorPoint(1, 2, Color.BLUE);
	p1.equals(p2); // true
	p2.equals(p1); // false
	```

	그래서 Point 객체일 때 color 값을 비교안하도록 할 경우, 대칭성은 보존되지만 추이성 위반

	```java
	public class ColorPoint extends Point {
		...

		// 추이성 위반
		@Override
		public boolean equals(Object obj) {
			if (!(obj instanceof Point)) return false;
			if (!(obj instanceof ColorPoint)) return obj.equals(this);
			return super.equals(obj) && ((ColorPoint)obj).color == color;
		}
	}
	```

	```java
	Point p0 = new ColorPoint(1, 2, Color.RED);
	Point p1 = new Point(1, 2);
	Point p2 = new ColorPoint(1, 2, Color.BLUE);

	p0.equals(p1); // true
	p1.equals(p2); // true
	p0.equals(p2); // false
	```

	> 사실 이것은 객체 지향 언어에서 동치 관계~equivalence relation~를 구현할 때 발생하는 본질적 문제다. 객체 지향적 추상화~object-oriented abstraction~의 혜택을 누리지 않을 거라면 모를까, **객체 생성 가능 클래스를 계승하여 새로운 값 컴포넌트를 추가하면서 equals 규약을 어기지 않을 방법은 없다.**

	TO-DO: 리스코프 대체 원칙 위반(p52)

	∴ Composition 으로 구현([규칙 16](#item16)).

	```java
	public class ColorPoint {
		private final Point point;
		private final Color color;

		public ColorPoint(int x, int y, Color color) {
			if(color == null) throw new NullPointerException();
			point = new Point(x, y);
			this.color = color;
		}

		public Point asPoint() { return point; }

		@Override
		public boolean equals(Object obj) {
			if(!(obj instanceof ColorPoint)) return false;
			ColorPoint cp = (ColorPoint) obj;
			return cp.point.equals(point) && cp.color.equals(color);
		}
	}
	```

	```java
	Point p0 = new ColorPoint(1, 2, Color.RED).asPoint();
	Point p1 = new Point(1, 2);
	Point p2 = new ColorPoint(1, 2, Color.BLUE).asPoint();

	p0.equals(p1); // true
	p1.equals(p0); // true

	p0.equals(p1); // true
	p1.equals(p2); // true
	p0.equals(p2); // true
	```

	cf. lombok

	- `@Value` 적용한 클래스는 `final class`가 되므로 상속 불가.
	- 롬북 활용할 경우

	```java
	@EqualsAndHashCode
	@AllArgsConstructor
	public class Point {
		private final int x, y;
	}

	@EqualsAndHashCode
	public class ColorPoint extends Point {
		private final Color color;

		public ColorPoint(int x, int y, Color color) {
			super(x, y);
			this.color = color;
		}
	}
	```

	```java
	Point p0 = new ColorPoint(1, 2, Color.RED);
	Point p1 = new Point(1, 2);
	Point p2 = new ColorPoint(1, 2, Color.BLUE);

	p0.equals(p1); // false
	p1.equals(p0); // false

	p0.equals(p1); // false
	p1.equals(p2); // false
	p0.equals(p2); // false
	```



- **일관성~Consistency~**: 값의 변화가 없다면 `x.equals(y)`는 호출 횟수에 상관없이 항상 같아야 함

	- 클래스를 구현할 때는 Mutable or immutable 을 깊이 생각해본다([규칙 15](#item15)).
	- 신뢰성이 보장되지 않는 자원~unreliable resource~들을 비교하는 equals를 구현하는 것은 삼가라. 그렇지 않으면 일관성 규약을 만족시키기가 너무 어려움.

- **Null에 대한 비 동치성~Non-nullity~**: *null*이 아닌 참조 x에 대해서 `x.equals(null)`은 항상 `false`

	equals의 일반 규약에서는 예외가 발생하는 것을 허용하지 않는다(e.g. NPE). 그래서 상당수의 클래스는 equals() 안에서 null 조건을 명시적으로 검사하는데(e.g. `if (o == null) return false;`), 이런 검사는 불필요하다.

	왜냐하면, equals 메서드는 먼저 인자를 형변환~cast~하는데, *instanceof* 연산자는 첫 번째 피연산자가 null이면 무조건 false를 반환한다[[JLS, 15.20.2](https://docs.oracle.com/javase/specs/jls/se7/html/jls-15.html#jls-15.20.2)].

	```java
	@Override
	public boolean equals(Object e) {
		if (!(o instanceof CustomType)) {
			return false;
		}
		...
	}
	```

###### equlas 메서드를 구현하기 위해 따라야 할 지침

1. == 연산자를 사용하여 equals의 인자가 자기 자신인지 검사 -> 단순히 성능 최적화~performance optimization~
2. instanceof 연산자를 사용하여 인자의 자료형이 정확한지 검사
3. equals의 인자를 정확한 자료형으로 변환
4. 각각의 필드가 일치하는지 검사
5. equals 메서드 구현을 끝냈다면, 대칭성·추이성·일관성의 세 속성이 만족하는지 검토 -> unit test

(+) 추가 주의 사항

- equals를 구현할 떄는 hashCode도 재정의하라
- 너무 머리 쓰지 마라
- equals 메서드의 인자 형을 Object에서 다른 것으로 바꾸지 마라

---

## 규칙 9. equals 메서드를 재정의하는 클래스는 반드시 hashCode 메서드도 재정의 해야 한다

> Object 일반 규약[JavaSE6]
>
> - 응용프로그램 실행 중에 같은 객체의 hashCode를 여러 번 호출하는 경우, equals가 사용하는 정보들이 변경되지 않았다면, 언제나 동일한 정수가 반환되어야 한다. 다만 프로그램이 종료되었다가 다시 실행되어도 같은 값이 나올 필요는 없다.
> - equals(Object) 메서드가 같다고 판정한 두 객체의 hashCode 값은 같아야 한다.
> - equals(Object) 메서드가 다르다고 판정한 두 객체의 hashCode 값은 꼭 다를 필요는 없다.그러나 서로 다른 hashCode 값이 나오면 hash table의 성능이 향상될 수 있다는 점은 이해하고 있어야 한다.

- **equals 메서드를 재정의하는 클래스는 반드시 hashCode 메서드도 재정의 해야 한다.** override 하지 않으면 Object 일반 규약중 두번째, 같은 객체는 같은 해시 코드 값을 가져야 한다는 규약이 위반되는 것이다. 재정의하지 않으면 Hash 기반 컬렉션과 함께 사용하면 오동작한다(e.g. HashMap, HashSet, ...)
- 좋은 해시 함수는 다른 객체에서 다른 해시 코드를 반환하는 경향이 있다. - 충돌~Collision~ 회피
	- 이상적인 해시 함수 만드는 방법 책 참고 - p64
	- [lombok](https://projectlombok.org/features/EqualsAndHashCode.html)의 `@EqualsAndHashCode` 참고(책의 방법과 비슷)
- 해시 코드 계산 비용이 높은 변경 불가능 클래스를 만들 때는, 재계산하는 대신 캐시해 두어야 할 수도 있다. 또한 경우에 해시 키에 따라 lazy initialization도 가능하다.
- **주의할 것은, 성능을 개선하려고 객체의 중요 부분을 해시 코드 계산 과정에서 생략하면 안된다.**

#### 참고

- [Java HashMap은 어떻게 동작하는가?](http://d2.naver.com/helloworld/831311)

---

## 규칙 10. toString은 항상 재정의하라

```
// 이것보단
PhoneNumber@163b91
// 이게 훨씬 낫다!
(070) 867-5309
```

> "모든 하위 클래스는 이 메서드를 재정의함이 바람직하다." - toString 일반 규약

```java
public class PhoneNumber {
	private Agency agency; // 통신사
	private String number; // 전화번호

	public Agency getAgency() { return agency; } ④

	/**
	 * 전화번호를 문자열로 변환해서 반환한다.
	 * "[SKT] 010-1234-1234" 형식으로 반환된다. ③
	 * ....
	 */
	@Override
	public String toString() { ①
		return agency.getName() + " " + number; ②
	}
}
```

1. toString을 잘 만들어 놓으면 클래스를 좀 더 쾌적하게 사용할 수 있다.
2. 가능하다면 toString()는 객체 내의 중요 정보를 전부 담아 반환해야 한다.
3. toString이 반환하는 문자열의 형식을 명시하건 그렇지 않건 간에, 어떤 의도인지는 문서에 분명하게 남겨야 한다.
4. toString이 반환하는 문자열에 포함되는 정보들은 전부 프로그래밍을 통해서 가져올 수 있도록(programmatic access)하라.
	toString에 포함되는 정보를 가져올 수 있는 accessor를 만들지 않으면, 클라이언트는 toString을 파싱하려 할 것이다.
