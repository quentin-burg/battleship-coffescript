express = require 'express'
socketIO = require 'socket.io'
http = require 'http'
path = require 'path'

app = express()
server = http.Server(app)
io = socketIO(server)

server.listen(3000)


players = []
gameRooms = []
roomNumber = 1;

io.sockets.on('connection', (socket) ->
    console.log ('new users')
    socket.on 'pseudo', (pseudo) -> 
        players.add(pseudo)
    socket.on 'shipsPositions', (shipsPositions) ->
        pseudo = shipsPositions[0]
        players.remove(pseudo)
        while (players.length == 0)
        
        

    socket.on 'selectedCell', (selectedCell) ->
        battleshipArray = players[selectedCell[0]]

        
)

app.get('/', (req, res) -> res.sendFile(path.join __dirname, 'public', 'index.html'))
app.use(express.static(path.join __dirname, 'public'))