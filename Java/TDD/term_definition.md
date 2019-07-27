# Test Double

## Stub

> Test Stub

Stub은 "이 객체는 무조건 이 값을 반환한다"와 같이 로직은 없고 원하는 값만 반환한다. 작성하기 쉽지만 불필요한 boilerplate 코드[1]를 줄이기 위해서 Mocking Framework를 이용하는게 편하다.

- 다 되었다 치고 배열 넘어오는 가짜 데이터

```java
@Mock
private Service stub; // Mocking Framework에 의해 생성된 Stub 객체

@InjectMock
private TestObject testObject; // 테스트 객체

@Test
void stubTest() {
	ContentManager manager = new ContentManager(stub);

	given(stub.isEmpty()).willReturn(true); // 원하는 값을 반환하도록 설정

	assertTrue(manager.isEmpty());
}
```

## Mock

> Mock Object

Mock은 "어떤 메서드가 호출될 것이다"는 행위에 대한 예상만 가지고 있다. 예상대로 메서드가 호출되지 않을 경우 테스트는 실패한다. 즉 Mock은 객체 사이의 행위(interaction)를 테스트하기 위해 사용한다.

- 행위를 검증할 수 있는 것
- 실제 객체처럼 만듦


```java

```

## Dummy

> Dummy Object


## Fake

> Fake Object

## Spy

> Test Spy

- 실체 객체를 감시하고 싶을 때 사용
- 내부의 상태가 바뀌었을 때 확인
- 클리했을 때 내부의 값이 바뀌었는지
- 한번 클릭했는지, 두번 클릭했는지 확인




# Mock, Stub 차이점

- "행위를 테스트(모의 객체 스타일)", "상태 테스트(고전적 스타일)"로 나눠짐
- 고전적 스타일, 모의 객체 스타일
- 상태 기반 테스트: 테스트의 목적 객체가 처리한 결과에 대해 판단하는 기법
- 행위 기반 테스트: 요구 사항이나 설계쩍 관점으로 테스트를 구현하는 것이 목적.
  즉, 테스트하는 객체가 올바른 방향으로 진행하고 있는가에 대한 것으로써 테스트의 성공 여부를 판단.

  이것을 위해 행위를 테스트하는 모의 객체를 황용하여 구현하는 방법을 제시하기 때문에 모의 개ㅑㄱ체 스타일이라고 부른다.

- 이런 전제를 기본으로 마틴 파울러는 다섯 가지 요소를 통해 각 스타일의 입장차이가 구분된다는 것을 피력한다.

  - Driving TDD(TDD 진행 방식의 차이)
  - Fixture setup(Fixture 얼마나 어떻게 사용되는가?)
  - Test Isolation(단위 테스트 격리에 대한 관점의 차이)
  - Coupling Tests to Implementations(단위 테스트와 구현체의 결합도 관점의 차이)
  - Design Style(설계에 미치는 영향)



## Driving TDD

todo



# Fixture

> Test Spy

- 단위 테스트의 실행 시 필요한 요소로서 많이 사용
- 때로는 테스트에 대한 성격이나 실행되는 단위 테스트의 그룹화를 일걸을 때도 사용
- 소프트웨어 테스트에서 반복적이고 동일한 결과를 얻는 테스트를 실행하기 위한 기반이 되는 정적인 상태들과 환경



# BDD

> BDD(Behaviour Driven Development, 행위 주도 개발)



# DDD






[1] boilerplate 코드: 꼭 필요하면서 간단한 기능인데 많은 코드를 필요로 하는 코드, 예로 getter/setter, html/head/body
마크업이 있다. [wiki](https://en.wikipedia.org/wiki/Boilerplate_code)

```java
// as-is
class Boilerplate {
	private int var;
	public void setVar(int var) {
		this.var = var;
	}
	public int getVar() {
		return this.var;
	}
}

// to-be: lombok 적용
@Data
class Boilerplate {
	private int var;
}
```

```html
<html>
<head></head>
<body></body>
</html>
```
