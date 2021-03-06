# Metric Definitions

> SonarQube에서 나타내는 각 매트릭에 대한 설명입니다. 8.3 문서 기준으로 작성하였으며, 자세한 내용은 [Metric Definitions](https://docs.sonarqube.org/latest/user-guide/metric-definitions/) 참고바랍니다.

## Complexity: 복잡도

-  Complexity
    - 코드를 통과하는 경우의 수를 기반으로 계산된 Cyclomatic Complexity
    - 함수의 제어 흐름이 분할될 때마다 복잡도 카운터가 증가
    - 각 함수의 최소 복잡도는 1, 각 언어의 키워드나 기능에 따라 계산방법이 다름
    - Java에서 복잡도를 올리는 키워드: `if`, `for`, `while`, `case`, `catch`, `throw`, `&&`, `||`, `?`
- Cognitive Complexity: 인지적 복잡도
    - [Cognitive Complexity](https://www.sonarsource.com/resources/white-papers/cognitive-complexity.html)
    - [Cognitive Complexity, Because Testability != Understandability](https://sonarqubekr.atlassian.net/wiki/spaces/SON/blog/2017/10/06/34996228/Cognitive+Complexity+Because+Testability+Understandability)

## Duplications: 코드중복

- Duplicated blocks: 중복된 코드의 블럭 수.
    - Java에서는 적어도 10개의 연속적이고 중복된 코드를 나타내며, 중복을 감지하는 동안 들여쓰기와 `String`은 무시
- Duplicated files: 중복된 파일 수
- Duplicated lines: 중복된 코드 라인 수

## Issues: 이슈

- New issues: 신규 코드에서 처음으로 발견한 이슈 개수
- New xxx issues: 신규 코드에 대해서 심각도별로 구분한 이슈 개수
    - blocker, critical, major, minor, info.
- Issues: 전체 코드에 대해서 발견한 이슈 개수
- xxx issues: 전체 코드에 대해서 심각도에 따라 구분한 이슈 개수
    - blocker, critical, major, minor, info.
- False positive issues: False Positive로 표시된 이슈 개수
    - 문제 없는데 문제 있다고 나온 것? 테스트 실패 건? 오탐?
    - [소프트웨어 테스팅의 False Positive](https://justhackem.wordpress.com/2018/12/20/false-positive-in-software-testing/)
- Open issues: 열려있는 총 이슈 개수
- Confirmed issues: Confirmed 상태의 총 이슈 개수
- Reopened issues: Reopened 상태의 총 이슈 개수

## Maintainability: 유지보수성

- Code Smells: 코드악취 이슈 개수
- New Code Smells: 신규 코드에 대한 코드악취 개수
- Maintainability Rating: 기술 부채 비율에 관련해 측정된 등급
    - 유지보수성 등급의 기본 비율 값: A=0-0.05, B=0.06-0.1, C=0.11-0.20, D=0.21-0.5, E=0.51-1
- Technical Debt: 유지보수 이슈를 해결하는데 예상되는 시간
    - 분 단위로 측정
    - 하루 8시간으로 가정
- Technical Debt on New Code: 신규 코드에서 발견한 유지보수 이슈를 해결하는데 예상되는 시간
- Technical Debt Ratio: 개발과 유지보수 비용 간의 비율
    - 코드를 개발하는데 드는 비용은 한 줄 당 0.06일로 계산
- Technical Debt Ratio on New Code: 신규 코드에 대해서 개발과 유지보수 비용 간의 비율

## Quality Gates: 품질 게이트

- Quality Gate Status: 품질 게이트 상태 (`ERROR`, `OK`)
    - `WARN`은 v7.6부터 없어짐
- Quality Gate Details: 품질 게이트에 어떤 조건이 통과하고 실패했는지에 대한 정보

## Reliability: 신뢰성

- Bugs: 버그 개수
- New Bugs: 신규 코드에서 발견된 버그 개수
- Reliability Rating
    - A: 0 bugs
    - B: 최소 1개의 Minor Bug
    - C: 최소 1개의 Major Bug
    - D: 최소 1개의 Critical Bug
    - E: 최소 1개의 Blocker Bug
- Reliability remediation effort: 버그를 해결하기 위한 비용
    - 분 단위로 저장하며, 하루 8시간으로 가정
- Reliability remediation effort on new code: 신규 코드에 대한 버그를 해결하기 위한 비용

> **Code Smell vs Bugs**
> - Code Smell: 이해가능성, 변경가능성, 재사용성 등과 관련한 유지보수성 이슈로 버그는 아니다.
> - Bugs: 잠재적인 버그나 런타임에 문제가 있을만한 코드를 나타낸다.

## Security: 보안성

- Vulnerabilities: 취약점 개수
- Vulnerabilities on new code: 신규 코드에서 발견한 취약점 개수
- Security Rating
    - A: 0 취약점
    - B: 최소 1개의 Minor 취약점
    - C: 최소 1개의 Major 취약점
    - D: 최소 1개의 Critical 취약점
    - E: 최소 1개의 Blocker 취약점
- Security remediation effort: 보안 취약점을 해결하기 위한 비용(or 노력)
- Security remediation effort on new code: 신규 코드에 대한 보안 취약점을 해결하기 위한 비용(or 노력)
- Security Hotspots: 보안 핫스팟 개수
- Security Hotspots on new code: 신규 코드에 대한 보안 핫스팟 개수
- Security Review Rating: 전체 코드에 대한 보안 검토 등급. 보안 핫스팟의 백분율을 기준으로 함
    - A = >= 80%
    - B = >= 70% and <80%
    - C = >= 50% and <70%
    - D = >= 30% and <50%
    - E = < 30%
- Security Review Rating on new code: 신규 코드에 대한 보안 검토 등급
- Security Hotspots Reviewed: 보안 핫스팟에 대한 백분율
- New Security Hotspots Reviewed: 신규 보안 핫스팟에 대한 백분율

> **Security Hotspot**
> 
> Security Hotspot은 아래와 같은 보안 프로젝트를 바탕으로 개발자의 검토가 필요한 (보안에 민감한) 코드를 나타냅니다. 이러한 Security Hotspot을 발견하고 코딩함으로 개발자는 보안 코딩 방법을 익히며 보안 리스크를 평가하는 방법을 배울 수 있습니다.
> - **OWASP(The Open Web Application Security Project)** 는 오픈소스 웹 애플리케이션 보안 프로젝트입니다. 주로 웹에 관한 정보노출, 악성 파일 및 스크립트, 보안 취약점 등을 연구하며, 10대 웹 애플리케이션의 취약점 (OWASP TOP 10)을 발표했습니다. 이 프로젝트의 원래 목표는 단순히 개발자와 관리자의 인식을 높이는 것이었지만, 사실상 애플리케이션 보안의 업계 표준이 되었습니다.
> - **CVE(Common Vulnerabilities and Exposures)** 는 취약점 리스트로, 발견된 보안 취약점들을 체계적으로 정리하여 보안 취약점 고유 번호로 나타냅니다.
> - **CWE(Common Weakness Enumeration)** 는 보안약점 리스트로, MITRE 프로젝트에서 관리하며 주요 취약점, 보안 문제를 정리한 프로젝트입니다.

> **Security Hotspot vs Vulnerability**
> 
> - Security Hotspot: 보안 관련해서 개발자가 직접 검토가 필요한 문제.
> - Vulnerability: 백도어 공격과 관련한 보안 관련 문제. [Security-releated Rules](https://docs.sonarqube.org/latest/user-guide/security-rules/) 참고
>     - SQL 인젝션, 크로스사이트 스크립팅, 코드 인젝션 등

## Size

- Classes
- Comment lines
    - Java에서 파일 헤더는 주석 줄수로 계산하지 않음. 일반적으로 라이센스를 정의하기 때문.
- Comments
    - 50%는 코드와 주석 줄 수가 같다는 것을 의미
    - 100%는 주석만 있다는 것을 의미
- Directories
- Files
- Lines
- Lines of code
- Lines of code per language
- Functions
    - Java에서 익명클래스의 메소드는 무시
- Projects
- Statements

## Tests

- Condition coverage: 조건 커버리지
    - condition coverage는 부울식이 포함된 각 코드 줄에서 true와 false의 경우가 모두 평가되었는지를 나타냄.
    ```
    Condition coverage = (CT + CF) / (2*B)
    ```
    - CT = 적어도 1번 `true`로 평가된 조건
    - CF = 적어도 1번 `false`로 평가된 조건
    - B = 조건의 전체 개수
- Condition coverage on new code: 신규 코드에 대한 조건 커버리지
- Condition coverage hits: 수행된(covered) 조건 목록
- Conditions by line: 각 라인별 조건 개수
- Covered conditions by line: 각 라인별 수행된(covered)조건 개수
- Coverage
    - 라인 커버리지와 조건 커버리지가 혼합됨
    - 단위 테스트에서 얼마나 많은 코드를 다루었는가에 대해서 알 수 있는 지표
    ```
    Coverage = (CT + CF + LC)/(2*B + EL)
    ```
    - CT = 적어도 1번 `true`로 평가된 조건
    - CF = 적어도 1번 `false`로 평가된 조건
    - LC = covered lines = 수행할 라인 - 수행되지 않은 라인
    - B = 전체 조건 개수
    - EL = 총 평가라인 수(lines_to_cover)
- Coverage on new code: 신규 코드에 대한 커버리지
- Line coverage: 수행된 라인에 대한 밀도(density)
    - 단위 테스트가 실행하는 동안 평가된 라인인지 나타냄
    ```
    Line coverage = LC / EL
    ```
    - LC = 수행된(covered) 라인 (`lines_to_cover` - `uncovered_lines`)
    - EL = total number of executable lines (`lines_to_cover`)
- Line coverage on new code: 신규 코드에 대한 라인 커버리지
- Line coverage hits: 수행된(covered) 라인 목록
- Lines to cover: 단위 테스트로 다룰 수 있는 코드 줄 수
- Lines to cover on new code: 신규 코드에 한해 단위 테스트로 다룰 수 있는 코드 줄 수
- Skipped unit tests: 건너 뛴 단위 테스트 개수
- Uncovered conditions: 단위 테스트에서 수행되지 않은(uncovered) 조건 개수 
- Uncovered conditions on new code: 신규 코드에 한해 단위 테스트에서 수행되지 않은(uncovered) 조건 개수
- Uncovered lines: 단위 테스트에서 수행되지 않은(uncovered) 줄 수
- Uncovered lines on new code: 신규 코드에 한해 단위 테스트에서 수행되지 않은(uncovered) 줄 수
- Unit tests: 단위 테스트 개수
- Unit tests duration: 단위 테스트 실행 시간
- Unit test errors: 실패한 단위 테스트 개수
- Unit test failures: 예상치 않은 예외로 실패한 단위 테스트 개수
- Unit test success density (%): 단위 테스트 성공 비율

> **Line Coverage, Statement Coverage**
> 
> Line Coverage(라인 커버리지), Statement Coverage(구문 커버리지, 스테이트먼트 커버리지)로 불리는 것 같다. 이 커버리지는 단위 테스트에 의해서 실행된 코드 라인 수를 의미한다.

# See Also

- [테스트 커버리지에 현혹되지 말자](http://egloos.zum.com/aeternum/v/1209470)
    > - 라인 커버리지만 올려 신뢰성이 떨어지는 지표를 만들지 말자. Path Coverage를 목표로 하라.
    > - "파레토 원리를 잊지 말자. 우리는 전체 오류의 80%를 차지하는 20% 부분에 집중해야 한다. 테스트 커버리지 측정은 적은 노력으로도 매우 큰 이익을 얻을 수 있는 효과적인 프랙티스다. 테스트 커버리지를 바보들의 황금으로 만드는 것은 테스트 그 자체가 아니라 테스트 커버리지를 사용하는 우리들 자신이라는 것을 잊지 말아야 한다. 배를 난파시키려는 세이렌의 노래에 현혹되지 말자. 눈을 감고 귀를 막을 필요까지는 없지만 무엇이 옳은 길인가에 대한 냉철한 판단력을 유지해야 한다."
    
