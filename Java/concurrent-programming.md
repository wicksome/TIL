# 병행 프로그래밍
> 카이 호스트만의 코어 자바8

## 태스크 실행하기

```java
Runnable task = () -> {
	System.out.println("yeongjun");
}
Executor exec = Executors.newCachedThreadPool();
Executor exec = Executors.newFixedThreadPool()
exec.execute(task);
```

**Executor**: 자바 병행성 라이브러리에서 실행자(executor)
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

**Callable**: Runnable.run()과는 달리 값을 반환

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

**Future**: A Future represents the result of an asynchronous computation
- `get()`: 결과를 얻게 되거나 타임아웃될 때까지 블록하고 값 반환
	- `call()`에서 예외를 전졌을 경우 해당 예외를 감싸고 있는 `ExecutionException`을 던짐
- `cancel()`: task 취소를 시도
	- 실행중이 아닌 태스크일 경우 스케줄링 되지 않음
	- 실행중이고 `cancel()`의 파라미터(mayInterruptIfRunning)가 true면 태스크 실행하는 스레드를 인터럽트

_NOTE._ task를 interrupt될 수 있게 하려면 인터럽션 요청을 주기적으로 확인해야 함

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

**여러 태스크 실행**
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

## 스레드 안전성

**가시성**

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

캐싱(caching)
- done의 메모리 위치가 램 칩의 트랜지스터 어딘가에 있는 비트? - (개발자 생각)
  - 모던 프로세스보다 몇 배 느리다
  - 그래서! 프로세스는 필요한 데이터를 register나 보드에 달린 memory cache에 저장하려한다
  - 그리고! 다시 메모리에 쓴다
- 이러한 캐싱은 프로세스 퍼포먼스에서 빠질 수 없는 역할
- 캐시된 사본을 동기화하는 연산이 있지만, 요청을 받을 때만 일어남

명령어 재배치(instruction reordering)
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

---

변수 업데이트가 보이게 보장하는 방법
- final 변수의 값을 초기화 후에 보인다
- static 변수의 초깃값은 정적 초기화(initialization) 후에 보인다
- volatile 변수의 변경은 보인다
- 잠금을 해제하기 전에 일어나는 변경은 같은 잠금을 획득하는 쪽에 보인다 

---

```java
private static volatile boolean done = false;
```

- 앞에 나온 코드에서는 공유 변수 done을 volatile 제어자로 선언하면 해결
- 컴파일러는 done을 변경했을 때, 다른 태스크에도 해당 변경이 보이도록 보장하는 데 필요한 명령어를 만듦
