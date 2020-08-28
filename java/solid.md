# SOLID

> SOLID(OOD, object-oriented design) Principles

## Single Responsibility Principle, 단일 책임 원칙

- 모든 클래스는 단 하나의 책임을 가진다
- "어떤 클래스를 변경해야 하는 이유는 오직 하나 뿐이어야 한다." - 로버트 C. 마틴
- 

## Open Close Principle, 개방-폐쇄 원칙

- 확장에는 열려있고, 변경에는 닫혀있어야 한다는 원리
- 변경이나 추가사항이 발생하더라도 기존 구성요소는 수정이 일어나지 말아야 하며, 기존 구성요소를 쉽게 확장해서 재사용할 수 있어야 한다
- 

## Liskov Substitution Principle, 리스코프 치환 원칙

"서브 타입은 언제나 기반 타임으로 교체할 수 있어야 한다." → 다형성 제공을 통해

## Interface Segregation Principle, 인터페이스 분리 원칙

- 자신이 이용하지 않는 메서드에 의존하지 않아야 한다.
- 하나의 인터페이스보다는 여러개의 작은 인터페이스가 낫다.

## Dependency Inversion Principle, 의존성 역전의 원칙

- 추상화에 의존해야지, 구체화에 의존하면 안된다.
