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