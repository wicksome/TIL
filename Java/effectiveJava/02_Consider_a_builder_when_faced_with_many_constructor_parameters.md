> 생성자의 매개변수가 많을 때는 빌더(builder)를 고려하자

**as-is**

```java
public class Test {
	public static void main(String[] args) {
		Person p;
		p = new Person(name, age);
		p = new Person(name, age, sex, birthDay);
		p = new Person(name, age, sex, birthDay, mail, phone, addess, city, state, zip);
	}
}
```

- 인자 수가 늘어나면 작성하기가 어려워지고, 가독성이 떨어진다.

**to-be**

```java
public class Test {
	public static void main(String[] args) {
		Person p;
		p =  new Persion.Builder("yeongjun", 'm').
						.age(26)
						.mail("opid911@gmail.com")
						.builder();
	}
}

class Person {
	private final String name;
	private final char sex;
	private final int age;
	private final String birthDay;
	private final String mail;
	private final String phone;
	private final String addess;
	private final String city;
	private final String state;
	private final String zip;

	public static class Builder {
		// 필수 인자
		private final String name;
		private final char sex;

		// 선택적 인자
		private int age = 0;
		private String birthDay = "none";
		private String mail = null;
		private String phone = null;
		private String addess = null;
		private String city = null;
		private String state = null;
		private String zip = null;

		public Builder(String name, char sex) {
			this.name = name;
			this.sex = sex;
		}

		public Builder age(int age) {
			age = age;
			return this;
		}

		...

		public Builder address(String address, String city, String state, String zip) {
			address = address;
			city = city;
			state = state;
			zip = zip;
			return this;
		}

		public Person build() {
			return new Person(this);
		}
	}

	private Person(Builder builder) {
		name = builder.name;
		sex = builder.sex;
		age = builder.age;
		birthDay = builder.birthDay;
		...
	}
}
```

위 코드에 제네릭 사용

```java
...

public interface Builder<T> {
	public T build();
}

class Person {
	private final String name;
	...

	public static class Builder implements Builder<Person> {
		private final String name;
		...

		public Builder(String name, char sex) {
			this.name = name;
			this.sex = sex;
		}

		...

		public Person build() {
			return new Person(this);
		}
	}

	private Person(Builder builder) {
		name = builder.name;
	}
}

```

- 인자가 많은 생성자
- static 팩토리가 필요한 클래스를 설계할 때(특히, 대부분 인자가 선택적 인자인 상황에 유리)