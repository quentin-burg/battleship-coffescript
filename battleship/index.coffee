express = require 'express'
socketIO = require 'socket.io'
http = require 'http'
path = require 'path'
randomstring = require 'randomstring'

app = express()
server = http.Server(app)
io = socketIO(server)

server.listen(3000)


players = []
rooms = []
# rooms = { "id": {"status" : "empty" || "free" || "full"}, "player1": "p1", "player2": "p2" }
createRoomId = () -> randomstring.generate(6)

placePlayerInRoom = (playerId) ->
	placed = false
	console.log(rooms)
	for rid in rooms
		console.log(rid)
		room = rooms[rid]
		if room.status is 'empty'
			room.player1 = { id: playerId, grid: [] }
			room.status = 'free'
			placed = r
		else if room.status is 'free'
			room.player2 = { id: playerId, grid: [] }
			room.status = 'full'
			placed = r
	if !placed
		roomId = createRoomId()
		newRoom = {roomId: roomId}
		newRoom.player1 = { id: playerId, grid: [] }
		newRoom.status = 'free'
		rooms.push newRoom
		return roomId
	return placed

# putGridForPlayer = (playerId) ->



io.sockets.on('connection', (socket) ->
	console.log ('new user')
	socket.on 'pseudo', (pseudo) ->
		players.push(pseudo)
		roomId = placePlayerInRoom(pseudo)
		socket.join(roomId)
	socket.on 'shipsPositions', (shipsPositions) ->
		pseudo = shipsPositions[0]
		# putGridForPlayer
	socket.on 'selectedCell', (selectedCell) ->
		battleshipArray = players[selectedCell[0]]
)

app.get('/', (req, res) -> res.sendFile(path.join __dirname, 'public', 'index.html'))
app.use(express.static(path.join __dirname, 'public'))