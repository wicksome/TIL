# apache

파일 다운로드 되도록 설정 추가

- 무조건 다운로드되도록 헤더 추가
- 사파리에서 xls 파일 다운로드가 아닌 열기로 실행되는 문제

```
<Location /static/download>
  Header add Content-Disposition "attachment;"
</Location>
```

# nginx

- https://stackoverflow.com/questions/11973047/adding-and-using-header-http-in-nginx
