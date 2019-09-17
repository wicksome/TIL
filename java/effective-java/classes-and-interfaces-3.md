---
title: 이펙티브자바 4장. 클래스와 인터페이스 - 3
date: 2017-05-15 10:20:00
tags:
- java
- effective java
desc: chapter 4. classes and interfaces in effective java
---

[규칙 19](../../../../2017/05/15/classes-and-interfaces-3/#19-인터페이스는-자료형을-정의할-때만-사용하라) - 인터페이스는 자료형을 정의할 때만 사용하라
[규칙 20](../../../../2017/05/15/classes-and-interfaces-3/#20-태그-달린-클래스-대신-클래스-계층을-활용하라) - 태그 달린 클래스 대신 클래스 계층을 활용하라
[규칙 21](../../../../2017/05/15/classes-and-interfaces-3/#21-전략을-표현하고-싶을-때는-함수-객체를-사용하라) - 전략을 표현하고 싶을 때는 함수 객체를 사용하라
[규칙 22](../../../../2017/05/15/classes-and-interfaces-3/#22-멤버-클래스는-가능하면-static으로-선언하라) - 멤버 클래스는 가능하면 static으로 선언하라

<!-- more -->

<div class="tip">
    <div>아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.</div>
    <ul>
        <li>조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.</li>
    </ul>
</div>

---

## 19. 인터페이스는 자료형을 정의할 때만 사용하라

- **상수 인터페이스 패턴은 인터페이스를 잘못 사용한 것이다.** 클래스가 어떤 상수를 어떻게 사용하느냐 하는 것은 구현 세부사항이다.

	```java
	public interface PhysicalConstants {
		static final double AVOGADROS_NUMBER = 6.02214199e23;
	}
	```
- 상수를 API 일부로 공개하고 싶을 때는 더 좋은 방법이 있다.
	- 해당 상수가 이미 존재하는 클래스나 인터페이스에 강하게 연결되어 있을 때는 해당 클래스/인터페이스에 추가한다.
	- enum 자료형의 멤버가 되어야 바람직할 때는 enum 자료형과 함께 공개한다.
	- 객체 생성이 불가능한 유틸리티 클래스에 넣어서 공개한다.
- 인터페이스는 자료형을 정의할 때만 사용해야 한다. 특정 상수를 API의 일부로 공개할 목적으로는 적절치 않다.

---

## 20. 태그 달린 클래스 대신 클래스 계층을 활용하라

#### Tagged Class

> 두 가지 이상의 기능을 가지고 있고, 그중 어떤 기능을 제공하는지 표시하는 tag가 달린 클래스

```java
class Figure {
    enum Shape { RECTANGLE, CIRCLE };

    // 태그 필드
    final Shape shape;

    double length;
    double width;

    double radius;

    // 원을 만드는 생성자
    Figure(double radius) {
        shape = Shape.CIRCLE;
        this.radius = radius;
    }

    // 사각형을 만드는 생성자
    Figure(double length, double width) {
        shape = Shape.RECTANGLE;
        this.length = length;
        this.width = width;
    }

    double area() {
        switch(shape) {
          case RECTANGLE:
        	return length * width;
          case CIRCLE:
        	return Math.PI * (radius * radius);
          default:
        	throw new AssertionError();
        }
    }
}
```

**문제점**

- 수정할 때마다 `switch`문에 새로운 `case`를 올바르게 넣어야 한다.
- 객체의 자료형만 봐서 그 객체가 무슨 기능을 제공하는지 알 수 없다.
- boilerplate code가 늘어난다.
- **오류 발생 가능성이 높아지고, 효율적이지 않다.**

#### 개선 코드

*e.g. 클래스 계층으로 변환한 결과([규칙 14](#item14))*

```java
abstract class Figure {
    abstract double area();
}

class Circle extends Figure {
    final double radius;

    Circle(double radius) {
        this.radius = radius;
    }

    double area() {
        return Math.PI * (radius * radius);
    }
}

// public 클래스인 경우(규칙 14)
@Data
public class Rectangle extends Figure {
    final private double length;
    final private double width;

    public double area() { return length * width; }
}
```

- 태그 기반 클래스 사용은 피하라.
- 태그 기반 클래스를 보게 된다면, 리팩토링을 통해 클래스 계층으로 변환할 방법은 없는지 고민하자.

## 21. 전략을 표현하고 싶을 때는 함수 객체를 사용하라

> 전략을 표현하고 싶을 때는 함수 객체~function object~를 사용하라
> 함수 객체의 주된 용도는 전략 패턴~Strategy pattern~을 구현하는 것.

**strategy pattern**

- 인자로 함수를 넘겨줘서 그 함수를 통해 실행 전략을 세우는 방법. 예를 들어 정렬을 한다고 할때, 어떻게 정렬하는가는 넘겨주는 것이 전략패턴.
- Java는 함수를 넘겨 줄수 없으나, 함수를 가지고 있는 객체(=함수 객체)를 넘겨주면 됨

```java
// 전략 인터페이스
public interface Comparator<T> {
	public int compare(T t1, T t2);
}
```

문자 길이로 하고자 할 때, 익명 클래스로 구현할 수 있으나 매번 필요없는 인스턴스를 생성함

```java
Arrays.sort(stringArray, new Comparator<String>() {
	public int compare(String s1, String s1) {
		return s1.length() - s2.length();
	}
});
```

그렇다면, 싱글턴으로 만들어서 사용하는 방법. 의도가 뚜렷한 이름을 정할 수 있는 것도 장점.

```java
Arrays.sort(stringArray, StringLengthComparator.INSTANCE);
class StringLengthComparator implements Comparator<String> {
	public static final StringLengthComparator INSTANCE = new StringLengthComparator();
	private StringLengthComparator();
	public int compare(String s1, String s1) {
		  return s1.length() - s2.length();
	}
}
```

java 8 lamdba를 이용하면 코드를 좀 더 줄일 수 있음

```java
Comparator<String> stringLengthComparator = (String s1, String s2) -> s1.length - s2.length;
Arrays.sort(stringArray, stringLengthComparator);
```

전략 인터페이스(`Comparator`)는 실행 가능 전략 객체들(`StringLengthComparator`)의 자료형 구실을 한다. 따라서 실행 가능 전략 클래스(`StringLengthComparator`)는 굳이 public으로 만들어 공개할 필요가 없다. 대신, 전략 인터페이스가 자료형인 public static 필드들을 갖는 "호스트 클래스(host class)"를 정의하는 것도 방법이다. 실행 가능 전략 클래스는 호스트 클래스의 private 중첩 클래스(nested class)로 정의하면 된다.

```java
class Host {
	public static final Comparator<String> STRING_LENGTH_COMPARATOR = (String s1, String s2) -> s1.length - s2.length;
}
```

`String` 클래스는 `CASE_INSENCITIVE_ORDER`라는 필드로 문자열 비교자를 공개함

---

## 22. 멤버 클래스는 가능하면 static으로 선언하라

#### 중첩클래스~nested class~ 의 종류

> 다른 클래스 안에 정의된 클래스

- Static Member Class
- Nonstatic Member Class
- Anonymous Class
- Local Class

#### Static Member Class

```java
public class ExternalClass {
    private int value;

    public void print() { PrivateStaticMemberClass.print(); } // (1)

    private static class PrivateStaticMemberClass {
        public static void print() {
            ExternalClass e = new ExternalClass();
            System.out.println(e.value);
        }
    }

    public static class StaticMemberClass {
        public static void print() { System.out.println("public"); }
    }
}
```

```java
// main
// ExternalClass.PrivateStaticMemberClass.print(); (1) 불가능
ExternalClass.StaticMemberClass.print(); // (2)
(new ExternalClass()).print();
```

- External Class의 모든 맴버에 접근 가능(private 포함)
- Static Member Class가 `private`이라면 External Class에서만 접근 가능 (1)
- External Class의 정적맴버 (2)

#### NonStatic Member Class

- External Class와 독립적으로 존재할 수 있도록 하려면 반드시 `static`으로 선언
- 문법으로는 `static` 여부 차이. 그러나 다르다.
- External Class와 자동적으로 연결된다.

    ```java
    public class ExternalClass {
        private int externalClassValue;

        public ExternalClass(int value) { this.externalClassValue = value; }

        private int getExternalClassValue() { return externalClassValue; }

        public void print() {
            System.out.println(externalClassValue);
            NonStaticMemberClass nsmc = new NonStaticMemberClass(); // (3)
            nsmc.setExternalClassValue(3);
            System.out.println(externalClassValue);
        }

        class NonStaticMemberClass {
            private int nonStaticMemberClassValue;

            void setExternalClassValue(int value) {
                ExternalClass.this.externalClassValue = value; // (2)
            }
        }
    }
    ```

    ```java
    // main
    ExternalClass t = new ExternalClass(2);
    t.new NonStaticMemberClass().setExternalClassValue(4); // (3) 직접 연결도 가능
    t.print();
    ```

    ```sh
    # 출력결과
    4
    3
    ```

    - NonStatic Member Class 안에서 External Class의 메서드 호출 가능 (1)
    - qualified this로 External Class 객체에 대한 참조 획득 가능 (2)
    - NonStatic Member Class와 External Class의 연결은 NonStatic Member Class의 객체가 생성될때 확립 (3)

- Adapter를 정의할 때 많이 사용(External Class를 다른 클래스 객체인 것처럼 보이게하는 용도)

    ```java
    public class MySet<E> extends AbstractSet<E> {
        public Iterator<E> iterator() {
            return new MyIterator();
        }

        private class MyIterator implements Iterator<E> {
            ...
        }
    }
    ```

#### Anonymous Class

- 함수 객체를 정의할 때 널리 쓰인다
- 표현식 중간에 등장하므로, 10줄 이하로 짧게 작성되어야 한다. 아니면 코드 가독성이 떨어진다
- nonstatic context 안에서 사용될 때만 External 객체를 갖는다

    ```java
    public class ExternalClass {
        private int externalClassValue = 2;
        private AnonymousClass ac;

        public void printAnonymousClassTest() {
            ac = new AnonymousClass() {
                private int value;

                @Override
                void print(int value) {
                    this.value = value;
                    System.out.printf("Anonymous Class Test %d %d",
                    ExternalClass.this.externalClassValue, this.value);
                }
            };
            ac.print(3);
        }
    }

    abstract class AnonymousClass {
        abstract void print(int value);
    }
    ```

    ```java
    public class MainClass {
        public static void main(String[] args) {
            ExternalClass t = new ExternalClass();
            t.printAnonymousClassTest();
        }
    }
    ```

#### Local Class

- 지역 변수 선언되는 곳에 선언된 클래스
- static 맴버 불가능, nonstatic context에서만 External Class의 맴버 접근 가능

  ```java
  public class ExternalClass {
  	private int externalClassValue = 2;

  	public void printLocalClassTest() { // non static context
  		class LocalClass {
  			private int value;
  			// private static value; 불가능

  			LocalClass(int value) { this.value = value; }

  			void print() { System.out.println(externalClassValue); } // External 객체 접근 가능
  		}

  		LocalClass lc = new LocalClass(1);
  		lc.print();
  	}
  }
  ```

#### 요약, 알아둘 것

- 중첩 클래스를 메서드 밖에서 사용할 수 있어야 하거나, 메서드 안에 놓기에 너무 길 경우 맴버 클래스로 정의
- 맴버 클래스의 객체들이 External Class의 객체들에 대한 참조를 가져야 하는 경우에서만 NonStatic Member Class로 정의
