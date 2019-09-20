import java.lang.reflect.Method;

import java.util.Arrays;
import java.util.Optional;

import java.util.stream.*;
import java.util.concurrent.Callable;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

public class App {
    public static void main(String[] args) throws Exception {
        if (args.length == 0) {
            System.out.println("usage: run <method> <arguments...>");
            return;
        }

        System.out.println(Stream.of(args).collect(Collectors.joining(", ", "[", "]")));

        Service obj = new Service();
        Method method = obj.getClass().getDeclaredMethod(args[0]);
        method.setAccessible(true);
        method.invoke(obj);
    }
}

class Service {
    public void test1() {
        Optional.ofNullable(null).orElse(new TestObject("1 "));
        System.out.println();
        Optional.ofNullable(new TestObject("2-1 ")).orElse(new TestObject("2-2 "));
        System.out.println();
        Optional.ofNullable(null).orElseGet(TestObject::new);
        System.out.println();
        Optional.ofNullable(new TestObject("4-1 ")).orElseGet(TestObject::new);
    }

    class TestObject {
        TestObject() { System.out.print("new"); }
        TestObject(String s) { System.out.print(s == null ? "new" : s); }
    }

    void fp() {
        Stream.of(1, 2, 3).forEach(System.out::println);
    }

    private void future() throws InterruptedException, ExecutionException {
        System.out.println("Thread#" + Thread.currentThread().getId());

        // java5에서 멀티스레드와 콜백 사용하기 위해 ExecutorService 사용
        ExecutorService executor = Executors.newFixedThreadPool(1);
        Future<Integer> future = executor.submit(() -> {
            TimeUnit.SECONDS.sleep(1);
            System.out.println("Thread#" + Thread.currentThread().getId());
            return 123;
        });

        System.out.println("future done?" + future.isDone());

        Integer result = future.get(); // get() is blocking method

        System.out.println("future done?" + future.isDone());

        System.out.println("Thread#" + Thread.currentThread().getId());
        System.out.println("result:" + result);
    }

    private void completableFuture() throws Exception {
        CompletableFuture<Integer> future = CompletableFuture.supplyAsync(() -> {
            System.out.println("Thread#" + Thread.currentThread().getId());
            try {
                TimeUnit.SECONDS.sleep(1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            return 123;
        });

        System.out.println("Thread#" + Thread.currentThread().getId());
        future.thenAccept(System.out::println);

        System.out.println("Thread#" + Thread.currentThread().getId());
        future.join();
    }
}