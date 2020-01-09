---
title: 이펙티브자바 9장. 예외 (3)
layout: post
date: "2017-12-28T10:30:00+09:00"
path: /blog/effective-java-chapter-9-3
tags: java, effective java
desc: chapter 9. exceptions in effective java
draft: false
---

- [규칙 63](#63-어떤-오류인지를-드러내는-정보를-상세한-메시지에-담으라) - 어떤 오류인지를 드러내는 정보를 상세한 메시지에 담으라
- [규칙 64](#64-실패-원자성-달성을-위해-노력하라) - 실패 원자성 달성을 위해 노력하라
- [규칙 65](#65-예외를-무시하지-마라) - 예외를 무시하지 마라

> 아래 책를 참고하여 학습한 내용을 정리/기록한 포스트입니다. 자세한 내용은 책을 참고하시기 바라며, 문제가 있을 경우 연락 부탁드립니다.
>
> - 조슈아 블로크, 이병준(옮긴이), Effective Java, 2판, 인사이트, 2015.ul>
</div>

---

## 63. 어떤 오류인지를 드러내는 정보를 상세한 메시지에 담으라

- 오류 정보를 포착해 내기 위해서는, 오류의 상세 메시지(e.g. `toString()`)에 "예외에 관계된" 모든 인자와 필드의 값을 포함시켜야 한다.
- 오류 포착에 필요한 상세한 정보를 요구하는 생성자를 만드는 숙어를 추천한다.

```java
public IndexOutOfBoundsException(int lowerBound, int upperBound, int index) {
    super("Lower bound: " + lowerBound + ", Upper bound: " + upperBound + ", Index: " + index);
    // ...
}
```

---

## 64. 실패 원자성 달성을 위해 노력하라

> - 예외를 던지고 난 뒤에도 객체의 상태가 잘 정의된, 사용 가능한 상태로 남아있으면 좋다 => 실패원자성(failuer atomicity)
> - 실패 원자성은 일반적으로 권장되는 덕목이지만 언제나 달성할 수 있는 것은 아니다. (e.g. 여러 스레드에서 동기화 없이 동시에 변경할 경우)

**실패원자성을 달성하는 방법들**

- 변경 불가능한 객체로 설계
- 실패할 가능성있는 코드를 객체 상태를 바꾸는 코드 앞에 배치
- 연산 수행 도중에 발생하는 오류를 가로채는 복구 코드(recovery code) 작성
- 객체의 임시 복사본상에서 필요한 연산을 수행하고, 연산이 끝난 다음 복사본의 내용으로 객체 상태를 변경

---

## 65. 예외를 무시하지 마라

- 적어도 catch 블록 안에는 예외를 무시해도 괜찮은 이유라도 주석으로 남겨 두어야 한다.
- PMD: [EmptyCatchBlock](http://pmd.sourceforge.net/pmd-4.3.0/rules/basic.html)
