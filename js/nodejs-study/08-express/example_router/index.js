var express = require('express');

// 서버 생성
var app = express();
app.use('/domains', require('./domainController').controller);
app.use('/groups', require('./groupController').controller);

app.listen(52273, function() {
    console.log('server running');
});
