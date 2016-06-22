# 병행 프로그래밍
> _카이 호스트만의 코어 자바8_ 

---

## 태스크 실행하기

```java
Runnable task = () -> {
	System.out.println("yeongjun");
}
Executor exec = Executors.newCachedThreadPool();
Executor exec = Executors.newFixedThreadPool()
exec.execute(task);
```

### Executor

> 자바 병행성 라이브러리에서 실행자(executor)

- 태스크를 수행할 스레드를 선택해서 태스크를 실행한다
- 다양한 유형의 실행자를 만들어내는 facroty method가 있다
- `Exectors.newCachedThreadPool()`
	- 프로그램에 최적화된 실행자를 반환
	- idle thread에서 실행, 모든 스레드가 사용중이면 새로운 스레드 생성, 장시간 idle state이면 종료
- `Executors.newFixedThreadPool(nThreads)`
	- 고정 갯수 thread pool을 반환
	- 강도 높은 계산을 수행하는 태스크에 적합
	- 다음 방법으로 스레드 갯수 도출

	```java
	int processors = Runtime.getRuntime().availableProcessors();
	```

### Callable

> Runnable.run()과는 달리 값을 반환

```java
public interface Callable<V> {
	V call() throws Exception;
}
```

- 실행하기 위해 `Executor`의 서브인터페이스인 `ExecutorService` 인터페이스의 인스턴스 필요
	- `newCachedThreadPool()`와 `newFixedThreadPool()`가 반환

	```java
	ExecutorService exec = Exectors.newCachedThreadPool();
	Callable<Integer> task = () -> {...};
	Future<Integer> result = exec.submit(task);
	```

### Future

> A Future represents the result of an asynchronous computation

- `get()`: 결과를 얻게 되거나 타임아웃될 때까지 블록하고 값 반환
	- `call()`에서 예외를 전졌을 경우 해당 예외를 감싸고 있는 `ExecutionException`을 던짐
- `cancel()`: task 취소를 시도
	- 실행중이 아닌 태스크일 경우 스케줄링 되지 않음
	- 실행중이고 `cancel()`의 파라미터(mayInterruptIfRunning)가 true면 태스크 실행하는 스레드를 인터럽트

### _NOTE_

> task를 interrupt될 수 있게 하려면 인터럽션 요청을 주기적으로 확인해야 함

```java
Callable<V> task = () -> {
	while (남은 작업이 있으면) {
		if (Thread.currentTheread().isInterrupted()) {
			return null;
		}
		남은 작업을 수행한다.
	}
	returen result;
}
```

### 여러 태스크 실행

- `invokeAll()`: Callable 인스턴스의 Collection을 받을 수 있음

  	```java
	Set<Path> paths = ...;
	List<Callable<Long>> tasks = new ArrayList<>();
	for (Path p = paths) {
		tasks.add(() -> {
			return p에서 특정단어가 나타난 횟수;
		});
	}
	ExecutorService exec = Executors.newCachedThreadPool();
	List<Furure<Long>> results = exec.invokeAll(task);
	long total = 0;
	for (Future<Long> result : results) {
		total += result.get();
	}
	```

	- 타임아웃을 파라미터로 받아서 해당 타임아웃때 나머지 태스크를 모두 취소하는 `invokeAll()`도 있음
	- 서브태스크가 모두 완료될 때까지 호출된 태스크가 블록되는 것이 싫으면 `ExecutorCompletionService`

- `invokeAny()`: 하나가 완료하면 즉시 반환

	```java
	Set<Path> paths = ...;
	List<Callable<Path>> tasks = new ArrayList<>();
	for (Path p : paths) {
		tasks.add(() -> {
			if (특정 단어가 있다면) {
				return p;
			} else {
				throw ...;
			}
		});
	}
	ExecutorService exec = Executors.newCachedThreadPool();
	Path found = exec.invokeAny(tasks);
	```

	- 특정 대상을 발견한 즉지 결론을 내릴 수 있는 검색에 유용

---

## 스레드 안전성

### 가시성

```java
private static boolean done = false;

public static void main(String[] args) {
	Runnable task1 = () -> {
		for (int i = 0; i <= 1000; i++) {
			System.out.println(i);
		}
		done = true;
	};
	Runnable task2 = () -> {
		int i = 1;
		while(!done) {
			i++;
		}
		System.out.println("end: " + i);
	};
	Executor exec = Executors.newCachedThreadPool();
	exec.execute(task1);
	exec.execute(task2);
}
```

- 왜 task1이 1000을 출력했을 때 task2는 끝나지 않는가?
  - 캐싱과 명령어 재배치와 관련한 여러 이유

#### 캐싱(caching)

- done의 메모리 위치가 램 칩의 트랜지스터 어딘가에 있는 비트? - (개발자 생각)
  - 모던 프로세스보다 몇 배 느리다
  - 그래서! 프로세스는 필요한 데이터를 register나 보드에 달린 memory cache에 저장하려한다
  - 그리고! 다시 메모리에 쓴다
- 이러한 캐싱은 프로세스 퍼포먼스에서 빠질 수 없는 역할
- 캐시된 사본을 동기화하는 연산이 있지만, 요청을 받을 때만 일어남

#### 명령어 재배치(instruction reordering)

- 컴파일러, VM, 프로세서는 프로그램의 의미를 바꾸지 않는 한 연산 속도를 올릴 목적으로 명령어 순서 변경 가능

	```java
	x = y와 관련 없는 값;
	y = x와 관련 없는 값;
	z = x + y;
	```

	- x와 y는 어떤 순서로 일어나도 상관 없다
	- 프로세서는 두 단계를 병렬로 수행하거나(종종 이렇게 한다), y를 더 먼저 구할 수 있음
	- 즉, 앞에 나온 코드를 다음과 같이 재배치 될 수 있음

		```java
		while (!done) i++; // before
		if (!done) while (true) i++; // after
		```

#### 변수 업데이트가 보이게 보장하는 방법
1. final 변수의 값을 초기화 후에 보인다
2. static 변수의 초깃값은 정적 초기화(initialization) 후에 보인다
3. volatile 변수의 변경은 보인다
4. 잠금을 해제하기 전에 일어나는 변경은 같은 잠금을 획득하는 쪽에 보인다 

```java
private static volatile boolean done = false;
```

- 앞에 나온 코드에서는 공유 변수 done을 volatile 제어자로 선언하면 해결
- 컴파일러는 done을 변경했을 때, 다른 태스크에도 해당 변경이 보이도록 보장하는 데 필요한 명령어를 만듦

### 경쟁 조건

```java
private static volatile int count = 0;
count++; // 태스크 1
count++; // 태스크 2
```

- `volatile`로 선언했지만 충분하지 않음
- `count++`는 atomic 않기 때문
	```java
	count = count + 1;
	```
	- 값을 넣어주기 전에 스레드가 선점되면 인터럽트될 수 있음
- 이런 오류는 공유 변수를 업데이트하는 '경쟁'에서 승리하는 스레드에 의존하므로 _경쟁 조건(race confition)_이라고 한다
- 해결 방법
	- 잠금을 이용해서 임계적인 연산을 원자적으로 만드는 것
	- 하지만 퍼포먼스를 떨어뜨리거나, deadlock를 야기하는 실수를 저지를 수 있음

### 안전한 병행성을 실행하는 전략

1. 가두기(confinement)
2. 불변성(immutability)
3. 잠금 설정(locking)

#### 가두기(confinement)

```java
public class Test {
	public static void main(String[] args) throws ExecutionException, InterruptedException {
		Callable<Integer> task1 = () -> 1;
		Callable<Integer> task2 = () -> 2;

		ExecutorService exec = Executors.newCachedThreadPool();
		Future<Integer> x = exec.submit(task1);
		Future<Integer> y = exec.submit(task2);

		MyRunnable result = new MyRunnable(x.get(), y.get());
		result.run();
	}
}

class MyRunnable implements Runnable {
	private int x;
	private int y;
	public MyRunnable(int x, int y) {
		this.x = x;
		this.y = y;
	}

	public void run() {
		System.out.println(x + y);
	}
}
```

- 데이터를 공유해야할 경우, 공유 변수를 사용하지 않고 각 태스크에서 비공개 변수를 제공
- 태스크가 완료될 때, 각 결과들을 결합하는 또 다른 태스크에 전달

#### 불변성(immutability)

- 불변 객체를 공유하는 일은 안전
- 뒤에 자세한 내용

#### 잠금 설정(locking)

- 한 번에 한 태스크에만 자료 구조에 접근할 수 있는 권한 부여

### 불변 클래스

- 한 번 인스턴스를 생성하고 나서 변경할 수 없는 클래스
- 주의 사항
	1. 인스턴스 변수를 final로 선언(가시성)
	2. 메서드, 클래스 final로 선언
	3. 가변 상태 유출 X, 참조가 필요하면 사본을 반환하거나 전달
	4. 생성자에서 this 참조 노출 X
		- this를 사용하면 생성자 안에서 객체가 불완전한 상태에 놓을 수 있다

---

## 병렬 알고리즘

### 병렬 스트림

```java
long result = coll.parallelStream()
				  .filter(s -> s.startsWith("A"))
				  .count();
```

- `parallelStream()`은 병렬 스트림을 반환한다
- 병렬 스트림은 여러 세그먼트로 나뉜다
- 각 세그먼트에서 필터랑과 카운팅을 수행하고 결과를 결합한다
- but, 개발자는 세부 내용을 신경쓰지 않아도 된다

### 병렬 배열 연산

```java
Arrays.parallelSetAll(values, i -> i % 10);
Arrays.parallelSort(words, Comparator.comparing(String::length));
Arrays.parallelSort(values, values.length / 2, values.length); // 상반부를 정렬
```

- Arrays 클래스는 다수의 병렬화된 연산 지원

---

## 스레드 안전 자료 구조

- 잠금을 이용해서 다른 스레드 접근시 blocking 할 수 있지만, 비효율적
- 잘 만들어진 `java.util.concurrent` 패키지에 있는 컬렉션 사용

### 병행 해시 맵
> `ConcurrentHashMap`

- 스레드가 안전한 연산을 할 수 있게 해줌
- 아무리 많은 스레드가 연산을 수행해도 내부가 손상되지 않음
- 상당수의 병행 리더(concurrent reader)와 일정 개수의 병행 라이터(concurrent writer)를 효율적으로 지원
- `compute()`는 원자적이다

	```java
	ConcurrentHashMap<String, Long> map = new ConcurrentHashMap<>();
	map.compute(word, (k, v) -> (v == null) ? 1 : v + 1);
	```

_TODO: 필요할 때 더 찾아볼 것_

### 블로킹 큐
> `BlockingQueue` 태스크 사이에서 작업을 조율하는 데 사용

- `LinkedBlockingQueue`: 연결 리스트 기반
- `ArrayBlocingQueue`: 원형 배열

_TODO: 필요할 때 더 찾아볼 것_

### 기타 스레드 안전 자료 구조

- `ConcurrentSkipListMap`: 비교하는 키를 기초고 하는 병행 맵
	- 정렬 순서로 키를 순회, `NavigableMap` 인터페이스에 추가된 메서드 중 하나가 필요할 때
	- `ConcurrentSkipListSet`: 유사한 클래스
- `CopyOnWriteArrayList`: 스레드 안전 컬렉션 
- `CopyOnWriterArraySet`: 스레드 안전 컬렉션

...

_TODO: 필요할 때 더 찾아볼 것_

---

## 원잣값
> 패키지: `java.util.concurrent.atomic`<br/>
> `AtomicInteger`, `AtomicIntegerArray`, `AtomicIntegerFieldUpdater`, `AtomicLongArray`, `AtomicLongFieldUpdater`, `AtomicReference`, `AtomicReferenceArray`, `AtomicReferenceFieldUpdater`, ...

- 안전하고 효율적인 머신 수준 명령어를 이용
- 연산의 원자성 보장
- 원자적인 업데이트 방법

	```java
	public static AtomicLong largest = new AtomicLong();
	largest.incrementAndGet(); // 1 증가
	largest.updateAndGet(x -> Math.max(x, observed));
	largest.accumulateAndGet(observed, Math::max);
	```

### LongAdder
> AtomicLong 사용시, 경쟁이 심한 상황에서 업데이트하는 경우 많은 재시도로 퍼포먼스가 떨어질 때 사용<br/>
> `increment()`, `add()`, `sum()`

```java
final LongAdder count = new LongAddr();
for(스레드) {
	executor.execute(() -> {
		while(파일) {
			if(조건) {
				count.increment();
			}
		}
	});
}
long total = count.sum();
```

### LongAccumulator
> 임의의 누적 연산으로 일반화함

- 생성자 파라미터로 '수행할 연산', '해당 연산의 중립 요소'
- 새 값을 넣을 때는 `accumlate()`
- 현재 값을 얻으려면 `get()`

```java
LongAccumulator accumulator = new LongAccumulator(Long::sum, 0);
```

---

## 잠금

### 재진입 가능 잠금

```java
Lock countLock = new ReentrantLock();
int count = 0;

countLock.lock(); // 임계구역 설정
try {
	count++;
} finally {
	countLock.unlock(); // 임계구역 해제
}
```

- `ReentrantLock`를 이용한 명시적 잠금
- deadlock에 빠지는 상황을 만들 수 있으므로 제대로 사용할 것
- 공유가 필요할 때는 `ConcurrentHashMap`, `LongAdder` 같은 스레드 안전 자료구조를 사용한다.

### synchronized 키워드

**case 1**

```java
synchronized (obj) {
	// todo
}

// 다음 코드와 같다
obj.intrinaicLock.lock();
try {
	// todo
} finally {
	obj.intrinsicLock.unlock();
}
```

**case 2**

```java
public synchronized void method() {
	// todo
}

// 다음 코드와 같다
public void method() {
	this.intrinaicLock.lock();
	try {
		// todo
	} finally {
		this.intrinsicLock.unlock();
	}
}
```

- 잠금은 가시성을 보장함

### 조건 대기
> 스레드가 `wait()`되어 비활성화되고 잠금을 놓은 상태를 조건 대기(waiting on a confition)

Queue에서 값이 없다면 대기 중 상태였다가 값이 들어오면 지우는 메서드(`task()`)를 예로 들 수 있다.

```java
public synchronized Object take() {
	while (head == null) wait();
	Node n = head;
	head = n.next();
	return n.value;
}

public synchronized void add(Object newValue) {
	...
	notifyAll();
}
```

- 스레드는 `wait()`를 호출하면 해당 객체의 대기 집합(wait set)에 들어감
- 또 다른 스레드에서 같은 객체에 `notifyAll()`를 호출할 때까지 비활성화 상태
- `notify()`는 모든 스레드의 블록 상태를 해제하는 것보다 효율적이지만, 선택된 스레드가 여전히 진행할 수 없다면 deadlock에 빠지기 때문에 위험하다.

---

## 스레드

- 스레드를 대신 관리해주는 실행자를 사용하는 것이 더 좋다.

### 스레드 시작하기

```java
Runnable task = () -> { ... };
Thread thread = new Thread(task);
thread.start();
```

- 현재 스레드를 잠들게 하려면 `Thread.sleep(millis)`
- 스레드의 작업이 끝나기를 기다린다면 `thread.join(millis)`
- 이 두 메서드는 검사 예외 던짐 `InterruptedException`

- 스레드는 `run()`이 반환될 때 종료
- 예외가 발생하면 해당 스레드의 _미처리 예외 핸들러_ 호출
	- 스레드가 생성될 때 궁극적 전역 핸들러인 스레드 그룹의 미처리 예외 핸들러로 설정
- `setUncaughtExceptionHandler()`로 스레드의 핸들러 변경 가능

### 스레드 인터럽션



