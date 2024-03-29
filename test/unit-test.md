- 만났던 개발자들 중 대다수는 테스트 코드를 작성하는 것을 귀찮아하고 싫어했었다.
- 이 책은 맹목적인 테스트 노력에서 벗어나 실용적인 테스트 구성에 대한 방법론으로 접근한다.

# 더 큰 그림

## 단위 테스트의 목표
- 단위 테스트를 배우는 것은 테스트 프레임워크나 mocking libarary 등과 같은 기술적인 부분을 익히는 것에 그치치 않는다. 
- 단위 테스트는 단순히 테스트를 작성하는 것보다 더 큰 범주다.
- 단위 테스트에 시간을 투자할 때는 항상 최대한 이득을 얻도록 노력하며, 테스트에 드는 노력을 가능한 줄이고 그에 따르는 이득을 최대화해야 한다.
- 비용 편익 분석<sup>cost-benefit analysis</sup>[^1] 방법을 배우고, 특정 상황에서 적절한 테스트 기술을 적용할 수 있을 것이다.
- 공통적인 안티 패턴<sup>anti-pattern</sup>(처음에는 고내찮은 것 같지만 미래에 문제를 야기하는 패턴)을 피하는 방법도 배운다.

[^1]: 여러 가지 대안에 대한 비용과 이익을 분석해서 가장 효과적인 대안을 찾는 방법론

### 1.1 단위 테스트 현황
- 많은 프로젝트에 (심지어 자동화된) 단위 테스트가 있지만, 테스트를 해도 개발자들이 원하는 결과를 얻지 못하는 경우가 많다.
- 좋은 테스트와 좋지 않은 테스트의 차이는 취량이나 개인적인 선호도의 문제가 아니라 ==현재 작업 중인 중대한 프로젝트의 상태를 가르는 문제==

### 1.2 단위 테스트의 목표
- 단위 테스트 활동이 더 나은 설계로 이어진다. 이는 사실.
- 코드베이스에 대해 단위 테스트 작성이 필요하면 일반적으로 더 나은 설계로 이어진다. 하지만 단위 테스트의 주목표는 아니다. 더 나은 설계는 단지 좋은 부수 효과일 뿐.
- 단위 테스트의 목표
    - 소프트웨어 프로젝트의 ==지속 가능한 성장을 가능하게 하는 것==
- 테스트가 없는 프로젝트
    - 처음에는 발목을 잡을 것이 없으므로 빨리 시작. 잘못된 아키텍처라 걱정할 만한 코드가 없다. 하지만 시간이 지나면서 점점 더 많은 시간을 들여야 처음고 같은 진척을 낼 수 있다.
    - 소프트웨어 엔트로피<sup>software entropy</sup>
        - 개발 속도가 빠르게 감소하는 현상
        - 엔트로피(시스템 내 무질서도)는 소프트웨어 시스템에도 적용할 수 있는 수학적이고 과학적인 개념
    - 소프트웨어에서 엔트로피는 품질을 떨어뜨리는 코드 형태로 나타남
        - 코드베이스에서 무언가를 변경할 때마다 무질서도는 증가
        - 지속적인 정리와 리팩터링 등과 같은 적절한 관리를 하지 않고 방치하면 시스템이 점점 더 복잡해지고 무질서해짐
        - 버그를 수정하면 더 많은 버그를 양산하고, 결국 코드베이스의 신뢰를 읽음.
- 테스트가 있는 프로젝트
    - 테스트는 안전망 역할
    - 대부분의 회귀<sup>regression</sup>에 대한 보험을 제공하는 도구
    - 새로운 기능 도입, 새로운 요구 사항에 더 잘 맞게 리팩터링한 후에도 기존 기능이 잘 작동하는지 확인하는 데 도움
    - 한 가지 단점은 초반에 노력이 필요하다는 것. 다만 장기적으로 그 비용을 메울 수 있음
- 지속성과 확장성이 핵심이며, 이를 통해 장기적으로 개발 속도를 유지할 수 있다.
- 목표를 달성하기 위한 유일한 방법
    - 좋은 테스트와 좋지 않은 테스트를 구별하는 방법을 배운다.
    - 테스트를 리팩터링해서 더 가치 있게 만든다.

```ad-note
회위는 특정 사건(일반적으로 코드 수정) 후에 기능이 의도한 대로 작동하는 않는 경우다. 소프트웨어 버그와 회귀라는 용어는 동의어이며 바꿔서 사용할 수 있다.
```

#### 1.2.1 좋은 테스트와 좋지 않은 테스트를 가르는 요인
- 잘못 작성한 테스트는 소프트웨어 엔트로피와 같은 결과를 나타냄
- 지속 가능한 프로젝트 설장을 위해서는 고품질 테스트에만 집중해야 한다.
- 고품질 테스트만이 테스트 스위트<sup>test suite</sup>에 남을 만한 테스트 유형이다.
- 제품 코드 vs. 테스트 코드
    - 사람들은 종종 제품 코드와 테스트 코드가 다르다고 생각한다.
    - 사람들은 종종 테스트가 많으면 많을수록 좋다고 생각한다.
    - 코드는 자산이 아니라 책임이다. 코드가 많아질수록 잠재적인 버그에 노출되는 표면적이 더 넓어지고, 프로젝트 유지비가 증가한다. 따라서 가능한 한 적은 코드로 문제를 해결하는 것이 좋다.
    - 테스트도 코드다. 
        - 특정 문제를 해결하는 것. 즉, 애플리케이션의 정확성을 보장하는 것을 목표로 하는 코드베이스의 일부.
    - 다른 코드와 마찬가지로 단위 테스트도 버그에 위략하고 유지 보수가 필요하다.

### 1.3 테스트 스위트 품질 측정을 위한 커버리지 목표
- 일반적으로 커버리지 숫자가 높을수록 좋다.
- 커버리지 지표는 테스트 스위트가 소스 코드를 얼마나 실행하는지를 박분율로 나타냄
- 커버리지 지표는 테스트 스위트의 품질을 평가하는 데 자주 사용됨
- 커버리지 지표는 중요한 피드백을 주더라도 테스트 스위트 품질을 효과적으로 측정하는 데 사용될 수 없다.
- 커버리지 지표는 괜찮은 부정 지표이지만 좋지 않은 긍정 지표다
    - 코드 커버리지가 너무 적을 때는 테스트가 충분치 않다는 좋은 증거.
    - but, 100% 커버리지라고 해서 반드시 양질의 테스트 스위트라고 보장하지 않음. 높은 커버리지의 테스트 스위트도 품질이 떨어질 수 있다.
- 코드 커버리지<sup>code coverage</sup>
    - 테스트 커버리지<sup>test coverage</sup>
    - 하나 이상의 테스트로 실행된 코드 라인 수와 제품 코드베이스의 전체 라인수의 비율
    - $$코드커버리지(테스트 커버리지) = \frac{실행 코드 라인 수}{전체 라인 수}$$
    - 테스트 커버리지의 함정
        - 단지 메서드 내 코드만 바꿨을 뿐인데, 테스트가 검증하는 결과 갯수는 같아도 다른 커버리지를 나타낸다.
        - 80% 테스트 커버리지 코드
            ```kotlin
            fun isStringLong(input: String) 
            {
                if (input.length > 5) 
                    return true
                return false
            }
            ```
        - 100% 테스트 커버리지 코드
            ```kotlin
            fun isStringLong(input: String) 
            {
                return input.length > 5
            }
            ```
- 분기 커버리지<sup>branch coverage</sup>
    - 코드 커버리지의 단점을 극복하는데 도움이 됨
    - 분기 커버리지 지표는 원시 코드 라인수를 사용하는 대신 if문과 swith문과 같은 제어 구조에 중점을 둠
    - $$분기 커버리지 = \frac{통과 분기}{전체 분기 수}$$
    - 해당 분기를 구현하는데 얼마나 코드가 필요한지 고려하지 않는다.
- 커버리지 지표에 관한 문제점
    - 분기 커버리지로 코드 커버리지 보다 더 나은 결과를 얻을 순 있지만, 테스트 스위트 품질을 결정하는 데 어떤 커버리지도 의존할 수 없다.
    - 외부 라이브러리의 코드 경로를 고려할 수 있는 커버리지 지표는 없음
- 검증이 없는 테스트
    ```
    fun test() {
        val result1 = isStringLong("abc")
        val result2 = isStringLong("abcdev")
    }
    ```
    - 위 코드는 커버리지 100%다. 다만 아무것도 검증하지 않는다.
    - 검증 없는 테스트 개념은 어리석은 생각 같지만 현장에서 실제로 일어난다.
- 커버리지 지표를 보는 가장 좋은 밥법은 지표 그 자체로 보는 것이며, 목표로 여겨서는 안된다.

## 1.4 무엇이 성공적인 테스트 스위트를 만드는가?
- 개인의 판단에 맡겨야 함
- 스튀트 내 각 테스트를 하나씩 따로 평가하는 것뿐
- 테스트 스위트가 얼마나 좋은지 자동으로 확인할 수 없다.
- 성공적인 테스트 스위트는 다음과 같은 특정을 갖는다
    1. 개발 주기에 통합돼 있다
    2. 코드베이스에서 사장 중요한 부분만을 대상으로 한다.
    3. 최소한의 유지비로 최대의 가치를 끌어낸다.

### 1.4.1 개발 주기에 통합돼 있음
- 코드가 변경될 때마다 아무리 작은 것이라도 실행됨

### 1.4.2 코드베이스에서 가장 중요한 부분만을 대상으로 함
- 대부분의 애플리케이션에서 가장 중요한 부분은 비즈니스 로직(도메인 모델)이 있는 부분


# 개발자에게 도움이 되는 테스트 만들기


# 통합 테스트 

# 단위 테스트 안티 패턴
