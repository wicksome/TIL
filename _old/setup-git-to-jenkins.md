---
title: Jenkins에 GIT 연동하기
date: 2018-04-27 15:40:00
tags:
  - git
  - jenkins
desc: setup git for jenkins
---

<!-- more -->

## 연동

연동하는 방법은 3 가지

- 로그인
- ssh
- token

## ssh 연동 방법

- git 에는 public 키를

```
$ cat id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8MDc1aGI1/UMV0SNMlCh4Z2nkNlNHFneJpH9OxjrLioMFby5qTf48EUo0WP1SsUQz8b5NBr2N5KeIzIq6sduKCCb1DmeRSuclqMfxMZHG+PzhIqwtZCX7JP+Z1RtxB7AzxGFIR/wIgwVlRPNgXXR6IkN4HLY+6EJ/t5JAqjdOuY2ouw7oTEqkJk4Rs64eQPtgh+qujItqHB8+8+BGXDp3ytKm6tmfQbGAxiBhWv+PbDCqeFIa6DCHr/IVMECDUEpzL3EZ5QgVhptwnJlzErfUHUlvCF0noXr0G5FPmOiOuy5Nt yj@jenkins_contact-ci.1
```

요기까지

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8MDc1aGI1/UMV0SNMlCh4Z2nkNlNHFneJpH9OxjrLioMFby5qTf48EUo0WP1SsUQz8b5NBr2N5KeIzIq6sduKCCb1DmeRSuclqMfxMZHG+PzhIqwtZCX7JP+Z1RtxB7AzxGFIR/YTfw3y1JUpNSUwIgwVlRPNgXXR6IkN4HLY+6EJ/t5JAqjdOuY2ouw7oTEqkJk4Rs64eQPtgh+qujItqHB8+8+BGXDp3ytKm6tmfQbGAxiBhWv+PbDCqeFIa6DCHr/IVMECDUEpzL3EZ5QgVhptwnJlzErfUHUlvCF0noXr0G5FPmOiOuy5Nt
```

- jenkins 에는 private 키를

전체 모두 추가

```
$ cat id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAvDA3NWhiNf1DFdEjTJQoeGdp5DZTRxZ3iaR/TsY6y4qDBW8u
...
gqNlgoaADvRTmas5hjAEFlW5syPd2TgSq6/jbj6PcidyJNqFKKiyCw==
-----END RSA PRIVATE KEY-----
```

## 참고

한번 등록된 키는 재사용 불가

## References

- http://moseskim.github.io/sonarqube/2016/04/18/stop‑planning‑fix‑the‑leak.html
- SonarQube in Action PDF ‑ http://dl.finebook.ir/book/6d/12427.pdf
- SonarQube 를 이용한 지속적인 품질 관리 ‑ http://www.nextree.co.kr/p2963/NHN
- [Quality Practice 적용 사례](https://www.sw.or.kr/ftp/conference/3_주제_3_Quality Practice 적용사례\_NHN.pdf)
