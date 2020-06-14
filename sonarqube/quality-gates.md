# Quality Gates

- 품질 게이트는 조직안에서 품질 정책을 시행하는 방법
- 아래 질문에 답하기 위해 프로젝트로부터 측정된 매트릭에 임계 값 기반으로 조건셋을 정의할 수 있음
  > "오늘 당신의 프로젝트를 운영환경에 제공할 수 있나요?"
- 모든 프로젝트는 한가지 품질 게이트만으로 정의할 수 없으며, SonarQube는 이를 해결하기 위해 원하는만큼 품질 게이트를 정의 가능
- 기본적으로 SonarSource에서 제공하는 읽기 전용인 "Sonar way"가 활성화됨
  - [Clean as You Code](https://docs.sonarqube.org/latest/user-guide/clean-as-you-code/) 개념을 구현하는 가장 좋은 방법에 대한 SonarSource사의 견해를 나타냄
  - SonarQube 릴리즈마다 SonarQube 기능에 따라 자동으로 조정
- SonarQube는 `Sonar way`에 대해서 대부분의 프로젝트에 권장하고 있음.
  - 오래된 코드를 수정하는 데 많은 노력을 기울이지 않고, 새로운 코드를 깨끗하게 유지하는 데 중점을 둠

## Sonar way

> v8.3 기준의 Sonar way 품질 게이트 조건셋

신규 코드에 대해서만 측정됨

- 커버리지: 80% 이상
- 중복코드: 3% 미만
- 유지보수성 등급: A (5% 이하의 기술부채)
- 신뢰성 등급: A (0개 버그)
- 보안성 등급: A (0개 취약점)
- 보안 핫스팟 리뷰: 100%

## Clean as You Code

- [Clean as You Code](https://docs.sonarqube.org/latest/user-guide/clean-as-you-code/)는 코드 품질에 대한 접근 방식으로, 기존 접근 방식에서 발생하는 많은 문제를 해결함
- 개발자는 높은 표준을 유지하고 신규 코드에 대해서 구체적으로 책임을 지는 데 중점을 둠
- SonarQube를 통해 높은 표준을 설정하고 자신이 작성한 코드가 해당 표준을 충족한다는 것에 자부심을 가질 수 있게 함

**features**

- [Focus on New Code](https://docs.sonarqube.org/latest/project-administration/new-code-period/)
  - 항상 신규 코드(새로운 기간에 추가되거나 변경된 코드)에 초점을 맞추고, 오늘 작성한 코드가 clean하고 safe한지 확인
  - 신규 코드 기간은 다른 레벨로 설정이 가능(전체, 프로젝트별, 브랜치별)
- [Personal Responsibility](https://docs.sonarqube.org/latest/user-guide/issues/)
  - 신규 코드에 대해서만 측정하므로 다른 사용자의 코드에 대한 책임이 없음
  - 새로운 이슈가 추가되면 SonarQube는 자동으로 담당자에게 이슈를 할당해줌
- [Quality Gate](https://docs.sonarqube.org/latest/user-guide/quality-gates/)
- [Pull Request Analysis](https://docs.sonarqube.org/latest/analysis/pull-request/)
  - PR에 대해서 merge 전에 표준을 충족하는지 확인할 수 있음
  - PR 별로 QG을 볼 수 있음
  - 

## 조건 항목

> 자세한 내용은 [Metric Definitions](https://github.com/wicksome/TIL/blob/master/sonarqube/metric-definitions.md) 참고

### 커버리지

- 조건 커버리지(Condition coverage)
- Conditions to cover
- 구문 커버리지(Line coverage)
- Lines to cover
- Uncovered conditions
- Uncovered lines

### 코드 중복

- Duplicated blocks
- Duplicated lines
- Duplicated lines (%)

### Issue

- Blocker issues
- Critical issues
- Info issues
- Issues
- Major issues
- Minor issues

### 유지보수성

- Added Technical Debt
- 유지보수성 등급
- 코드 악취
- 기술 부채 비율

### 신뢰성
- Bugs
- 신뢰성 등급
- 신뢰성 개선 필요 공수

### 보안성
- 취약점
- 보안성 등급
- 보안성 개선 필요 공부

### Security Review
- Security Hotspots Reviewed
- Security Review Rating

### 사이즈
- Lines

# See Also

- [Quality Gates](https://docs.sonarqube.org/latest/user-guide/quality-gates/) - SonarQube Docs
- [Metric Definitions](https://docs.sonarqube.org/latest/user-guide/metric-definitions/) - SonarQube Docs
