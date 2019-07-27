```java
@Slf4j
@RunWith(SpringRunner.class)
public class DataControllerTest {
	@Mock
	private DataBO dataBO;

	@InjectMocks
	private DataController dataController;

	@Test
	public void getWithId() throws Exception {
		// given
		User user = UserMock.getDefaultUser();
		Data expected = new Data();
		expected.setName("worksmobile");
		expected.setId(2001);
		expected.setRegisterDate(ZonedDateTime.of(2016, 8, 10, 0, 0, 0, 0, ZoneId.systemDefault()));

		given(dataBO.get(expected.getId())).willReturn(expected);

		// when
		Data result = dataController.get(user, new MockHttpServletResponse());

		// then
		assertThat(result.getId(), is(expected.getId()));
		assertThat(result.getName(), is(expected.getName()));
		assertThat(result.getRegisterDate(), is(expected.getRegisterDate()));
		assertThat(result, is(expected));
	}
}
```

```java
@Slf4j
public class UserMock {

	public static User getDefaultUser() {
		User user = mock(User.class);
		when(user.getName()).thenReturn("worksmobile");
		when(user.getId()).thenReturn(2001);
		...
		
		return user;
	}
}
```