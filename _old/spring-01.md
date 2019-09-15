---
title: spring study 01
date: 2016-04-07 02:32:16
tags:
- spring
- java
desc: spring framework study
category:
- slide
layout: slide
---
<center>
	<h2 style="text-align: center;">Spring in Action</h2>
	**chapter 1**<br/>
	스프링 속으로
</center><br/><br/>
<div style="text-align: right;">
	<p>**@date**	2016.04.07</p>
</div>

---

## readme

Spring in Action 으로 공부하면서 어려웠던 부분, 기억해야 할 것같은 부분 위주로 정리한 ppt이다. 상단 제목의 번호는 필요할 때 책을 참고하고자 동일하게 적어두었다.

---

## 1.1 자바 개발 간소화

자바 복잡도 간소화를 지원하기 위한 주요 전략

1. POJO를 이용한 가볍고(lightweight) 비침투적(non-invasive)인 개발<sup>*</sup>
2. DI와 인터페이스 지향(interface orientation)을 통한 느슨한 결합도(loose coupling)
3. 애스펙트와 공통 규약을 통한 선언적(declarative) 프로그래밍
4. 애스팩트와 템플릿(template)을 통한 반복적인 코드 제거

<small>비침투적 개발이란, 바탕이 되는 기술을 사용하는 클래스, 인터페이스, API 등을 코드에 직접 나타내지 않는 방법으로 복잡함을 분리할 수 있다.</small>

--

## 1.1.2 종속객체 주입

- **종속객체 주입(DI, Dependency Injection)**
- 객체는 종속객체를 생성하거나 얻지 않는다. 즉, 종속객체는 종속객체가 필요한 객체에 주입된다.

--

### 1.1.2-1
**생성자 주입(constructor injection)**

	public class BraveKnight implements Knight {
		private Quest quest;
		public BraveKnight(Quest quest) { // Quest 주입
			this.quest = quest;
		}
		public void embarkOnQuest() {
			quest.embark();
		}
	}

--

### 1.1.2-2
BraveNight 테스트

	public class BraveKnightTest {
		@Test
		public void knightShouldEmbarkOnQuest() {
			Quest mockQuest = mock(Quest.class); // 모의 Quest 생성
			BraveKnight knight = new BraveKnight(mockQuest); // 모의 Quest 주입
			knight.embarkOnQuest();
			verify(mockQuest, time(1)).embark();
		}
	}

강한 결합으로 생성자 안에서 quest를 생성할 때는 테스트가 불가능 했지만 DI를 이용하고 테스트가 가능하다. embarkOnQuest()를 호출한 후에 Mockito에게 Quest의 embark()가 정확히 한 번 호출됐는지 확인한다.

--

### 1.1.2-3

	public class SlayDragonQuest implements Quest {
		private PrintStream stream;
		public SlayDragonQuest(PrintStream stream) {
			this.stream = stream;
		}
		public void embark() {
			stream.println("Embarking on quest to slay the dragon!");
		}
	}

위와 같은 클래스가 있을 때, 어떻게 BraveKnight에게 SlayDragonQuest를 줄 수 있는가? 그리고 어떻게 SlayDragonQuest에게 PrintStrean을 줄 수 있는가?

--

### 1.1.2-4
**와이어링(wiring)**: 애플리케이션 컴포넌트 간의 관계를 정의하는 것(xml or java를 이용한 방법)

xml

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans.xsd">
		<bean id="knight" class="com.test.knights.BraveKnight">
			<constructor-arg ref="quest"/> <!-- 빈 주입 -->
		</bean>

		<bean id="quest" class="com.test.knights.SlayDragonQuest"> <!-- SlayDragonQuest 생성 -->
			<constructor-arg value="#{T(System).out}" />
		</bean>
	</beans>

--

### 1.1.2-5
java

	@Configuration
	public class KnightConfig {
		@Bean
		public Knight knight() {
			return new BraveKnight(quest());
		}

		@Bean
		public Quest quest() {
			return new SlayDragonQuest(System.out);
		}
	}

--

### 1.1.2-6
**실행해 보기**

**application context**은 빈에 관한 정의들을 바탕으로 빈들을 엮어 준다. 스프링 애플리케이션 컨텍스트는 애플리케이션을 구성하는 객체의 생성과 와이어링을 전적으로 책임진다.

xml: ClassPathXmlApplicationContext()

java: AnnotationConfigApplicationContext()

	public static void main(String[] args) {
		ClassPathXmlApplicationContext context = // 스프링 컨텍스트 로드
			new ClassPathXmlApplicationContext(
					"META-INF/spring/knights.xml");
		Knight k = context.getBean(Knight.class); // 빈 얻기
		k.embarkOnQuest(); // 사용
		context.close();
	}

--

## 1.1.3 애스펙트 적용
AOP(Aspect-Oriented Programming)은 애플리케이션 전체에 걸쳐 사용되는 기능을 재사용할 수 있는 컴포넌트에 담는다. 즉, 소프트웨어 내부의 관심사들을 서로 분리하는 기술이다. 예를 들어 로깅, 트랜잭션 관리, 보안 등의 시스템 서비스(이렇게 여러 컴포넌트에 관련되는 것을 **횡단 관심사(cross-cutting concerns)**라고 한다. 이러한 관심사가 각각의 컴포넌트에 퍼지게 되면 다음과 같은 문제점이 있다.

1. 관심사를 구현하는 코드가 시스템 전반에 중복되어 걸쳐있어, 변경해야하는 경우 모두 변경해야 한다.
2. 컴포넌트의 코드가 본연의 기능과 관련 없응 코드로 지저분해진다.

--

### 1.1.3-1
AOP를 이용하면 응집도가 높고 본연의 관심사에 집중하는 컴포넌트를 만든다. 즉, 애스펙트는 확실히 POJO를 단순화한다.
<center>
![aspect-exam](http://www.geekmantra.com/staticcontent/contentimages/Spring-Aspect-Oriented1.gif)
</center>

--

### 1.1.3-2
ex) 기사가 원정전,후에 노래가 울려야 할 경우

	public class BraveKnight implements Knight {
		...
		public void embarkOuest() {
			sing.beforeQuest(); // 기사가 이것까지 관리해야할까?
			quest.embark();
			sing.afterQuest();
		}
	}

--

### 1.1.3-3

	<beans xmlns="http://www.springframework.org/schema/beans"
		xmlns:aop="http://www.springframework.org/schema/aop"
		...>
		<bean id="sing" class="com.test.Sing">
			...
		</bean>
		<aop:config>
			<aop:aspect ref="sing">
				<aop:pointcut id="embark"
					expression="execution(* *.embarkOnQuest(..))"/> <!-- 포인트커트 정의 -->
				<aop:before pointcut-ref="embark"
					method="beforeQuest"/>
				<aop:after pointcut-ref="embark"
					method="afterQuest"/>
			</sop:aspect>
		</aop:config>
	</bean>

---

## 1.2 빈은 담는 그릇, 컨테이너
스프링 기반 애플리케이션은 spring container 안에서 객체가 태어나고, 자라고, 소멸한다. 그래서 spring container는 객체를 생성하고, 엮어주고, 이들의 전체 생명주기를 관리한다.

--

### 1.2-1
스프링에는 여러 컨테이너 구현체가 존재하며, 이들은 크게 두 가지로 분류된다.
1. 빈 팩토리(org.springframework.beans.factory.BeanFactory)
	- 인터페이스에 의해 정의
	- DI에 대한 기본적인 지원을 제공하는 가장 단순한 컨테이너
2. 애플리케이션 컨텍스트(org.springframework.context.ApplicationContext)
	- 인터페이스에 의해 정의
	- 빈 팩토리를 확장해 애플리케이션 프레임워크 서비스를 제공하는 컨테이너

--

### 1.2.1 애플리케이션 컨텍스트
애플리케이션의 설정을 제공하기 위한 중앙 인터페이스로, 실행중일땐 읽기만 가능하지만, 실행이 지원되면 리로드될 수 있다.

- AnnotationConfigApplicationContext
	<small>하나 이상의 자바 기반 설정 클래스에서 스코프 애플리케이션 컨텍스트를 로드</small>
- AnnotationConfigWebApplicationContext
	<small>하나 이상의 자바 기반 설정 클래스에서 스프링 웹 애플리케이션 컨텍스트를 로드</small>
- ClassPathXmlApplicationContext
	<small>클래스패스에 위치한 xml 파일에서 컨텍스트 정의 내용을 로드</small>
- FileSystemXmlApplicationContext
	<small>파일 경로로 지정된 xml 파일에서 컨텍스트 정의 내용 로드</small>
- XmlWebApplicationContext
	<small>웹 어플리케이션에 포함된 xml 파일에서 컨텍스트 정의 내용 로드</small>

--

### 1.2.2 빈의 생명주기
<center><img src="https://premaseem.files.wordpress.com/2013/02/spring-bean-lifecycle.png" style="border:0px; width:60%; height:60%"/></center>

--

### 1.2.2-1 life-cycle
1. 스프링이 빈 인스턴스화
2. 스프링이 값과 빈의 레퍼런스를 빈의 프로퍼티에 주입
3. 빈이 BeanNameAware를 구현하면 스프링이 빈의 ID를 setBEanName()에 넘김
4. 빈이 BeanFactoryAware를 구현하면 setBEanFactory() 호출하여 빈팩토리 자체를 넘김
5. 빈이 ApplicationContextAware를 구현하면 스프링이 setApplicationContext()를 호출하고 둘러싼 애플리케이션컨텍스트에 대한 참조를 넘김
6. 빈이 BeanPostProcessor 인터페이스를 구현하면 스프링은 postProcessBeforeInitialzation()을 호출

--

### 1.2.2-2 life-cycle
<ol start="7">
<li>빈이 InitialzingBean 인터페이스를 구현하면 스프링은 afterPropertiesSet() 호출, 빈이 init-method와 함께 선언됐으면 지정한 초기화 메소드가 호출</li>
<li>빈이 BeanPostProcessor를 구현하면 스프링은 postProcessAfterInitialization() 호출</li>
<li>이 상태가 되면 빈은 애플리케이션에서 사용될 준비가 된 것이며, 애플리케이션 컨텍스트가 소멸될 때까지 애플리케이션 컨텍스트에 남아 있다.</li>
<li>빈이 DisposableBean 인터페이스를 구현하면 스프링은 destroy()를 호출한다. 마찬가지고 빈이 destroy-method와 함께 선언됬으면 지정 메소드가 호출</li>
</ol>
