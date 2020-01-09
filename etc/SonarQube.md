# SonarQube
> SonarSource에서 개발한 오픈소스 코드 품질 관리 플랫폼.(정적 분석 툴)

[GitHub](https://github.com/SonarSource/sonarqube), [DEMO](https://sonarqube.com/dashboard?id=com.icegreen%3Agreenmail-parent)

![SonarQube Demo](https://blog.sonarsource.com/wp-content/uploads/2016/01/Selection_999179-571x500.png)

## 요약

- 정적 분석 툴(CheckStyle, FindBugs, PMD, ...)을 Plug-in으로 제공
- 각종 Plug-in의 결과를 통합해서 직관적인 UI의 Dashboard로 확인(= 코드 가시화)
- 분석 결과를 DB에 저장하기 때문에 코드 품질이 어떻게 변하는지 확인 가능
- 코드 품질 지표를 실시간으로 확인
- webhook 제공

## 구조

![SonarQube Architecture](https://docs.sonarqube.org/download/attachments/6961766/SQArchitecture5.5.png?version=1&modificationDate=1459863102000&api=v2) https://docs.sonarqube.org/display/SONARQUBE56/Architecture+and+Integration

## Work Flow

![Integration with SonarQube](https://docs.sonarqube.org/download/attachments/6961766/SQ55Integration.png?version=1&modificationDate=1459863190000&api=v2)

**SonarLint 사용(local)**

1. IntelliJ에서 SonarQube(SQ) 플러그인으로 코드 분석

**대시보드 사용 시나리오**

1. OSS에 Code Commit
2. Jenkins에서..
	1. SQ Scanners로 코드 분석(테스트 -> 정적 분석), 결과는 SQ Server로 전달
	2. SQ에서 문제 발생하면 Jenkins는 빌드 취소(webhook 활용)
	2. 이상없으면 Jenkins는 단순 빌드/컴파일 작업만 실행, 배포
3. SQ Server에서 각종 정보 가시화 및 DB 저장
4. 대시보드를 통한 코드 품질 모니터링

## 특징

*SonarQube 홈페이지 내용을 위주로 정리*

**장점 및 특징**

- 클린 코드 작성을 도와줌 -> 지속적인 품질 향상
	- Dashboard를 통해 품질(잠재적 버그, 코딩 규칙, 테스트, 중복, 주석, 아키텍처 및 설계, 복잡도) 가시화, 직관적인 UI
	- 문제가 있는 코드에 대한 정보를 한번에 확인 가능(코드 작성자, 코드 이슈, 이슈 수준 등)
	- 품질 게이트 적용: 품질 지표값이 목표 조건에 만족하지 못할 경우 빌드를 실패케 하여 품질 기대 수준에 합격한 애플리케이션만 배포하도록 가능.
	- pull reuqest 분석
	- 기술 부채 확인
- 버그 예방
	- 잘못된 코드나 버그 가능성이 큰 코드를 찾음(e.g. null 포인터 역참조, 메모리 누출, 논리 오류 등)
	- 냄새나는 코드(e.g. 중복된 코드) 확인
	- 보안 취약점 추적(e.g. SQL주입, 하드 코딩된 암호 등)
	- 모든 실행 경로 탐색
	- 코드 분석하는 품질 프로파일에 필요한 규칙만 활성화 가능
- 다양한 언어 제공(Java, C, JavaScript, ...)
- 데브옵스 통합<sup>[(1)](#1)</sup>
	- 빌드시스템: maven과 통합 가능
	- CI 엔진: 젠킨스와 연동
	- webhook을 활용하여 Quality Gate를 통과하는 artifacts만 배포할 수 있음
	- 여러가지 분석 툴(플러그인으로 제공)을 통합하여 한번에 검사 가능<br>(Checkstyle, PMD, FindBugs, CPPCheck, Cobertura 등)

**단점**

- 하나의 작업에 하나의 언어만을 분석할 수 있다 -> 동일 소스를 대상으로 해당 언어 만큼 작업을 실행해야하는 단점.

## SonarQube vs CI

- Jenkins는 빌드 프로세스를 관리하는 CI 서버
- Maven은 빌드 툴
- SQ는 코드 품질 관리 툴
	- Scanner(각종 플러그인 사용)가 정적 분석

## 사용 관련 링크

**SonarQube**

- [Requirements](https://docs.sonarqube.org/display/SONAR/Requirements)
- [Installation](https://docs.sonarqube.org/display/SONAR/Setup+and+Upgrade)

**Etc**

- plugin for IntelliJ IDEA ([링크](https://plugins.jetbrains.com/idea/plugin/7238-sonarqube-community-plugin))
- plugin for Jenkins ([링크](https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner+for+Jenkins))
Jenkins 빌드 시 Sonar 서버로 전송되어 분석이 이뤄진다.
- Sonar 크롬 확장 프로그램 - [링크](https://chrome.google.com/webstore/detail/sonar/dibilcjfahbokhiodajibcajcabfjein)
- plugin for GitHub ([링크](https://docs.sonarqube.org/display/PLUG/GitHub+Plugin))
풀 리퀘스트 시 커멘트로 달아준다.

![그림](https://docs.sonarqube.org/download/attachments/5311422/PullRequestAnalysis.png?version=2&modificationDate=1434545380000&api=v2&effects=drop-shadow)

## Installation

> CentOS 6.8 64Bit, 4vCPU, 8GB Mem

### JAVA - jdk8

**설치 및 링크 설정**

```sh
$ wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz
$ cd && mkdir apps
$ tar xvfz jdk-8u121-linux-x64.tar.gz -C /home/yj/apps
$ cd apps && ln -s jdk1.8.0._121 jdk
```

**.bashrc 수정**

```sh
export APP_HOME=/home/yj
export JAVA_HOME=${APP_HOME}/apps/jdk8
export PATH=${JAVA_HOME}/bin:$PATH
```

### DB - MySQL(InnoDB)

- https://dev.mysql.com/doc/refman/5.7/en/linux-installation-yum-repo.html
- http://www.tecmint.com/install-latest-mysql-on-rhel-centos-and-fedora/

```sh
$ cd && wget http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
$ sudo rpm -Uvh mysql57-community-release-el7-9.noarch.rpm
$ sudo yum install mysql-community-server
```


#### Troubleshooting

##### `yum install mysql-server`에서 아래와 같은 에러 발생

```bash
** Found 3 pre-existing rpmdb problem(s), 'yum check' output follows:
2:postfix-2.6.6-6.el6_7.1.x86_64 has missing requires of libmysqlclient.so.16()(64bit)
2:postfix-2.6.6-6.el6_7.1.x86_64 has missing requires of libmysqlclient.so.16(libmysqlclient_16)(64bit)
2:postfix-2.6.6-6.el6_7.1.x86_64 has missing requires of mysql-libs
```

```sh
$ wget ftp://rpmfind.net/linux/centos/6.8/os/x86_64/Packages/mysql-libs-5.1.73-7.el6.x86_64.rpm

```

##### 에러

```sh
mysql: error while loading shared libraries: libmysqlclient.so.16: cannot open shared object file: No such file or directory
```







## 참고 자료

- <a name="1"></a>(1) 데브옵스란 무엇입니까?: https://aws.amazon.com/ko/devops/what-is-devops/
- Jenkins와 SonarQube 연동 - http://pseg.or.kr/pseg/infouse/4882
- 스크린샷으로 보는 SonarQube v5.2 - http://moseskim.github.io/sonarqube/2015/11/29/sq-5_2_release.html
- SonarQube in Action PDF - http://dl.finebook.ir/book/6d/12427.pdf
- sonar-vs-jenkins - http://stackoverflow.com/questions/14460275/sonar-vs-jenkins
- SonarQube를 이용한 지속적인 품질 관리 - http://www.nextree.co.kr/p2963/
- 리눅스 환경에서 SonarQube 간단하게 사용해보기 - http://www.slideshare.net/flashscope/sonarqube

