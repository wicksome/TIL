var express = require('express'),
    app = express(); // 서버 생성

// use를 사용하면 여러개 사용 가능.
// use의 파라미터에 입력되는 함수를 미들웨어라고 함.
app.use(function(req, res, next) {
    console.log('first');
    req.number = 1;
    res.number = 2;
    next();
});

app.use(function(req, res, next) {
    console.log('second', req.number, res.number);
    next();
});

app.use(function(req, res, next) {
    console.log('third', req.number, res.number);

    res.writeHead(200, {
        'Content-Type': 'text/html'
    });
    res.end('express test');
});

app.listen(52273, function() {
    console.log('Server running at http://127.0.0.1:52273');
});
