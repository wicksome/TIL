 # Express Framework

*micro framework*

> 프레임워크는 제어 역전(Inverse of Control, IoC) 방식으로 개발할 수 있게 하는 라이브러리를 의미합니다. … '개발자가 호출할 대상을 직접 지정하며 개발하는 것'을 제어라고 부르며 일반적인 라이브러리의 특성입니다. 그런데 라이브버리가 "일방 기본 구조를 만들어줄 테니까 개발자님은 제가 요구하는 부분만 작성해주세요"라고 한다면 제어가 역전된 것이며, 이러한 라이브러리를 '프레임워크'라고 부릅니다.



## Installation

```shell
$ sudo npm install -g express-generator // 관리자 권한으로 설치
```



## Usage

```shell
$ express [PROJECT_NAME] # 프로젝트 생성
$ cd [PROJECT_NAME] && npm install # 관련 모듈 설치
$ DEBUG=[PROJECT_NAME]:* npm start # 프로젝트 실행
```



***Note.*** `npm start`

*package.json* 파일에 scripts 객체의 start 속성에 적힌 명령이 실행되는 것.



***Note.*** express 옵션

```shell
$ express --help # express 옵션 확인
$ express --pug --git [PROJECT_NAME]
```



## Default Directory Structure

```shell
$ tree ./ -L 1
./
├── app.js
├── bin
├── node_modules
├── package.json
├── public
├── routes
└── views
```

**app.js**: 프로젝트의 중심이 되는 파일

**bin**: 프로그램의 실행과 관련된 파일 저장

**package.json**: 관련 정보와 모듈을 설치하는 데 필요한 내용을 저장

**public**: express 모듈의 static 미들웨어를 사용해 웹 서버에 올라가는 폴더(js, css, image, ...)

**routes**: 페이지 라우트와 관련된 모듈 저장

**views**: 템플릿 파일 저장



## app.js

### 서버 생성

```javascript
var express = require('express'),
    path = require('path'),
    favicon = require('serve-favicon'),
    logger = require('morgan'),
    cookieParser = require('cookie-parser'),
    session = require('express-session'),
    bodyParser = require('body-parser');

var app = express();
```



### 어플리케이션 설정

set() 은 express 프레임워크의 설정 옵션을 지정하는 메서드

```javascript
app.set('case sensitive routing', true); // 페이지 라우트할 때 대소문자 구분
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');
```



### 미들웨어 설정

```javascript
// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: false
}));
app.use(cookieParser());
app.use(session({
    secret: 'secret key',
    resave: false,
    saveUninitialized: true
}));
app.use(express.static(path.join(__dirname, 'public')));
```



### 페이지 라우트

```javascript
var index = require('./routes/index'),
    users = require('./routes/users');

app.use('/', index);
app.use('/users', users);
```

***Note.*** require('express')

여러 파일에서 같은 모듈을 추출하는 코드가 여러 개 있을 수 있다. 이 경우 모듈은 한 번만 추출되며 공유해서 사용된다.



## 페이지 렌더링

express 프레임워크는 자체적으로 File System 모듈을 사용해 페이지를 제공하는 render()을 제공한다.
폴더도 페이지를 분류할 수도 있으며, 폴더 이름을 지정할 경우 폴더 내의 index 파일을 자동으로 선택한다.

```shell
├── index.pug
└── product
    ├── index.pug
    └── insert.pug
```

```jade
//- product/insert.pug
doctype html
html
    head
        title= title
        link(rel='stylesheet', href='/stylesheets/style.css')
    body
        h1 #{title}
        p Node.js Programming for Modern Web development
        hr
```

```javascript
app.get('/product', function(req, res) { // product 디렉토리내 index.pug 호출
    res.render('product', {
        title: 'Product Page'
    });
});

app.get('/product/insert', function(req, res) {
    res.render('product/insert', {
        title: 'Product Page11'
    });
});
```



## 페이지 레이아웃

### pug

```shell
├── index.pug
├── error.pug
└── layout.pug
```
*layout.pug*

```jade
doctype html
html
  head
    title= title
    link(rel='stylesheet', href='/stylesheets/style.css')
  body
    block content
```

*index.pug*

```jade
extends layout

block content
  h1= title
  p Welcome to #{title}
```



### ejs

레이아웃 기능을 따로 제공하지는 않지만, `include`를 활용할 수 있다.

*index.ejs*

```ejs
<% include headerLayout.ejs %>
<p>test</p>
<% include footerLayout.ejs %>
```



## 실행 환경 설정

```shell
# window
> SET NODE_ENV=development
> npm start
```

```shell
# mac | linux
$ export NODE_ENV=development
$ npm start
```

| mode       | development | production |
| ---------- | ----------- | ---------- |
| 오류 출력      | 출력          | 출력 안 함     |
| view cache | 사용 안 함      | 사용         |
| 디버그 모드     | 설정하면 사용     | 사용 불가      |

```shell
$ DEBUG=http,mail,express:* node index.js
--export-
```

***Note.*** 최종 환경 설정

```javascript
var app = express();
app.settings.env = 'production';
```
