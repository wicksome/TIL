```java
@Data
@Accessors(chain = true, fluent = true)
public abstract class AbstractException extends Exception {
	private String code;
	private String message;
  
  public abstract ErrorCode getErrorCode();
}

public CustomException extends AbstractException {
  ...
}
```

```java
throw new CustomException()
  .code()
  .message()
```
