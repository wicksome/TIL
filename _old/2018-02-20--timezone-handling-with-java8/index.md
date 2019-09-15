---
title: Java8에서 TimeZone 다루기
date: "2018-02-20T23:30:00+09:00"
updated: "2018-02-21T17:50:00+09:00"
layout: post
path: /blog/timezone-handling-with-java8
tags: java, java8, timezone
draft: false
---
<br/>

> **📍용어 정리**
> ### TimeZone
> 타임존은 여러 가지 다른 것을 설명하는 데 사용할 수 있지만 대개 지역 또는 국가의 현지 시간을 나타내며, 주로 해당 국가에
> 의해 법적으로 지정된다. GMT와 UTC는 같은 시간을 공유하고(동일하진 않고 초의 소숫점단위에서 차이가 난다) 혼용되서 사용되지만
> 엄밀히 구분하자면 다르다.
> 
> "GMT is a <b>time zone</b> and UTC is a <b>time standard</b>."
>
> ### GMT
> Greenwich Mean Time<sup>GMT</sup>는 경도 0도에 위치한 영국 런던 그리니치에 있는 왕립 천문대의 시간으로, 모든 시간대의 시작점을
> 나타내며, 일년내내 Daylight Saving Time<sup>DST</sup>의 영향을 받지 않는다. GMT는 1925년 2월 5일부터 사용하기 시작했으며, 1972년
> 1월 1일까지 세계 표준시로 사용되었다.
>
> ### UTC
> UTC(협정 세계시, 協定世界時)는 국제 표준시로 타임존이 아니다. 즉, UTC를 공식적으로 현지 시간으로 사용하는 국가나 지역은
> 없다. 협정 세계시를 영어권에서는 Coordinated Universal Time<sup>CUT</sup>라고, 프랑스어권에서는 Temps Universel Coordonné<sup>TUC</sup>라고
> 하는데, 혼돈을 방지하기 위해서 공식적으로 UTC라고 정해졌다.
> 
> ### DST
> Daylight Saving time<sup>DST</sup>은 자연 일광을 보다 잘 활용하기 위해서 여름철에 표준 시간에서 1시간 앞으로, 그리고 다시 가을에 시간을 1시간 전으로 설정하는
> 것을 말한다. DST와 "summer time"은 같은 말을 뜻하며 특정 나라에서 주로 불린다. 영국에서 썸머타임이라고 많이 사용하며, DST가 적용되지 않는 표준시는
> "winter time"이라고 사용되기도 한다. DST를 독일에서는 "sommerzeit", 스칸디나비아에서는 "sommertid"라고도 사용한다.

## Java8의 타임존

Time-Zone은 정부에 의해 변경되는 경우가 있는데, Java는 [IANA 데이터베이스](https://www.iana.org/time-zones)를 사용하고, 따로 버전업 없이
독립적으로 시간대 데이터베이스를 업데이트 한다. 즉, 하드코딩으로 관리하지 않아도 된다. 또한, Java8에서는 타임존, DST를 좀 더 편하게 사용하기 위해
`ZoneId`, `ZonedDateTime`, `LocalDateTime` 등이 추가되었다. 이용할 수 있는 Time-Zone은 `ZoneId.getAvilableIds()`로 확인할 수 있으며,
현재 시점 등록된 ID는 600개이다.

| class               | desc                                             |
| ------------------- | ------------------------------------------------ |
| `ZoneId`            | 시간대를 나타낸다.                               |
| `LocalDateTime`     | 지역 시간을 나타낸다. 즉, 시간대 정보가 없다.    |
| `ZonedDateTime`     | 구역 시간을 나타낸다.                            |
| `TemporalAdjuster`  | 달력 계산에 사용한다. (e.g. 다음 달의 첫번째 날) |
| `DateTimeFormatter` | 날짜와 시간의 서식을 지정하기 위해 사용한다.     |

아래는 타임존 관련된 몇 가지 예제이다.

## 사용자에게 타임존(+offset)을 표시할 때 어떻게 보여줄 것인가?

```
GMT-04:00 Santiago
GMT+09:00 Seoul
GMT+10:00 Sydney
```

위와 같이 출력하고자 할 경우 아래와 같다.

```java
// 현재 시간 기준(2018/03/21)
final List<ZoneId> timeZones = new ArrayList<>();
timeZones.add(ZoneId.of("America/Santiago"));
timeZones.add(ZoneId.of("Asia/Seoul"));
timeZones.add(ZoneId.of("Australia/Sydney"));

timeZones.forEach(zoneId -> {
    final ZoneOffset offset = zoneId.getRules().getStandardOffset(Instant.now());
    System.out.println(String.format("GMT%s %s", offset.getId(), zoneId.getId().split("/")[1]));
});
```

위 코드에는 한 가지 이슈가 있다. 현재 시점(2018년 2월 21일)에 Santiago는 DST가 시행중으로 offset은 1시간 당긴 `-03:00`이다. 하지만, `getStandardOffset()`은 표준 오프셋을 가져오므로 `-04:00`를 출력한다(Sydney도 동일하다). 아래와 같이 `offset`을 선언하면 DST가 적용된 offset을 가져올 수 있다.

```java
final ZoneOffset offset = LocalDateTime.now().atZone(zoneId).getOffset();
```

> **📍생각해보기**
>
> 이 [글](https://www.timeanddate.com/time/gmt-utc-time.html)에서 GMT는 DST로 변하지 않는다고 말한다. 그러면 위 코드처럼 DST가 적용된 시간을 `GMT{offset}`으로 출력해도 되는가? 여러가지 생각해봤지만 어느것이 맞는지 더 찾아봐야겠다.
> - 각 나라의 표준시를 보여줄 것인가?
> - DST를 적용한 GMT를 보여줄 것인가?
> - DST를 적용한 UTC를 보여줄 것인가?
> - 따로 DST 적용기간 아이콘을 보여줄 것인가?
>
> 구글 캘린더에서는 `(GMT-03:00) 산티아고`라고 DST를 적용한 GMT시간을 보여준다.

## `LocalDateTime`에 `ZoneId` 설정하기

특정 지역 시간(localDateTime)에 Zone-ID를 추가하려면 아래와 같다.

```
localDateTime.atZone(ZoneId zoneId);
ZonedDateTime.of(LocalDateTime localDateTime, ZoneId zoneId);
```

_예제_

```java
final LocalDateTime localDateTime = LocalDateTime.of(2017, Month.OCTOBER, 18, 9, 0);
final ZonedDateTime zonedDateTime1 = localDateTime.atZone(ZoneId.of("UTC"));
final ZonedDateTime zonedDateTime2 = ZonedDateTime.of(localDateTime, ZoneId.of("Asia/Seoul"));
System.out.println(zonedDateTime1);
System.out.println(zonedDateTime2);
```

```
2017-10-18T09:00Z[UTC]
2017-10-18T09:00+09:00[Asia/Seoul]
```

**참고**

아래 코드와 같은 실수는 하지말자. `atZone()`은 Zone 정보만 추가할뿐 시간을 변경하지 않는다. 그러므로 `localDateTime1`과 `localDateTime2`는 동일하다.

```java
final LocalDateTime localDateTime1 = localDateTime.atZone(seoul).toLocalDateTime();
final LocalDateTime localDateTime2 = localDateTime.atZone(utc).toLocalDateTime();
```

#### 특정 구역 시간의 다른 구역 시간 구하기

예를 들어, 로스앤젤레스 시간으로 오전 9시가 서울 시간으로 몇시일지 확인하려고 하려고 한다. 아래와 같이 `withZoneSameInstant(ZoneId)`를 사용하여 시간을 구할 수 있다.

```java
final LocalDateTime localDateTime = LocalDateTime.of(2017, Month.OCTOBER, 18, 9, 0);
final ZonedDateTime losAngeles = localDateTime.atZone(ZoneId.of("America/Los_Angeles"));
final ZonedDateTime seoul = losAngeles.withZoneSameInstant(ZoneId.of("Asia/Seoul"));
System.out.println(seoul.toLocalDateTime());
```

#### 시간대(`ZoneId`) 변경하기

시간대만 변경하고자할 땐, `withZoneSameLocal(ZoneId)`를 사용한다. 즉, 아래 코드에서 `losAngeles`와 `seoul`의 `localDateTime`은 같다.

```java
final LocalDateTime localDateTime = LocalDateTime.of(2017, Month.OCTOBER, 18, 9, 0);
final ZonedDateTime losAngeles = localDateTime.atZone(ZoneId.of("America/Los_Angeles"));
final ZonedDateTime seoul = losAngeles.withZoneSameLocal(ZoneId.of("Asia/Seoul"));
System.out.println(losAngeles);
System.out.println(seoul);
```

```
2017-10-18T09:00-07:00[America/Los_Angeles]
2017-10-18T09:00+09:00[Asia/Seoul]
```

#### 1주일뒤 회의시간 예약하기

예를 들어, Santiago에서 2018년 5월 10일 10시 기준으로 7주일 이후에 회의를 잡으려고 한다. 이 경우에는 `Period.ofDays(int)`을 사용한다.

```java
// santiago 2018/05/13 00:00:00 이후로 DST 적용
final ZonedDateTime now = ZonedDateTime.of(2018, 5, 10, 10, 0, 0, 0, ZoneId.of("America/Santiago"));
final ZonedDateTime nextMeeting = now.plus(Period.ofDays(7));

System.out.println(now);
System.out.println(nextMeeting);
```

```
2018-05-10T10:00-03:00[America/Santiago]
2018-05-17T10:00-04:00[America/Santiago]
```

만약 `Duration`을 사용했다면 Santiago의 DST가 적용되지 잘못된 시간에 회의를 예약하게 된다.

```java
final ZonedDateTime nextMeeting = now.plus(Duration.ofDays(7));
System.out.println(nextMeeting);
```

```
2018-05-17T09:00-04:00[America/Santiago]
```

## References

- timeanddate - What is a Time Zone?: https://www.timeanddate.com/time/time-zones.html
- 위키피디아 - 시간대: https://ko.wikipedia.org/wiki/시간대
- https://greenwichmeantime.com/what-is-gmt/
- https://www.timeanddate.com/time/gmt-utc-time.html
- https://community.akamai.com/groups/korea-user-group/blog/2015/06/30/gmt-vs-utc
- https://www.timeanddate.com/time/utc-abbreviation.html
- https://www.timeanddate.com/time/dst/
- https://www.timeanddate.com/time/dst/summer-time.html
- https://docs.oracle.com/javase/8/docs/api/java/time/ZoneId.html
- http://d2.naver.com/helloworld/645609
- Java 8 이전 버전에서 시간 다루기: https://www.mkyong.com/java/java-convert-date-and-time-between-timezone/
- Toast - 자바스크립트에서 타임존 다루기 (1): http://meetup.toast.com/posts/125
