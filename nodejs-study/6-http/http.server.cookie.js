var http = require('http');

http.createServer(function(request, response) {
    // GET cookie
    if (request.headers.cookie) {
        var cookie = request.headers.cookie.split(';').map(function(element) {
            var elem = element.split('=');
            return {
                key: elem[0],
                value: elem[1]
            };
        });

        response.end('<h1>' + JSON.stringify(cookie) + '</h1>');
    } else {
        // SET cookie
        response.writeHead(200, {
            'Content-type': 'text/html',
            'Set-Cookie': ['name = yeongjun', 'region = Seoul', ]
        });
        response.end('<h1>created cookie.</h1>');
    }
}).listen(52273, function() {
    console.log('Server Running at http://127.0.0.1:52273');
});
