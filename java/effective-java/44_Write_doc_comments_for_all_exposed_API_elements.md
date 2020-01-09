# 모든 API 요소에 문서화 주석을 달라

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