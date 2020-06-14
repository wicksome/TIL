## Metric Definitions:

> 소나큐브에서 나타내는 각 매트릭에 대한 설명입니다. 자세한 내용은 [Metric Definitions](https://docs.sonarqube.org/latest/user-guide/metric-definitions/) 참고바랍니다.

### Complexity: 복잡도

-  Complexity
    - 코드를 통과하는 경우의 수를 기반으로 계산된 Cyclomatic Complexity
    - 함수의 제어 흐름이 분할될 때마다 복잡도 카운터가 증가
    - 각 함수의 최소 복잡도는 1, 각 언어의 키워드나 기능에 따라 계산방법이 다름
    - Java에서 복잡도를 올리는 키워드: `if`, `for`, `while`, `case`, `catch`, `throw`, `&&`, `||`, `?`
- Cognitive Complexity: 인지적 복잡도
    - https://www.sonarsource.com/resources/white-papers/cognitive-complexity.html
    - https://sonarqubekr.atlassian.net/wiki/spaces/SON/blog/2017/10/06/34996228/Cognitive+Complexity+Because+Testability+Understandability

### Duplications: 코드중복

- Duplicated blocks: 중복된 코드의 블럭 수.
    - Java에서는 적어도 10개의 연속적이고 중복된 코드를 나타내며, 중복을 감지하는 동안 들여쓰기와 `String`은 무시
- Duplicated files: 중복된 파일 수
- Duplicated lines: 중복된 코드 라인 수

### Issues: 이슈

- New issues: 신규 코드에서 처음으로 발견한 이슈 갯수
- New xxx issues: 신규 코드에 대해서 심각도별로 구분한 이슈 갯수
    - blocker, critical, major, minor, info.
- Issues: 전체 코드에 대해서 발견한 이슈 갯수
- xxx issues: 전체 코드에 대해서 심각도에 따라 구분한 이슈 갯수
    - blocker, critical, major, minor, info.
- False positive issues: False Positive로 표시된 이슈 갯수
    - 문제 없는데 문제 있다고 나온 것? 테스트 실패 건? 오탐?
    - [소프트웨어 테스팅의 False Positive](https://justhackem.wordpress.com/2018/12/20/false-positive-in-software-testing/)
- Open issues: 열려있는 총 이슈 갯수
- Confirmed issues: Confirmed 상태의 총 이슈 갯수
- Reopened issues: Reopened 상태의 총 이슈 갯수

### Maintainability: 유지보수성

- Code Smells: 코드악취 이슈 갯수
- New Code Smells: 신규 코드에 대한 코드악취 갯수
- Maintainability Rating: 기술 부채 비율에 관련해 측정된 등급
    - 유지보수성 등급의 기본 비율 값: A=0-0.05, B=0.06-0.1, C=0.11-0.20, D=0.21-0.5, E=0.51-1
- Technical Debt: 유지보수 이슈를 해결하는데 예상되는 시간
    - 분 단위로 측정
    - 하루 8시간으로 가정
- Technical Debt on New Code: 신규 코드에서 발견한 유지보수 이슈를 해결하는데 예상되는 시간
- Technical Debt Ratio: 개발과 유지보수 비용 간의 비율
    - 코드를 개발하는데 드는 비용은 한 줄 당 0.06일로 계산
- Technical Debt Ratio on New Code: 신규 코드에 대해서 개발과 유지보수 비용 간의 비율

### Quality Gates: 품질 게이트

- Quality Gate Status: 품질 게이트 상태 (`ERROR`, `OK`)
    - `WARN`은 v7.6부터 없어짐
- Quality Gate Details: 품질 게이트에 어떤 조건이 통과하고 실패했는지에 대한 정보

### Reliability: 신뢰성


