var express = require('express'),
    controller = express.Router();


controller.get('/:id', function(req, res) {
    var id = req.params.id;
    res.send('get group: ' + id);
});

exports.controller = controller;
