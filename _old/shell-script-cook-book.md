---
title: Shell Script Cookbook
date: 2018-02-21 15:20:00
updated: 2018-02-21 15:20:00
tags:
- shell script
- bash
desc: Shell Script Cookbook
---

> 두번 작성하기 귀찮아서 모아놓은 스크립트

#### 2018-02-21 05:00 ~ 2018-02-21 05:09 로그 보기

```bash
grep -E "^2018-02-21 05:0[0-9]:[0-9]{2} " catalina.out > temp.$(hostname).out
```
