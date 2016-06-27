> private 생성자나 enum 타입은 싱글톤 패턴을 따르도록 설계하라.

**JDK 1.5 이전에 싱글톤을 구현하는 방법**

1. public final 이용

```java
public class Single {
	public static final Single INSTANCE = new Single();

	private Single() {
		...
	}
}
```

_주의할점_
 
리플렉션 기능을 통해 private 생성자를 호출할 수 있다.

2. static factory 이용

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

## 직렬화

싱글톤 클래스를 직렬화 가능(Serializable) 클래스로 만드려면, 
- 클래스 선언에 `implements Serializable` 추가
- 모든 필드에 `transient` 선언
- [`readResolve()` 추가](#item77)
	
	```java
	private Object readResolve() {
		// 동일한 객체가 반환되도록 하는 동시에,
		// 가짜 객체는 gc가 처리하도록 만든다.
		return INSTANCE;
	}
	```

**JDK 1.5 이후, `enum`을 이용하는 방법**

```java
public enum Single {
	INSTANCE;
	...
}
```

- 직렬화 자동으로 처리된다.
- 리플렉션 공격에도 안전하다.