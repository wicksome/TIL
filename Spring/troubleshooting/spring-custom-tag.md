# spring custom tag 적용기

## 문제

```jsp
<c:choose>
	<c:when test="${jsDebug == true}">
		<script type="text/javascript" src="<s:eval expression="@dataProperties['data.web.host']"/>/v2/js/component/jquery.js"></script>
		<script type="text/javascript" src="<s:eval expression="@dataProperties['data.web.host']"/>/v2/js/component/handlebars.js" charset="utf-8"></script>
		<script type="text/javascript" src="<s:eval expression="@dataProperties['data.web.host']"/>/v2/js/component/jquery.i18n.properties.js" charset="utf-8"></script>
		<script type="text/javascript" src="<s:eval expression="@dataProperties['data.web.host']"/>/v2/js/component/i18n.js" charset="utf-8"></script>
		....
	</c:when>
	<c:otherwise>
		<script type="text/javascript" src="<s:eval expression="@dataProperties['data.web.host']"/><s:eval expression="@uiVersion['/v2/js/service/component.js']"/>"></script>
		<script type="text/javascript" src="<s:eval expression="@dataProperties['data.web.host']"/><s:eval expression="@uiVersion['/v2/js/service/common.js']"/>"></script>
	</c:otherwise>
</c:choose>
```

- 리소스파일들을 상대주소로 사용중인데 프록시를 타면서 절대주소 필요
- charset 설정도 들쑥날쑥
- 하드코딩은 싫다




## 해결방안

***결과***

```jsp
<c:choose>
  <c:when test="${jsDebug == true}">
    <resource:js path="/js/component/jquery.js"/>
    <resource:js path="/js/component/handlebars.js"/>
    <resource:js path="/js/component/jquery.i18n.properties.js"/>
    <resource:js path="/js/component/i18n.js"/>
	...
  </c:when>
  <c:otherwise>
    <resource:js path="/js/service/component.js" uncache="true"/>
    <resource:js path="/js/service/common.js" uncache="true"/>
  </c:otherwise>
</c:choose>
```

```jsp
<resource:css path="/css/main.css" uncache="true" relative="true"/>
```



### custom tag로 따로 만들어서 쓰자!

1. 디펜던시 추가 - `pom.xml`

```xml
<dependency>
  <groupId>javax.servlet.jsp</groupId>
  <artifactId>jsp-api</artifactId>
  <version>2.1</version>
</dependency>
```

2. `tld` 생성 - `WEB-INF/Resource.tld`

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<taglib xmlns="http://java.sun.com/xml/ns/j2ee"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-jsptaglibrary_2_0.xsd"
		version="2.0">
	<description></description>
	<tlib-version>1.0</tlib-version>
	<short-name>res</short-name>
	<uri>/WEB-INF/tld/resource</uri>

	<tag>
		<name>js</name>
		<tag-class>com.worksmobile.contact.web.support.tag.JsTag</tag-class>
		<body-content>empty</body-content>
		<attribute>
			<name>path</name>
			<type>java.lang.String</type>
			<required>true</required>
			<rtexprvalue>true</rtexprvalue>
		</attribute>
		<attribute>
			<name>relative</name>
			<type>java.lang.Boolean</type>
			<required>false</required>
			<description></description>
			<rtexprvalue>true</rtexprvalue>
		</attribute>
	</tag>
	<tag>
		<name>css</name>
		<tag-class>com.worksmobile.contact.web.support.tag.CssTag</tag-class>
		<body-content>empty</body-content>
		<attribute>
			<name>path</name>
			<type>java.lang.String</type>
			<required>true</required>
			<rtexprvalue>true</rtexprvalue>
		</attribute>
		<attribute>
			<name>relative</name>
			<type>java.lang.Boolean</type>
			<required>false</required>
			<description></description>
			<rtexprvalue>true</rtexprvalue>
		</attribute>
	</tag>
</taglib>
```

3. SimpleTagSupport 상속받고 `doTag()` 구현하기 - `ResourceTagSupport.java`, `JsTag.java`, `CssTag.java`

> **문제점**
>
> `data.xml`에서 host url을 가져와야함
>
> **해결방안**
>
> properties를 주입받아야하는데 스프링 빈으로 받을 수 없으므로 따로 xml 불러와서 host url 가져옴

```java
@Data
@Slf4j
public abstract class ResourceTagSupport extends SimpleTagSupport {
	private String path;
	private Boolean relative;

	protected static final String HOST_URL;

	static {
		Properties props = new Properties();
		try (InputStream stream = JsTag.class.getResourceAsStream("/data.xml")) {
			props.loadFromXML(stream);
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
		HOST_URL = props.getProperty("data.web.host");
	}

	ResourceTagSupport() {
		this.relative = getRelative() != null ? getRelative() : false;
	}

	@Override
	abstract public void doTag() throws JspException, IOException;
}
```

```java
@Slf4j
@NoArgsConstructor
public class JsTag extends ResourceTagSupport {
	private static final String TEMPLATE = "<script type=\"text/javascript\" src=\"${path}\" charset=\"utf-8\"></script>";

	@Override
	public void doTag() throws JspException, IOException {
		Map<String, String> values = new HashMap<>();
		values.put("path", getRelative() ? getPath() : HOST_URL + getPath());

		StrSubstitutor sub = new StrSubstitutor(values);

		JspWriter writer = getJspContext().getOut();
		writer.println(sub.replace(TEMPLATE));
	}
}
```



### 리팩토링

> **문제점**
>
> - 기존코드에 리소스 캐싱되는 문제를 해결하기 위해 uiVersion을 생성하는 spring component를 사용하는데, 어떻게 가져와서 쓸까? (uiVersion은 리소스 파일을 읽어서 md5 해시도 만들어줌)
> - uiVersion을 JsTag에서 하나하나 사용하려면 페이지 불러오는데 시간이 오래 걸릴 것 같음
> - 기존에는 spring component이기 때문에 스프링 올라갈때 해싱 값 구해서 맵으로 가지고 있음
>
> **해결방안**
>
> - spring custom tag로 갈아타자!

1. `tld`에 attribute 추가

```xml
<attribute>
  <name>uncache</name>
  <type>java.lang.Boolean</type>
  <required>false</required>
  <description></description>
  <rtexprvalue>true</rtexprvalue>
</attribute>
```

2. `extends SimpleTagSupport` -> `extends RequestContextAwareTag` 변경 - `ResourceTagSupport.java`, `JsTag.java`

   > **트러블슈팅**
   >
   > - `getRequestContext().getWebApplicationContext().getBean(클래스);`로 spring Bean 가져올수 있음
   >
   > - `SimpleTagSupport`는 매번 생성자를 호출하는데, `RequestContxtAwareTag`는 생성자는 한번만 호출
   > - 같은 클래스에 Bean이 두개일 경우, `getBean()`에 Bean id/name을 파라미터로 전달

```java
@Slf4j
public abstract class ResourceTagSupport extends RequestContextAwareTag {
	private final String prefix = "/v2";

	@Getter(AccessLevel.PRIVATE)
	@Setter
	private String path;
	@Getter(AccessLevel.PRIVATE)
	@Setter
	private Boolean relative;
	@Getter(AccessLevel.PRIVATE)
	@Setter
	private Boolean uncache;

	@Autowired
	private UIVersion uiVersion;
	private String webHost;

	ResourceTagSupport() {
		// default setting
		this.relative = getRelative() != null ? getRelative() : false;
		this.uncache = getUncache() != null ? getUncache() : false;
	}

	@Autowired
	public int doStartTagInternal() throws JspException {
		// init bean
		WebApplicationContext wac = getRequestContext().getWebApplicationContext();
		this.uiVersion = wac.getBean(UIVersion.class);
		this.webHost = wac.getBean("dataProperties", Properties.class).getProperty("data.web.host");
		setPath(prefix + getPath());
		// do work
		return doTag();
	}

	protected abstract int doTag() throws JspException;

	/**
	 * 캐싱, 상대/절대 주소 적용하기
	 * @return
	 */
	protected String getPathUrl() {
		String host = getRelative() ? "" : webHost;
		String resultPath = getUncache() ? Optional.ofNullable(uiVersion.get(getPath())).orElse(getPath()) : getPath();
		return host + resultPath;
	}
}
```

```java
@Slf4j
public class JsTag extends ResourceTagSupport {
	private static final String TEMPLATE = "<script type=\"text/javascript\" src=\"${src}\" charset=\"utf-8\"></script>";

	@Override
	public int doTag() throws JspException {
		Map<String, String> values = new HashMap<>();
		values.put("src", getPathUrl());
		StrSubstitutor sub = new StrSubstitutor(values);

		try {
			JspWriter writer = pageContext.getOut();
			writer.println(sub.replace(TEMPLATE));
		} catch (IOException e) {
			throw new JspException(e);
		}
		return SKIP_BODY;
	}
}
```



*참고*

- http://mungchung.com/xe/spring/36064
- http://blog.code-adept.com/blog/2008/01/25/unit-testing-jsp-custom-tags/