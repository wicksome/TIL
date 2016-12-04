# 모든 API 요소에 문서화 주석을 달라

> **좋은 API 문서를 만들려면 API에 포함된 모든 클래스, 인터페이스, 생성자, 메서드, 그리고 필드 선언에 문서화 주석을 달아야 한다.**

- 문서화 주석과 javadoc을 통해 API 문서를 자동으로 만들 수 있다. 문서화 주석 분법은 자바 언어의 일부는 아니지만, 모든 프로그래머가 알아야 하는 실질적인 표준 API다. ([How to Write Doc Comments - Oracle 웹사이트](http://www.oracle.com/technetwork/articles/java/index-137868.html))




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



>  **코드는 `{@code }` 태그를 사용하라.**

- 코드 서체로 표시되도록 한다.

- 태그 안에 포함된 모든 HTML 마크업이나 javadoc 태그가 위력을 발휘하지 못하도록 한다.

- 여러 줄로 나뉜 코드를 문서화 주석에 넣을 때는 `{@code }` 태그를 HTML `<pre>` 태그 안에 넣어라.

- `<tt>`  태그는 HTML5 에서 더이상 지원하지 않는다(고정폭을 보여줘야 할 경우에는 일반적으로 `<code>` 태그).

  *\<tt\> - MDN*

  > **Obsolete**
  > This feature is obsolete. Although it may still work in some browsers, its use is discouraged since it could be removed at any time. Try to avoid using it.




>  **주석을 달 때 명심해야 할 일반적 원칙은, 문서화 주석은 소스 코드로 보나 javadoc으로 변환한 결과물로 보나 읽을 만해야 한다는 것이다. 그럴수 없는 상황이라면, javadoc으로 변환한 결과물의 가독성을 우선시하기 바란다.**

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




## 클래스

```

```

- 직렬화(serialization)가 가능한 클래스라면 직렬화 형식도 밝혀야 한다(규칙 75). 




## 메서드

```

```

- 메서드와 클라이언트 사이의 규약을 간명하게 설명해야 한다. 
- 메서드에 대한 문서화 주석은 메서드와 클라이언트 사이의 규약(contract)을 간명하게 설명해야 한다.
- 계승을 위해 설계된 메서드가 아니라면(규칙 17) 메서드가 *무엇*을 하는지를 설명해야 한다. ( = *어떻게* 그 일을 하는지를 설명해서는 안 된다)
- 해당 메서드의 모든 선행조건(precondition)과 후행조건(postcondition)을 나열해야 한다.
  - 선행조건: 메서드를 호출하려면 반드시 참(true)이 되어야 하는 조건들
     무결점 예외(unchecked exception)에 대한 @throw 태그를 통해 암묵적으로 기술한다. 관계도니 인자의 @param 태그를 통해 명시할 수도 있다.
  - 후행조건: 메서드 실행이 성공적으로 끝난 다음에 만족되어야 하는 조건들
- 메서드는 부작용(side effect)에 대해서도 문서화 해야 한다. 부작용은 후행조건을 만족하기 위해 필요한 것이 아닌, 시스템의 관측 가능한 상태 변화를 일컫는다.
- 규칙 70에 설명한 대로, 클래스가 메서드의 스레드 안전성(thread safety)에 대해서도 문서에 남겨야 한다.
- 메서드의 규약(contract)을 완벽하게 기술하려고 문서화 주먹에는 인사마다 @param 태그를 달아야 하고, 반환값 자료형이 void 가 아니라면. @return 태그도 달아야 한고, 무덤덤/점검 여부에 상관없이 모든 예외에는 @throws 태그도 붙어야 한다(규칙 62).








swagger