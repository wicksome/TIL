---
title: 이펙티브자바 2장. 객체 생성과 삭제 - 3
date: 2017-02-21 10:00:00
tags:
- java
- effective java
desc: chapter 2. Creating and Destroying Objects in effective java
---

[규칙 6](../../../../2017/02/21/creating-and-destroying-objects-3/#규칙-6-유효기간이-지난-객체-참조는-폐기하라) - 유효기간이 지난 객체 참조는 폐기하라
[규칙 7](../../../../2017/02/21/creating-and-destroying-objects-3/#규칙-7-종료자-사용을-피하라) - 종료자 사용을 피하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 규칙 6. 유효기간이 지난 객체 참조는 폐기하라

*e.g. 메모리 누수*

```java
public class Stack {
	private Object[] element = new Object[16];
	private int size = 0;

	public void push(Object e) {
		ensureCapacity();
		elements[size++] = e;
	}

	public Object pop() {
		if (size == 0)
			throw new EmptyStackException();
		return elements[--size];
	}

	private void ensureCapacity() {
		if (elements.length == size) {
			elements = Arrays.copyOf(elements, 2 * size + 1);
		}
	}
}
```

스택이 커졌다가 줄어들 때, 인덱스 값이 size보다 큰 곳에 있는 요소들(쓰레기 값)은 GC가 처리하지 못한다. 스택이 그런 객체에 대한 *만기 참조~obsolete reference~*를 제거하지 않기 때문이다. 만기 참조란 다시 이용되지 않을 참조~reference~를 말한다.

자동적으로 쓰레기 객체를 수집하는 언어에서 발생하는 메모리 누수 문제(≒ 의도치 않은 객체 보유~unintentional object retention~)는 찾아내기 어렵다.

#### 해결방안

만기 참조를 제거하는 가장 좋은 방법은, 해당 참조가 보관된 변수의 유효범위~socpe~를 최대한 좁게 만들어 벗어나게 두는 것이다([규칙 45](#item45)).

위 예제 Stack과 같이 자체적으로 메모리는 관리하는 경우에는, 쓸 일이 없는 객체 참조는 반드시 null로 바꿔준다.

```java
public Object pop() {
	if (size == 0)
		throw new EmptyStackException();
	Object result = elements[--size];
	elements[size] = null;
	return result;
}
```

#### 흔히 메모리 누수가 발견되는 곳

- 자체적으로 관리하는 메모리가 있는 클래스
- 캐시~cache~: 객체 참조를 캐시 안에 넣어 놓고 잊어버리는 일이 많기 때문. (수명이 키에 대한 외부 참조의 수명에 따라 결정되는 상황에는 *WeakHashMap* 활용)
- 리스너~listener~등의 역호출자~callback~ - 콜백을 명시적으로 제거하지 않을 경우, 적절한 조치를 취하기 전까지 메모리는 점유된 상태. 해결방안으로 콜백에 대한 약한 참조~weak reference~만 저장하는 것(WeakHashMap)

---

## 규칙 7. 종료자 사용을 피하라

#### finalize?

```java
public class Object {
	/**
	 * Called by the garbage collector on an object when garbage collection
	 * determines that there are no more references to the object.
	 * ...
	 */
	protected void finalize() throws Throwable { }
}
```

> ‼️ **종료자~finalizer~는 예측 불가능하며, 대체로 위험하고, 일반적으로 불필요하다.** ... 어쨌든 종료자 사용은 피하는 것이 원칙이다.

- GC가 객체에 대한 참조가 더 이상 없다고 판단할 때 GC로부터 호출된다. 하지만, 즉시 실행되리라는 보장이 전혀 없다([JLS, 12.6](https://docs.oracle.com/javase/specs/jls/se8/html/jls-12.html#jls-12.6)). **따라서 긴급한(time-critical) 작업을 종료자 안에서 처리하면 안 된다**(e.g. finalize안에서 파일 닫기).
- 종료자의 실행시점은 GC 알고리즘에 좌우되는데, 이 알고리즘은 JVM 구현마다 크게 다르다.
- 종료자의 더딘 실행~tardy finalization~은 단순히 이론적인 문제가 아니다. 클래스에 종료자를 붙여 놓으면, 드문 일이지만 객체 메모리 반환이 지연될 수도 있다.
- 종료자가 실행되지 않은 객체가 남은 상태로 프로그램이 끝나는 일도 충분히 가능하다. 그러므로 **지속성이 보장되어야 하는 중요 상태 정보~critical persistent state~는 종료자로 갱신하면 안 된다.**
- `System.gc()`나 `System.runFinalization()` 같은 메서드는 종료자 실행 가능성을 높여주긴 하지만 보장하지 않는다.
- `System.runFinalizersOnExit()`, `Runtime.runFinalizersOnExit()`는 종료자 실행을 보장하지만, 심각한 결함을 갖고 있어 이미 명세에서 deprecated 되었다.
- **종료자를 사용하면 프로그램 성능이 심각하게 떨어진다.**
- **명시적인 종료 메서드~termination method~를 하나 정의**하고, 더 이상 필요하지 않는 객체라면 클라이언트가 해당 메서드를 호출하도록 하라. 명심할 것은, 종료 여부를 객체 안에 보관해야 한다(유효하지 않은 객체임을 표시하는 private 필드 선언).
- **명시적 종료 메서드는 보통 try-finally 문과 함께 쓰인다. 객체 종료를 보장하기 위해서다.** Java1.7부터는 try-with-resources문 제공하기 때문에 finally 블록은 사용하지 않아도 된다([try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html)).

#### 사용하기 적합한 곳

- 명시적 종료 메서드 호출을 잊을 경우를 대비하는 안전망~safety net~으로서의 역할.

	**종료자는 반환되지 않은 자원을 발견하게 될 경우 반드시 log를 남겨야 한다.** 클라이언트 코드에 버그가 있는 것이므로, 고치도록 알려야 하기 때문이다. (추가 비용을 감당하면서 구현할 가치가 있는지 신중하게 생각한다)

- *네이티브 피어~native peer: 일반 자바 객체가 네이티브 메서드를 통해 기능 수행을 위임하는 네이티브 객체~*와 연결된 객체를 다룰 때.

	네이티브 피어는 일반 객체가 아니므로, 객체가 소멸되더라도 GC는 모른다(GC가 알 수 없을 뿐더라 Java peer가 반환될 때 같이 반환할 수도 없다). 네이티브 피어가 중요한 자원을 점유하고 있지 않다고 가정한다면, 종료자는 그런 객체의 반환에 걸맞다. 즉시 종료되어야 하는 자원을 포함하는 경우에는, 명시적인 종료 메서드를 클래스에 추가해야 한다.

#### 주의할 점

- finalizer chaining이 자동으로 이루어지지 않는다.

	종료자를 구현한 클래스를 상속받은 경우, 하위 클래스의 종료자는 상위클래스의 종료자를 명시적으로 호출해야 한다.

	```java
	@Override
	protected void finalize() throws Throwable {
		try {
			...
		} finally {
			// 반드시 호출시키기 위해 try-finally 사용
			super.finalize();
		}
	}
	```

	**더 나은 방법 - 종료 보호자 패턴**

	종료되어야 하는 객체의 클래스마다 안에 종료자를 정의하는 대신 익명 클래스를 활용하는 방법. 이 익명 클래스로 만든 객체를 *종료 보호자~finalizer guardian~*라고 한다. Foo 객체의 참조가 사라지는 순간 종료 보호자도 실행 가능한 상태가 된다.

	```java
	// 종료 보호자 숙어(Finalizer Fuardian idiom)
	public class Foo {
		// 이 객체는 바깥 객체(Foo)를 종료시키는 역할만 한다
		private final Object finalizerFuardian = new Object() {
			@Override
			protected void finaliza() throws Throwable {
				// 바깥 Foo 객체를 종료시킴
			}
		}
	}
	```
