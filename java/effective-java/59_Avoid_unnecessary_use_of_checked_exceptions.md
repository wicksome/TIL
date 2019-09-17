# 불필요한 점검지정 예외 사용은 피하라

점검지정 예외는 프로그래머 하여금 예외적인 상황을 처리하도록 장제함으로써 안정성을 높인다.

아래 경우에 해당하지 않을 경우 무점검 예외를 이용하는 것이 좋다.

- API를 제대로 이용해도 예외 상황이 벌어지는 것을 막을 수 없을 때
- API 사용자가 예외상황에 대한 조치를 취할 수 있을 때

API 사용자가 이보다 좋은 코드를 만들 수 없다면, 무점검 예외가 적당하다.

```java
} catch (TheCheckedException e) {
  throw new AssertionError();
} 
```

```java
} catch (TheCheckedException e) {
  e.printStackTrace();
  System.exit(1);
}
```

메서드가 던지는 예외가 하나뿐일 경우, 점검지정 예외를 없앨 방법이 없을지 고민해보는 것이 좋다.

- 예외를 던지는 메서드를 둘로 나눠서 첫 번째 메서드가 boolean값을 반환 하도록 만드는 것

  ```java
  /* as-is */
  try {
    obj.action(args);
  } catch (TheCheckedException e) {
    // 예외적 상황 처리
  }

  /* to-be: 상태 검사 메서드를 거쳐서 무점검 예외 메서드를 호출 */
  if (obj.actionPermitted(args)) {
    obj.action(args);
  } else {
    // 예외적 상황 처리
  }
  ```

- 결과적으로 만들어지는 API는 규칙 57에서 설명한 상태 검사 메서드와 본질적으로 같기 때문에, 동일한 문제를 갖는다.
  그러므로, 외부적인 동기화 수단 없이 병렬적으로 이용될 가능성이 있는 객체거나, 외부에서 그 상태를 바꿀 가능성이 있는 객체라면 위의 리팩토링 기법은 적용할수 없다.