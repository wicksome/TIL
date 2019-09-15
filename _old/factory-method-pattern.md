---
title: Factory Method Pattern
date: 2017-02-10 10:00:00
tags:
- design pattern
- creational pattern
- java
desc: factory method pattern in design pattern
---

## 의도
객체를 생성하기 위해 인터페이스를 정의하지만, 어떤 클래스의 인스턴스를 생성할지에 대한 결정은 서브클래스가 내리도록 한다.

{% blockquote 위키백과 https://ko.wikipedia.org/wiki/%ED%8C%A9%ED%86%A0%EB%A6%AC_%EB%A9%94%EC%84%9C%EB%93%9C_%ED%8C%A8%ED%84%B4 팩토리 메서드 패턴 %}
Factory Method라는 패턴 이름이 적절하지 못한데, 이름으로 인해 객체를 생성하는 메소드를 Factory method라 오해하는 개발자가 많이 있다(Allen Holub의 말을 인용.) 이런 생성 메소드가 모두 Factory method 패턴을 사용하는 것은 아니다. Template Method의 생성 패턴 버전으로 볼 수 있는데 Template Method를 알지 못한다면 그 패턴을 먼저 이해하는 것이 Factory Method를 이해하기 수월할 것이다.
{% endblockquote %}

## 구조
![Factory Method Pattern](https://www.codeproject.com/KB/architecture/csdespat_1/dpcs_fm.gif)

## 활용성
- 어떤 클래스가 자신이 생성해야 하는 객체의 클래스를 예측할 수 없을 때
- 생성할 객체를 기술하는 책임을 자신의 서브클래스가 지정했으면 할 때
- 객체 생성의 책임을 몇 개의 보조 서브클래스 가운데 하나에게 위임하고, 어떤 서브클래스가 위임자인지에 대한 정보를 국소화시키고 싶을 때

<!--more-->

## 예제

예를 들어 다양한 종류의 문서를 표현하는 응용프로그램 프레임워크가 있다. 이를 위해서는 일단 두 개의 큰 추상화가 필요하다. 하나는 *Creator*(응용프로그램) 추상 클래스이고, 다른 하나는 *Product*(문서) 추상 클래스(혹은 인터페이스)이다.
*Creator* 클래스는 문서의 인스턴스를 ++언제++ 만들지는 알지만, ++어떤 문서++를 만들어야 하는지는 알지 못한다. *Product* 클래스가 추상 클래스이기 때문에 인스턴스를 가질 수 없기 때문이다.

```java
abstract class Creator {
	public Product newProduct() { return createProduct(); }
	public abstract Product createProduct(); // factory method
}

interface Product {}
```

팩토리 메서드 패턴은 이런 문제에 대한 해법을 제시한다. *Document*의 서브클래스 중 어느 것을 생성해야 하는지에 대한 정보를 캡슐화하고, 그것을 프레임워크에서 떼어낸다.

```java
public class TextProduct implements Product {}
public class PhotoProduct implements Product {}
```

*TextProduct* 클래스와 PhotoProduct 클래스를 팩토리 메서드 패턴을 활용하여 생성한다면 아래와 같은 방법이 있다.

#### 방법 1) 추상 클래스

사용자는 특정 응용프로그램에 종속적인 구현을 위해서 두 클래스의 서브 클래스를 정의할 수 있다. *Creator* 클래스는 *Product* 객체를 관리하는 책임을 맡고 있으며, 필요에 따라 문서를 생성할 수도 있다.

```java
// factory pattern example with abstract class
Creator textCreator = new TextCreator();
Product p1 = textCreator.newProduct();

Creator photoCreator = new PhotoCreator();
Product p2 = photoCreator.newProduct();
```

```java
public class TextCreator extends Creator {
	@Override
	public Product createProduct() {
		return new WordProduct();
	}
}
public class PhotoCreator extends Creator {
	@Override
	public Product createProduct() {
		return new PhotoProduct();
	}
}
```

```java
public class TextProduct implements Product {}
public class PhotoProduct implements Product {}
```

#### 방법 2) 팩토리 메서드 매개변수화 - abstract factory pattern

팩토리 메서드가 매개변수를 받아서 어떤 종류의 제품을 생성할지 만드는 방법도 있다. (추상 팩토리 패턴은 팩토리 메서드를 이용해서 구현할 때가 많다)

```java
// Factory pattern example using argument
Product p1 = Creator1.create(ProductType.TEXT);
Product p2 = Creator1.create(ProductType.PHOTO);
```

```java
public enum ProductType {
	TEXT, PHOTO
}
```

```java
public class Creator {
	static public Product create(ProductType type) {
		switch (type) {
			case TEXT:
				return new ExcelProduct();
			case PHOTO:
				return new ImageProduct();
			default:
				return null;
		}
	}
}
```

#### 방법 3) Lazy Initialization 기법

인스턴스화하는 접근자 메서드를 통해서만 인스턴스에 접근하는 방법으로, 생성자에서 아무 의미 없는 값으로 인스턴스에 대한 매개변수를 초기화하고, 접근자 메서드가 인스턴스를 반환하도록 할 수 있다. 생성자가 초기화 시키는 것이 아니라 필요한 시점에서 초기화를 수행하기 때문에 이런 기법을 Lazy Initialization이라고 한다.

```java
// factory pattern with lazy initialization
TextCreator textCreator = new TextCreator();
List collection = textCreator.newCollection();
```

```java
public class TextCreator extends Creator {
	@Override
	protected List createCollection() {
		return new ArrayList<TextProduct>();
	}
}
```

```java
public abstract class Creator {
	private List<Product> collection = null;

	public List newCollection() {
		// lazy initialization
		if (collection == null) {
			collection = createCollection();
		}
		return collection;
	}

	// factory method
	abstract protected List createCollection();
}
```

#### 방법 4) 템플릿 활용

팩토리 메서드를 사용하면 생길 수 있는 문제점 중 하나는 *Product* 클래스 하나를 추가하려 할 때마다 *Creator* 클래스를 서브클래싱해야 한다는 점이다([방법 1](#방법-1-추상-클래스)). 이로써 클래스 계통의 부피가 확장되는 문제가 생길 수 있다. 이런 문제를 해결할 수 있는 방법 중 하나는 *Creator* 클래스를 상속받는 제네릭 클래스를 정의하고 Product 클래스로 매개변수화되도록 만드는 것이다.

```java
// factory pattern example whti template
StandardCreator<WordProduct> wordProductCreator = new StandardCreator<>(WordProduct.class);
Product p1 = wordProductCreator.newProduct();

StandardCreator<ImageProduct> imageProductCreator = new StandardCreator<>(ImageProduct.class);
Product p2 = imageProductCreator.newProduct();
```

```java
/**
 * Creator Template
 * @param <T> product type
 */
public class StandardCreator<T extends Product> extends Creator {
	private Class<T> cls;

	public StandardCreator(Class<T> cls) {
		this.cls = cls;
	}

	@Override
	public Product createProduct() {
		T product = null;
		try {
			product = cls.newInstance();
		} catch (InstantiationException | IllegalAccessException e) {
			e.printStackTrace();
		}
		return product;
	}
}
```

---

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>[[GOF](http://wiki.c2.com/?GangOfFour){kr}:156] - 팩토리 메서드</li>
        <li>GoF, 김정아(옮긴이), Design Patterns, 개정판, 프로텍미디어, 2015.</li>
    </ul>
</div>
