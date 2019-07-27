# Effective Java, 2nd Edition

> by Joshua Bloch

공부하면서 내맘대로 정리하고 기록한 것들.

***📓 Study History***

- 2016.06.20 ~ 2017.04.03
- 2017.02.13 ~ 진행중
- 틈틈이 생각나면 보고 수정.

***📗 Convention*** - [link](#convention)

## 목차

**객체의 생성과 삭제**

1. [생성자 대신 static factory 메서드 사용을 고려하자](#item1)
2. [생성자의 매개변수가 많을 때는 builder를 고려하자](#item2)
3. [private 생성자나 enum 자료형은 싱글턴 패턴을 따르도록 설계하라](#item3)
4. [객체 생성을 막을 때는 private 생성자를 사용하라](#item4)
5. [불필요한 객체는 만들지 말라](#item5)
6. [유효기간이 지난 객체 참조는 폐기하라](#item6)
7. [종료자 사용을 피하라](#item7)

**모든 객체의 공통 메서드**

8. [equals를 재정의할 때는 일반 규약을 따르라](#item8)
9. [equals를 재정의할 때는 반드시 hashCode도 재정의하라](#item9)
10. [toString은 항상 재정의하라](#item10)
11. [clone을 재정할 때는 신중하라](#item11)
12. [Complarable 구현을 고려하라](#item12)

**클래스와 인터페이스**

13. [클래스와 멤버의 접근 권한을 최소화하라](#item13)
14. [public 클래스 안에는 public 필드를 두지 말고 접근자 메서드를 사용하라](#item14)
15. [변경 가능성을 최소화하라](#item15)
16. [계승하는 대신 구성하라](#item16)
17. [계승을 위한 설계와 문서를 갖추거나, 그럴 수 없다면 계승을 금지하라](#item17)
18. [추상 클래스 대신 인터페이스를 사용하라](#item18)
19. [인터페이스는 자료형을 정의할 때만 사용하라](#item19)
20. [태그 달린 클래스 대신 클래스 계층을 활용하라](#item20)
21. [전략을 표현하고 싶을 때는 함수 객체를 사용하라](#item21)
22. 멤버 클래스는 가능하면 static으로 선언하라

**제네릭**

23. 클래스와 맴버의 접근 권한을 최소화하라
24. public 클래스 안에는 public 필드를 두지 말고 접근자 메서드를 사용하라
25. 배열 대신 리스트를 써라
26. 가능하면 제네릭 자료형으로 만들 것
27. 가능하면 제네릭 메서드로 만들 것
28. 한정적 와일드카드를 써서 API 유연성을 높여라
29. 형 한전 다형성 컨테이너를 쓰면 어떨지 따져보라

**열거형(enum)과 어노테이션**

30. int 상수 대신 enum을 사용하라
31. ordinal 대신 객체 필드를 사용하라
32. 비트 필드(bit field) 대신 EnumSet을 사용하라
33. ordinal을 배열 첨자로 사용하는 대신 EnumMap을 이용하라
34. 확장 가능한 enum을 만들어야 한다면 인터페이스를 이용하라
35. 작명 패턴 대신 어노테이션을 사용하라
36. Override 어노테이션은 일관되게 사용하라
37. 자료형을 정의할 때 표식인터페이스를 사용하라

**메서드**

38. 인자의 유효성을 검사하라
39. 필요하다면 방어적 복사본을 만들라
40. 메서드 시그너처는 신중하게 설계하라
41. 오버로딩할 때는 주의하라
42. varargs는 신중히 사용하라
43. null 대신 빈 배열이나 컬렉션을 반환하라
44. 모든 API 요소에 문서화 주석을 달라

**일반적인 프로그래밍 원칙들**

45. 지역변수의 유효범위를 최소화하라
46. for 문보다는 for-each 문을 사용하라
47. 어떤 라이브러리가 있는지 파악하고, 적절히 활용하라
48. 정호가한 답이 필요하다면 float와 double은 피하라
49. 객체화된 기본 자료형 대신 기본 자료형을 이용하라
50. 다른 자료형이 적절하다면 문자열 사용은 피하라
51. 문자열 연결 시 성능에 주의하라
52. 객체를 참조할 때는 그 인터페이스를 사용하라
53. 리플렉션 대신 인터페이스를 이용하라
54. 네이티브 메서드는 신중하게 사용하라
55. 신중하게 최적화하라
56. 일반적으로 통용되는 작명 관습을 따르라

**예외**

57. [예외는 예외적 상황에만 사용하라](#item57)
58. [복구 가능 상태에는 점검지정 예외를 사용하고, 프로그래밍 오류에는 실행지점 예외를 이용하라](#item58)
59. [불필요한 점검지정 예외 사용은 피하라](#item59)
60. 표준 예외를 사용하라
61. 추상화 수준에 맞는 예외를 던져라
62. 메서드에서 던져지는 모든 예외에 대해 문서를 남겨라
63. 어떤 오류인지를 드러내는 정보를 상세한 메시지에 담으라
64. 실패 원자성 달성을 위해 노력하라
65. 예외를 무시하지 마라

**병행성**

66. 변경 가능 공유 데이터에 대한 접근은 동기화하라
67. 과도한 동기화는 피하라
68. 스레드보다는 실행자와 태스크를 이용하라
69. wait나 notify 대신 병행성 유틸리티를 이용하라
70. [스레드 안전성에 대해 문서로 남겨라](#item70)
71. [초기화 지연은 신중하게 하라](#item71)
72. 그레드 스케줄러에 의존하지 마라
73. 스레드 그룹은 피하라

**직렬화**

74. Serializable 인터페이스를 구현할 때는 신중하라
75. 사용자 지정 직렬화 형식을 사횽하면 좋을지 따져 보라
76. readObject 메서드는 방어적으로 구현하라
77. 개체 통제가 필요하다면 readResolve 대신 enum 자료형을 이용하라
78. 직렬화된 객체 대신 직렬화 프락시를 고려해 보라

[top]: #effective-java-2nd-edition
[design-patterns]: ./design-patterns.md "Design Patterns"
[dp-builder]: ./design-patterns.md#builder "Builder Pattern"
[dp-factory-method]: ./design-patterns.md#factory-method "Facoty Method Pattern"
[dp-abstract-method]: ./design-patterns.md#abstact-method "Abstract Method Pattern"
[dp-flyweight]: ./design-patterns.md#flyweight "Flyweight Pattern"
[dp-abstract-factory]: ./design-patterns.md#abstact-factory-method "Abstract Factory Method Pattern"
[dp-singleton]: ./design-patterns.md "Singleton Pattern"

---

## Convention

### Text

- 중요 단어, 문장은 **bold**로 표기한다.
- 강조할 부분은 *italic*으로 표기한다.
- 같이 알아두면 도움이 될 영어 표현은 `<sub></sub>`로 표기한다.
- 패키지(e.g. *java.utils.Collections*)나 클래스(e.g. *Object*)는 첫 표현만 이탤릭으로 표기한다.

*e.g. 규칙11(p81)*

**객체 복제를 지원하는 좋은 방법은, *복사 생성자<sub>copy constructor</sub>*나 *복사 팩터리<sub>copy factory</sub>*를 제공하는 것이다.** 복사 생성자는 단순히 같은 클래스의 객체 하나를 인자로 받는 생성자다.

### Code

- 설명에 들어갈 코드(e.g. `Data.getTime();`)는 \`code\`로 표기한다.
- 나머지는 코드 블럭에 표기하며, 코드  제목은 *이탤릭*으로 표현한다.

*code-title-or-file-name*

```java
System.out.println("Hello World!");
```

### 인용구

인용구는 '\>'로 추가한다.

> 클래스를 통해 객체를 만드는 일반적인 방법은 public으로 선언된 생성자<sub>constructor</sub>를 이용하는 것이다.

---

<a name="item1"></a>
# 규칙 1. 생성자 대신 static factory method 사용을 고려하자

> 클래스를 통해 객체를 만드는 방법
>
> - Constructor
> - Static factory method
>   (Design Patterns에 나오는 [팩토리 메서드 패턴][dp-factory-method]과 다르다.)

*Static factory method 예제 코드*

```java
public class Boolean {
	public static final Boolean TRUE;
	public static final Boolean FALSE;

	private boolean value;

	static {
		TRUE = new Boolean(true);
		FALSE = new Boolean(false);
		// Q. static 초기화 블록 vs 선언과 동시에 생성
		// A. 초기화 블록은 클래스 초기화 될 떄 수행하고, 동시 생성은 언제?
	}

	private Boolean(boolean b) { this.value = b; }

	private Boolean(String str) { this.value = "true".equalsIgnoreCase(str); }
  	// Q. str.equalsIgnoreCase("true") 를 안쓰는 이유
	// A. str이 null이면 NullPointException 발생

	// Static factory method
	public static Boolean valueOf(boolean b) {
		return b ? Boolean.TRUE : Boolean.FALSE;
	}

	...
}
```

```java
boolean b = (boolean)Boolean.TRUE; // unboxing
Boolean b = (Boolean)true; // boxing
Boolean b = true; // auto boxing
Boolean b = Boolean.valueOf(true);
```

public으로 선언된 생성자 대신 Static factory method를 제공하는 방법의 장단점은 아래와 같다.

## 장점

*java.utils.Collections* 클래스에는 Static factory method의 장점이 대부분 적용되어 있다.

```java
package java.util;
public class Collections { // 3-3
	private Collections() {} // 2-2(Non-instantiable class)

	public static final Map EMPTY_MAP = new EmptyMap<>(); // 2-1, 2-2(Singleton)

	public static final <K,V> Map<K,V> emptyMap() { // 1, 3-2, 4
		return (Map<K,V>) EMPTY_MAP;
	}

	private static class EmptyMap<K,V> // 3-1
		extends AbstractMap<K,V>
		implements Serializable
	{
		/* ... */
	}
}
```

```java
public interface Map<K,V> {/* ... */}
public interface List<E> extends Collection<E> {/* ... */} // 3-3
```

1. 이해하기 쉬운 이름의 메서드를 생성자로 사용할 수 있다(가독성).

	클래스의 인스턴스를 생성하는데 있어서 매개변수의 타입과 갯수로 구별하는 것보단 잘 지은 이름이 더 파악하기 쉽다.

2. 호출할 때마다 인스턴스화하지 않아도 된다.

	1. 만든 객체를 캐시<sub>cache</sub> 해놓고 재사용하여 같은 객체가 불필요하게 거듭 생성되는 일을 피할 수 있다.

		`Boolean.value(boolean)`는 이 기법을 활용한 좋은 사례로 [Flyweight 패턴][dp-flyweight]과 유사하다. 동일한 객체가 요청되는 일이 잦고, 특히 객체를 만드는 비용이 클 때 적용하면 성능을 크게 개선할 수 있다.

	2. 같은 객체를 반복해서 반환할 수 있다.

		> 어떤 시점에 어떤 객체가 얼마나 존재할지를 정밀하게 제어할 수 있다. 그런 기능을 갖춘 클래스를 *개체 통제 클래스<sub>instance-controlled class</sub>*라고 부른다.

		개체 통제 클래스를 작성하는 이유는 아래와 같다.

		- [Singleton pattern](#item3) 적용

		- [Non-instantiable class](#item4) 생성 가능(e.g. Utility class)

			```java
	       public class UtilityClass {
	       	private UtilityClass() { throw new AssertionError(); }
	       }
			```

		- [불변 클래스](#item15)

			-   `equals()` 대신 `==` 연산자 사용 가능

			-   [enum](#item30)이 이 기법을 사용

			```java
			public class Complex {
				private final double re;
				private final double im;

				private Complex(double re, double im) {
					this.re = re;
					this.im = im;
				}

				public static Complex valueOf(double re, double im) {
					return new Complex(re, im);
				}
			}
			```

3. 자신의 인스턴스만 반환하는 생성자와는 달리, 서브타입 객체도 반환 가능하다.

	1. > "public으로 선언되지 않은 클래스의 객체를 반환하는 API를 만들 수 있다. 그러면 구현 세부사항을 감출 수 있으므로 아주 간결한 API가 가능하다."

	2. > "이 기법은 인터페이스 기반 프레임워크(interface-based framework) 구현에 적합한데, 이 프레임워크에서 인터페이스는 정적 팩터리 메서드의 반환값 자료형으로 이용된다."

	3. > "관습상 반환값 자료형이 Type이라는 이름의 인터페이스인 정적 팩터리 맥서드를 Types라는 이름의 객체 생성 불가능 클래스안에 둔다."

	```java
	public interface Fruit {
		String getName();
	}

	public class Fruits {
		private Fruits() {}

		public static Fruit getBanana() { return new Banana(); }

		public static Fruit getApple() { return new Apple(); }

		private static class Apple implements Fruit {
			@Override
			public String getName() {
				return "apple";
			}
		}

		private static class Banana implements Fruit {
			@Override
			public String getName() {
				return "banana";
			}
		}
	}
	```

	```java
	@Test
	public void main() {
		Fruit apple = Fruits.getApple();
		apple.getName();
	}
	```

4. 제네릭 클래스의 인스턴스를 생성하는 코드를 간결하게 해준다.

	static 팩토리 메서드를 사용하면 컴파일러가 타입 추론(type inference)으로 해결할 수 있다.

	```java
   // before
   Map<String, List<String>> m = new HashMap<String, List<String>>();

   // after: 1.6 버전
   public static <K, V> HashMap<K, V> newInstance() {
   	return new HashMap<K, V>();
   }
   Map<String, List<String>> m = HahsMap.newInstance();

   // after: 1.7
   // <>(다이아몬드) 연산자 추가
   Map<String, List<String>> m = new HashMap<>();
	```

## 단점

1. Static factory method만 있는 클래스는 public이나 protected로 선언된 클래스가 없으므로 하위 클래스를 만들 수 없다.

   ```java
	public class Collections {
		Collections() {}
	}

	// inheritance
	public class CustomCollections extends Collections {
		public CustomCollections() {
			super(); // 불가능
		}
	}
	```

   그러므로, [Composition](#item16)을 사용한다.

	```java
	// composition
	public class CustomCollections {
		private Collections collections;
	}
	```

	- 상속을 사용하는 경우: `is-a` 관계
	- 컴포지션을 사용하는 경우: `has-a` 관계

2. 다른 Static factory method와 쉽게 구별할 수 없다.

	API 문서에 메서드와 생성자가 분리되어 있지만, static 팩토리 메서드는 다른 메서드와 섞여 잘 구분되지 않는다. 그래서 컨벤션을 정하여 보다 구별하기 쉽게 한다.

	- `valueOf`: 자신의 매개변수와 같은 값을 갖는 인스턴스를 반환
	- `of`: `valueOf` 줄인 형태, [*EnumSet*](#item32)에서 사용
	- `getInstance`: 매개변수에 맞는 인스턴스 반환, 싱글톤인 경우 하나의 인스턴스 반환
	- `newInstance`: 새로운 인스턴스 반환
	- `get`*Type*: `getInstance`와 유사하나 팩토리 메서드가 다른 클래스에 있을 때 사용. 여기서 *Type*은 팩토리 메서드에서 반환되는 객체의 타입을 나타낸다.
	- `new`*Type*: `get`*Type*와 같음(?)

[🔝 *위로 이동*][top]

---

<a name="item2"></a>
# 규칙 2. 생성자의 매개변수가 많을 때는 빌더(builder)를 고려하자

선택적 인자가 많을 때 객체를 생성하는 방법 세 가지.


## 방법 1) 점층적 생성자 패턴(telescoping constructor pattern)

> *Bad Practice 👎*

- 이 방법은 필수 인자만 받는 생성자를 하나 정의하고, 선택적 인자를 받는 생성자를 추가하는 것이다.
- 객체를 생성할 때는 설정하려는 인자 갯수에 맞는 생성자를 골라 호출한다.

**문제점**

- 설정할 필요가 없는 필드에도 인자를 전달해야 해야 한다.
- 인자 수가 늘어날수록 가독성이 떨어진다.

*Code*

```java
public class Person {
	private final String name; // 필수
	private final int age; // 필수
	private final String mail;
	private final String city;
	private final String state;

	public Person(String name, int age) {
		this(name, age, "");
	}

	public Person(String name, int age, String mail) {
		this(name, age, mail, "");
	}

	public Person(String name, int age, String mail, String city) {
		this(name, age, mail, city, "");
	}

	public Person(String name, int age, String mail, String city, String state) {
		this.name = name;
		this.age = age;
		this.mail = mail;
		this.city = city;
		this.state = state;
	}
}
```

*Usage*

```java
Person me = new Person("yeongjun.kim", "27");
Person me = new Person("yeongjun.kim", "27", "opid911@gmail.com");
```


## 방법 2) JavaBeans 패턴

> *Bad Practice 👎*

- 인자 없는 생성자를 호출하여 객체를 만들고, setter로 값 설정하는 방법.
- 객체 생성도 쉽고, 가독성도 좋다.

**문제점**

- 1회의 함수 호출로 객체 생성을 끝낼 수 없으므로, 객체 일관성이 일시작으로 깨질 수 있다.
- 변경 불가능 클래스를 만들 수 없다. 해결하기 위해서 추가 구현할 코드가 많아진다.

*Code*

```java
@Setter
public class Person {
	private String name;
	private int age;
	private String mail;
	private String city;
	private String state;

	public Person() {}
}
```

*Usage*

```java
Person me = new Person();
me.setName("yeongjun.kim");
me.setAge(27);
```


## 방법 3) Builder 패턴<sub>[↩︎][dp-builder]</sub>

> ***Good Practice 👍***

- 필수 인자들을 생성자(또는 정적 팩터리 메서드)에 전달하여 빌더 객체를 만들고, 선택적 인자들을 추가한 뒤, 마지막에 `build()`를 호출하여 Immutable 객체를 만드는 방법.

	*Code*

	```java
	public class Person {
		private final String name;
		private final int age;
		private final String mail;
		private final String city;
		private final String state;

		// 빌더 객체
		public static class Builder {
			// 필수 인자
			private final String name;
			private final String age;
			// 선택적 인자 - 기본값으로 초기화
			private final String mail = "";
			private final String city = "";
			private final String state = "";

			public Builder(String of, int age) {
				this.name = name;
				this.age = age;
			}

			public Builder mail(String mail) {
				this.mail = mail;
				return this;
			}

			public Builder city(String city) {
				this.city = city;
				return this;
			}

			public Builder state(String state) {
				this.state = state;
				return this;
			}

			public Person build() {
				return new Person(this);
			}
		}

		private Person(Builder builder) {
			this.name = name;
			this.age = age;
			this.mail = mail;
			this.city = city;
			this.state = state;
		}
	}
	```

	*Usage*

	```java
	Person me = Person.Builder("yeongjun.kim", 27)
		.mail("opid911@gmail.com")
		.build();
	```

- 빌더 클래스(*Builder*)는 빌더가 만드는 객체 클래스(*Person*)의 정적 맴버 클래스로 정의한다([규칙 22](#item22)).

	```java
	public class Person {
		public static class Builder {
			...
		}
	}
	```

- 불변식을 적용할 수 있으며, build()에서 불변식이 위반되었는지 검사할 수 있다.

	```java
	public class Person {
		public static class Builder {
			...
			public Person build() {
				Person result = new Person(this);
				if(/* result의 값 검사 */) {
					throw new IllegalStateException(/* 위반 원인 */);
				}
				return result;
			}
		}
	}
	```

	- 빌더 객체에서 실제 객체로 인자가 복사된 다음에 불변식들을 검사할 수 있다는 것, 그리고 그 불변식을 빌더 객체의 필드가 아니라 실제 객체의 필드를 두고 검사할 수 있다는 것은 중요하다([규칙 39](#item39)).
	- 불변식을 위반한 경우, *build()*는 *IllegalStateException*을 던져야 한다([규칙 60](#item60)).
	- 예외 객체를 살펴보면 어떤 불변식을 위반했는지 알아낼 수도 있어야 한다([규칙 63](#item63)).

	*cf. 불변식을 강제하는 방법*

	- 불변식이 적용될 값 전부를 인자로 받는 setter를 정의하는 방법.
	- setter는 불변식이 만족하지 않으면 *IllegalArgumentException*을 던짐.
	- build()가 호출되기 전에 불변식을 깨뜨리는 인자가 전달되었다는 것을 신속하게 알 수 있는 장점.

	```java
	public class Person {
		...

		public static class Builder {

			public Builder setNameAndAge(String name, int ate) {
				if(name == null) {
					throw new IllegalArgumentException();
				}
				return this;
			}

			...

			public Person build() {
				return new Person(this);
			}
		}
		...
	}
	```

- 메서드마다 하나씩, 필요한 만큼 varargs 인자를 받을 수 있다.

	```java
	public class Person {
		public static class Builder {
			public Builder names(String... names) {
				this.names = names;
				return this;
			}

			public Builder foramily(String... names) {
				this.farther = names[0];
				this.marther = names[1];
				return this;
			}
		}
		...
	}
	```

- 유연하다. (e.g. 객체가 만들어질 때마다 자동적으로 증가하는 일련번호 같은 것을 채울 수 있다)
- 인자가 설정된 빌더는 훌륭한 [Abstract Factory][dp-abstract-factory]다. JDK1.5 이상을 사용하는 경우, 제네릭 자료형 하나면 어떤 자료형의 객체를 만드는 빌더냐의 관계 없이 모든 빌더에 적용할 수 있다.

	```java
	public interface Builder<T> {
		public T build();
	}
	```

	```java
	public class Person {
		public static class Builder implements Builder<Person> {
			...
			public Person build() {
				return new Person(this);
			}
		}
	}
	```

	**e.g.** *Code at package `java.util.stream`*

	```java
	Stream.builder().add(1).add(2).add(3).build();
	```

- 빌더 객체를 인자로 받는 메서드는 보통 *한정적 와일드카드 자료형<sub>bounded wildcard type</sub>*을 통해 인자의 자료형을 제한한다([규칙 28](#items28)).

	```java
	Tree buildTree(Builder<? extends Node> nodeBuilder) {...}
	```

- 자바가 제공하는 추상적 팩토리로는 Class 객체가 있으며, 이 객체의 *newInstance()* 가 build 메서드 구실을 한다.

	**하지만,** newInstance()는 항상 무인자 생성자를 호출하려 하는데, 문제는 그런 생성자가 없을 수도 있다는 것. TO-DO

**문제점**

- 빌더 객체를 만드는 오버헤드가 문제가 될 수 있다(성능이 중요한 상황). 그러니 인자 갯수가 통제할 수 없을 정도로 많아지만 빌더 패턴을 적용하자.

## 요약

빌더 패턴은 인자가 많은 생성자나 정적 팩터리가 필요한 클래스를 설계할 때, 특시 대부분의 인자가 선택적 인자인 상황에 유용하다.

**cf.** *Code with [Lombok](https://projectlombok.org/features/Builder.html)* - 정적 팩터리 메서드로 구현

```java
@Value // immutable(private, final 적용)
@Builder
public class Person {
	String name;
	int age;
	String mail;
	String city;
	String state;
}
```

[🔝 *위로 이동*][top]

---

<a name="item3"></a>
# 규칙 3. private 생성자나 enum 자료형은 싱글턴 패턴을 따르도록 설계하라

> [싱글턴](dp-singleton)은 객체를 하나만 만들 수 있는 클래스다.

## singleton 구현 방법

### *public static final* 상수(before JDK 1.5)

```java
public class Single {
	public static final Single INSTANCE = new Single();

	private Single() { ... }
}
```

**문제점**

- 리플렉션으로 private 생성자 호출 가능
- 생성자에서 에러날 경우 예외처리 불가능 -> static 초기화 블럭으로 해결 가능

### *static factory* 메서드(before JDK 1.5)

```java
public class Single {
	private static final Single INSTANCE = new Single();
	private Single() { ... }
	public static Single getInstance() {
		return INSTANCE;
	}
}
```

**문제점**

- 리플렉션으로 private 생성자 호출 가능
- 위 두 방법에서 [직렬화](#serializable)가능 클래스로 만드려면 클래스 선언에 `implements Serializable`을 추가하는 것으로는 부족하다.
	- 클래스 선언에 `implements Serializable` 추가
	- 모든 객체 필드에 `transient` 선언
	- [`readResolve()` 추가](#item77)

		```java
		private Object readResolve() {
			// 동일한 객체가 반환되도록 하는 동시에,
			// 가짜 객체는 gc가 처리하도록 만든다.
			return INSTANCE;
		}
		```
- thread safe하려면 synchronized 적용

	```java
	public static synchronized Single getInstance() { ... }
	```  

### Initialization on demand holder idiom

- jvm 의 class loader의 매커니즘과 class의 load 시점을 이용하여 내부 class를 생성시킴으로 thread 간의 동기화 문제를 해결
- lazy initialization

```java
public class Singleton {
	private Singleton() { }

	private static class SingletonHolder {
	        public static final Singleton INSTANCE = new Singleton();
	}

	public static Singleton getInstance() {
	        return SingletonHolder.INSTANCE;
	}
}
```

### *enum*을 이용하는 방법(after JDK 1.5)

```java
public enum Single {
	INSTANCE;
	...
}
```

- 직렬화 자동으로 처리된다.
- 리플렉션 공격에도 안전하다.
- Enum 생성은 Thread-safe하지만, 내부 메서드들은 Thread-safe를 보장하지 않는다.

*why?*

- 선언된 상수 이외의 다른 객체는 존재할 수 없다는 확실한 보장이 생긴다(JVM이 해주는 보장).
- `enum` 타입은 `Comparable` 인터페이스, `Serializable` 인터페이스가 구현되어 있다.

## 참고

### Link

- java singleton pattern (싱글톤 패턴) - https://blog.seotory.com/post/2016/03/java-singleton-pattern
- 게으른 홀더를 통한 싱글턴의 동시성 문제 해결 (Initialization on demand holder idiom) - http://changsuk.me/?p=1433
- Thread-safe Enum Singleton - http://stackoverflow.com/questions/28369025/thread-safe-enum-singleton

### serializable

> 객체의 내용을 파일에 저장하거나 네트워크로 전송하기 위해서 스트림으로 만드는 작업(바이트 단위로 변환)

- `Serializable` 인터페이스 구현
- 모든 필드 또한 `Serializable` 인터페이스 구현
- 제외하고자하는 필드는 `transient`

*example*

```java
public class Test {
	public static void main(String[] args) throws IOException, ClassNotFoundException {
		SerializerTest test = new SerializerTest();
		test.serialization();
		test.deserialization();
	}
}

class SerializerTest {
	private String filePath = "/Users/yeongjun/Desktop/test.ser";
	private User user;

	public void serialization() throws IOException {
		user = new User("yj", 26, "pwd");
		FileOutputStream f = new FileOutputStream(filePath);
		ObjectOutputStream o = new ObjectOutputStream(f); // 직렬화 클래스
		o.writeObject(user); // 파라미터로 넘긴 객체를 스트림으로 만들어서 출력하는 메서드
		o.close();
	}

	public void deserialization() throws IOException, ClassNotFoundException {
		FileInputStream f = new FileInputStream(filePath);
		ObjectInputStream o = new ObjectInputStream(f); // 역직렬화 클래스
		user = (User)o.readObject(); // 입력된 스트림으로부터 객체를 만들어서 반환하는 메서드
		o.close();
		System.out.println(user.toString());
	}
}

class User implements Serializable {
	private static final long serialVersionUID = 1L; // 이건 왜?
	private String name;
	private int age;
	private transient String password;

	public User(String name, int age, String password) {
		this.name = name;
		this.age = age;
		this.password = password;
	}

	@Override
	public String toString() {
		return "User{name='" + name + '\'' + ", age=" + age + ", password='" + password + "\'}";
	}
}
```

[🔝 *위로 이동*][top]

---

<a name="item4"></a>
# 규칙 4. 객체 생성을 막을 때는 private 생성자를 사용하라

- 생성자를 생략하면 컴파일러는 자동으로 인자없는 `public` 생성자를 만든다. 그러므로, 객체 생성을 막기 위해서 `private` 생성자를 추가한다.
- `AssertionError()`를 통해 혹시나 클래스내에서 생성자를 사용할 경우를 방지한다.

```java
public class Utils {
	private Utils() {		
		throw new AssertionError();
	}
}
```

**cf.** *Code with [Lombok](https://projectlombok.org/features/experimental/UtilityClass.html)*

- 필드, 메서드를 static으로 변환
- private 생성자 추가

```java
@UtilityClass
public class Utils {
	private final int VERSION  = 1;

	public void getVersion() {
		return VERSION;
	}
}
```

🔝 [*위로 이동*][top]

---

<a name="item5"></a>
# 규칙 5. 불필요한 객체는 만들지 말라

- 변경 불가능(immutable) 객체는 언제나 재용사할수 있다.([규칙 15](#item15))
- *Bad Practice* 코드는 실행될 때마다 `String` 객체를 만드는 쓸데없는 짓을 한다. loop 도는 만큰 `String` 객체를 생성한다. *Good Practices*는 실행할 때마다 객체를 생성하지 않고, 동일한 `String` 객체를 사용한다. 같은 가상머신에서 실행되는 모든 코드가 해당 객체를 사용한다([JLS, 3.10.5](https://docs.oracle.com/javase/specs/jls/se8/html/jls-3.html#jls-3.10.5)).

	```java
	for(int i = 0; i < 999999; i++) {
		// Bad Practice
		System.out.println(new String("test"));

		// Good Practice
		System.out.println("test");
	}
	```

- Static Factory Method([규칙 1](#item1))를 이용하면 불필요한 객체 생성을 피할 수 있다.

	```java
	Boolean.valueOf(String)
	```

- 변경 가능한 객체이지만 변경할 일이 없다면 재사용한다.

	*AS-IS*

	```java
	public class Person {
		private final Date birthDate;

		public boolean isBabyBoomer() {
			Calendar gmtCal = Calendar.getInstance(TimeZone.getTimeZone("GMT"));
			gmtCal.set(1946, Calendar.JANUARY, 1, 0, 0, 0);
			Date boomStart = gmtCal.getTime();
			gmtCal.set(1965, Calendar.JANUARY, 1, 0, 0, 0);
			Date boomEnd = gmtCal.getTime();
			return birthDate.compareTo(boomStart) >= 0 && birthDate.compareTo(boomEnd) < 0;
		}
	}
	```

	*TO-BE*

	```java
	public class Person {
		private final Date birthDate;

		private static final Date BOOM_START;
		private static final Date BOOM_END;

		static {
			Calendar gmtCal = Calendar.getInstance(TimeZone.getTimeZone("GMT"));
			gmtCal.set(1946, Calendar.JANUARY, 1, 0, 0, 0);
			BOOM_START = gmtCal.getTime();
			gmtCal.set(1965, Calendar.JANUARY, 1, 0, 0, 0);
			BOOM_END = gmtCal.getTime();
		}

		public boolean isBabyBoomer() {
			return birthDate.compareTo(BOOM_START) >= 0 && birthDate.compareTo(BOOM_END) < 0;
		}
	}
	```

	static initialzer을 하지않고 [lazy initialization](#item71) 기법을 사용할 수도 있다. 하지만, 추천하지 않는다. 구현이 복잡해질 뿐더러 *TO-BE*로 개선한 것 이상으로 성능을 높이기 어렵기 때문이다([규칙 55](#item55)).

- 어댑터 TO-DO
- JDK 1.5 이후, 쓸데없는 객체 생성하는 방법 추가 - autoboxing

	```java
	public static void main(String[] args) {
		Long sum = 0L;
		for (long i = 0; i < Integer.MAX_VALUE; i++) {
			sum += i;
		}
	}
	```

	`sum`이 `long`이 아닌 `Long`으로 선언되어 있기 때문에 더해질때마다 객체가 생성된다(2^31개 생성). 객체 표현형 대신 기본 자료형을 사용하고, 생각지도 못한 자동 객체화가 발생하지 않도록 유의하라.

- 직접 관리하는 객체 풀을 만들어 객체 생성을 피하는 기법은 객체 생성 비용이 극단적으로 높지 않다면 사용하지 않는 것이 좋다.

	독자적으로 관리되는 객체풀을 만들면,

	- 코드의 복잡성
	- 메모리 요구량 증가
	- 성능 떨어짐

	사용해야할 상황: **데이터베이스**

	- 접속 비용이 큼
	- 라이선스 정책에 따라 연결 수가 제한될 수 있음

- 규칙 39는 방어적 복사<sub>defensive copy</sub>에 관한 것.
	- 규칙 5: "재사용이 가능하다면 새로운 객체는 만들지 말라"
	- [규칙 39](#item39): "새로운 객체를 만들어야 한다면 기존 객체는 재사용하지 말라"

	방어적 복사가 요구되는 상황에서 객체를 재사용하는 것은 (쓸데없이 같은 객체를 만드는) 비용보다 훨씬 높다는 것에 유의하자. 필요할 때 방어적 복사본을 만들지 못하면 버그나 보안 결함으로 이어진다. 쓸데 없는 객체들은 고작 코드 스타일과 성능에나 영향을 줄 뿐이다.

	```java
	// 방어적 복사 방법
	public Period(Date start, Date end) {
		this.start = new Date(start.getTime());
		this.end = new Date(end.getTime());
	}
	```

[🔝 *위로 이동*][top]

---

<a name="item6"></a>
# 규칙 6. 유효기간이 지난 객체 참조는 폐기하라

*e.g. 메모리 누수*

```java
public class Stack {
	private Object[] element = new Object[16];
	private int size = 0;

	public void push(Object e) {
		ensureCapacity();
		elements[size++] = e;
	}

	public Object pop() {
		if (size == 0)
			throw new EmptyStackException();
		return elements[--size];
	}

	private void ensureCapacity() {
		if (elements.length == size) {
			elements = Arrays.copyOf(elements, 2 * size + 1);
		}
	}
}
```

스택이 커졌다가 줄어들 때, 인덱스 값이 size보다 큰 곳에 있는 요소들(쓰레기 값)은 GC가 처리하지 못한다. 스택이 그런 객체에 대한 *만기 참조<sub>obsolete reference</sub>*를 제거하지 않기 때문이다. 만기 참조란 다시 이용되지 않을 참조<sub>reference</sub>를 말한다.

자동적으로 쓰레기 객체를 수집하는 언어에서 발생하는 메모리 누수 문제(≒ 의도치 않은 객체 보유<sub>unintentional object retention</sub>)는 찾아내기 어렵다.

## 해결방안

만기 참조를 제거하는 가장 좋은 방법은, 해당 참조가 보관된 변수의 유효범위<sub>socpe</sub>를 최대한 좁게 만들어 벗어나게 두는 것이다([규칙 45](#item45)).

위 예제 Stack과 같이 자체적으로 메모리는 관리하는 경우에는, 쓸 일이 없는 객체 참조는 반드시 null로 바꿔준다.

```java
public Object pop() {
	if (size == 0)
		throw new EmptyStackException();
	Object result = elements[--size];
	elements[size] = null;
	return result;
}
```

## 흔히 메모리 누수가 발견되는 곳

- 자체적으로 관리하는 메모리가 있는 클래스
- 캐시<sub>cache</sub>: 객체 참조를 캐시 안에 넣어 놓고 잊어버리는 일이 많기 때문. (수명이 키에 대한 외부 참조의 수명에 따라 결정되는 상황에는 *WeakHashMap* 활용)
- 리스너<sub>listener</sub>등의 역호출자<sub>callback</sub> - 콜백을 명시적으로 제거하지 않을 경우, 적절한 조치를 취하기 전까지 메모리는 점유된 상태. 해결방안으로 콜백에 대한 약한 참조<sub>weak reference</sub>만 저장하는 것(WeakHashMap)

[🔝 *위로 이동*][top]

---

<a name="item7"></a>
# 규칙 7. 종료자 사용을 피하라

## finalize?

```java
public class Object {
	/**
	 * Called by the garbage collector on an object when garbage collection
	 * determines that there are no more references to the object.
	 * ...
	 */
	protected void finalize() throws Throwable { }
}
```

> ‼️ **종료자<sub>finalizer</sub>는 예측 불가능하며, 대체로 위험하고, 일반적으로 불필요하다.** ... 어쨌든 종료자 사용은 피하는 것이 원칙이다.

- GC가 객체에 대한 참조가 더 이상 없다고 판단할 때 GC로부터 호출된다. 하지만, 즉시 실행되리라는 보장이 전혀 없다([JLS, 12.6](https://docs.oracle.com/javase/specs/jls/se8/html/jls-12.html#jls-12.6)). **따라서 긴급한(time-critical) 작업을 종료자 안에서 처리하면 안 된다**(e.g. finalize안에서 파일 닫기).
- 종료자의 실행시점은 GC 알고리즘에 좌우되는데, 이 알고리즘은 JVM 구현마다 크게 다르다.
- 종료자의 더딘 실행<sub>tardy finalization</sub>은 단순히 이론적인 문제가 아니다. 클래스에 종료자를 붙여 놓으면, 드문 일이지만 객체 메모리 반환이 지연될 수도 있다.
- 종료자가 실행되지 않은 객체가 남은 상태로 프로그램이 끝나는 일도 충분히 가능하다. 그러므로 **지속성이 보장되어야 하는 중요 상태 정보<sub>critical persistent state</sub>는 종료자로 갱신하면 안 된다.**
- `System.gc()`나 `System.runFinalization()` 같은 메서드는 종료자 실행 가능성을 높여주긴 하지만 보장하지 않는다.
- `System.runFinalizersOnExit()`, `Runtime.runFinalizersOnExit()`는 종료자 실행을 보장하지만, 심각한 결함을 갖고 있어 이미 명세에서 deprecated 되었다.
- **종료자를 사용하면 프로그램 성능이 심각하게 떨어진다.**
- **명시적인 종료 메서드<sub>termination method</sub>를 하나 정의**하고, 더 이상 필요하지 않는 객체라면 클라이언트가 해당 메서드를 호출하도록 하라. 명심할 것은, 종료 여부를 객체 안에 보관해야 한다(유효하지 않은 객체임을 표시하는 private 필드 선언).
- **명시적 종료 메서드는 보통 try-finally 문과 함께 쓰인다. 객체 종료를 보장하기 위해서다.** Java1.7부터는 try-with-resources문 제공하기 때문에 finally 블록은 사용하지 않아도 된다([try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html)).

## 사용하기 적합한 곳

- 명시적 종료 메서드 호출을 잊을 경우를 대비하는 안전망<sub>safety net</sub>으로서의 역할.

	**종료자는 반환되지 않은 자원을 발견하게 될 경우 반드시 log를 남겨야 한다.** 클라이언트 코드에 버그가 있는 것이므로, 고치도록 알려야 하기 때문이다. (추가 비용을 감당하면서 구현할 가치가 있는지 신중하게 생각한다)

- *네이티브 피어<sub>native peer: 일반 자바 객체가 네이티브 메서드를 통해 기능 수행을 위임하는 네이티브 객체</sub>*와 연결된 객체를 다룰 때.

	네이티브 피어는 일반 객체가 아니므로, 객체가 소멸되더라도 GC는 모른다(GC가 알 수 없을 뿐더라 Java peer가 반환될 때 같이 반환할 수도 없다). 네이티브 피어가 중요한 자원을 점유하고 있지 않다고 가정한다면, 종료자는 그런 객체의 반환에 걸맞다. 즉시 종료되어야 하는 자원을 포함하는 경우에는, 명시적인 종료 메서드를 클래스에 추가해야 한다.

## 주의할 점

- finalizer chaining이 자동으로 이루어지지 않는다.

	종료자를 구현한 클래스를 상속받은 경우, 하위 클래스의 종료자는 상위클래스의 종료자를 명시적으로 호출해야 한다.

	```java
	@Override
	protected void finalize() throws Throwable {
		try {
			...
		} finally {
			// 반드시 호출시키기 위해 try-finally 사용
			super.finalize();
		}
	}
	```

	**더 나은 방법 - 종료 보호자 패턴**

	종료되어야 하는 객체의 클래스마다 안에 종료자를 정의하는 대신 익명 클래스를 활용하는 방법. 이 익명 클래스로 만든 객체를 *종료 보호자<sub>finalizer guardian</sub>*라고 한다. Foo 객체의 참조가 사라지는 순간 종료 보호자도 실행 가능한 상태가 된다.

	```java
	// 종료 보호자 숙어(Finalizer Fuardian idiom)
	public class Foo {
		// 이 객체는 바깥 객체(Foo)를 종료시키는 역할만 한다
		private final Object finalizerFuardian = new Object() {
			@Override
			protected void finaliza() throws Throwable {
				// 바깥 Foo 객체를 종료시킴
			}
		}
	}
	```

[🔝 *위로 이동*][top]

---

<a name="item8"></a>
# 규칙 8. equals를 재정의할 때는 일반 규약을 따르라

## Override 상황

### Override 하지 않는 경우

1. 각각의 객체가 고유할 때

	값<sub>value</sub> 대신 활성 개체<sub>active entity</sub>를 나타내는 *Thread* 같은 클래스.

2. 논리적 동일성<sub>logical equality</sub> 검사 방법이 상관 없을 때

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

### Override 하는 경우

1. *논리적 동일성<sub>logical equality</sub>*의 개념을 지원하는 클래스일 때
2. 상위 클래스의 equals가 하위 클래스의 필요를 충족하지 못할 때

### Override 할 필요가 없는 경우

1. 개체 통제([규칙 1](#item1)) 기능으로 하나의 객체만 존재하는 클래스(e.g. 싱글톤, enum([규칙 30](#item30)))

## Override 규약, 주의

### equals 메서드를 정의할 때 준수해야 하는 일반 규약<sub>general contract</sub>

> *Object* 클래스 명세(specification)[JavaSE6]

*동치 관계<sub>equivalence relation</sub>* 구현, 다음과 같은 관계를 동치 관계라 한다.

- **반사성<sub>Reflexivity</sub>**: `x.equals(x)`는 `true`
- **대칭성<sub>Symmetry</sub>**: `x.equals(y)`가 `true`일 때, `y.equals(x)`도 `true`

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

- **추이성<sub>Transitivity</sub>**: `x.equals(y)`가 `true`이고, `y.equals(z)`가 `true`이면 `x.equals(z)`도 `true`

	*e.g. 하위 클래스에서 새로운 값 컴포넌트<sub>value component</sub>를 추가하는 상황.*

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

	> 사실 이것은 객체 지향 언어에서 동치 관계<sub>equivalence relation</sub>를 구현할 때 발생하는 본질적 문제다. 객체 지향적 추상화<sub>object-oriented abstraction</sub>의 혜택을 누리지 않을 거라면 모를까, **객체 생성 가능 클래스를 계승하여 새로운 값 컴포넌트를 추가하면서 equals 규약을 어기지 않을 방법은 없다.**

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



- **일관성<sub>Consistency</sub>**: 값의 변화가 없다면 `x.equals(y)`는 호출 횟수에 상관없이 항상 같아야 함

	- 클래스를 구현할 때는 Mutable or immutable 을 깊이 생각해본다([규칙 15](#item15)).
	- 신뢰성이 보장되지 않는 자원<sub>unreliable resource</sub>들을 비교하는 equals를 구현하는 것은 삼가라. 그렇지 않으면 일관성 규약을 만족시키기가 너무 어려움.

- **Null에 대한 비 동치성<sub>Non-nullity</sub>**: *null*이 아닌 참조 x에 대해서 `x.equals(null)`은 항상 `false`

	equals의 일반 규약에서는 예외가 발생하는 것을 허용하지 않는다(e.g. NPE). 그래서 상당수의 클래스는 equals() 안에서 null 조건을 명시적으로 검사하는데(e.g. `if (o == null) return false;`), 이런 검사는 불필요하다.

	왜냐하면, equals 메서드는 먼저 인자를 형변환<sub>cast</sub>하는데, *instanceof* 연산자는 첫 번째 피연산자가 null이면 무조건 false를 반환한다[[JLS, 15.20.2](https://docs.oracle.com/javase/specs/jls/se7/html/jls-15.html#jls-15.20.2)].

	```java
	@Override
	public boolean equals(Object e) {
		if (!(o instanceof CustomType)) {
			return false;
		}
		...
	}
	```

### equlas 메서드를 구현하기 위해 따라야 할 지침

1. == 연산자를 사용하여 equals의 인자가 자기 자신인지 검사 -> 단순히 성능 최적화<sub>performance optimization</sub>
2. instanceof 연산자를 사용하여 인자의 자료형이 정확한지 검사
3. equals의 인자를 정확한 자료형으로 변환
4. 각각의 필드가 일치하는지 검사
5. equals 메서드 구현을 끝냈다면, 대칭성·추이성·일관성의 세 속성이 만족하는지 검토 -> unit test

(+) 추가 주의 사항

- equals를 구현할 떄는 hashCode도 재정의하라
- 너무 머리 쓰지 마라
- equals 메서드의 인자 형을 Object에서 다른 것으로 바꾸지 마라

[🔝 *위로 이동*][top]

---

<a name="item9"></a>
# 규칙 9. equals 메서드를 재정의하는 클래스는 반드시 hashCode 메서드도 재정의 해야 한다

> Object 일반 규약[JavaSE6]
>
> - 응용프로그램 실행 중에 같은 객체의 hashCode를 여러 번 호출하는 경우, equals가 사용하는 정보들이 변경되지 않았다면, 언제나 동일한 정수가 반환되어야 한다. 다만 프로그램이 종료되었다가 다시 실행되어도 같은 값이 나올 필요는 없다.
> - equals(Object) 메서드가 같다고 판정한 두 객체의 hashCode 값은 같아야 한다.
> - equals(Object) 메서드가 다르다고 판정한 두 객체의 hashCode 값은 꼭 다를 필요는 없다.그러나 서로 다른 hashCode 값이 나오면 hash table의 성능이 향상될 수 있다는 점은 이해하고 있어야 한다.

- **equals 메서드를 재정의하는 클래스는 반드시 hashCode 메서드도 재정의 해야 한다.** override 하지 않으면 Object 일반 규약중 두번째, 같은 객체는 같은 해시 코드 값을 가져야 한다는 규약이 위반되는 것이다. 재정의하지 않으면 Hash 기반 컬렉션과 함께 사용하면 오동작한다(e.g. HashMap, HashSet, ...)
- 좋은 해시 함수는 다른 객체에서 다른 해시 코드를 반환하는 경향이 있다. - 충돌<sub>Collision</sub> 회피
	- 이상적인 해시 함수 만드는 방법 책 참고 - p64
	- [lombok](https://projectlombok.org/features/EqualsAndHashCode.html)의 `@EqualsAndHashCode` 참고(책의 방법과 비슷)
- 해시 코드 계산 비용이 높은 변경 불가능 클래스를 만들 때는, 재계산하는 대신 캐시해 두어야 할 수도 있다. 또한 경우에 해시 키에 따라 lazy initialization도 가능하다.
- **주의할 것은, 성능을 개선하려고 객체의 중요 부분을 해시 코드 계산 과정에서 생략하면 안된다.**

## 참고

- [Java HashMap은 어떻게 동작하는가?](http://d2.naver.com/helloworld/831311)

[🔝 *위로 이동*][top]

---

<a name="item10"></a>
# 규칙 10. toString은 항상 재정의하라

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

[🔝 *위로 이동*][top]

---

<a name="item11"></a>
# 규칙 11. clone을 재정의할 때는 신중하라

## Cloneable 인터페이스

- 어떤 객체가 clone을 허용한다는 사실을 알리는 데 쓰려고 고안된 *mixin 인터페이스*([규칙 18](#item18))
	- clone 메서드가 없으며, Object의 clone 메서드는 potected로 선언되어 있다.
- protected로 선언된 Object의 clone 메서드가 어떻게 동작할지 정한다.
	- 어떤 클래스가 Cloneable을 구현하면, Object의 clone 메서드는 해당 객체를 필드 단위로 복사한 객체를 반환
	- 어떤 클래스가 Cloneable을 구현하지 않으면 CloneNotSupportedExceptiond을 던짐
- 인터페이스를 괴상하게 이용한 사례
	- 일반적으로 인터페이스를 구현한다는 것은 클래스가 무슨 일을 할 수 있는지 클라이언트에게 알리는 것
	- Clonealed은 상위 클래스의 protected 맴버가 어떻게 동작할지 규정하는 용도
- Cloneable을 구현해서 어떤 결과를 얻으려면, 해당 클래스뿐 아니라 그 모든 상위 클래스들은 복잡한 데다 강제할 수 없고(unenforceable) 문서도 부족한 프로토콜을 따라야 한다. 그리고 그렇게 하면 언어 외적인(ectralinguistic) 객체 생성 메커니즘이 탄생한다. 생성자 호출 없이도 객체를 생성할 수 있게 되는 것이다.

## java.lang.Object.clone() 일반 규약

- 객체의 복사본을 만들어서 반환
- "복사"의 정확한 의미는 클래스마다 다르며, 일반적으로 다음과 같은 조건이 충족되어야 한다.
	- True: `x.clone() != x`
	- True 그러나 반드시 True여야 하는 것은 아님:
		- ① `x.clone().getClass() == x.getClass()`
		- `x.cline().equals(x)`
- 내부 자료구조까지 복사해야 될 수도 있다.
- ② 어떤 생성자도 호출되지 않는다.

## clone() 규약의 문제점

- ② 규정은 너무 심하다.
	- clone이 만드는 복사본의 내부 객체는 생성자로 만들 수도 있다.
	- 클래스가 final로 선언되어 있다면, 생성자로 만든 객체를 반환하도록 clone을 구현할 수도 있다.
- ① 규정은 너무 느슨하다.

## 중점?

- 비-final 클래스에 clone을 재정의할 때는 반드시 super.clone을 호출해 얻은 객체를 반환해야 한다.
- 실질적으로 Cloneable 인터페이스를 구현하는 클래스는 제대로 동작하는 public clone 메서드를 제공해야 한다.
- 라이브러리가 할 수 있는 일을 클라이언트에게 미루지 말라.
- 사실상, clone 메서드는 또 다른 형태의 생성자다. 원래 객체를 손상시키는 일이 없도록 해야 하고, 복사본의 불변식<sub>invariant</sub>도 제대로 만족시켜야 한다.
- clone의 아키텍처는 변경 가능한 객체를 참조하는 final 필드의 일반적 용볍과 호환되지 않는다.
- 객체를 복사할 대안을 제공하거나, 아예 복제 기능을 제공하지 않는 것이 낫다.
- 객체 복제를 지원하는 좋은 방법은 *복사 생성자<sub>copy constructor</sub>*나 *복사 팩터리<sub>copy factory</sub>*를 제공하는 것이다.

[🔝 *위로 이동*][top]

---

<a name="item12"></a>
# 규칙 12. Comparable 구현을 고려하라

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

[🔝 *위로 이동*][top]

---

<a name="item13"></a>
# 규칙 13. 클래스와 맴버의 접근 권한을 최소화하라

- 소프트웨어 설계의 기본적인 원칙 중 하나 - 정보 은닉<sub>information hiding</sub>, 캡슐화<sub>encapsulation</sub>
- 접근 권한은 가능한 낮춰라.
- public static final 필드를 제외한 어떤 필드도 public 필드로 선언하지 마라
- public static final 필드가 참조하는 객체는 변경 불가능 객체로 만들어라

## 정보 은닉, 캡슐화

- 시스템을 구성하는 모듈 사이의 *의존성을 낮춤<sub>decouple</sub>*
- 성능을 보장하는 것은 아니지만, 효과적인 성능 튜닝을 가능하게 한다. 어떤 모듈이 성능 문제를 일으키는지 프로파일링<sub>profiling</sub> 하기 용이하기 때문([규칙 55](#item55))
- 소프트웨어의 재사용 가능성을 높인다.
- 대규모 시스템 개발 과정의 리스트를 낮춘다.
- 접근 제어<sub>access control</sub> 메커니즘은 클래스와 인터페이스, 그리고 그 멤버들의 접근 권한<sub>accessibility</sub>을 규정한다([JLS, 6.6](https://docs.oracle.com/javase/specs/jls/se8/html/jls-6.html#jls-6.6))
- **각 클래스와 멤버는 가능한 한 접근 불가능하도록 만들라는 것** - 가장 낮은 접근 권한 설정
- **객체 필드<sub>instance field</sub>는 절대로 public으로 선언하면 안 된다**([규칙 14](#item14)).
- **변경 가능 public 필드를 가진 클래스는 다중 스레드에 안전하지 않다.**
- 예외적으로 어떤 상수들이 클래스로 추상화된 결과물의 핵심적 부분을 구성한다고 판단되는 경우, 해당 상수들을 `public static final` 필드들로 선언하여 공개할 수 있다. 이런 필드들은 관습적으로 대문자로 구성된 이름을 가지며, 이름을 구성하는 단어들은 밑줄 기호로 구분한다([규칙 56](#item56)). 이런 필드들은 반드시 기본 자료형 값들을 갖거나, 변경 불가능 객체를 참조해야 한다([규칙 15](#item15)).
- 길이가 0 아닌 배열은 언제나 변경 가능하므로, **public static final 배열 필드를 두거나, 배열 필드를 반환하는 접근자<sub>accessor</sub>를 정의하면 안 된다.** - 보안문제 유발

	```java
	/* AS-IS */
	// 보안 문제를 초래할 수 있는 코드
	public static final Thing[] VAUES = {...};

	/* TO-BE */
	// (1) 변경 불가능 public 리스트 사용
	private static final Thing[] PRIVATE_VALUES = {...};
	public static final List<Thing> VALUES = Collections.unmodifiableList(Arrays.asList(PRIVATE_VALUES));

	// (2) 복사해서 반환하는 메서드 추가
	private static final Thing[] PRIVATE_VALUES = {...};
	public static final Thing[] values() {
		return PRIVATE_VALUES.clone();
	}
	```

[🔝 *위로 이동*][top]

---

<a name="item14"></a>
# 규칙 14. public 클래스 안에는 public 필드를 두지 말고 접근자 메서드를 사용하라

- **getter/setter(접근자 메서드)를 사용하자**
	- 캡슐화의 이점
	- 불변식 가능
	- 필드 사용시 다른 동작 가능
	- (+) boilerplate code를 줄이기 위해서 lombok의 `@Data`, `@Value` 활용
- 원칙을 어긴 Java 클래스 - `Point.class`, `Dimension.class`
	- 이런 클래스는 참고하지 않는 것이 좋다.
	- Dimension 클래스가 내부 표현을 공개한 것은 아직까지도 해결되지 않고 있는 심각한 성능 문제 때문이다([규칙 55](#item55)에 설명).

[🔝 *위로 이동*][top]

---

<a name="item15"></a>
# 규칙 15. 변경 가능성을 최소화하라

**요약**

- Mutable Class로 만들 타당한 이유가 없다면, 반드시 Immutable Class로 만들어야 한다
	- 모든 getter 마다 그에 대응하는 setter를 두는 것은 피하라
	- 유일한 장점은 특정 상황에서 성능 문제가 생길 수 있다는 것이다
	- 작은 객체는 반드시 immutable로 만들어라
- Immutable Class로 만들 수 없다면, 변경 가능성을 최대한 제한하라
- 특별한 이유가 없다면 모든 필드는 final로 선언하라
	- 특별한 이유가 없다면, 생성자 이외에 public 초기화 메서드나 정적 팩터리 메서드를 제공하지 마라
	- 재 초기화 메서드도 제공하지 마라. 코드 복잡성만 늘어나고, 성능 향상에 도움 되는 경우는 거의 없다

## 변경 불가능<sub>immutable</sub> 클래스 생성 규칙

- 객체 상태를 변경하는 메서드(수정자<sub>mutator</sub> 메서드 등)를 제공하지 않는다.
- 계승할(상속 받을) 수 없도록 한다. - e.g. `public final class { ... }`
- 모든 필드는 final로 선언한다.
	- 프로그래머의 의도가 분명해짐
	- 자바 *메모리 모델*에 명시된 바와 같이[[JLS, 17.5](https://docs.oracle.com/javase/specs/jls/se7/html/jls-17.html#jls-17.5)], 새로 생성된 객체에 대한 참조가 동기화 없이 다른 스레드로 전달되어도 안전
- 모든 필드를 private로 선언한다.
- 변경 가능 컴포넌트에 대한 독점적 접근권을 보장한다.
	- 변경 가능 객체에 대한 참조를 클라이언트는 획득할 수 없어야 한다.
	- 그런 필드는 클라이언트가 제공하는 객체로 초기화해서는 안되고, 접근자<sub>accessor</sub> 또한 그런 필드를 반환해서는 안 된다.
	- 생성자나 접근다, readObject 메서드([규칙 76](#item76))안에서는 *방어적 복사본<sub>defensive copy</sub>*을 만들어야 한다([규칙 39](#item39)).

## Immutable Object 특징

- **변경 불가능 객체는 단순하다. 생성될 때 부여된 한 가지 상태만 갖는다.**
- **변경 불가능 객체는 스레드에 안전(thread-safe)할 수밖에 없다. 어떤 동기화도 필요 없으며,** 여러 스레드가 동시에 사용해도 상태가 훼손될 일이 없다.
- **변경 불가능 객체는 자유롭게 공유할 수 있다.** 방어적 복사본([규칙 39](#item39))을 만들 필요가 없단 뜻이기도 하다.
- **변경 불가능 객체는 그 내부도 공유할 수 있다.**
- **변경 불가능 객체는 다른 객체의 구성요소로도 훌륭하다.**
- **변경 불가능 객체의 유일한 단점은 값마다 별도의 객체를 만들어야 한다는 점이다.** 따라서 객체 생성 비용이 높을 가능성이 있다.

## Immutable Object 생성하는 다른 방법

모든 생성자를 private이나 package-private로 선언하고 public 생성자 대신 public 정적 팩터리 제공([규칙 1](#item1)) - 장점은 규칙 1 확인

[🔝 *위로 이동*][top]

---

<a name="item17"></a>
# 규칙 17. 계승을 위한 설계와 문서를 갖추거나, 그럴 수 없다면 계승을 금지하라

- 재정의 가능 메서드를 내부적으로 어떻게 사용하는지 반드시 문서에 남겨라.
	- 관습적으로, 재정의 가능 메서드를 어떤 식으로 호출하는지는 메서드 주석문 마지막에 명시한다.

[🔝 *위로 이동*][top]

---

<a name="item18"></a>
# 규칙 18. 추상 클래스 대신 인터페이스를 사용하라

- 이미 있는 클래스를 개조해서 새로운 인터페이스를 구현하도록 하는 것은 간단하다.
- 인터페이스는 믹스인<sub>mixin</sub>을 정의하는 데 이상적이다.<br/>
믹스인은 클래스가 "주 자료형<sub>primary type</sub>" 이외에 추가로 구현할 수 있는 자료형으로, 어떤 선택적 기능을 제공한다는 사실을 선언하기 위해 쓰인다. (e.g. Comparable)
- 인터페이스는 비 계층적인(nonhierarchical) 자료형 프레임워크를 만들 수 있도록 한다.

	```java
	public interface SingerSongwriter extends Singer, Songwriter {
		AudioClip strum();
		void actSensitive();
	}
	```

	- 인터페이스를 쓰지 않으려면 필요한 속성 조합마다 별도의 클래스를 만들어 거대한 클래스 계층을 만들어야 한다. 필요한 속성이 n개가 있다면 지원해야 하는 조합의 가짓수는 2<sup>n</sup>개에 달한 것이다. 이런 문제는 *조합 폭증<sub>combinatorial explosion</sub>*이라는 이름으로 알려져 있다.
- 인터페이스를 사용하면 *포장 클래스 숙어<sub>wrapper class idiom</sub>*를 통해([규칙 16](#item16)) 안전하면서도 강력한 기능 개선이 가능하다.
- *추상 골격 구현 클래스<sub>abstract skeletal implementation</sub>*를 중요 인터페이스마다 두면, 인터페이스의 장점과 추상 클래스의 장점을 결합할 수 있다.
	- 인터페이스로는 자료형을 정의하고, 구현하는 일은 골격 구현 클래스에 맡기면 된다.
	- 관습적으로 골격 구현 클래스의 이름은 Abstract*Interface*와 같이 정한다.<br/>
		(e.g. Collection Framework에는 인터페이스별로 골격 구현 클래스들이 하나씩 제공된다. `AbstractCollection`, `AbstractSet`, `AbstractList`, `AbstractMap`)
	- 골격 구현 클래스를 적절히 정의하기만 하면, 프로그래머는 쉽게 인터페이스를 구현할 수 있다.
- 추상클래스의 장점으로 인터페이스보다 추상 클래스가 발전시키기 쉽다. 하지만 java 1.8에서는 인터페이스에 default 메서드를 추가할 수 있다(하지만 인터페이스당 한 개의 default 메서드).
- 인터페이스가 공개되고 널리 구현된 다음에는, 인터페이스 수정이 거의 불가능하다. 그러므로, public 인터페이스는 극도로 주의해서 설계해야 하며 실제로 여러 구현을 만들어 보면서 광범위하게 테스트해야 한다.

[🔝 *위로 이동*][top]

---

<a name="item19"></a>
# 규칙 19. 인터페이스는 자료형을 정의할 때만 사용하라

- **상수 인터페이스 패턴은 인터페이스를 잘못 사용한 것이다.** 클래스가 어떤 상수를 어떻게 사용하느냐 하는 것은 구현 세부사항이다.

	```java
	public interface PhysicalConstants {
		static final double AVOGADROS_NUMBER = 6.02214199e23;
	}
	```
- 상수를 API 일부로 공개하고 싶을 때는 더 좋은 방법이 있다.
	- 해당 상수가 이미 존재하는 클래스나 인터페이스에 강하게 연결되어 있을 때는 해당 클래스/인터페이스에 추가한다.
	- enum 자료형의 멤버가 되어야 바람직할 때는 enum 자료형과 함께 공개한다.
	- 객체 생성이 불가능한 유틸리티 클래스에 넣어서 공개한다.
- 인터페이스는 자료형을 정의할 때만 사용해야 한다. 특정 상수를 API의 일부로 공개할 목적으로는 적절치 않다.

[🔝 *위로 이동*][top]

---

<a name="item20"></a>
# 규칙 20. 태그 달린 클래스 대신 클래스 계층을 활용하라

> *Tagged Class*<br/>
> 두 가지 이상의 기능을 가지고 있고, 그중 어떤 기능을 제공하는지 표시하는 tag가 달린 클래스

*e.g. tagged class*

```java
class Figure {
  enum Shape { RECTANGLE, CIRCLE };
  
  // 태그 필드
  final Shape shape;
  
  double length;
  double width;
  
  double radius;
  
  // 원을 만드는 생성자
  Figure(double radius) {
    shape = Shape.CIRCLE;
    this.radius = radius;
  }
  
  // 사각형을 만드는 생성자
  Figure(double length, double width) {
    shape = Shape.RECTANGLE;
    this.length = length;
    this.width = width;
  }
  
  double area() {
    switch(shape) {
      case RECTANGLE:
        return length * width;
      case CIRCLE:
        return Math.PI * (radius * radius);
      default:
        throw new AssertionError();
    }
  }
}
```

**문제점**

- 수정할 때마다 `switch`문에 새로운 `case`를 올바르게 넣어야 한다. 
- 객체의 자료형만 봐서 그 객체가 무슨 기능을 제공하는지 알 수 없다.
- boilerplate code가 늘어난다.
- **오류 발생 가능성이 높아지고, 효율적이지 않다.**

*e.g. 클래스 계층으로 변환한 결과([규칙 14](#item14))*

```java
abstract class Figure {
  abstract double area();
}

class Circle extends Figure {
  final double radius;
  
  Circle(double radius) {
    this.radius = radius;
  }
  
  double area() {
    return Math.PI * (radius * radius);
  }
}

// public 클래스인 경우(규칙 14)
@Data
public class Rectangle extends Figure {
  final private double length;
  final private double width;
  
  public double area() {
    return length * width;
  }
}
```

- 태그 기반 클래스 사용은 피하라.
- 태그 기반 클래스를 보게 된다면, 리팩토링을 통해 클래스 계층으로 변환할 방법은 없는지 고민하자.

[🔝 *위로 이동*][top]

---

<a name="item21"></a>
# 규칙 21. 전략을 표현하고 싶을 때는 함수 객체를 사용하라

> 전략을 표현하고 싶을 때는 함수 객체<sub>function object</sub>를 사용하라<br/>
> 함수 객체의 주된 용도는 전략 패턴<sub>Strategy pattern</sub>을 구현하는 것.

**strategy pattern**

- 인자로 함수를 넘겨줘서 그 함수를 통해 실행 전략을 세우는 방법. 예를 들어 정렬을 한다고 할때, 어떻게 정렬하는가는 넘겨주는 것이 전략패턴.
- Java는 함수를 넘겨 줄수 없으나, 함수를 가지고 있는 객체(=함수 객체)를 넘겨주면 됨

```java
// 전략 인터페이스
public interface Comparator<T> {
	public int compare(T t1, T t2);
}
```

문자 길이로 하고자 할 때, 익명 클래스로 구현할 수 있으나 매번 필요없는 인스턴스를 생성함

```java
Arrays.sort(stringArray, new Comparator<String>() {
	public int compare(String s1, String s1) {
    	return s1.length() - s2.length();
	}
});
```

그렇다면, 싱글턴으로 만들어서 사용하는 방법. 의도가 뚜렷한 이름을 정할 수 있는 것도 장점.

```java
Arrays.sort(stringArray, StringLengthComparator.INSTANCE);
class StringLengthComparator implements Comparator<String> {
	public static final StringLengthComparator INSTANCE = new StringLengthComparator();
	private StringLengthComparator();
	public int compare(String s1, String s1) {
          return s1.length() - s2.length();
	}
}
```

java 8 lamdba를 이용하면 코드를 좀 더 줄일 수 있음

```java
Comparator<String> stringLengthComparator = (String s1, String s2) -> s1.length - s2.length;
Arrays.sort(stringArray, stringLengthComparator);
```



전략 인터페이스(`Comparator`)는 실행 가능 전략 객체들(`StringLengthComparator`)의 자료형 구실을 한다. 따라서 실행 가능 전략 클래스(`StringLengthComparator`)는 굳이 public으로 만들어 공개할 필요가 없다. 대신, 전략 인터페이스가 자료형인 public static 필드들을 갖는 "호스트 클래스(host class)"를 정의하는 것도 방법이다. 실행 가능 전략 클래스는 호스트 클래스의 private 중첩 클래스(nested class)로 정의하면 된다.

```java
class Host {
	public static final Comparator<String> STRING_LENGTH_COMPARATOR = (String s1, String s2) -> s1.length - s2.length;
}
```

`String` 클래스는 `CASE_INSENCITIVE_ORDER`라는 필드로 문자열 비교자를 공개함


[🔝 *위로 이동*][top]

---

<a name="item43"></a>
# 규칙 43. null 대신 빈 배열이나 컬렉션을 반환하라

> Null References
>
> *"I call it my billion-dollar mistake."* - Tony Hoare

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

[🔝 *위로 이동*][top]

---

<a name="item44"></a>
# 규칙 44. 모든 API 요소에 문서화 주석을 달라

> **좋은 API 문서를 만들려면 API에 포함된 모든 클래스, 인터페이스, 생성자, 메서드, 그리고 필드 선언에 문서화 주석을 달아야 한다.**

- 문서화 주석과 javadoc을 통해 API 문서를 자동으로 만들 수 있다. 문서화 주석 문법은 자바 언어의 일부는 아니지만, 모든 프로그래머가 알아야 하는 실질적인 표준 API다. ([How to Write Doc Comments - Oracle 웹사이트](http://www.oracle.com/technetwork/articles/java/index-137868.html))

## 공통

*List.java*

```java
/**
 * Returns the hash code value for this list.  The hash code of a list
 * is defined to be the result of the following calculation:
 * <pre>{@code
 *     int hashCode = 1;
 *     for (E e : list)
 *         hashCode = 31*hashCode + (e==null ? 0 : e.hashCode());
 * }</pre>
 * This ensures that <tt>list1.equals(list2)</tt> implies that
 * <tt>list1.hashCode()==list2.hashCode()</tt> for any two lists,
 * <tt>list1</tt> and <tt>list2</tt>, as required by the general
 * contract of {@link Object#hashCode}.
 *
 * @return the hash code value for this list
 * @see Object#equals(Object)
 * @see #equals(Object)
 */
int hashCode();
```



**코드는 `{@code }` 태그를 사용하라.**

- 코드 서체로 표시되도록 한다.

- 태그 안에 포함된 모든 HTML 마크업이나 javadoc 태그가 위력을 발휘하지 못하도록 한다.

- 여러 줄로 나뉜 코드를 문서화 주석에 넣을 때는 `{@code }` 태그를 HTML `<pre>` 태그 안에 넣어라.

- `<tt>`  태그는 HTML5 에서 더이상 지원하지 않는다(고정폭을 보여줘야 할 경우에는 일반적으로 `<code>` 태그).

  *\<tt\> - MDN*

  > **Obsolete**
  > This feature is obsolete. Although it may still work in some browsers, its use is discouraged since it could be removed at any time. Try to avoid using it.


**주석을 달 때 명심해야 할 일반적 원칙은, 문서화 주석은 소스 코드로 보나 javadoc으로 변환한 결과물로 보나 읽을 만해야 한다는 것이다. 그럴수 없는 상황이라면, javadoc으로 변환한 결과물의 가독성을 우선시하기 바란다.**

```java
/**
 * The triangle inequality is {@literal |x + y| < |x| + |y|}.
 ...
 */
```

- HTML 메타문자들을 사용할 때는 `{@literal }` 태그를 사용하라.
- `<` 기호만 `{@literal }` 태그로 둘 수도 있었겠지만, 그랬으면 가독성이 떨어졌을 것이다.
- `{@code }` 태그와 유사하지만, 코드 서체로 표시되지 않는 차이가 있다.


**모든 문서화 주석의 첫 번째 "문장"은 해당 주석에 담긴 내용을 요약한 것이다(summary description).**

- 혼란을 막기 위해, 클래스나 인터페이스의 맴버나 생성자들 가운데 요약문 같은 것은 없어야 한다.
- 오버로딩할 경우에는 같은 요약을 쓰는 것이 자연스러울 때가 있으니 주의하라(하지만 문서화 주석의 경우, 동일한 첫 문장은 곤란하다).


**요약문에 마침표가 여러 번 포함되어야 하는 경우에는 주의하라.**

-   javadoc은 뒤에 *공백*, *탭*, *줄바꿈 문자(line terminator)*, *블록 태그(block tag)*가 오는 첫번째 마침표 위치에서 요약문이 끝나는 것으로 생각한다. 이 문제를 푸는 가장 좋은 방법은, `{@literal }` 태그로 감싸는 것이다.

    *example.*

    ```java
    /**
     * A college degree, such as B.S., M.S. or Ph.D.
     * College is a fountain of knowledge where many go to drink.
     */
    public class Degree { ... }
    ```

    ```java
    /**
     * A college degree, such as B.S., {@literal M.S.} or Ph.D.
     * ...
    ```


**엄밀히 따지자면 문서화 주석의 요약문은 첫 번째 "문장"일 필요는 없다. 완벽한 문장일 필요가 없다는 것이다.**

-    **메서드나 생성자의 경우,** 요약문은 메서드가 무슨 일을 하는지 기술하는 (객체를 포함하는) 완전한 동사구(verb phrase)여야 한다.

     *Collection.java - size()*

     ```java
     /**
      * Returns the number of elements in this collection.  If this collection
      * contains more than <tt>Integer.MAX_VALUE</tt> elements, returns
      * <tt>Integer.MAX_VALUE</tt>.
      *
      * @return the number of elements in this collection
      */
     int size();
     ```

     *ArrayList.java - Constructor*

     ```java
     /**
      * Constructs an empty list with the specified initial capacity.
      *
      * @param  initialCapacity  the initial capacity of the list
      * @throws IllegalArgumentException if the specified initial capacity
      *         is negative
      */
     public ArrayList(int initialCapacity) { ... }
     ```

-    **클래스와 인터페이스의 요약문은,** 해당 클래스나 인터페이스로 만들어진 객체가 무엇을 나타내는지를 표현하는 명사구여야 한다.

        *Collection.java*

     ```java
     /**
      * The root interface in the <i>collection hierarchy</i>.  A collection...
      */
      public interface Collection<E> extends Iterable<E> { ... }
     ```


-    **필드의 요약문은,** 필드가 나타내는 것이 무엇인지를 설명하는 명사구여야 한다.

     *Math.PI*

     ```java
     /**
      * The {@code double} value that is closer than any other to
      * <i>pi</i>, the ratio of the circumference of a circle to its
      * diameter.
      */
     public static final double PI = 3.14159265358979323846;
     ```


**javadoc에는 메서드 주석을 "상속"하는 기능이 있다.**

-  적용 가능한 문서화 주석 가운데 가장 근접한 것을 찾는다. 이때 상위 클래스보다는 인터페이스 쪽에 우선권이 주어진다.

-  `{@inheritDoc }` 태그를 사용하면 상위 자료형에 있는 문서화 주석 가운데 일부를 상속할 수도 있다.

   *ArrayList.java*

   ```java
   /**
   * (중간 생략)
   * @throws IndexOutOfBoundsException {@inheritDoc}
   */
   public E get(int index) { ... }
   ```

   *List.java*

   ```java
   /**
    * (중간 생략)
    * @throws IndexOutOfBoundsException if the index is out of range
    *         (<tt>index &lt; 0 || index &gt;= size()</tt>)
    */
   E get(int index);
   ```
**API 관련 별도 문서가 있다면, 문서화 주석에 링크를 남긴다.**

>   문서화 주석에 관해서, 마지막으로 한 가지 주의사항만 더 살펴보자. 모든 공개 API 요소에는 문서화 주석을 달 필요가 있지만, 항상 그 정도면 충분하지 않다. **관련된 클래스가 많아서 복잡한 API의 경우, API의 전반적인 구조를 설명하는 	별도 문서(external document)가 필요한 경우가 많다. 그런 문서가 있다면, 관련 클래스나 패키지의 문서화 주석에는 해당 문서로 연결되는 링크가 있어야 한다.**

## 메서드

**메서드에 대한 문서화 주석은, 메서드와 클라이언트 사이의 규약을 간명하게 설명해야 한다.**

- 계승을 위해 설계된 메서드가 아니라면(규칙17) 메서드가 *어떻게*가 아닌 *무엇*을 하는지를 설명해야 한다.
- 해당 메서드의 모든 선행조건(precondition)과 후행조건(postcondition)을 나열해야 한다.
  - 선행조건: 메서드를 호출하려면 반드시 참(true)이 되어야 하는 조건들
  - 후행조건: 메서드 실행이 성공적으로 끝난 다음에 만족되어야 하는 조건들
- 보통 선행조건은 무결점 예외(unchecked exception)에 대한 `@throw` 태그를 통해 암묵적으로 기술한다. 관계된 인자의 `@param` 태그를 통해 명시할 수도 있다.


- 메서드는 부작용(side effect)에 대해서도 문서화 해야 한다. 부작용은 후행조건을 만족하기 위해 필요한 것이 아닌, 시스템의 관측 가능한 상태 변화를 일컫는다.
- 규칙 70에 설명한 대로, 클래스가 메서드의 스레드 안전성(thread safety)에 대해서도 문서에 남겨야 한다.


**메서드의 규약(contract)을 완벽하게 기술하려면, 문서화 주석에는 인자마다 `@param` 태그를 달아야 하고, 반환값 자료형이 void 가 아니라면 `@return` 태그도 달아야 하고, 무점검/점검 여부에 상관없이 모든 예외에는 `@throws` 태그도 붙어야 한다(규칙 62).**

**관습적으로,**

*List.java*

```java
/**
 * Removes the element at the specified position in this list (optional
 * operation).  Shifts any subsequent elements to the left (subtracts one
 * from their indices).  Returns the element that was removed from the
 * list.
 *
 * @param index the index of the element to be removed
 * @return the element previously at the specified position
 * @throws UnsupportedOperationException if the <tt>remove</tt> operation
 *         is not supported by this list
 * @throws IndexOutOfBoundsException if the index is out of range
 *         (<tt>index &lt; 0 || index &gt;= size()</tt>)
 */
E remove(int index);
```

- `@param` 태그나 `@return` 태그 다음에는 인자나 반환값을 설명하는 명사구(noun phrase)가 와야 한다.
- `@throw` 태그 다음에는 어떤 조건에서 예외가 발생하는지를 설명하는 if 절이 온다.
- 명사구 대신 산술 표현식(arithmetic expression)이 쓰일 때도 있다.
- `@param`, `@return`, `@throws` 태그 다음에 오는 구나 절에는 마침표를 찍지 않는다.

## 클래스

**클래스가 스레드에 안전하건 그렇지 않건 간에, 그 안전성 수준을 문서로 남겨야 한다(규칙 70).**

**직렬화(serialization)가 가능한 클래스라면 직렬화 형식도 밝혀야 한다(규칙 75).**

**제네릭 자료형이나 메서드에 주석을 달 때는 모든 자료형 인자들을 설명해야 한다.**

*Map.java*

```java
/**
 * An object that maps keys to values.  A map cannot contain duplicate keys;
 * each key can map to at most one value.
 *
 * (중간 생략)
 *
 * @param <K> the type of keys maintained by this map
 * @param <V> the type of mapped values
 */
public interface Map<K,V> { ... }
```

**enum 자료형에 주석을 달 때는 자료형이나 public 메서드뿐 아니라 상수 각각에도 주석을 달아 주어야 한다.**

```java
/**
 * 조직 연동에 사용되는 서비스.
 * 어드민에서 조직연동 API와 같이 내려오는 값도 포함(SSO, IPT)
 * @author yeongjun on 2016. 11. 2.
 */
public enum OrgSyncType {
	/** 조직/구성원의 조직 */
	GROUP,

	/** 조직/구성원의 구성원 */
	MEMBER,

	/** 직급/직책 */
	JOB
}
```

**어노테이션 자료형에 주석을 달 때는 자료형뿐 아니라 모든 멤버에도 주석을 달아야 한다.**

- 멤버에는 필드인 것처럼 명사구 주석을 달아라.
- 자료형 요약문에는 동사구를 써서, 언제 이 자료형을 어노테이션으로 붙여야 하는지 설명하라.

```java
/**
 * 조직연동시 접근제한이 필요한 API라는 것을 명시.
 *
 * @author yeongjun on 2016. 11. 2.
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({java.lang.annotation.ElementType.METHOD})
public @interface OrgSyncUsersDenied {
	/**
	 * 어노테이션 붙은 메서드가 제한되어야 하는 조직연동 서비스 타입.
	 */
	OrgSyncType[] value();
}
```

**릴리즈 1.5부터는 *패키지 수준 문서화 주석(package-level doc comment)*은 `package-info.java`에 두어야 한다.**

- 패키지 선언 및 패키지 어노테이션을 넣을 수 있다.

## 참고

- [Swagger](http://swagger.io/): API Document을 만들어 주는 툴

[🔝 *위로 이동*][top]

---

<a name="item57"></a>
# 규칙 57. 예외는 예외적 상황에만 사용하라

## **예외는 예외적인 상황에만 사용하라.** 평상시 제어 흐름(ordinary control flow)에 이용해서는 안된다.

- 예외는 예외적 상황을 위해 고안된 것이기 때문에, JVM을 구현하는 사람 입장에서 보면 명시적 테스트만큼 빠르게 만들 이유가 별로 없다.
- 쉽게 이해할 수 있는 표준적인 숙어대로 코딩해야지, 더 좋은 성능을 내 보려고 너무 머리를 많이 굴리면 곤란하다는 것이다.
- 너무 머리를 많이 굴린 기법일수록 묘한 버그가 생길 가능성이 높고 유지보수 때문에 골치 아플 일도 많은 법.

## 클라이언트에게 제어 흐름의 일부로 **예외를 사용하도록 강요하는 API를 만들지 말아라.**

- 특정한 예측 불가능 조건이 만족될 때만 호출할 수 있는 "상태 종속적(state-dependent)" 메서드를 가진 클래스에는 보통 해당 메서드를 호출해도 되는지를 알기 위한 **"상태 검사(state-testing)"** 메서드가 별도로 갖춰져 있다.

  ```java
  for (Iterator<Foo> i = collection.iterator(); i.hasNext(); ) {
    Foo foo = i.next();
  }
  ```

  *`i.hasNexe()`와 같은 상태 검사 메서드가 없을 경우*

  ```java
  try {
    Iterator<Foo> i = collection.iterator();
    while (true) {
      Foo foo = i.next();
      ...
    }
  } catch (NoSuchElementException e) {
  }
  ```

- 상태 검사 메서드를 제공하기 싫다면 부적절한 상태의 객체에 상태 종속적 메서드를 호출하면 null 같은 **특이값(distinguished value)이 반환**되도록 구현하는 방법도 있다.
  `Iterator`에서 `null`은 `next()`의 정상적 반환값일 수 있기 때문에 사용할 수 없다.

- **특이값 방식**

  외부적인 동기화 메커니즘 없이 병렬적으로 사용될 수 있는 객체거나, 외부적인 요인으로 상태 변화가 일어날 수 있는 객체라면 반드시 특이값 방식으로 구현. (상태 검사 메서드를 호출한 다음 상태 종속적 메서드를 호출하기까지의 시간 동안 객체 상태가 변할 수 있기 때문)

  상태 종속적 메서드가 하는 일을 상태 검사 메서드가 중복해서 하는 바람에 성능이 떨어질까 우려될 경우.

- **상태 검사 메서드**

  다른 모든 조건이 동일하다면 상태 검사 메서드를 두는 편이 대체로 바람직. 가독성 측면에서도 조금 더 낫고, API를 잘못 이용하는 경우도 쉽게 찾아낼 수 있기 때문.

  상태 검사 메서드를 실수로 호출하지 않으면 상태 종속적 메서드에서 예외가 발생하니까 버그가 분명하게 드러난다.

  실수로 특이값 검사를 생략하는 버그는 찾기 어려울 수 있다.(null 체크를 안할 경우?)

[🔝 *위로 이동*][top]

---

<a name="item58"></a>
# 규칙 58. 복구 가능 상태에는 점검지정 예외를 사용하고, 프로그래밍 오류에는 실행시점 예외를 이용하라

**핵심**

>  복구 가능한 상태에는 점검지정 예외를 사용하고, 프로그래밍 오류를 나타내고 싶을 때는 실행지점 예외를 사용하라.
>
>  잘 모르겠다면 무점검 예외를 이용하는 편이 나을 것이다(규칙 59).

**Java는 세 가지 종류의 throwable을 제공한다.**

> 점검지정 예외(checked exception), 실행시점 예외(runtime exception), 오류(error)

무엇을 사용해야 하는지 딱 떨어지는 기준이 있는 것은 아니지만, 훌륭한 지침으로 삼을 만한 일반 규칙이 있다.

**호출자(caller) 측에서 복구할 것으로 여겨지는 상황에 대해서는 점검지정 예외를 이용해야 한다.**

- 점검지정 예외를 사용할 것인지 무점검 예외(unchecked exception)를 사용할 것인지에 대한 가장 기본적인 규칙

- 메서드에 선언된 점검지정 예외는 메서드를 호출하면 해당 예외와 관련된 상황이 발생할 수 있음을 API 사용자에게 알리는 구실을 한다.

  API 사용자에게 검점지정 예외를 준다는 것은, 그 상태를 복구할 권한을 준다는 뜻.
  사용자는 그 권한을 무시할 수 있지만 일반적으로 그렇게 하면 곤란하다(규칙 65, 예외를 무시하지 마라).

- 점검지정 예외는 일반적으로 복구 가능한 상태를 나타내기 때문에, 호출자 측에서 상태를 복구하는 데 이용할 정보를 제공하는 메서드를 갖춰놓는 것이 아주 중요하다.

**프로그래밍 오류를 표현할 때는 실행시점 예외를 사용하라.**

- 대부분의 런타임 예외는 선행조건 위반(precondition violation)을 나타낸다.

  클라이언트가 API 명세에 기술된 규악을 지키지 않았다는 뜻. (ArrayIndexOutOfBoundsException)

**사용자 정의 무점검 throwable은 RuntimeException의 하위 클래스로 만들어야 한다.**

- 자바 언어 명세에 강제된 사항은 아니지만, 보통 오류(error)는 JVM이 자원 부족이나 불변식 위한 등, 더 이상 프로그램을 실행할 수 없는 상태에 도달했음을 알리기 위해 사용.

  이 관습은 거의 보편적으로 받아들여지고 있어서, Error의 하위 클래스는 새로 만들지 않는 것이 최선이다.

- 예외를 만들 경우, 예외 정보 문자열을 파싱하는 것은 위험한 방법이다(규칙 10). 객체가 어떤 형식의 문자열로 변환되는지 상세히 명시하는 클래스는 별로 없다. 따라서 문자열 변환 결과는 구현마다, 그리고 릴리스마다 달라질 수 있기 때문에 *예외를 문자열로 나타낸 결과를 파싱하는 코드는 이식성도 없고 깨지기도 쉽다.*

[🔝 *위로 이동*][top]

---

<a name="item59"></a>
# 규칙59. 불필요한 점검지정 예외 사용은 피하라

점검지정 예외는 프로그래머 하여금 예외적인 상황을 처리하도록 장제함으로써 안정성을 높인다.

아래 경우에 해당하지 않을 경우 무점검 예외를 이용하는 것이 좋다.

- API를 제대로 이용해도 예외 상황이 벌어지는 것을 막을 수 없을 때
- API 사용자가 예외상황에 대한 조치를 취할 수 있을 때

API 사용자가 이보다 좋은 코드를 만들 수 없다면, 무점검 예외가 적당하다.

```java
} catch (TheCheckedException e) {
  throw new AssertionError();
}
```

```java
} catch (TheCheckedException e) {
  e.printStackTrace();
  System.exit(1);
}
```

메서드가 던지는 예외가 하나뿐일 경우, 점검지정 예외를 없앨 방법이 없을지 고민해보는 것이 좋다.

- 예외를 던지는 메서드를 둘로 나눠서 첫 번째 메서드가 boolean값을 반환 하도록 만드는 것

  ```java
  /* as-is */
  try {
    obj.action(args);
  } catch (TheCheckedException e) {
    // 예외적 상황 처리
  }

  /* to-be: 상태 검사 메서드를 거쳐서 무점검 예외 메서드를 호출 */
  if (obj.actionPermitted(args)) {
    obj.action(args);
  } else {
    // 예외적 상황 처리
  }
  ```

- 결과적으로 만들어지는 API는 규칙 57에서 설명한 상태 검사 메서드와 본질적으로 같기 때문에, 동일한 문제를 갖는다.
  그러므로, 외부적인 동기화 수단 없이 병렬적으로 이용될 가능성이 있는 객체거나, 외부에서 그 상태를 바꿀 가능성이 있는 객체라면 위의 리팩토링 기법은 적용할수 없다.

[🔝 *위로 이동*][top]

---

<a name="item70"></a>
# 규칙 70. 스레드 안전성에 대해 문서로 남겨라

- 클래스의 객체나 정적 메서드가 병렬적으로 이용되었을 때 어떻게 동작하는지 문서화하라. 그렇지 않으면 프로그래머는 클래스를 이용할 때 가정<sub>assumption</sub>을 하게 된다. 그 가정이 틀리면 프로그램은 동기화를 충분히 하지 못하거나([규칙 66](#item66)) 지나친 동기화를 하게 된다([규칙 67](#item67)).
- **synchronized 키워드는 메서드의 구현 상세<sub>implementation detail</sub>에 해당하는 정보이며, 공개 API의 일부가 아니다.** 메서드가 다중스레드에 안전하다는 뜻으로 믿으면 곤란하다.
- **병렬적으로 사용해도 안전한 클래스가 되려면, 어떤 수준의 [스레드 안전성](#스레드-안전성-범주)을 제공하는 클래스인지 문서에 정확하게 남겨야 한다.**

## 스레드 안전성 범주

각 범주는('다중 스레드에 적대적' 제외) 대략적으로 보면 『Java Concurrency in Practice』에 언급된 *스레드 안전성 어노테이션<sub>thread safety annotation</sub>* `@Immutable`, `@ThreadSafe`, `@NotThreadSafe` 각각에 해당([Goetz06](#goetz06), Appendix A). 무조건적/조건부 스레드 안전성 범주는 전부 ThreadSafe 어노테이션에 해당한다.

### 변경 불가능<sub>immutable</sub>

- 이 클래스의 객체(인스턴스)들은 모두 상수
- 즉, 외부적인 동기화 메커니즘 없이도 병렬적 이용 가능
- e.g. String, Long, BigInteger ([규칙15](#item15))

### 무조건적 스레드 안전성<sub>unconditionally thread-safe</sub>

> 구현할 때, 메서드를 synchronized로 선언하는 대신 [private 락 객체](#private-lock-object)를 이용하면 어떨지 따져보자. 이런 락 객체를 이용하면 클라이언트나 하위 클래스가 동기화에 개입하는 것을 막을 수 있고, 다음번 릴리스에는 좀 더 복잡한 병행성 제어 전략도 쉽게 채택할 수 있게 된다.

- 인스턴스는 변경 가능하지만 적절한 내부 동기화 메커니즘을 갖추고 있어서 외부적으로 동기화 메커니즘을 적용하지 않아도 병렬적 사용 가능
- e.g. Random, ConcurrentHashMap

### 조건부 스레드 안전성<sub>conditionally thread-safe</sub>

> 어떤 순서로 메서드를 호출할 때 외부적 동기화가 필요한지 문서에 밝혀야 하고, 그때 어떤 락을 획득하게 되는지도 밝혀야 한다.

- 무조건적 스레드 안전성과 거의 같지만 몇몇 스레드는 외부적 동기화 없이는 병렬적으로 사용 불가능
- e.g. Collections.synchronized 계열 메서드가 반환하는 wrapper 객체(SynchronizedMap, ...), 이런 객체들의 iterator는 외부적 동기화 없이는 병렬 사용 불가능.

### 스레드 안전성 없음

- 인스턴스는 변경 가능
- 병렬적으로 사용하려면 클라이언트는 메서드를 호출하는 부분을 클라이언트가 선택한 외부적 동기화 수단으로 감싸야 함
- e.g. ArrayList, HashMap 등 일반 용도의 Collection 구현체

### 다중 스레드에 적대적<sub>thread-hostile</sub>

- 모든 부분을 외주덕 동기화 수단으로 감싸더라도 안전하지 않음
- 보통 동기화 없이 static data를 변경하는 경우
- e.g. `System.runFinalizersOnExit()`, 지금은 deprecated.


## private lock object

- 외부로 공개한 락을 통해 동기화하도록 하는 클래스의 경우, 클라이언트가 락을 오랫동안 들고 있으면 DoS 공격<sub>denial-of-service attack</sub>이 가능하다.
- 동기화 메서드를 쓰는 방법은 클래스 외부로 공개된 락이나 다름 없음

```java
// DoS 공격을 피하기 위한 private lock object 숙어
private final Object lock = new Object();

public void foo() {
	synchronized(lock) {
		....
	}
}
```

- private 락 객체는 클래스 바깥에서는 이용할 수 없으므로, 클라이언트는 객체의 동기화 메커니즘에 개입할 수 없다([규칙13](#item13) - 락 객체 캡슐화).
- lock 필드는 final로 선언
	- 실수로 lock필드의 내용을 변경하는 일 방지. 실수로 변경하게 되면, 끔찍하게도 객체의 내용에 동기화 없이 접근 가능([규칙66](#item66))
	- lock 필드의 변경 가능성 최소화([규칙15](#item15))
- private 락 객체는 계승을 염두에 두고 설계하는 클래스에 걸맞다([규칙17](#item17))
	- TODO

## 참고

- <a name="goetz06"></a>Goetz06: Goetz, Brian, with Tim Peierls et al. *[Java Concurrency in Practice](https://www.google.co.kr/search?newwindow=1&biw=1440&bih=780&q=java+concurrency+in+practice&oq=java+concurrency+in+practice&gs_l=serp.3..35i39k1l2j0l7.70385.70744.0.70975.3.3.0.0.0.0.116.338.0j3.3.0....0...1.1.64.serp..0.3.337.1qjYTBqbFtA)*. Addison - Wesley, Boston, 2006. ISBN: 0321349601.

[🔝 *위로 이동*][top]

---

<a name="item71"></a>
# 규칙 71. 초기화 지연은 신중하게 하라

- 초기화 지연<sub>lazy initialization</sub>은 필드 초기화를 실제로 그 값이 쓰일 때까지 미루는 것
- static 필드와 객체 필드에 모두 적용 가능
- 클래스나 객체 초기화 가정에서 발생하는 해로운 순환성<sub>circularity</sub>을 해소하기 위해서도 사용
- 초기화 지연을 적용할 때 따라야 할 최고의 지침은 "정말로 필요하지 않으면 하지 마라"이다([규칙55](#item55)).
	- 필드 사용 빈도가 나고 초기화 비용이 높다면 쓸만함
	- 초기화 지연 적용 전후의 성능을 비교할 것
- 다중 스레드 환경에서 초기화 지연 기법을 구현하는 것은 까다롭다. 두 개 이상의 스레드가 그런 필드를 공유할 때는 반드시 적절한 동기화를 해 주어야 하며, 그렇지 않으면 심각한 버그가 생길 수 있다([규칙66](#item66)).
- **대부분의 경우, 지연된 초기화를 하느니 일반 초기화를 하는 편이 낫다.**

	```java
	// 전형적 필드 선언문, 일반 초기화 숙어
	private final FieldType field = computeFieldValue();
	```

	- final로 선언하고 있음([규칙15](#item15))
- **초기화 순환성<sub>initialization circularity</sub><sup>71.1</sup> 문제를 해소하기 위해서 초기화를 지연시키는 경우에는 동기화된 접근자<sub>synchronized accessor</sub>를 사용하라.**

	```java
	// 동기화된 접근자를 통한 초기화 지연 숙어
	private FieldType field;

	synchronized FieldType getField() {
		if (field == null) {
			field = computeFieldValue();
		}
		return field;
	}
	```

- **성능 문제 때문에 정적 필드 초기화를 지연시키고 싶을 때는 *초기화 지연 담당 클래스<sub>lazy initialzation holder class</sub> 숙어*를 적용하라**(≒ 요청 기반 초기화 담당 클래스<sub>initialiize-on-demand holder class</sub>). 클래스는 실제로 사용되는 순간에 초기화된다는 점을 이용한 것([JLS, 12.4.1](https://docs.oracle.com/javase/specs/jls/se8/html/jls-12.html#jls-12.4.1))

	```java
	private static class FieldHolder {
		static final FieldType field = computeFieldValue();
	}

	static FieldType getField() { return FieldHolder.field; }
	```

- **성능 문제 때문에 객체 필드 초기화를 지연시키고 싶다면 *이중 검사<sub>double-check</sub> 숙어*를 사용하라.**
	- 초기화 끝난 필드를 이용하기 위해 락을 걸어야 하는 비용을 없앨 수 있다([규칙67](#item67)).
	- 한 번은 락 없이 검사하고, 초기화가 되지 않은 것 같으면 락을 걸어서 검사한다(필드를 두 번 검사하기 때문에 double-check이다).
	- 이미 초기화된 필드에는 락을 걸지 않으므로, 필드는 반드시 volatile로 선언해야 한다([규칙66](#item66)).

	```java
	private volatile FieldType field;

	FieldType getField() {
		FieldType result = field;
		if (result == null) { // 첫 번째 검사(락 없음)
			synchronized(this) {
				result = field;
				if (result == null) { // 두 번째 검사(락)
					field = result = computeFieldValue();
				}
			}
		}
		return result;
	}
	```

	- `result`는 이미 초기화된 필드는 딱 한 번만 읽도록 하기 위한 변수 -> 성능을 높일 수 있음(반드시 필요한 건 아님)
	- java 1.5에 도입된 메모리 모델 때문에 volatile를 사용하여 이중 검사 숙어를 안정적으로 사용 가능
	- 오늘날, 이중 검사 숙어는 객체 필드 초기화를 지연시키고자 할 때 반드시 사용해야 하는 숙어가 되었다.
	- 정적 필드에 이중 검사 숙어를 적용할 수 있지만, 초기화 지연 담당 클래스 숙어를 이용하는 것이 바람직하다.
	- 여러 번 초기화되어도 상관없는 객체 필드 초기화를 지연시키고 싶을 때는 *단일 검사<sub>single-check</sub> 숙어*를 사용해도 된다.

		```java
		// 단일 검사 숙어
		private volatile FieldType field;

		private FieldType getField() {
			FieldType result = field;
			if (result == null) {
				field = result = computeFieldValue();
			}
			return result;
		}
		```

	- 모든 스레드가 필드 값을 재계산하더라도 상관없고 필드 자료형이 long이나 double 아닌 기본 자료형인 경우에는 단일 검사 숙어에서 volatile 키워드는 빼도 된다. -> *경쟁적 단일 검사<sub>racy single-check</sub>*

## 참고

- 초기화 순환성: http://stackoverflow.com/questions/1941572/circularity-in-class-initialization
- volatile 키워드: http://thswave.github.io/java/2015/03/08/java-volatile.html

[🔝 *위로 이동*][top]

---

# 참고 자료

- 71.1
