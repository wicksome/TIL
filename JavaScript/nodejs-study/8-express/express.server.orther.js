/**
 * express 프레임워크에서는 아래 방식처럼 실행한다.
 * socket.io 모듈과 같은 다른 모듈과 함께 사용할 때는 아래 방법을 사용한다.
 **/
var http = require('http'),
    express = require('express');

var app = express();

http.createServer(app).listen(52273, function() {
    console.log('Server running at http://127.0.0.1:52273');
});
