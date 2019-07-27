var mysql = require('mysql');

var client = mysql.createConnection({
    user: 'root',
    password: 'password'
});

client.query('USE Company');
client.query('SELECT * FROM products', function(error, result, fields) {
    if (error) {
        console.log('query error');
    } else {
        console.log(result);
    }
});
client.query('INSERT INTO products (name) VALUES (?)', ['test'], function(error, results, fields) {
    if (error) {
        console.log('query error');
    } else {
        console.log(results);
    }
});
