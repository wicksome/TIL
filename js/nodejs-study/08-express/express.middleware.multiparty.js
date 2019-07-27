var fs = require('fs'),
    express = require('express'),
    multipart = require('connect-multiparty');

var app = express();

app.use(multipart({
    uploadDir: __dirname + '/multipart'
}));

app.post('/', function(req, res) {
    console.log(req.files);
});

app.listen(52273, function() {
    console.log('Server Running');
});
