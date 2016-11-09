var ejs = require('ejs'),
    http = require('http'),
    fs = require('fs'),
    path = require('path');

http.createServer(function(request, response) {
    var file = path.resolve(__dirname, 'ejsPage.ejs'),
        data = {
            title: 'Cleaning supplies',
            supplies: ['mop', 'broom', 'duster']
        };

    fs.readFile(file, 'utf-8', function(error, markup) {
        response.writeHead(200, {
            'Countent-Type': 'text/html'
        });
        response.end(ejs.render(markup, data));
    });
}).listen(52273, function() {
    console.log('Server Running at http://127.0.0.1:52273')
});
