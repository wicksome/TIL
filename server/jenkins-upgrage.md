# 젠킨스 업그레이드

1. https://jenkins.io/ 에서 jenkins.war 파일 다운로드
2. 서버 작업

```sh
# 톰캣 정지
$ tomcat/bin/shutdown.sh

# 이전 버전  war, dir 백업
$ mv jenkins.war jenkins.war.old
$ mv jenkins jenkins.war

# 새로운 버전 이동
$ mv jenkins.war /tomcat/webapps

# 톰캣 재시작
$ tomcat/bin/startup.sh
```