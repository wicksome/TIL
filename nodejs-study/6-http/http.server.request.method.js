var http = require('http'),
    url = require('url');

http.createServer(function(request, response) {
    switch (request.method) {
        case 'GET':
            var query = url.parse(request.url, true).query;
            console.log('GET', JSON.stringify(query));
            response.end();
            break;
        case 'POST':
            // TEST
            // $ curl -X POST -d "data" 127.0.0.1:52273
            request.on('data', function(data) {
                console.log('POST', data.toString());
            });
            response.end();
            break;
    }

}).listen(52273, function() {
    console.log('Server Running at local');
});
