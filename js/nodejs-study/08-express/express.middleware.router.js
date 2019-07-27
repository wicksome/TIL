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
