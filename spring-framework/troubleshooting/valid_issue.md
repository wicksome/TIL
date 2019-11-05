# `@valid`를 이용한 Validation

- https://spring.io/guides/gs/validating-form-input/
- `pom.xml`에 디펜던시 추가

```xml
<!-- Hibernate Validator -->
<dependency>
	<groupId>org.hibernate</groupId>
	<artifactId>hibernate-validator</artifactId>
	<version>4.2.0.Final</version>
</dependency>
```
- `model`|`domain`에 어노테이션 추가

```java
public class BoardForm {
	@Size(min = 2, max=200, message="{issue.title.size}")
	private String title;
	...
}
```
- `controller`에 추가(`BindinfResult result`는 반드시 `@Valid`밑에 써주어야 한다.)
- 또한, 스프링폼을 호출하는 컨트롤러에도 `@ModelAttribute...`을 추가한다.


```java
@RequestMapping(value = "/save", method = RequestMethod.POST)
public ModelAndView save(//
		@ModelAttribute("issueUploadForm") @Valid IssueForm uploadForm, //
		BindingResult result) {
	ModelAndView mav = new ModelAndView();

	if(result.hasErrors()) {
		mav.setViewName("redirect:issueform");
		return mav;
	}
	...
	return mav;
}
```
- `*view.jsp`에 `<form:errors ... />` 추가


```jsp
...
<form:form method="post" action="save" modelAttribute="issueUploadForm" enctype="multipart/form-data">
	<form:errors path="*" cssClass="errorblock" element="div" />

	<!-- 제목 -->
	<form:label path="title">title</form:label><br/>
	<form:input path="title" maxlength="200"/>
	<form:errors path="title" cssClass="error"/>
	...
```
