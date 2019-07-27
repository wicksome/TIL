'use strict';

const express = require('express');
const app = express();
app.use(express.static('.'));

const server = app.listen(52273, () => console.log('Server Runnuing.'));
const io = require('socket.io')(server);

io.on('connection', client => {
    let currentRoom = 'default';

    // 불가능
    client.on('connect', () => {
        console.log('connect chat');
    });

    client.on('join', (room, fn) => {
        if (!room) {
            room = currentRoom;
        }

        console.log(`connect: ${room}`);
        client.leave(currentRoom)
              .join(room);
        currentRoom = room;

        // io.sockets.to(client.id).emit('join', currentRoom);
        // io.sockets.to(client.id).emit('connect'); 호출 불가능

        if (fn) {
            fn({
                success: true,
                message: `Success join as ${currentRoom}`
            });
        }
    });

    client.on('message', message => {
        client.to(currentRoom).emit('message', {
            sender: client.id,
            content: message
        });
    });

    client.on('leave', () => {
        client.leave(currentRoom);
        currentRoom = undefined;
        console.log(`${currentRoom} leaved`);
    });

    // 브라우저 종료하면 발생
    client.on('disconnect', socket => {
        client.leave(currentRoom);
        console.log(`${currentRoom} that ${socket.id}\'s room disconnected.`);
    });
});
