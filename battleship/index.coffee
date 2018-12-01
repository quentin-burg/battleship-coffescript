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
	for room in rooms
		if room.status is 'empty'
			room.player1 = { id: playerId, grid: [] }
			room.status = 'free'
			placed = true
		else if room.status is 'free'
			room.player2 = { id: playerId, grid: [] }
			room.status = 'full'
			placed = true
	if !placed
		roomId = createRoomId()
		newRoom = { roomId: roomId }
		newRoom.player1 = { id: playerId, grid: [] }
		newRoom.status = 'free'
		rooms.push newRoom
		return roomId
	return placed

putGridForPlayer = (playerId, grid) ->
	for room in rooms
		if room.player1 and room.player1.id is playerId
			room.player1.grid = grid
		else if room.player2 and room.player2.id is playerId
			room.player2.grid = grid

getRoomFromPseudo = (playerId) ->
	for room in rooms
		if room.player1.id is playerId || room.player2.id is playerId
			return room

getOtherGridFromShooter = (room, shooter) ->
	if room.player1.id is shooter
		return room.player2.grid
	else if room.player2.id is shooter
		return room.player1.grid

findCellFromGrid = (grid, cellLabel) ->
	for rows in grid
		for cell in rows
			if cell.label is cell and cell.hasShip
				# change state of cell
				if isFlowed(rows, cell.hasShip)
					return 'C'
				cell.state = 'T'
				return 'T'
			else
				return 'O'

isFlowed = (rows, shipId) ->
	# la taille que prend un bateau est dans son nom (ship2 prend 2 cases)
	n = shipId.split('ship')[1]
	for cell in rows
		if cell.hasShip is shipId and cell.state is 'T'
			n = n - 1
	return n <= 0


getResultFromTarget = (targetCell, room, shooter) ->
	targetGrid = getOtherGridFromShooter(room, shooter)
	result = findCellFromGrid(targetGrid, targetCell)
	io.to(room.roomId).emit('resultShoot', { result, cell: targetCell })

io.sockets.on('connection', (socket) ->
	console.log ('new user')
	socket.on 'pseudo', (pseudo) ->
		players.push(pseudo)
		roomId = placePlayerInRoom(pseudo)
		socket.join(roomId)
	socket.on 'shipsPositions', (shipsPositions) ->
		pseudo = shipsPositions[0]
		putGridForPlayer(pseudo, shipsPositions[1])
	socket.on 'selectedCell', (selectedCell) ->
		room = getRoomFromPseudo selectedCell[0]
		getResultFromTarget selectedCell[1], room, selectedCell[0]
)

app.get('/', (req, res) -> res.sendFile(path.join __dirname, 'public', 'index.html'))
app.use(express.static(path.join __dirname, 'public'))