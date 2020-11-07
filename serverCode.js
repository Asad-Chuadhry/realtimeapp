var mysql = require('mysql')
const express = require('express');
const app = express();
const WebSocket = require('ws');
const wss = new WebSocket.Server({ server: app.listen(3000, () => console.log('server is up')) });
wss.on('connection', socket => {
    socket.on('message', userData => {
        console.log(`received from a client: ${userData}`);
        var dbConnection = mysql.createConnection({
            host: 'localhost',
            user: 'root',
            password: '',
            database: 'testdb'
        })
        dbConnection.connect()
        if (userData == "init") {

            dbConnection.query('select * from realdata',
                (err, result, fields) => {
                    if (err) console.log(err)
                    console.log(JSON.stringify(result))
                    wss.clients.forEach(function each(client) {
                        if (client.readyState === WebSocket.OPEN) {
                            client.send(JSON.stringify(result));
                        }
                    });
                }
            )
        } else if (userData == "clear") {
            dbConnection.query(
                "Update realdata SET count=0",
                (err, result1) => {
                    if (err) console.log(err)
                    dbConnection.query('select * from realdata',
                        (err, result2, fields) => {
                            if (err) console.log(err)
                            console.log(JSON.stringify(result2))
                            wss.clients.forEach(function each(client) {
                                if (client.readyState === WebSocket.OPEN) {
                                    client.send(JSON.stringify(result2));
                                }
                            });
                        })
                }
            )
        } else {
            dbConnection.query(
                "Update realdata SET count=count+1 where ID=" + userData,
                (err, result) => {
                    console.log("data updated")
                    dbConnection.query(
                        "Update realdata SET count=" + userData + " where ID=5",
                        (err, result1) => {
                            if (err) console.log(err)
                            dbConnection.query('select * from realdata',
                                (err, result2, fields) => {
                                    if (err) console.log(err)
                                    console.log(JSON.stringify(result2))
                                    wss.clients.forEach(function each(client) {
                                        if (client.readyState === WebSocket.OPEN) {
                                            client.send(JSON.stringify(result2));
                                        }
                                    });
                                })
                        }
                    )
                }
            )
        }
        // dbConnection.end();
    });
})