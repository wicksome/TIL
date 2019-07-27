var express = require('express'),
    app = express();

app.use(function(req, res) {
    var agent = req.header('User-Agent');
    // console.log(req.headers);
    console.log(agent);

    if (agent.toLowerCase().match(/chrome/)) {
        res.send('chrome');
    } else {
        res.send('default');
    }
});

app.listen(52273, function() {
    console.log('Server running at http://127.0.0.1:52273');
});
