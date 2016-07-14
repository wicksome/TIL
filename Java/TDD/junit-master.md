 # JUnit 마스터하기

**하나의 테스트 메서드에서는 하나의 테스트만 수행하라**
**테스트 메서드를 합치지 말자**

```java
@Test
public void testProcessRequest() {
	Response response = controller.processRequest(request);
	assertNotNull("Must not return a null response", response);
	assertEquals("Response shold be of type SampleResponse", SampleResponse.class, response.getClass());
	assertEquals(new SampleResponse(), response);
}

@Test
@Deprecated
public void testAddAndProcess() {
	RequestHandler handler2 = controller.getHandler(request);
	assertSame("Handler we set in controller should be the same handler we get", handler2, handler);

	Response response = controller.processRequest(request);
	assertNotNull("Must not return a null response", response);
	assertEquals("Response shold be of type SampleResponse", SampleResponse.class, response.getClass());
}
```

**예외를 던지는 메서드 테스트**

```java
@Test(expected = RuntimeException.class)
public void testGetHandlerNotDefined() {
	SampleRequest request = new SampleRequest("testNotDefined");
	controller.getHandler(request);
}
```

**타임아웃 테스트**

- 테스트를 건너뛸 때는 반드시 그 이유를 명시하라
- 시간이 지나면 실패
- ex) 오래 끌어서는 안되는 메서드의 경우 테스트

```java
@Test(timeout = 130)
@Ignore(value = "Ignore for now until we decide a decent time-limit")
public void testProcessMultipleRequestsTimeout() {
	Request request;
	Response response = new SampleResponse();
	RequestHandler handler = new SampleHandler();
	for (int i = 0; i < 10; i++) {
		request = new SampleRequest(String.valueOf(i));
		controller.addHandler(request, handler);
		response = controller.processRequest(request);
		assertNotNull(response);
		assertNotSame(ErrorResponse.class, response.getClass());

	}
}

```

**테스트용 클래스**

- 동일 패키지에 public class로 만든다
- 이너 클래스로 만든다

```java
// 이너 클래스
public class testDefaultControll {
	...
	private class SampleRequest implements Request {
		private static final String DEFAULT_NAME = "Test";
		private String name;

		public SampleRequest(String name) {
			this.name = name;
		}

		public SampleRequest() {
			this(DEFAULT_NAME);
		}

		@Override
		public String getName() {
			return this.name;
		}
	}
	...
}
```

**ETC**

- 테스트 클래스 이름
	- 책에서는 테스트 클래스의 이름을 'test' 접두어를 사용하라고 말함
		- junit 1.3 버전에서는 필수
		- 1.4 버전에서는 `@Test`가 있기때문에 필수는 아님
	- 인텔리제이에서 테스트케이스 자동생성하면 'Test' 접미어로 생성됨
