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
touchedShips = 0
# rooms = { "id": {"status" : "empty" || "free" || "full"}, "player1": "p1", "player2": "p2" }
createRoomId = () -> randomstring.generate(6)

placePlayerInRoom = (playerId, socket) ->
	placed = false
	for room in rooms
		if room.status is 'empty'
			# regarder si ce if est utile
			room.player1 = { id: playerId, grid: [], socket }
			room.status = 'free'
			placed = true
		else if room.status is 'free'
			room.player2 = { id: playerId, grid: [], socket }
			room.status = 'full'
			placed = true
	if !placed
		roomId = createRoomId()
		newRoom = { roomId: roomId }
		newRoom.player1 = { id: playerId, grid: [], socket }
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
	for column in grid
		for cell in column
			if cell.label is cellLabel
				if cell.hasShip
					# change state of cell
					cell.state = 'T'
					if isFlowed(grid, cell.hasShip)
						return 'C'
					return 'T'
				else
					return 'O'

isFlowed = (grid, shipId) ->
	# la taille que prend un bateau est dans son nom (ship2 prend 2 cases)
	n = shipId.split('ship')[1]
	for column in grid
		for cell in column
			if cell.hasShip is shipId and cell.state is 'T'
				n = n - 1
			if n == 0
				return true
	return false

# playerIsReadyToPlay = (pseudo) ->
# 	room = getRoomFromPseudo(pseudo)
# 	return room.status is "full"

getEnemy = (pseudo) ->
	room = getRoomFromPseudo(pseudo)
	return if room.player1.id is pseudo then room.player2.id else room.player1.id

getResultFromTarget = (targetCell, room, shooter, socket) ->
	targetGrid = getOtherGridFromShooter(room, shooter)
	result = findCellFromGrid(targetGrid, targetCell)
	socket.emit('resultShoot', { result, cell: targetCell})

getPlayerFromId = (playerId) ->
	for room in rooms
		return if room.player1.id is playerId then room.player1 else romm.player2


# sendEnemy = (playerId) ->







io.sockets.on('connection', (socket) ->
	console.log ('new user')
	socket.on 'pseudo', (pseudo) ->
		players.push({pseudo: pseudo, socket: socket})
		roomId = placePlayerInRoom(pseudo, socket)
	socket.on 'shipsPositions', (shipsPositions) ->
		pseudo = shipsPositions[0]
		# io.to(getRoomFromPseudo(pseudo).roomId).emit('readyToPlay', getEnemy(pseudo))
		socket.emit('readyToPlay', getEnemy(pseudo))
		putGridForPlayer(pseudo, shipsPositions[1])
	socket.on 'selectedCell', (selectedCell) ->
		room = getRoomFromPseudo selectedCell[0]
		getResultFromTarget selectedCell[1], room, selectedCell[0], socket

)

app.get('/', (req, res) -> res.sendFile(path.join __dirname, 'public', 'index.html'))
app.use(express.static(path.join __dirname, 'public'))