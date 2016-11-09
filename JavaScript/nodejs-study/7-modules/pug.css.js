var pug = require('pug'),
    http = require('http'),
    fs = require('fs'),
    path = require('path');

http.createServer(function(request, response) {
    var file = path.resolve(__dirname, 'pug.css.pug');

    fs.readFile(file, 'utf-8', function(error, markup) {
        response.writeHead(200, {
            'Countent-Type': 'text/html'
        });
        response.end(pug.renderFile(file));
    });
}).listen(52273, function() {
    console.log('Server Running at http://127.0.0.1:52273')
});
