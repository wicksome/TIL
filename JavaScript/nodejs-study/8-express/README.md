# Middleware

**router**

- express 모듈에 내장되어 있는 미들웨어
- `params` vs  `query`
- `*`는 항상 가장 밑에 선언


```javascript
var express = require('express'),
    app = express();

// http://127.0.0.1:52273/params/test
app.get('/params/:id', function(req, res) {
    var id = req.params.id;
    res.send(id);
});

// http://127.0.0.1:52273/query?test=3
app.get('/query', function(req, res) {
    res.send(req.query);
});

// express 모듈은 라우터 메서드를 사용한 순서대로 요청을 확인하므로,
// 전체 선택자를 사용하는 라우터 메서드는 반드시 마지막에 위치해야 함.
app.all('*', function(req, res) {
    res.status(404).send('ERROR - Page Not Found');
});

app.listen(52273, function() {
    console.log('Server running');
});
```

- Java에서 쓰던 것처럼 파일을 나눠보자면 아마 이렇게 되지 않을까 생각함


*index.js*


```javascript
  var express = require('express');

  // 서버 생성
  var app = express();
  app.use('/domains', require('./domainController').controller);
  app.use('/groups', require('./groupController').controller);

  app.listen(52273, function() {
      console.log('server running');
  });
```

*domainController.js*

```javascript
var express = require('express'),
    controller = express.Router();


controller.get('/:id', function(req, res) {
    var id = req.params.id;
    res.send('get domain: ' + id);
});

exports.controller = controller;
```

*groupController.js*

```javascript
var express = require('express'),
    controller = express.Router();


controller.get('/:id', function(req, res) {
    var id = req.params.id;
    res.send('get group: ' + id);
});

exports.controller = controller;
```



**static**

- static 파일 제공 용도
- express 모듈에 내장되어 있는 미들웨어

```shell
.
├── express.middleware.static.js
└── public
    └── tomcat.png
```

```javascript
// express.middleware.static.js
var express = require('express'),
    app = express();

app.use(express.static(__dirname + '/public'))

app.listen(52273, function() {
    console.log('Test url', 'http://127.0.0.1:52273/tomcat.png');
});
```



**morgan**

- 웹 요청이 들어왔을 때 로그 출력하는 미들웨어
- 외부 모듈이라 설치 필요

```shell
$ npm install morgan
```

- `morgan()` 매개변수에 토큰을 조합 혹은 정의된 포맷으로 로그 형태 변경 가능
  - [morgan 미들웨어의 토큰](https://www.npmjs.com/package/morgan#tokens)
  - [morgan 미들웨어 로그 포맷](https://www.npmjs.com/package/morgan#predefined-formats)

```javascript
...
app.use(morgan('combined')); // 기본적인 로그
...
```



**cookie parser**

- 요청 쿠키를 추출하는 미들웨어, 외부 모듈

```
$ npm install cookie-parser
```

- 세번째 파라미터로 [쿠키 옵션](https://www.npmjs.com/package/cookie#options-1) 지정 가능

*express.middleware.cookie.js*

```javascript
var express = require('express'),
    cookieParser = require('cookie-parser'),
    app = express();

// 미들웨어 설정
app.use(cookieParser());

app.get('/getCookie', function(req, res) {
    res.send(req.cookies)
});

app.get('/setCookie', function(req, res) {
    res.cookie('string', 'cookie');
    res.cookie('json', {
        name: 'cookie',
        property: 'delicious'
    });
    // 쿠키 옵션 지정 가능(세번째 인자)
    res.cookie('cookieOptions', 'test', {
        maxAge: 6000
    });

    res.redirect('/getCookie')
});

app.listen(52273, function() {
    console.log('Server Running');
})
```



**body parser**

- POST 요청 데이터를 추출하는 미들웨어

```shell
$ npm install body-parser
```

- `application/x-www-form-urlencoded` 인코딩 방식만 지원

```javascript
...
app.post('/login', function(req, res) {
  	var id = req.body.id,
        pwd = req.body.password;
});
...
```



**connect-multiparty**

- `POST` 방식의 `multipart/form-data` 인코딩 방식을 받기 위한 미들웨어

```shell
$ npm install connect-multiparty
```

*html*

```html
<form method="post" enctype="multipart/form-data">
	<input type="file" name="fileUpload"/>
</form>
```

```html
<!-- 배열 형태로 파일이 전달됨 -->
<input type="file" multiple="multiple"/>
<input type="file" multiple="multiple"/>
...
```

*js*

- `uploadDir` 속성을 지정하면 파일 업로드시 지정된 경로에 파일이 업로드
- 파일이 업로드되면 `request`객체의 `files` 속성이 전달

```javascript
var fs = require('fs'),
    express = require('express'),
    multipart = require('connect-multiparty');

var app = express();

app.use(multipart({
    uploadDir: __dirname + '/multipart'
}));

app.post('/', function(req, res) {
    console.log(req.files);
});

app.listen(52273, function() {
    console.log('Server Running');
});
```

- Tip. 파일 이름 중복 없도록 정하기 때 UUID 활용 - `node-uuid`
- 그 외 미들웨어
  - busboy
  - formidable
  - multiparty
  - multer
- 특정 페이지 라우팅에만 미들웨어 적용


```javascript
// multiparty 미들웨어가 먼저 수행되고, 사용자가 만든 함수 호출
app.post('/', multipart, function (req, res){
  	/* 생략 */
});
```



**express-session**

[express-session 링크](https://www.npmjs.com/package/express-session)

```shell
$ npm install express-session
```

```javascript
var express = require('express'),
	session = require('express-session');
	
var app = express();

app.use(session({
	secret: 'secret key',
	resave: false,
	saveUninitialized: true
}));

/* 생략 */
```