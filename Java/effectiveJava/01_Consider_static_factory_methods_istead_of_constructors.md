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

	- 여러번 호출하더라도 미리 생성된 인스턴스 사용/반환 가능
	
		> [Flyweight 패턴](#flyweight-pattern)과 유사하다.

		- 동일한 인스턴스를 자주 사용하는 경우
		- 이미 생성된 인스턴스를 사용해야 하는 경우

	- 클래스에서 인스턴스들의 존재를 직접 제어 가능

		> 이러한 클래스를 _인스턴스 제어 클래스_라고 한다.

		- 인스턴스를 제어하면 [singleton](#item03) 또는 [noninstantiable(인스턴스 생성 불가)](#item04) 클래스 생성 가능
		- [불변 클래스](#item15)에서 두 개의 동일한 인스턴스가 생기지 않도록 함
			- `equals()` 대신 `==` 연산자 사용 가능
			- [`enum`에서는](#item30) 이것을 보장

3. 자신의 인스턴스만 반환하는 생성자와는 달리, 서브타입 객체도 반환 가능하다.

	- inner 클래스의 객체를 생성하고 반환할 수 있는 API가 있다. 이런 형태로 구현 클래스를 감추면 API가 매우 간결해 진다. 이 기법은 static 팩토리 메서드의 반환 타입으로 `interface`를 사용하는 [_인터페이스 기반 프레임워크_](#item18)에 적합하다.

		```java
		// TODO: 이해하기
		```

	- 자바의 인터페이스는 static 메서드를 가질 수 없으므로 `Type`이라는 인터페이스 타입을 반환하는 static 팩토리 메서드들이 Types로 명명된 [인스턴스 생성 불가 클래스](#item4)에 들어있다.

		```java
		// TODO: 이해하기

		// java.lang.reflect
		iterface Type {
			default String getTypeName() {
				return toString();
			}
		}
		// Q. default 키워드?
		// A. java 8 추가기능, 

		public class Types implements Type {
			private Types() {
				throw new AssertionError();
			}

			public Type getType() {
				return ...
			}
		}
		```

	- TODO: 이해하기

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

1. 인스턴스 생성을 위해 static 팩토리 메서드만 갖고 있으면서 public이나 protected 생성자가 없는 클래스의 경우는 서브 클래스를 가질 수 없다는 것이다.

	```java
	class Types {
		private Types() {
			throw new AssertionError();
		}
		...
	}

	// inheritance
	public class Collection extends Types {
		public Collecction() {
			super(); // 불가능
		}
	}

	// composition
	public class Collection {
		Types types;
	}
	```

	- `public`이나 `protected` 생성자가 없기 때문에 확장이 불가능하다.
	- 그러므로, [composition을 사용한다.](#item16)
		- 상속을 사용하는 경우: `is-a` 관계
		- 컴포지션을 사용하는 경우: `has-a` 관계

## note

#### Flyweight pattern

