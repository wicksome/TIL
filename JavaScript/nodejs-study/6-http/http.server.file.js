var fs = require('fs'),
    http = require('http'),
    path = require('path');

// 사진 서버
http.createServer(function(request, response) {
    var file = path.resolve(__dirname, 'Chrysanthemum.jpg');

    // QUESTION: 왜 두번씩 호출되는지?
    // SOLUTION: 대부분의 브라우저가 http://localhost를 요청할 때 http://localhost/favicon.ico을 로드하려고 하기 때문이다.
    fs.readFile(file, function(error, data) {
        response.writeHead(200, {
            'Content-type': 'image/jpeg'
        });
        response.end(data);

    });
}).listen(52273, function() {
    console.log('Server Running at http://127.0.0.1:52273');
});

// mp3 서버
http.createServer(function(request, response) {
    var file = path.resolve(__dirname, 'Kalimba.mp3');

    fs.readFile(file, function(error, data) {
        response.writeHead(200, {
            'Content-type': 'audio/mp3'
        });
        response.end(data);

    });
}).listen(52274, function() {
    console.log('Server Running at http://127.0.0.1:52274');
});
