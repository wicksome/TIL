> 객체 생성을 막을 때는 private 생성자를 사용하라

생성자를 안 만들겠다고 생략하면 컴파일러는 자동으로 인자없는 `public` 생성자를 만든다. 그러므로, 객체 생성을 막기 위해서 `private` 생성자를 추가한다.

```java
public class Utils {
	private Utils() {		
		throw new AssertionError();
	}
}
```

`AssertionError()`은 혹시나 클래스내에서 생성자를 사용할 경우 알려주기 위함이다.