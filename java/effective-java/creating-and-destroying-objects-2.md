---
title: 이펙티브자바 2장. 객체 생성과 삭제 - 2
date: 2017-02-12 10:00:00
tags:
- java
- effective java
desc: chapter 2. Creating and Destroying Objects in effective java
---

[규칙 3](../../../../2017/02/12/creating-and-destroying-objects-2/#규칙-3-private-생성자나-enum-자료형은-싱글턴-패턴을-따르도록-설계하라) - private 생성자나 enum 자료형은 싱글턴 패턴을 따르도록 설계하라
[규칙 4](../../../../2017/02/12/creating-and-destroying-objects-2/#규칙-4-객체-생성을-막을-때는-private-생성자를-사용하라) - 객체 생성을 막을 때는 private 생성자를 사용하라
[규칙 5](../../../../2017/02/12/creating-and-destroying-objects-2/#규칙-5-불필요한-객체는-만들지-말라) - 불필요한 객체는 만들지 말라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 규칙 3. private 생성자나 enum 자료형은 싱글턴 패턴을 따르도록 설계하라

> [싱글턴](dp-singleton)은 객체를 하나만 만들 수 있는 클래스다.

#### singleton 구현 방법

###### *public static final* 상수(before JDK 1.5)

```java
public class Single {
	public static final Single INSTANCE = new Single();

	private Single() { ... }
}
```

**문제점**

- 리플렉션으로 private 생성자 호출 가능
- 생성자에서 에러날 경우 예외처리 불가능 -> static 초기화 블럭으로 해결 가능

###### *static factory* 메서드(before JDK 1.5)

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

###### Initialization on demand holder idiom

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

###### *enum*을 이용하는 방법(after JDK 1.5)

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

#### 참고

###### Link

- java singleton pattern (싱글톤 패턴) - https://blog.seotory.com/post/2016/03/java-singleton-pattern
- 게으른 홀더를 통한 싱글턴의 동시성 문제 해결 (Initialization on demand holder idiom) - http://changsuk.me/?p=1433
- Thread-safe Enum Singleton - http://stackoverflow.com/questions/28369025/thread-safe-enum-singleton

###### serializable

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

---

## 규칙 4. 객체 생성을 막을 때는 private 생성자를 사용하라

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

---

## 규칙 5. 불필요한 객체는 만들지 말라

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
	- 성능 떨어짐: 사용해야할 상황 - **데이터베이스**
	- 접속 비용이 큼
	- 라이선스 정책에 따라 연결 수가 제한될 수 있음

- 규칙 39는 방어적 복사<sub>defensive copy</sub>에 관한 것.

    ```java
    // 방어적 복사 방법
    public Period(Date start, Date end) {
        this.start = new Date(start.getTime());
        this.end = new Date(end.getTime());
    }
    ```

	- 규칙 5: "재사용이 가능하다면 새로운 객체는 만들지 말라"
	- [규칙 39](#item39): "새로운 객체를 만들어야 한다면 기존 객체는 재사용하지 말라"
	   방어적 복사가 요구되는 상황에서 객체를 재사용하는 것은 (쓸데없이 같은 객체를 만드는) 비용보다 훨씬 높다는 것에 유의하자. 필요할 때 방어적 복사본을 만들지 못하면 버그나 보안 결함으로 이어진다. 쓸데 없는 객체들은 고작 코드 스타일과 성능에나 영향을 줄 뿐이다.
