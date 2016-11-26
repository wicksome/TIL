var url = require('url'),
    app = require('express')();

app.use(function(req, res, next) {
    var name = req.query.name,
        region = req.query.region;

    console.log('express', req.query);
    console.log('------------------------------------------------------------------express req');
    console.log(req.connection._httpMessage._headers);
    res.send(name + '-' + region);

    // 기존 배운 방법
    var query = url.parse(req.url, true).query;
    console.log('url.parse in express', query);
    // req.query와 url.parse하는 것과 서로 다른가??
    // app.use()의 req는 http.createServer()의 req와 다른가?
    // 비교
    // expres에는 headers, headerNamse가 추가
    // 그리고 next, baseUrl, originUrl, parsedUrl, params, query, res 등 추가됨
});

app.listen(52273, function() {
    console.log('runnig');
});


var url = require('url');
require('http').createServer(function(req, res) {
    var query = url.parse(req.url, true).query;
    console.log('------------------------------------------------------------------http req');
    // console.log(req.server.headers);
    console.log(req.connection._httpMessage._headers);
    console.log('http', JSON.stringify(query));
    res.end();
}).listen(52274, function() {
    console.log('Server Running at local');
});
