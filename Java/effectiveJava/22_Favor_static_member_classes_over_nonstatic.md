# 맴버 클래스는 가능하면 static으로 선언하라

**nested class 의 종류**

- static member class
- nonstatic member class
- anonymous class
- local class



**static member class**

- External-Class의 모든 맴버에 접근 가능

  > TODO: 이해 못함…..

- Static-Member-Class가 `private`이라면 External-Class에서만 접근 가능 (1)

- External-Class의 정적맴버 (2)

  ```java
  public class ExternalClass {
  	private int value;

  	public static class StaticMemberClass {
  		public static void print() {
  			System.out.println("public static member class test");
  		}
  	}

  	private static class PrivateStaticMemberClass {
  		public static void print() {
  			System.out.println("private static member class test");
  		}
  	}

  	public void print() {
  		PrivateStaticMemberClass.print(); // (1)
  	}
  }
  ```

  ```java
  public class MainClass {
  	public static void main(String[] args) {
  		ExternalClass t = new ExternalClass();

  		ExternalClass.StaticMemberClass.print(); // (2)
  		// ExternalClass.PrivateStaticMemberClass.print(); (1) 불가능

  		t.print();
  	}
  }
  ```



**nonstatic member class**

- 문법으로는 `static` 여부 차이. 그러나, ..

- External-Class와 자동적으로 연결된다.

  - NonStatic-Member-Class 안에서 External-Class의 메서드 호출 가능 (1)
  - qualified this로 External-Class 객체에 대한 참조 획득 가능 (2)
  - NonStatic-Member-Class와 External-Class의 연결은 NonStatic-Member-Class의 객체가 생성될때 확립 (3)

  ```java
  public class ExternalClass {
  	private int externalClassValue;

  	public ExternalClass(int value) {
  		this.externalClassValue = value;
  	}

  	private int getExternalClassValue() {
  		return externalClassValue;
  	}

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
  public class MainClass {
  	public static void main(String[] args) {
  		ExternalClass t = new ExternalClass(2);
  		t.new NonStaticMemberClass().setExternalClassValue(4); // (3) 직접 연결도 가능
  		t.print();
  	}
  }
  ```

  ```sh
  // 출력결과
  4
  3
  ```

- External-Class와 독립적으로 존재할 수 있도록 하려면 반드시 `static`으로 선언

- Adapter를 정의할 때 많이 사용(External-Class를 다른 클래스 객체인 것처럼 보이게하는 용도)

  > 예제를 만들어보면서 이해하려했지만.. 이해 부족..
  >
  > 반환값이 인터페이스일 때 사용한다는 것인가? 메서드안이 너무 길어질 것 같으니까 맴버클래스로 정의?!

  ```java
  abstract class Person {
  	String name;
  	abstract Output working();
  }

  interface Output {
  	String getOutputName();
  	String getCreator();
  }

  class SoftwareDeveloper extends Person {
  	@Override
  	public Output working() {
  		return new Program();
  	}

  	private final class Program implements Output {
  		@Override
  		public String getOutputName() {
  			return "software";
  		}

  		@Override
  		public String getCreator() {
  			return name;
  		}
  	}
  }

  class Designer extends Person {

  	@Override
  	public Output working() {
  		return new Output() {
  			@Override
  			public String getOutputName() {
  				return "design";
  			}

  			@Override
  			public String getCreator() {
  				return name;
  			}
  		};
  	}
  }
  ```

  ​

**anonymous class**

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

- static context 안에서 사용된다 해도 static 맴버를 가질 수 없다

  > 아래 코드를 말하는게 맞는지 모르겠음..

  ```java
  	...
  	private static AnonymousClass ac;

  	public static void printAnonymousClassTest() {
  		ac = new AnonymousClass() {
  			// private static int value; 불가능
  			...
  ```

- 함수 객체를 정의할 때 널리 쓰인다



**local class**

- 지역 변수 선언되는 곳에 선언된 클래스

- static 맴버 불가능, nonstatic context에서만 External-Class의 맴버 접근 가능

  ```java
  public class ExternalClass {
  	private int externalClassValue = 2;

  	public void printLocalClassTest() { // non static context
  		class LocalClass {
  			private int value;
  			// private static value; 불가능

  			LocalClass(int value) {
  				this.value = value;
  			}

  			void print() {
  				System.out.println(externalClassValue); // External 객체 접근 가능
  			}
  		}

  		LocalClass lc = new LocalClass(1);
  		lc.print();
  	}
  }
  ```



요약, 알아둘 것

- 중첩 클래스를 메서드 밖에서 사용할 수 있어야 하거나, 메서드 안에 놓기에 너무 길 경우 맴버 클래스로 정의

- 맴버 클래스의 객체들이 External-Class의 객체들에 대한 참조를 가져야 하는 경우에서만 NonStatic-Member-Class로 정의

  ​
