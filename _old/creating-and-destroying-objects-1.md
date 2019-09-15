---
title: 이펙티브자바 2장. 객체 생성과 삭제 - 1
date: 2017-02-10 10:00:00
tags:
- java
- effective java
desc: chapter 2. Creating and Destroying Objects in effective java
---

[규칙 1](../../../../2017/02/10/creating-and-destroying-objects-1/#규칙-1-생성자-대신-static-factory-method-사용을-고려하자) - 생성자 대신 static factory method 사용을 고려하자
[규칙 2](../../../../2017/02/10/creating-and-destroying-objects-1/#규칙-2-생성자의-매개변수가-많을-때는-빌더-builder-를-고려하자) - 생성자의 매개변수가 많을 때는 빌더(builder)를 고려하자

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 규칙 1. 생성자 대신 static factory method 사용을 고려하자

> 클래스를 통해 객체를 만드는 방법
>
> - Constructor
> - Static factory method
>     (Design Patterns에 나오는 [팩토리 메서드 패턴][dp-factory-method]과 다르다.)

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

#### 장점

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
	1. 만든 객체를 캐시~cache~ 해놓고 재사용하여 같은 객체가 불필요하게 거듭 생성되는 일을 피할 수 있다.
		`Boolean.value(boolean)`는 이 기법을 활용한 좋은 사례로 [Flyweight 패턴][dp-flyweight]과 유사하다. 동일한 객체가 요청되는 일이 잦고, 특히 객체를 만드는 비용이 클 때 적용하면 성능을 크게 개선할 수 있다.
	2. 같은 객체를 반복해서 반환할 수 있다.

        > 어떤 시점에 어떤 객체가 얼마나 존재할지를 정밀하게 제어할 수 있다. 그런 기능을 갖춘 클래스를 *개체 통제 클래스~instance-controlled class~*라고 부른다.

		개체 통제 클래스를 작성하는 이유는 아래와 같다.
		- [Singleton pattern](#item3) 적용
		- [Non-instantiable class](#item4) 생성 가능(e.g. Utility class)

			```java
	       public class UtilityClass {
	       	private UtilityClass() { throw new AssertionError(); }
	       }
			```

		- [불변 클래스](#item15)

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

            -   [enum](#item30)이 이 기법을 사용
            -   `equals()` 대신 `==` 연산자 사용 가능

3. 자신의 인스턴스만 반환하는 생성자와는 달리, 서브타입 객체도 반환 가능하다.

    > 1. "public으로 선언되지 않은 클래스의 객체를 반환하는 API를 만들 수 있다. 그러면 구현 세부사항을 감출 수 있으므로 아주 간결한 API가 가능하다."
    > 2. "이 기법은 인터페이스 기반 프레임워크(interface-based framework) 구현에 적합한데, 이 프레임워크에서 인터페이스는 정적 팩터리 메서드의 반환값 자료형으로 이용된다."
    > 3. "관습상 반환값 자료형이 Type이라는 이름의 인터페이스인 정적 팩터리 맥서드를 Types라는 이름의 객체 생성 불가능 클래스안에 둔다."

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

#### 단점

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

---

## 규칙 2. 생성자의 매개변수가 많을 때는 빌더(builder)를 고려하자

선택적 인자가 많을 때 객체를 생성하는 방법 세 가지.

#### 방법 1) 점층적 생성자 패턴(telescoping constructor pattern)

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


#### 방법 2) JavaBeans 패턴

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


#### 방법 3) Builder 패턴[↩︎][dp-builder]

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

- 빌더 객체를 인자로 받는 메서드는 보통 *한정적 와일드카드 자료형~bounded wildcard type~*을 통해 인자의 자료형을 제한한다([규칙 28](#items28)).

	```java
	Tree buildTree(Builder<? extends Node> nodeBuilder) {...}
	```

- 자바가 제공하는 추상적 팩토리로는 Class 객체가 있으며, 이 객체의 *newInstance()* 가 build 메서드 구실을 한다.

	**하지만,** newInstance()는 항상 무인자 생성자를 호출하려 하는데, 문제는 그런 생성자가 없을 수도 있다는 것. TO-DO

**문제점**

- 빌더 객체를 만드는 오버헤드가 문제가 될 수 있다(성능이 중요한 상황). 그러니 인자 갯수가 통제할 수 없을 정도로 많아지만 빌더 패턴을 적용하자.

#### 요약

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
