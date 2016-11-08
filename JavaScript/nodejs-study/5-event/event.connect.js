process.on('exit', function (code) {
	console.log('good bye');
});

process.on('uncaughtException', function() {
	console.log('occured exception');	
});

var count = 0;
var test = function () {
	count = count + 1;
	if (count > 3) { return; }
	
	setTimeout(test, 2000);
	error.error.error();
};
setTimeout(test, 2000);
