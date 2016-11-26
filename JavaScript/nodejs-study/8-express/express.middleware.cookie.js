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
