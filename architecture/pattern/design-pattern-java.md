# Design Patterns *with Java*

> GoF, 김정아(옮긴이), *Design Patterns*, 개정판, 프로텍미디어, 2015.

## 목차

- **생성 패턴(Creational Patterns)**
    - Abstract Factory
    - Builder
    - Factory Method
    - Prototype
    - Singleton
- **구조 패턴(Structural Patterns)**
    - Adapter
    - Bridge
    - Composite
    - Decorator
    - Facade
    - Flyweight
    - Proxy
- **행동 패턴(Behavioral Patterns)**
    - Command
    - Interpreter
    - Iterator
    - Memento
    - Observer
    - State
    - Strategy

---

# Abstract Factory

- *[[GOF](http://wiki.c2.com/?GangOfFour){kr}:132] - 추상 팩토리*

> **의도**
> 
> 상세화된 서브클래스를 정의하지 않고도 서로 관련성이 있거나 독립적인 여러 객체의 군을 생성하기 위한 인터페이스를 제공한다.
> 
> *IMO*. 다형성을 제공하기 위함?
> 
> **구조**
> 
> ![Abstract Factory](http://www.cs.unc.edu/~stotts/GOF/hires/Pictures/abfac108.gif)
> 
> **활용성**
> 
> - 객체가 생성되거나 구성∙표현되는 방식과 무관하게 시스템을 독립적으로 만들고자 할 때
> - 여러 제품군 중 하나를 선택해서 시스템을 설정해야 하고 한번 구성한 제품을 다른 것으로 대체할 수 있을 때
> - 관련된 제품 객체들이 함께 사용되도록 설계되었고, 이 부분에 대한 제약이 외부에도 지켜지도록 할 때
> - 제품에 대한 클래스 라이브러리를 제공하고, 그들의 구현이 아닌 인터페이스를 노출시키고 싶을 때

---

# Builder

-   *[[GOF](http://wiki.c2.com/?GangOfFour){kr}:144] - 빌더 패턴*

> **의도**
>
> 복잡한 객체를 생성하는 방법과 표현하는 방법을 정의하는 클래스를 별도로 분리하여, 서로 다른 표현이라도 이를 생성할 수 있는 동일한 절차를 제공할 수 있도록 합니다.
>
> **구조**
>
> ![Builder Pattern](http://www.cs.unc.edu/~stotts/GOF/hires/Pictures/builder.gif)
>
> **활용성**
>
> - 복합 객체의 생성 알고리즘이 이를 합성하는 요소 객체들이 무엇인지 이들의 조립 방법에 독립적일 때
> - 합성할 객체들의 표현이 서로 다르더라도 생성 절차에서 이를 지원해야 할 때

---

# Prototype

TO-DO

---

# Singleton

TO-DO

https://blog.seotory.com/post/2016/03/java-singleton-pattern

---

# Adapter

TO-DO

---

# Bridge

TO-DO

---

# Composite

TO-DO

---

# Decorator

TO-DO

---

# Facade

TO-DO

---

# Flyweight

- *[[GOF](http://wiki.c2.com/?GangOfFour){kr}:265] - 플라이급*

TO-DO

---

# Proxy

TO-DO

---

# Command

TO-DO

---

# Interpreter

TO-DO

---

# Iterator

TO-DO

---

# Memento

TO-DO

---

# Observer

TO-DO

---

# State

TO-DO

---

# Strategy

TO-DO

---


---

# 참고

- IMO: In My Opinion
