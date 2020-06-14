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
