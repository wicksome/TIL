---
title: Template Method Pattern
layout: post
date: "2017-02-10T10:00:00+09:00"
path: /blog/template-method-pattern-with-java
tags: design pattern, java
desc: template method pattern in design pattern
draft: false
---

## 의도
연산~operation~에 알고리즘의 뼈대만 정의하고, 구체적 처리는 서브클래스로 미룬다. 알고리즘 구조는 변경하지 않고 단계처리만 서브클래스는에서 재정의할 수 있도록 한다.

## 구조
![Template Method Pattern](http://www.cs.unc.edu/~stotts/GOF/hires/Pictures/tmethod.gif)

## 활용성
- 어떤 한 알고리즘을 이루는 부분 중 변하지 않는 부분을 한 번 정의해 놓고 다양해질 수 있는 부분은 서브클래스에서 정의할 수 있도록 남겨두고자 할 때
- 서브클래스 사이의 공통적인 행동을 추출하여 하나의 공통 클래스에 몰아둠으로써 코드 중복을 피하고 싶을 때. 이것은 Opdyke와 Johnson이 설명한[OJ93][^1] "refactoring to generalize"의 좋은 예이다. 먼저 기존코드에서 차이점을 찾고 이를 새로운 연산으로 분리한다. 그 다음 달라진 코드 부분을 새로운 연산을 호출하는 템플릿 메서드로 대체한다.
- 서브클래스의 확장을 제어할 수 있다. 템플릿 메서드가 어떤 특정한 시점에 "hook" 연산을 호출하도록 정의함으로써, 그 특정 시점에서만 확장되도록 한다.

<!--more-->

## 결과

- 템플릿 메서드는 코드 재사용을 위한 기본 기술이다(특히 클라스 라이브러리 구현 시 중요).
- 템플릿 메서드는 IoC(Inversion of Control, 제어 역전) 구조를 이끌어 낸다. 즉, 부모 클래스는 서브클래스에 정의된 연산을 호출할 수 있지만 반대 방향의 호출은 안 된다.
{% blockquote 할리우드 원칙(Hollywood principle) %}
Don't call us, we'll call you.
{% endblockquote %}
- 템플릿 메서드는 여러 종류의 연산 중 하나를 호출한다.
    - 구체 연산
    - AbstractClass 구체 연산
    - 기본 연산
    - factory method
    - hook operation: 필요하다면 서브클래스에서 활장할 수 있는 기본 행동을 제공하는 연산. 기본적으로 아무 내용도 정의하지 않는다.

## 구현

- **접근제어자를 이용한다.** - 템플릿 메서드에서 호출하는 기본 연산들을 protected로 구현한다. 이렇게 하면 이 연산들은 템플릿 메서드만 호출할 수 있게 된다. 템플릿 메서드는 재정의하면 안되므로 맴버 함수로 만든다(final로 정의하면 재정의 불가능).
- **기본 연산의 수를 최소화한다.** - 템플릿 메서드를 설계할 때 중요한 목표 중 하나는 서브클래스가 오버라이드해야 하는 연산의 수를 최소화하는 것이다. 재정의해야 하는 메서드가 많아질수록 사용자는 불편해진다.
- **네이밍 규칙을 만든다.** - 재정의 연산에 접두어를 추가하여 식별이 잘되도록 할 수 있다. 예를 들어, 매킨토시 응용프로그램의 MapAPP프레임워크[App89][^2]의 모든 템플릿 메서드는 `Do-`로 시작한다. `DoCreateDocument`, `DoRead`

## 예제

문서 관리 응용프로그램이 새 문서를 만드는 경우로 예를 들어 보자. 모든 응용프로그램은 파일을 생성하기 전에 파일 존재 확인과 권한 확인을 하며, 특정 응용프로그램은 파일을 열기전에 로그를 출력해야 한다.

이런 경우에 `openNewDocument()` 템플릿 메서드를 사용할 수 있다. `Application.java`는 항상 확인해야할 연산(파일 존재 확인, 권한 확인)을 추상 메서드로 정의하고 템플릿 메서드에서 수행한다. Application에서 `beforeCreateDocument()`는 hook 연산으로 필요에따라 확장해서 사용 가능하다. 이렇게 함으로

추상 연산을 통해 알고리즘의 일부를 정의함으로써, 템플릿 메서드는 각 단계의 순서는 고정하되 각각의 서브클래스는 필요에 따라 이들 단계의 처리를 다양화시킬 수 있다.

*Application.java(AbstractClass)*

```java
public abstract class Application {
	public Document newDcument() { return createDocument(); }
	public abstract Document createDocument(); // factory method

	// template method
	final public Document openNewDocument(String fileName) {
		if (!existDocument(fileName)) {
			throw new IllegalStateException("The file doesn't exist: " + fileName);
		}

		if (!canOpenDocument(fileName)) {
			throw new IllegalStateException("can't open the document: " + fileName);
		}

		beforeCreateDocument(); // hook 연산
		Document document = createDocument(); // template method에서 factory method가 호출된다.
		document.setFileName(fileName);
		return document;
	}

	protected abstract boolean existDocument(String fileName);
	protected abstract boolean canOpenDocument(String fileName);

	protected void beforeCreateDocument() {} // hook: 기본적으로 아무 내용도 정의하지 않는다.
}
```

*MyApplication.java(ConcreteClass)*

```java
public class MyApplication extends Application {
	private static final String BASE_PATH = "/local/path/base";

	@Override
	public void beforeCreateDocument() { System.out.println("create document"); }

	@Override
	public Document createDocument() { return new WordDocument(); }

	@Override
	protected boolean existDocument(String fileName) {
		return (new File(BASE_PATH + fileName)).exists();
	}

    ...
}
```

> 아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.
>
> - [[GOF](http://wiki.c2.com/?GangOfFour){kr}:419] - 팩토리 메서드
> - GoF, 김정아(옮긴이), Design Patterns, 개정판, 프로텍미디어, 2015.

[^1]: William F. Opdyke and Ralph E. Johnson. Creating abstract superclasses by refactoring. In Proceedings of the 21st Annual Computer Science Conference (ACM CSC '93), pages 66–73, Indianapolis, IN, February 1993.
[^2]: Addison-Wesley, Reading, MA. NEXTSTEP General Reference: Release 3, Volumes 1 and 2, 1994.
