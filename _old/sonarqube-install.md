---
title: SonarQube 설치
date: 2018-01-12 01:00:00
tags:
  - sonarqube
  - quality
desc: install sonarqube
---

<center><img src="https://www.sonarsource.com/images/common/sonarqube-logo-black.svg"></center>

> open source quality management platform

이번에 서버를 새로 받으면서 버전업도 하고 설치 순서도 다시 정리해보려한다. 소나큐브란 코드 중복, 유닛 테스트, 복잡고, 코딩 규칙, 취약점등 프로젝트의 품질을 관리할 수 있는 정적 분석 도구이다. 소나큐브에 대한 자세한 내용은 [문서](https://docs.sonarqube.org/display/SONAR/Documentation)를 참고하자. 공식적이진 않지만, [한국어 문서](https://sonarqubekr.atlassian.net/wiki/spaces/SON/overview)도 정말 잘 되어 있다 👍

<!-- more -->

**Feature**

- 정적 분석 툴(CheckStyle, FindBugs, PMD, ...)을 Plug‑in 으로 제공
- 각종 Plug‑in 의 결과를 통합해서 직관적인 UI 의 Dashboard 로 확인
- 코드 품질 지표를 실시간으로 확인
- webhook 제공
- 프로젝트를 한눈에 보기(관리자를 위한 도구?)
- 보안성: https://docs.sonarqube.org/display/SONAR/Security‑related+rules

**정적분석을 통해 발견되는 결함**

- 정의되지 않은 값으로 변수 참조
- 모듈과 컴포넌트 간에 일관되지 않은 인터페이스
- 사용되지 않는 변수
- 사용되지 않는 코드 (Dead Code)
- 코딩 표준 위반
- 보안 취약성
- 코드와 소프트웨어 모델의 syntax 위반

**Structure**

![SonarQube Structure](https://docs.sonarqube.org/download/attachments/6961766/SQArchitecture5.5.png?version=1&modificationDate=1459863102000&api=v2)

https://docs.sonarqube.org/display/SONARQUBE56/Architecture+and+Integration

**Work Flow**

![workflow](https://docs.sonarqube.org/download/attachments/6961766/SQ55Integration.png?version=1&modificationDate=1459863190000&api=v2)

- SonarQube: 분석 결과 관리
- SonarQube Scanner: 코드 분석
  - CheckStyle: 코딩 룰을 잘 따르고 있는지 분석
  - FindBugs: 잠재적인 에러 타입 검사
  - PMD: 미사용 변수, 비어있는 코드 블락, 불필요한 오브젝트 생성과 같은 Defect 을 유발할 수 있는 코드를 검사
  - Junit

## Requirements

> https://docs.sonarqube.org/display/SONAR/Requirements

- JAVA 8
- DB

#### OS 확인

```bash
$ cat /etc/*-release | uniq
CentOS release 6.9 (Final)
#DO NOT remove/modify this file.
Ncloud 1.1
IDC="krlgp"
PRODUCT="Internal"
SERVICE="NAVER"
CentOS release 6.9 (Final)
$ uname -m
x86_64
```

#### Java 설치

[여기](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)서 Java 다운로드 링크 복사.

```bash
$ cd
$ mkdir apps && cd apps
$ wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz
$ tar -xvzf jdk-8u151-linux-x64.tar.gz && rm jdk-8u151-linux-x64.tar.gz
$ ln -s ./jdk1.8.0_151/ ~/apps/jdk8
```

환경변수 설정.

```bash
export JAVA_HOME="/yeongjun/jdk8"
export PATH="${JAVA_HOME}/bin:$PATH"
```

**Reference:**

- https://tecadmin.net/install-java-8-on-centos-rhel-and-fedora/
- https://www.linode.com/docs/development/install-java-on-centos

#### MySQL 설치

사내 DB 스크립트로 설치했다.. 그레서 MySQL 은 구글링을 통해...🙏

## SonarQube

#### Install SonarQube

```bash
$ cd ~/apps/
$ wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-6.7.zip
$ unzip sonarqube-6.7.1.zip && rm sonarqube-6.7.1.zip
$ ln -s ./sonarqube-6.7.1 ./sonarqube
```

**Reference:**

- https://www.sonarqube.org/
- https://docs.sonarqube.org/display/SONAR/Installing+the+Server

#### Settings MySQL

Create sonar, allow external access.

```
$ mysql -u root
mysql> use mysql;
mysql> INSERT INTO user(host,user,authentication_string,ssl_cipher,x509_issuer,x509_subject) VALUES('%','sonar',password('sonar'),'','','');
mysql> GRANT ALL PRIVILEGES ON *.* TO 'sonar'@'%';
mysql> FLUSH PRIVILEGES;
mysql> CREATE DATABASE sonarqube CHARACTER SET utf8 COLLATE utf8_bin;
```

#### Settings SonarQube

```bash
cd ~/apps/sonarqube/conf
vi sonar.properties
```

```
...
sonar.jdbc.username=sonar
sonar.jdbc.password=sonar
...
sonar.jdbc.url=jdbc:mysql://localhost:13306/sonarqube?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance
...
sonar.web.host=10.111.111.11
sonar.web.port=15001
```

#### Run SonarQube

```
$ cd ~/apps/sonarqube/bin/linux-x86-64
$ ./sonar.sh start
```

## Result

![works sonarqube](https://user-images.githubusercontent.com/5036939/34835783-3777b054-f739-11e7-8d12-8272cd67b1ea.png)

(DNS, SSL 설정, 사내 링크, 각종 셋팅을 모두 지우고나니 명령어 몇개 밖에 없고, 이게 가이드인지..😱)

도입하기 전에는 IntelliJ 에 [FindBug](http://findbugs.sourceforge.net/), [Checkstyle](http://checkstyle.sourceforge.net/), [JUnit](http://junit.org/) 따로따로 실행하고 확인했었는데, [SonarQube IntelliJ Community Plugin](https://github.com/sonar-intellij-plugin/sonar-intellij-plugin)을 통해 한번에 확인 가능하고, 주니어 입장에서 코드 한줄한줄 리뷰 받는 느낌이다..

앞으로 SonarQube 를 통해서... QP(Quality Practice: 소스코드의 정적 분석 결과, 코드 복잡도, 코드 커버리지 개선을 통해 소프트웨어 품질을 높이는 활동)를 신경써보자. 마지막으로 와닿은 말([참고](https://prezi.com/rv_ce5akpvq6/quality-practice/))..

- QP 활동은 개발자 부담을 늘리기 위한 것이 아닙니다.
- QP 도구를 활용해 문제를 사전에 발견해 조치할 수 있습니다.
- QP 지수를 통해 현재 품질 상태를 파악할 수 있습니다.
- QP 를 통해 좋은 품질의 소프트웨어를 만듭시다.

> **나중은 결코 오지 않는다 ‑ 르블랑의법칙**

## References

- http://moseskim.github.io/sonarqube/2016/04/18/stop‑planning‑fix‑the‑leak.html
- SonarQube in Action PDF ‑ http://dl.finebook.ir/book/6d/12427.pdf
- SonarQube 를 이용한 지속적인 품질 관리 ‑ http://www.nextree.co.kr/p2963/NHN
- [Quality Practice 적용 사례](https://www.sw.or.kr/ftp/conference/3_주제_3_Quality Practice 적용사례\_NHN.pdf)
