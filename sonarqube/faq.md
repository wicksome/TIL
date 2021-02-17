### 1. Dependency-Check 플러그인을 사용할 수 없나요?

먼저 SonarQube의 [Dependency-Check 플러그인](https://github.com/dependency-check/dependency-check-sonar-plugin)은 빌드 단계에서 만들어진 html 리포트를 해당 프로젝트에서 보여주는 용도만 제공합니다. 빌드 단계에서 [dependency-check-gradle](https://search.maven.org/artifact/org.owasp/dependency-check-gradle/6.1.0/gradle-plugin)을 사용할 경우 외부 API를 통해 분석에 필요한 데이터를 가져오는데, 전금법망내에서 외부 통신이 안되므로 현재 사용할 수 없습니다. 대체재로 Toothless를 사용하면 cve-search를 통해 오픈소스 취약점 확인을 제공합니다.

### 2. 왜 SonarQube Scanner CLI를 사용했나요?

> 개인적인 고민의 결과이므로 개인 혹은 팀의 의견에 따라 변경될 수 있습니다.

이전에는 maven의 `mvn sonar:sonar goal`을 추가해서 사용했으나 분석 설정 변경이 있을 때 빌드와 관련이 없어도 `pom.xml`을 수정해야 했고, 초기 구축 단계에서 분석 설정 변경이 있을 때마다 PR을 생성해야 하는 불편함이 있었습니다. 

### 3. Pipeline이 뭔가요?

가이드내에 자주 업급되는 Pipeline(or Pipeline Script)는 Jenkins의 Pipeline을 의미합니다. Declarative 혹은 Scripted Pipeline은 software delivery pipeline의 일부를 작성한 DSL입니다. `Scripted Pipeline`은 일부 제한된 형태의 Groovy 문법으로 작성하며, `Declarative Pipeline`은 최근 Jenkins Pipelie에 추가된 것으로 기존에 제공하던 `Scriped Pipeline` 보다 비교적 단순하고 Jenkins와 관련된 기능을 제공하는 파이프라인입니다.

### 4. 왜 Pipeline 스크립트를 사용했나요?

> 개인적인 고민의 결과이므로 개인 혹은 팀의 의견에 따라 변경될 수 있습니다.

Freestyle project를 사용할 경우 UI를 통해 누구나 설정이 가능하지만 형상관리가 어려웠습니다. 이에 반해 Pipeline은 초기 학습비용이 들지만 `Jenkinsfile`로 저장하여 형상관리가 가능하고, 각 stage 별로 실행시간도 확인할 수 있습니다. 또한 [Blue Ocean](https://www.jenkins.io/projects/blueocean/)과 연동되어 CD pipeline을 시각적으로 확인 할 수 있습니다.

### 5. 왜 Multibranch Pipeline을 사용했나요?

> 개인적인 고민의 결과이므로 개인 혹은 팀의 의견에 따라 변경될 수 있습니다.

이전엔 `master`, `develop` 브랜치는 webhook을 사용하고, PR 분석은 [GitHub Pull Request Builder](https://plugins.jenkins.io/ghprb/) 플러그인을 사용했었습니다. 하지만 GitHub Pull Request Builder 플러그인은 앞으로 [GitHub Branch Source Plugin](https://plugins.jenkins.io/github-branch-source/)로 마이그레이션 될 것이라 가이드하고 있었고, CI/CD를 운영하면서 2개의 작업을 관리해야하는 불편함도 있었습니다.

[[images/migrate-github-branch-plugin.png]]

[Multibranch Pipeline](https://plugins.jenkins.io/workflow-multibranch/)를 사용하면 하나의 저장소(repository)에 대해서 하나의 jenkins item으로 관리할 수 있었고, Jenkins에서 직접 폴더를 통해 PR을 구분하지 않아도 되며, 블루 오션 UI를 통해서도 명확하게 관리할 수 있었습니다.

#### 참고

- [Branches and Pull Requests](https://www.jenkins.io/doc/book/pipeline/multibranch/)
- GitHub 조직을 전체로 관리하려면 "GitHub Organization" 아이템으로 생성할 수 있습니다.
- Multibranch Pipeline에서 자동으로 추가되는 commit status를 없애기 위한 플러그인: [Disable GitHub Multibranch Status](https://plugins.jenkins.io/disable-github-multibranch-status/)
