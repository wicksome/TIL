var server = require('http').createServer();

server.on('request', function(code) {
	console.log('Request On');
});


server.on('connection', function(code) {
	console.log('Connection On');
});

server.on('close', function(code) {
	console.log('Close On');
});

server.listen(52273);
