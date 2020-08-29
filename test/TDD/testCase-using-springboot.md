> 아직 찾아보는 중

```java
@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest(classes = {Application.class})
public class DataControllerTest {
	@MockBean
	private DataBO dataBO;

	@Autowired
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