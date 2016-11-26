var express = require('express'),
    app = express();


var domainRestController = express.Router(),
    groupRestController = express.Router();

domainRestController.get('/:id', function(req, res, next) {
    var id = req.params.id;
    res.send('get domain: ' + id);
});

groupRestController.get('/:id', function(req, res, next) {
    var id = req.params.id;
    res.send('get group: ' + id);
});

app.use('/domains', domainRestController);
app.use('/groups', groupRestController);

app.listen(52273, function() {
    console.log('server running');
});
