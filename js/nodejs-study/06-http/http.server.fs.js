var fs = require('fs'),
    http = require('http');

http.createServer(function(request, response) {
    var file = require('path').resolve(__dirname, 'HTMLPage.html');
    fs.readFile(file, function(error, data) {
        response.writeHead(200, {
            'Content-Type': 'text/html'
        });
        response.end(data);
    });
}).listen(52273, function() {
    console.log('Server Running at http://127.0.0.1:52273');
});
