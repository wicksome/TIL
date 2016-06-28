> 불필요한 객체는 만들지 말라

```java
String s = new String("str"); // 피해야할 예
```

위코드는 실행될 때마다 `String` 객체를 만드는 쓸데없는 짓을 한다. loop안에 있다면 수백만 개의 `String` 객체를 생성한다.

```java
String s = "str";
```

이렇게 하면 실행할 때마다 객체를 생성하지 않고, 동일한 `String` 객체를 사용한다. 같은 가상머신에서 실행되는 모든 코드가 해당 객체를 사용한다.

## 

- 변경 불가능(immutable) 객체는 언제나 재용할수 있다.([규칙15](#item15))
- 변경 가능한 객체도 재사용 가능하지만 하지말아야하는 일이 있다.
	
	**as-is**

	```java
	public class Person {
		private final Date birthDate;

		public boolean isBabyBoomer() {
			Calendar gmtCal = Calendar.getInstance(TimeZone.getTimeZone("GMT"));
			...
		}
	}
	```

	여기서 `isBabyBoomer()`를 호출할때마다 `Calenar`객체와 `TimeZone`객체를 쓸데없이 생성한다.

	**to-be**

	```java
	public class Person {
		private final Date birthDate;

		static {
			Calendar gmtCal = Calendar.getInstance(TimeZone.getTimeZone("GMT"));
			...
		}
	}
	```

	만약 `gmtCal`을 사용하는 메서드가 한번도 호출되지 않는다면 쓸데 없이 초기화되었다고 봐야한다. 

		- [lazy initialization](#item71) 기법을 사용하면 피할 수 있다.
		- 그러나, 추천하지 않는다.
			- 복잡한 구현
			- 성능 개선의 어려움[(규칙55)](#item55)

