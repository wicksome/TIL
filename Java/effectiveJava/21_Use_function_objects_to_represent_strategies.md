# 전략을 표현하고 싶을 때는 함수 객체를 사용하라

> ''전략을 표현하고 싶을 때는 전략 패턴을 써라'' 이건가?



**strategy pattern**

인자로 함수를 넘겨줘서 그 함수를 통해 실행 전략을 세우는 방법.

정렬을 한다고 할때, 어떻게 정렬하는가는 넘겨주는 것이 전략패턴.

JAVA는 함수를 넘겨 줄수 없으나, 함수를 가지고 있는 객체를 넘겨주면 됨

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
