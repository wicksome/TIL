## Dump

#### 분석할 PID 조회

```bash
# jps: JVM Process Status tool
$ jps
5884 Jps
18565 Bootstrap

# options.
## -m: Output the arguments passed to the main method.
## -l: Output the full package name for the application's main class or the full  path name to the application's JAR file.
## -v: Output the arguments pass to the JVM.
$ jps -mlv
5884 sun.tools.jps.Jps -mlv -Dapplication.home=/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home -Xms8m
18565 org.apache.catalina.startup.Bootstrap start  -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Dfile.encoding=UTF-8 -Xms256m -Xmx1g -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/logs -XX:MaxTenuringThreshold=15 ...
```

- tomcat 은 실행시 bootstrap.jar 를 이용하기 때문에 bootstrap 으로 나온다.

---

## Thread

#### Thread 란

#### Thread 종류

## Thread dump

#### 쓰레드 덤프를 추출할때 좋은 경우
- 모든 시스템에 응답이 없을때- 사용자 수가 많지 않은데 cpu 사용량이 높을때- 특정 어플리케이션 수행시 응답이 없을때 - 간헐적으로 응답이 느릴때
- 서비스 실행시간이 길어질수록 응답시간이나 cpu 사용량이 늘어날때 등등

#### 덤프 생성

```bash
$ kill -3 [pid] # 가능하면 사용 비추천, 위험
$ jstack [pid] # jdk6
$ jcmd [pid] Thread.print # 가장 추천하는 방법 jdk7
```

**tip**

생성할 땐 반드시 3~4장을 연속으로 혹은 텀을 두고 생성

#### jcmd

```bash
$ jcmd [pid] help # 자신이 보여줄수있는 명령어 출력
$ jcmd [pid] Thread.dump > dump.log # thread dump
$ jcmd [pid] GC.heap_dump heap.log # heap dump
```

#### 스레드 정보

- 우선순위 오라클 문서에서 무시
- nid: os에서 부여하는 id
- pid: app에서 부여하는 id

#### Thread name

- 오픈소스를 보니 공통된 것은 없지만 목적을 정확히 길게 쓰더라
- `setName()`
- thread pool은 아쉽게도 이름 변경 불가능 -> 이름을 실행하기전에 주기적으로 변경(긴 작업인 경우에만, 덤프볼 때 오해할 수 있음)

#### Thread id

- tid: java process내에 threadBean을 이용해서 많은 정보를 가져올 수 있음(객체안에 얼마나 실행, 블락 등 정보 -> ThreadInfo인데 이것을 보려면 restApi나 jmx 활용해야 함)
- nid: ps

```
# 진수 변환
# 10진수 -> 16진수
$ echo "obase=16;10039" | bc # 2737# 16진수 -> 10진수$ echo $((0x2737)) # 10039
```

#### Thread state

#### jvisualvm

- http://jo.centis1504.net/?p=1681

---

## Heep Dump 뜨기

```sh
$ jmap dump:format=b,file=<output filename> <pid>
```

## 분석하기

[Eclipse MAT(Memory Analyzer)](http://www.eclipse.org/mat/)

- https://spoqa.github.io/2012/02/06/eclipse-mat.html
- http://d2.naver.com/helloworld/1326256
- http://byplacebo.tistory.com/25

> **macos에서 실행시 에러 발생하는 문제**
>
> `sudo open /Applications/mat.app`으로 실행

## 기타 참고

- [jvm-mon: Console based JVM monitoring](https://github.com/ajermakovics/jvm-mon)
