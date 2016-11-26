var express = require('express'),
    app = express();

app.use(function(request, response) {
    var data = [{
        name: 'yeongjun.kim',
        data: 'test1'
    }, {
        name: '0jun',
        data: 'test2'
    }]

    // 자료형이 문자열이면 HTML, 배열이나 객체면 JSON으로 반환
    response.status(200).send(data);
    // response.sendStatus(404); // 상태코드만 전달하는 경우
});

app.listen(52273, function() {
    console.log('Server running at http://127.0.0.1:52273');
});
