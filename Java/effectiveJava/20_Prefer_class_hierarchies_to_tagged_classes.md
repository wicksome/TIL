# 태그 달린 클래스 대신 클래스 계층을 활용하라.

**as-is**

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

**단점**

- 수정할 때마다 `switch`문에 새로운 `case`를 올바르게 넣어야 한다. 
- 객체의 자료형만 봐서 그 객체가 무슨 기능을 제공하는지 알 수 없다.
- boilerplate code가 늘어난다.
- 오류 발생 가능성이 높아지고, 효율적이지 않다.



**to-be**

규칙 14

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
  
  public double area() {
    return length * width;
  }
}
```