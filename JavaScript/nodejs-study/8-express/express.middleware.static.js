var express = require('express'),
    app = express();

app.use(express.static(__dirname + '/public'))

app.listen(52273, function() {
    console.log('Test url', 'http://127.0.0.1:52273/tomcat.png');
});
