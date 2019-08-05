```java
import static org.easymock.EasyMock.*;
import static org.junit.Assert.*;

import javax.servlet.http.HttpServletResponse;

import org.easymock.EasyMockRule;
import org.easymock.EasyMockSupport;
import org.easymock.Mock;
import org.easymock.TestSubject;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ErrorCollector;

import lombok.extern.slf4j.Slf4j;

/**
 * easyMock을 사용한 테스트케이스
 * @author yeongjun on 2016. 8. 4.
 */
@Slf4j
public class ControllerTest extends EasyMockSupport {

	@Rule
	public EasyMockRule rule = new EasyMockRule(this);
	@Rule
	public ErrorCollector rule2 = new ErrorCollector();

	@Mock
	private TestBO testBO;
	@Mock
	private HttpServletResponse response;

	@TestSubject
	private TestController controller = new TestController();

	private Data data;
	private User user;

	@Before
	public void setUp() {
		data = new Data();
		data.setId(2001);
		data.setName("yeongjun");

		user = UserMock.getDefaultuser();
	}

	@Test
	public void get() throws Exception {
		// given

		// when
		int returnTotalCount = 123;
		expect(testBO.get(user.getId())).andReturn(data);
		expect(testBO.getMemberCount(user.getId())).andReturn(returnTotalCount);
		expect(response.getHeader("X-TOTAL-COUNT")).andReturn(returnTotalCount + "");
		response.setHeader(anyString(), anyString());
		expectLastCall();
		replayAll();

		// then
		Data t = controller.get(user, response);
		assertEquals(2001, t.getId());
		assertEquals("yeongjun", t.getName());
		assertEquals("123", response.getHeader("X-TOTAL-COUNT"));
	}

	@Test
	public void getWithId() throws Exception {
		// given
		int id = 2001;

		// when
		expect(testBO.get(id)).andReturn(data);
		replayAll();

		// then
		Data t = controller.getWithId(user, id);
		assertEquals(2001, t.getId());
		assertEquals("yeongjun", t.getName());
	}

	@After
	public void after() {
		verifyAll();
	}
}
```

```java
@Slf4j
public class UserMock {
	public static User getDefaultWorksUser() {
		User user = mock(User.class);
		when(user.getId()).thenReturn(2001);

		return user;
	}
}
```