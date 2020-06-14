# Rules

크게 4가지 타입으로 나눌 수 있음:

- Code Smell (유지보수 관점)
- Bug (신뢰성 관점)
- Vulnerability (보안성 관점)
- Security Hotspot (보안성 관점)

---

- 코드악취와 버그의 경우는 오탐(false-positive)이 없음 
  - 이것은 목표이며, 개발자가 반드시 수정해야하는 것은 아님
- 취약점은 80% 이상의 문제가 true-positive인 것이 목표
- 보안 핫스팟 규칙은 보안에 민감한 코드로 주의를 끈다.
  - 개발자의 검토 후 80% 이상의 문제가 "검토"로 빠르게 해결될 것으로 예상.

## 정의 기준

> **Rules Severities**
> 
> 영향도(Impact), 가능성(Likelihood)를 기준으로 아래와 같이 분류되었고, 자세한 내용은 [여기](https://blog.sonarsource.com/we-are-adjusting-rules-severities) 혹은 [여기](https://docs.sonarqube.org/latest/user-guide/rules/#header-7) 확인 바랍니다.

![image](https://images.prismic.io/sonarsource/377c688a0d90c45b9485aecb5d342c40afedb1c4_table.png?auto=compress,format)

### Bugs

- 영향도: 최악의 경우 어플리케이션을 중단시키거나 저장된 데이터를 손상시킬 수 있는지?
- 가능성: 최악의 상황이 발생할 가능성이 얼마나 되는지?

### Vulnerabilities

- 영향도: 취약점을 악용하면 자산(assets)이나 사용자에게 심각한 피해를 줄 수 있는지?
- 가능성: 해커가 이 문제를 악용할 가능성이 얼마나 있는지?

### Code Smells

- 영향도: 코드스멜로 인해서 관리자가 버그를 일으킬 수 있는지?
- 가능성: 최악의 상황이 발생할 가능성이 얼마나 되는지?

---

- law of demeter
  - [디미터 법칙](https://johngrib.github.io/wiki/law-of-demeter)
  


## Correctness - Method of Singleton class writes to a field in an unsynchronized manner

> fb-contrib:USFW_UNSYNCHRONIZED_SINGLETON_FIELD_WRITES

이 메서드는 해당 클래스의 필드를 수정을 합니다. 허나 이 클래스는 싱글톤(singleton)으로 보이며 해당 필드가 동기적으로 변경되지 않기 때문에 경합 상태(race condition)가 발생하거나 다른 스레드가 확인할 수 없는 변경을 만들 수 있습니다.

단위 테스트를 위해 생성된 Setter일 경우, Spring Framework의 [ReflectionTestUtils](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/test/util/ReflectionTestUtils.html)를 활용할 수 있습니다.

Spring Batch의 Job에서 Step 간의 데이터 이동이 필요한 경우에는 [Passing Data to Future Steps](https://docs.spring.io/spring-batch/docs/current/reference/html/common-patterns.html#passingDataToFutureSteps)를 참고할 수 있습니다.

**See Also**

* [How can we share data between the different steps of a Job in Spring Batch?](https://stackoverflow.com/a/2791644/3793078) - stackoverflow
