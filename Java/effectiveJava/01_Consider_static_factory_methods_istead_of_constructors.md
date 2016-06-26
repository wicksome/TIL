> 생성자 대신 static factory method 사용을 고려하자

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

	private Boolean(boolean b) {
		this.value = b;
	}

	private Boolean(String str) {
		this.value = "true".equalsIgnoreCase(str);
		// Q. str.equalsIgnoreCase("true") 를 안쓰는 이유
		// A. str이 null이면 NullPointException 발생
	}

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

- 위 코드에 statice factory method `valueOf()`는 Design Patterns에 나오는 팩토리 메서드 패턴과 다르다.

## 장점

1. 이해하기 쉬운 메서드를 생성자로 사용할 수 있다.

	클래스의 인스턴스를 생성하는데 있어서 매개변수의 타입과 갯수로 구별하는 것보단 잘 지은 이름이 더 파악하기 쉽다.

2. 생성할 때마다 인스턴스를 생성하지 않아도 된다.

	특정 경우(동일한 인스턴스를 자주 사용하는 경우, 이미 생성된 인스턴스를 사용해야 하는 경우...)에 미리 생성된 인스턴스를 사용할 수 있다([Flyweight 패턴](#flyweight-pattern)과 유사하다).

	생성자를 여러 번 호출하더라도 이미 생성된 동일한 객체를 반환할 수 있다. 즉, 클래스에서 언제든지 인스턴스들의 존재를 직접 제어할 수 있다(== 인스턴스 제어 클래스). 인스턴스를 제어하면 singleton 또는 noninstantiable(인스턴스 생성 불가) 클래스로 만들 수 있다.

## note

#### Flyweight pattern

