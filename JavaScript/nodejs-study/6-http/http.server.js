// create server
var server = require('http').createServer();

// run server
server.listen(52273, function() {
    console.log('Server Running at http://127.0.0.1:52273');
});

setTimeout(function() {
    server.close();
}, 10000);
