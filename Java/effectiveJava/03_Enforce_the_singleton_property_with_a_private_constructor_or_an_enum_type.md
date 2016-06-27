> private 생성자나 enum 타입은 싱글톤 패턴을 따르도록 설계하라.

## JDK 1.5 이전에 싱글톤을 구현하는 방법

1. `public final` 이용

	```java
	public class Single {
		public static final Single INSTANCE = new Single();

		private Single() {
			...
		}
	}
	```

2. `static factory` 이용

	```java
	public class Single {
		private static final Single INSTANCE = new Single();
		private Single() {
			...
		}
		public static Single getInstance() {
			return INSTANCE;
		}
	}
	```

**_주의할점_**
 
리플렉션 기능을 통해 private 생성자를 호출할 수 있다.

**_[직렬화](#serializable) 문제_**

싱글톤 클래스를 직렬화 가능(Serializable) 클래스로 만드려면, 
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

## JDK 1.5 이후, `enum`을 이용하는 방법

```java
public enum Single {
	INSTANCE;
	...
}
```

- 직렬화 자동으로 처리된다.
- 리플렉션 공격에도 안전하다.

_why?_

- 선언된 상수 이외의 다른 객체는 존재할 수 없다는 확실한 보장이 생긴다(JVM이 해주는 보장).
- `enum` 타입은 `Comparable` 인터페이스, `Serializable` 인터페이스가 구현되어 있다.

## NOTE

#### serializable

> 객체의 내용을 파일에 저장하거나 네트워크로 전송하기 위해서 스트림으로 만드는 작업(바이트 단위로 변환)

- `Serializable` 인터페이스 구현 
- 모든 필드 또한 `Serializable` 인터페이스 구현
- 제외하고자하는 필드는 `transient`

```java
public class SerializerTest {
	private String filePath = "/file/test.ser";
	private User user;

	public void 직렬화() {
		user = new User("yj", 26, "pwd");
		FileOutputStream f = new FileOutputStream(filePath);
		ObjectOutputStream o = new ObjectOutputStream(f); // 직렬화 클래스
		o.writerObject(uesr); // 파라미터로 넘긴 객체를 스트림으로 만들어서 출력하는 메서드
		o.close();
	}

	public void 역직렬화() {
		FileInputStream f = new FileInputStream(filePath);
		ObjectInputStream o = new ObjectInputStram(f); // 역직렬화 클래스
		user = (User) o.readObject(); // 입력된 스트림으로부터 객체를 만들어서 반환하는 메서드
		o.close();
	}
}

@Data
class User implments Serializable {
	private static final long serialVersionUID = 1L; // 이건 왜?
	private String name;
	private int age;
	private transient String password;
}
```


