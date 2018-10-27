express = require 'express'
socketIO = require 'socket.io'
http = require 'http'
path = require 'path'

app = express()
server = http.Server(app)
io = socketIO(server)

server.listen(3000)

io.sockets.on('connection', (socket) ->
    console.log ('new users')
    socket.on 'bonjour', () ->
        console.log 'bonjour'
)

app.get('/', (req, res) -> res.sendFile(path.join __dirname, 'public', 'index.html'))
app.use(express.static(path.join __dirname, 'public'))