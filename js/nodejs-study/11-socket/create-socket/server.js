//  export DEBUG=socket.io* & node create-socket/server
var http = require('http'),
    fs = require('fs'),
    socketio = require('socket.io');

var server = http.createServer((req, res) => {
    fs.readFile('create-socket/page.html', function(error, data) {
        res.writeHead(200, {
            'Content-Type': 'text/html'
        });
        res.end(data);
    });
}).listen(52273, () => {
    console.log('Server running at http://localhost:52273');
});

var io = socketio.listen(server),
    id = 0;
io.sockets.on('connection', socket => {
    // 이렇게하면 가장 최근에 접속한 클라이언트 저장
    id = socket.id;
    socket.on('createSocket', data => {
        console.log('Recive Data:', data);

        switch (data.type) {
            case 'SOCKET':
                socket.emit('echo', 'socket');
                break;
            case 'BROADCAST':
                socket.broadcast.emit('echo', 'broadcast');
                break;
            case 'PUBLIC':
                io.sockets.emit('echo', 'public');
                break;
            case 'PRIVATE':
                io.sockets.to(id).emit('echo', 'private');
                // io.sockets.in(id).emit('echo', data);
                break;
        }
    });
});
