# mysql Database

**mysql 설치**

```shell
# 1. Homebrew 설치 - http://brew.sh/index_ko.html
# 2. mysql 설치
$ brew install mysql
# 3. mysql 실행/접속
$ mysql.server restart
$ mysql -u root
```



**mysql 설정**

```shell
# root 패스워드 변경
$ mysql_secure_installation

# 패스워드 강도를 높였을 때 변경 방법
$ mysql -u root -p
mysql> SHOW VARIABLES LIKE 'validate_password%';
+--------------------------------------+--------+
| Variable_name                        | Value  |
+--------------------------------------+--------+
| validate_password_check_user_name    | OFF    |
| validate_password_dictionary_file    |        |
| validate_password_length             | 8      |
| validate_password_mixed_case_count   | 1      |
| validate_password_number_count       | 1      |
| validate_password_policy             | MEDIUM |
| validate_password_special_char_count | 1      |
+--------------------------------------+--------+
7 rows in set (0.01 sec)

mysql> SET GLOBAL validate_password_policy=LOW;
```

* brew로 설치시 환경변수 지정 필요 없음
* charset 기본값이 utf-8이라 따로 변경하지 않음





**참고**

- [Install MySQL on Mac OSX using Homebrew](https://blog.joefallon.net/2013/10/install-mysql-on-mac-osx-using-homebrew/)
- [맥에서 mysql 설치 후 환경설정하기](https://github.com/helloheesu/SecretlyGreatly/wiki/맥에서-mysql-설치-후-환경설정하기)




## mysql 모듈

```shell
$ npm install mysql
```



**연결**

```json
var mysql = require('mysql');
var client = mysql.createConnection({
    user: 'root', // 필수
    password: 'password', // 필수
    // host
    // port
    // database 연결할 데이터베이스
    // debug 디버그 모드 사용 여부
});
```



**쿼리**

```javascript
client.query('USE Company');
client.query('SELECT * FROM products', function(error, result, fields) {
    if (error) {
        console.log('query error');
    } else {
        console.log(result);
    }
});
// ? 토큰
client.query('INSERT INTO products (name) VALUES (?)', ['test'], function(error, results, fields) {
    if (error) {
        console.log('query error');
    } else {
        console.log(results);
    }
});
```

