---
title: Java Generic
date: 2016-04-12 16:40:01
tags:
- java
category:
- slide
layout: slide
---
## 제네릭 프로그래밍

---

## generic class, method

    // class
    public class Entry<K, V> {
        private K key;
        private V value;
        ...
    }

    Entry<String, Integer> entry = new Entry<>(...);

    // method
    public class Arrays {
        public <T> void swap(T[] array, int i, int j) {
            T tmp = array[i];
            array[i] = array[j];
            array[j] = tmp;
        }
    }

--

### generic method

	public static <T> void swap(T[] array, int i, int j)

- 타입 파라미터를 제어자와 반환타입 사이에 둔다
- 호출할 때는 명시하지 않아도 가능
	- 컴파일러가 타입파라미터 추론
	```
	Arrays.<String>swap(friends, 0, 1);
	```
	- 원한다면 명시적으로 가능
	- 문제 발생시 더 자세한 오류 메시지

--

### E? T? <code>?</code>?

- E : Element
- T : Type
- V : Value
- K : Key
- ? : 와일드 카드
- ...

--

### 기본 타입은 불가능

    Entry<String, int> // 불가능

---

## 타입 경계
제네릭 클래스/메서드가 받는 타입 파라미터의 타입을 제한할 때

    public status <T extends AutoCloseable> void closeAll(ArrayList<T> elems) {
        for (T elem : elems) {
            elem.close();
        }
    }

- 다중 경계 지정

```java
T extends Runable & AutoCloseable
```

--

### &lt;T extends AutoCloseable&gt;

- 요소타입이 AutoCloseable의 서브타입임을 보장한다.
- extends == 서브타입, 상속 X
    - 기존에 사용하던 extends 키워드를 사용함

---

## 타입 가변성과 와일드카드

- Employee의 서브클래스 객체로 구성된 배열을 사용하고자 할 때,
    ```
    public static void process(Employee[] staff) {...}
    ```
- 이때, Manager[]이 Employee[]의 서브타입이라면 process()에 전달할 수 있다.
    - 이러한 동작을 공변성(covariance)라고 한다.
    - 즉, 배열은 요소 타입과 같은 방식으로 변한다.
- 자바에서는 와일드카드로 메서드의 파라미터와 반환 타입이 변하는 방식을 지정.
	- 이 메커니즘을 use-site variance(사용처 공변성)이라고 한다.

--

### covariance

	Manager[] bosses1 = new Manager[10];
	Employee[] empls1 = bosses1; // 공변성
	empls1[0] = new Manager(); // p.169
	// 런타임에서 ArrayStoreException을 던질 때 잡을 수 파악

- 자바의 모든 제네릭 타입은 불변(invariant)

--

### But!

	ArrayList<Manager> bosses2 = new ArrayList<>();
	ArrayList<Employee> empls2 = bosses2; // error

- 자바의 모든 제네릭 타입은 불변(invariant)
- ArrayList<Manager>은 ArrayList<Employee>의 서브타입이 아니다.

--

### 서브타입 와일드카드

- &lt;? extends Employee&gt;
	```
	public statis void pringNames(ArrayList<? extends Employee> staff) {
		for(Employee e : staff) {
			System.out.println(e.getName());
		}
	}
	```
- ?는 Employee의 서브타입

--

#### But!!

	Employee e = staff.get(0); // 가능
	staff.add(new Manager("yj")); // 불가능, 컴파일 에러

- ?는 어떤 서브클래스든 가르킬 수 있으므로 컴파일 오류
- 즉, ? extends Employee는
	- Employee로 변환할 수 있지만
	- 어떤 것도 절대 ? extends Employee로 변환할 수 없다.

	<img src="doc/images/java-generic-01.png"/>

- ArrayList&lt;? extends Employee&gt;에서 읽을 수는 있지만 쓸 수는 없다.

--

### 슈퍼타입 와일드카드

- ? super Employee
	- 함수형 객체의 파라미터로 유용
	```
	public interface Pridicate<T> {
		boolean test(T arg);
		...
	}
	```
	- p.247 다시 볼것
	- [super vs extends](http://stackoverflow.com/questions/4343202/difference-between-super-t-and-extends-t-in-java)

--

### 슈퍼타입 와일드카드 2

PECS(Producer Extends Consumer Super)
와일드카드와 관련해 PECS라는 약칭을 사용하기도 한다. 생산자에는 extends, 소비자에는 super를 사용한다는 의미이다.

	public void pushAll(Iterable<? extends E> src) {
		for (E e : src) {
			push(e);
		}
	}

	public void popAll(Collection<? super E> dst) {
		while(!isEmpty()) {
			dst.add(pop());
		}
	}

예를 들어, Stack의 경우에 pushAll()의 src는 Stack에서 사용될 E 인스턴스를 생산하므로 extends, popAll()의 dst는 Stack으로부터 E 인스턴스를 소비하므로 super가 적합하다. <small>(이펙티브자바 항목 28)</small>

--

### 타입 변수와 함께 사용하는 와일드카드

- p.249 공부할 곳

--

### 경계 없는 와일드카드

	public static boolean hasNulls(ArrayList<?> elems) {
		for(Object e : elems) {
			if (e == null) return true;
		}
		return false;
	}

- 파라미터(ArrayList)의 타입 파라미터(?)가 중요하지 않을 때 제네릭 메서드보다 ArrayList<?>를 사용하는 것이 타당

--

### 와일드카드 캡처

	public static void swap(ArrayList<?> elems, int i, int j) {
		? temp = elems.get(i);
		elems.set(i, elems.get(j));
		elems.set(j, temp);
	}

- ?을 타입으로 사용할 수 없다.

--

#### 정상적인 코드

	public static void swap(ArrayList<?> elems, int i, int j) {
		swapHelper(elems, i, j);
	}

	private static <T> void swapHelper(ArrayList<T> elems, int i, int j) {
		T temp = elems.get(i);
		elems.set(i, elems.get(j));
		elems.set(j, temp);
	}

--

### why?

- 와일드카드 캡처라는 규칙 덕분에 가능
- 컴파일러는 ?를 모르지만, ?는 어떤 타입을 나타내므로 제네릭 메서드를 호출해도 된다.
- swapHelper 메서드의 타입파라미터 T는 와일드카드 타입을 **캡처**한다.
- API 사용자가 T보다 ?를 이해하는것이 쉽다.

---

## 자바 가상 머신에서의 제네릭

- 제네릭이 없던 시절에는 Object 타입으로 받았다.
- 이후 설계자들은 VM에서 타입을 지우는 구현 방식으로 기존 버전 클래스와 호환되게 했다.
- 그리고 점진적으로 제네릭으로 옮겨갔다.

--

### 1. 타입소거

제네릭을 정의하면 해당 타입은 raw 타입으로 컴파일된다.

	public class Entry {
		private Object key;
		private Object value;

		public Entry(Object key, Object value) {
			this.key = key;
			this.value = value;
		}
		...
	}

--

#### 경계가 있는 타입변수의 경우

첫 번째 경계로 교체된다.

	public class Entry<K extends Comparable<? super K> & Serializable,
					   V extends Serializable>

다음과 같이 교체

	public class Entry{
		private Comparable key;
		private Serializable value;
		...

--

### 2. 타입 변환 연산자 삽입

- Entry<String, Integer>의 객체로 생성할 경우 반드시 String, Integer가 전달되야 한다.
	- 그렇지 않으면 컴파일 X
	- 즉, getKey()는 String을 반환한다는 것을 보장받는다.(컴파일이 안되므로)

--

### 2.1 타입 변환 연산자 삽입

- 타입 연산자(T), 제네릭, raw(Object)를 사용하여 컴파일된 경우(비검사 경고옵션으로)
	- 다른 값이 들어갈 수 있다.
	- 따라서 실행 시간에 안전성 검사를 해야 한다.
```
Entry<String, Integer> entry = ...
String key = entry.getKey();
```
	- 타입이 소거된 getKey()는 Object를 반환하므로 컴파일러는 다음과 같은 코드를 만들어낸다.
```
String key = (String) entry.getKey();
```

--

### 3. bridge method

- 메서드 파라미터와 반환 타입을 소거할 때 때때로 컴파일러가 브릿지 메서드를 만들어내야 한다.
- 컴파일러가 raw로 만들었기 때문에 bridge method 생성

--

#### example

	public class WordList extends ArrayList<String> {
		public void add(String e) {
			return isBadWord(e) ? false : super.add(e);
		}
		...
	}
	...
	WordList words = ...
	ArrayList<String> strs = words;
	strs.add("JAVA");

- strs.add()에서 타입소거된 ArrayList의 add(Object)를 호출한다.
- WordList 객체의 add를 호춣하면 동적 메서드 조회가 일어나고, ArrayList가 아닌 WordList의 add가 호출될 것을 예상할 수 있다.

--

#### example

- 컴파일러는 예상대로 동작하게 하려고 WordList 안에 bridge method를 만든다.

```
public class WordList extends ArrayList<String> {
	public void add(String e) {
		return isBasWord(e) ? false : super.add(e);
	}

	// bridge method
	public void add(Object e) {
		add((String) e);
	}
	...
}
```
- add(Object)가 호출되고 WordList의 add(String)가 호출된다.

--

#### bridge method

- 컴파일러는 동적 메서드 조회가 일어나게 하려고 브릿지 메서드를 만들어낸다.
- 자바에서는 이러한 메서드 쌍을 구현할 수 없다.(?)
	- 파라미터 타입이 다르면 오버로딩으로 가능한데 why?
	- String get(int), Object get(int)의 형태로도 bridge method 생성!
- 가상 머신에서는 메서드를 이름, 파라미터 타입, 반환 타입으로 명시하므로 컴파일러가 이 메서드 쌍을 만들어낼 수 있다.

--

#### Note

- 제네릭 외에 공변 반환 타입(covariant return type)을 구현하는데도 이용

```
public class Employee implements Cloneable {
	public Employee clone() throws CloneNotSupportedException { ... }
}

Employee clone()
Object clone() // bridge method
```

---

## 제네릭의 제약
- 기본 타입 인자가 없다
- 실행 시간에는 모든 타입이 raw 형태다
- 타입 변수의 인스턴스를 만들 수 없다
- 파라미터화된 타입의 배열을 생성할 수 없다
- 정적 컨텍스트에서는 클래스 타입 변수가 유효하지 않다
- 메서드가 소거 후 충동하지 않을 수도 있다
- 예외와 제네릭

### 실행 시간에는 모든 타입이 raw 형태다
VM에는 오직 raw type만 있다. 그래서 실행시간에 ArrayList가 String 객체를 담고 있는지 알아낼 수 없다.

<img src="doc/images/java-generic-02.png"/>

이와 같은 조건은 절대로 검사할 수 없으므로 compile-time error를 일으킨다

--

### 실행 시간에는 모든 타입이 raw 형태다

아래 코드는 비효율적이지만 합법적인 방법이다. obj가 ArrayList인지만 검사한다.

	Object obj = ...;
	ArrayList<String> list = (ArrayList<String>) obj;

경고창을 사라지게 하려면 변수앞에 어노테이션을 붙여야 한다.

	@SuppressWarnings("unchecked") ArrayList<String> list = (ArrayList<String>) obj;

--

### but!

**caution**

@SuppressWarnings 어노테이션을 잘못 사용하면 heap pollution으로 이어질 수 있다. heap pollution이란 객체가 특정 제네릭 타입 인스턴스에 속해야 하지만 실제로는 다른 인스턴스에 속하는 현상을 말한다. ArrayList<String>에 ArrayList<Integer>을 할당할 수 있지만, 부적합한 타입 요소를 추출하면 당연히 ClassCastException이 일어난다.

<img src="doc/images/java-generic-03.png"/>

--

### but!

**tip**

힙 펄루션의 문제점은 보고된 실행 시간 오류가 문제의 원인(부적합한 요소의 삽입)과 상당히 다르다는 점이다(문제의 원인은 인스턴스에 다른 값을 넣은 것인데 ClassCate가 발생하는 점). 이런 문제를 디버그하려면 checked view를 사용해야 한다.

	List<String> strings =
		Collections.checkedList(new ArrayList<>, String.class);

이 검사 뷰는 해당 리스트에 삽입하는 동작을 모두 검사해서 부적합한 타입 객체를 추가하는 순간 예외를 던진다.

--

### 실행 시간에는 모든 타입이 raw 형태다

getClass 메서드는 항상 raw 타입을 반환한다.

	ArrayList<String> list = ...;
	list.getClass(); // ArrayList.class
	ArrayList<String>/classl // 없는 클래스이므로 문법오류 발생

--

### 타입 변수의 인스턴스를 만들 수 없다.

해결하려면 호출하는 쪽에서 배열 생성자를 메서드 참조로 제공하게 해야 한다.

	// obj가 n개 들어간 배열을 만든다고 가정할때
	String[] arr = Arrays.repeat(10, "hi", String[]::new);
	public static <T> T[] repeat(int i, T obj, IntFunction<T[]> constr) {
		T[] result = constr.apply(n);
		for (int i=0; i < n; i++) result[i] = obj;
		return result;
	}

	String[] arr = Arrays.repeat(10, "hi", String.class); // 리플렉션
	public static <T> T[] repeat(int n, T obj, Class<T> cl) {
		@SuppressWarnings("unchecked") T[] result = (T[]) java.lang.reflect.Array.newInstance(cl, n);
		for (int i=0; i < n; i++) result[i] = obj;
		return result;
	}

--

### 타입 변수의 인스턴스를 만들 수 없다.
또 다른 방법으로 호출하는 쪽에서 배열을 할당하게 하는 방법

	String[] arr = Arrays.repeat(10, "hi", new String[5]);
	public static <T> T[] repeat(int i, T obj, T[] array) {
		T[] result;
		if(array.length >= n) {
			result = array;
		} else {
			@SuppressWarnings("unchecked") T[] newArray = (T[]) java.lang.reflect.Array.newInstance(
					array.getClass().getComponenetType(), n);
			result = newArray;
		}
		for (int i=0; i < n; i++) result[i] = obj;
		return result;
	}

--

### tip

타입 변수를 이용하여 ArrayList는 생성가능하니, 마땅히 배열을 사용해야하는 이유가 없다면 ArrayList방법을 권장한다.

	public static <T> ArrayList<T> repeat(int n, T obj) {
		ArrayList<T> result = new ArrayList<>();
		for(int i = 0; i < n; i++) result.add(obj);
		return result;
	}

--

### 파라미터화된 타입의 배열을 생성할 수 없다.

	// 오류 - 제네릭 컴포넌트 타입으로 구성된 배열은 생성할 수 없다.
	Entry<String, Integer>[] entries = new Entry<String, Integer>[100];
	// 해결방안
	@SuppressWarnings("unchecked") Entry<String, Integer>[] entries
		= (Entry<String, Integer>[]) new Entry<?, ?>[100];

	// 더 나은 방안 - ArrayList 사용
	ArrayList<Entry<String, Integer>> entries = new ArrayList<>(100);

--

### 파라미터화된 타입의 배열을 생성할 수 없다.

	public static <T> ArrayList<T> asList(T... elements) {
		ArrayList<T> result = new ArrayList<>();
		for(T e : elements) {
			result.add(e);
		}
		return result;
	}
	...
	Entry<String, Integer> e1 = ...;
	Entry<String, Integer> e2 = ...;
	ArrayList<Entry<String, Integer>> entries = Lists.asList(e1, e2); // 컴파일러가 경고, 오류X

	@SafeVarargs public static <T> ArrayList<T> asList(T... elements) {
		...

--

### 정적 컨텍스트에서는 클래스 타입 변수가 유효하지 않다.

	public class Entry<K, V> {
		private static V defaultValue; // 오류
		public static void setDefault(V value) { ... } // 오류
		...
	}

	타입 소거는 소거된 Entry 클래스에 이런 종류의 변수나 메서드가 K와 V별로 있는 것이 아니라 오직 한 개만 있다는 것을 알 수 있다.
	== 타입 소거가 되면 Entry 클래스에는 Object로 모두 바뀌어서 구분할 수 없이 Object 한 개만 있다는 것이다?

--

### 메서드가 소거 후 충돌하지 않을 수도 있다.

타입 소거 후 충돌을 일으킬 수 있는 메서드는 선언하지 않아야 한다. 다음 코드는 타입 소거후 Object의 equals과 충돌한다.

	public interface Ordered<T> extends Comparable<T> {
		public default boolean equals(T value) {
			return compareTo(value) == 0;
		}
		...
	}

--

### 메서드가 소거 후 충돌하지 않을 수도 있다. 2

충돌의 원인이 미묘할 때

	public class Employee implements Comparable<Employee> {
		...
		public int compareTo(Employee other) {
			return name.compareTo(other.name);
		}
	}
	public class Manager extends Employee implements Comparable<Manager> {
		// 오류 - 두 Comparable 인스턴스를 슈퍼타입으로 둘 수 없다.
		...
		public int compareTo(Manager other) {
			return Double.compare(salary, other.salary);
		}
	}

여기서는 소거가 일어나지 않는다. 두 compareTo의 브릿지 메서드가 충돌한다.
// ?. 제목이랑 내용이랑 무슨 말인지..?

--

### 예외와 제네릭

제네릭 클래스의 객체는 예외로 던지거나 잡아낼 수 없다. Throwable의 제네릭 서브클래스조차 만들 수 없다.

	public class Problem<T> extends Exception {
		// 제네릭 틀래스는 Throwable의 서브타입이 될 수 없다.
	}

catch 절에서도 타입 변수를 사용할 수 없다.

	...
	try {
		r.run();
	} catch(T ex) {
		Logger.get....
	}

--

### but

throws 선언에는 타입 변수를 사용할 수 있다.

	public static <V, T extends Throwable> V doWork(Callable<V> c, T ex) throws T {
		try {
			return c.call();
		} catch (Throwable realEx) {
			ex.initCause(realEx);
			throw ex;
		}
	}

---

## 리플렉션과 제네릭

--

### Class<T> 클래스
**Class 클래스는 Class 객체가 기술하는 클래스를 타입 파라미터로 받는다.**

String.class 는 타입이 Class<String>이다. 그러므로, Class<String>의 newInstance 메서드는 String을 반환한다.
이 정보 덕분에 타입 변환 연산자를 사용하지 않아도된다.

--

### 가상 머신에서 제네릭 타입 정보

**제네릭 클래스와 제네릭 메서드의 선언부가 지워지지 않으므로 리플렉션으로 접근할 수 있다.**

--

### 가상 머신에서 제네릭 타입 정보 2

java.lang.reflect 패키지의 Type 인터페이스는 제네릭 타입 선언을 나타낸다. Type 인터페이스의 서브타입은 다음과 같다.

1. 구체적인 타입을 기술하는 Class 클래스
2. (T extends Comparable<? super T> 같은) 타입 변수를 나타내는 TypeVariable 인터페이스
3. (? super T 같은) 와일드카드를 나타내는 WildcardType 인터페이스
4. (Comparable<? super T> 같은) 제네릭 클래스나 인터페이스를 나타내는 ParameterizedType 인터페이스
5. (T[] 같은) 제네릭 배열을 나타내는 GenericArrayType 인터페이스

--

### 가상 머신에서 제네릭 타입 정보 3

Class, Method, Constructor 객체가 제네릭 선언에서 나온 것인지 알아내려면 getTypeParameters 메서드를 호출한다. 반환값으로 TypeVariable 인스턴스 배열을 얻으며 각 요소는 선언부에 있는 타입 변수를 나타낸다. 길이가 0이라면 제네릭 선언이 아니다.

	Method m = Collections.class.getMethod("sort", List.class);
	TypeVariable<Method>[] vars = m.getTypeParameters();
	String name = vars[0].getName();
	System.out.println(name); // "T"
