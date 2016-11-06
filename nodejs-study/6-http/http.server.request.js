var http = require('http'),
    fs = require('fs'),
    url = require('url'),
    path = require('path');

http.createServer(function(request, response) {
    var pathName = url.parse(request.url).pathname;

    if (pathName == '/') {
        fs.readFile(path.resolve(__dirname, 'index.html'), function(error, data) {
            response.writeHead(200, {
                'Content-type': 'text/html'
            });
            response.end(data);
        });
    } else if (pathName == '/other') {
      fs.readFile(path.resolve(__dirname, 'otherPage.html'), function(error, data) {
          response.writeHead(200, {
              'Content-type': 'text/html'
          });
          response.end(data);
      });
    }
}).listen(52273, function() {
    console.log('Server Running at local');
});
