중재자 패턴

- Mediator: Colleague 오브젝트와 통신할 수 있는 인터페이스를 정의한다.
- ConcreteMediator: ConcreteColleagues 오브젝트들의 레퍼런스를 가지고 있다. 정보를 전달해 주는 역할을 수행
- Colleague classes: Mediator 오브젝트의 레퍼런스를 가지고 있다가 다른 Colleague와 통신하길 원하면 Mediator를 통해서 통신을 한다.

고려사항

- Mediator 객체가 연동하고 있는 개체들에게 주요 이벤트가 발생했을 때 알리는 방법으로 별도의 인터페이스를 정의하는 방법이 있고 다른 방법으로  Observer 패턴을 활용해서 Mediator객체에게 이벤트의 발생을 알려주는 방법이 있다.
- 정보가 많을 경우 Async를 고려한다면 Message Queue가 필요할 수 있다.
- Colleague가 많아지면 Mediator구현체가 복잡해질 수 있다.
- Mediator 인터페이스 정의는 Colleague들이 여러 개의 Mediator가 필요한 경우이다. 한 개의 Mediator만 필요하다면 굳이 인터페이스 정의는 필요없다.

참고

- http://mobicon.tistory.com/250