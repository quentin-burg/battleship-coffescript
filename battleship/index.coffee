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
	console.log 'player Id' + playerId
	for room in rooms
		if room.status is 'empty'
			console.log 'room empty'
			# regarder si ce if est utile
			room.player1 = { id: playerId, grid: [], socket }
			room.status = 'free'
			placed = true
		else if room.status is 'free'
			console.log 'room free'
			room.player2 = { id: playerId, grid: [], socket }
			room.status = 'full'
			placed = true
	if !placed
		console.log 'new room'
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
		if (room.player1 and (room.player1.id is playerId) || (room.player2 and (room.player2.id is playerId)))
			return room

getOtherPlayerFromPlayerId = (room, playerId) ->
	if room.status is 'full'
		if room.player1.id is playerId
			return room.player2
		else if room.player2.id is playerId
			return room.player1

# TP
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

# TP
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

getEnemy = (pseudo) ->
	room = getRoomFromPseudo(pseudo)
	return if room.player1.id is pseudo then room.player2.id else room.player1.id

# TP
getResultFromTarget = (targetCell, room, shooter, socket) ->
	targetPlayer = getOtherPlayerFromPlayerId(room, shooter)
	targetGrid = targetPlayer.grid
	result = findCellFromGrid(targetGrid, targetCell)
	socket.emit('resultShoot', { result, cell: targetCell })
	targetPlayer.socket.emit('canPlay')

# getPlayerFromId = (playerId) ->
# 	for room in rooms
# 		return if room.player1.id is playerId then room.player1 else romm.player2

sendEnemy = (playerId) ->
	room = getRoomFromPseudo(playerId)
	if room.status is 'full'
		room.player1.socket.emit('readyToPlay', getEnemy(room.player1.id))
		room.player2.socket.emit('readyToPlay', getEnemy(room.player2.id))
		# par dafaut le joueur qui début est le joueur 1
		room.player1.socket.emit('canPlay')

getRoomFromSocketId = (socketId) ->
	for room in rooms
		if room.player1 and room.player1.socket.id is socketId
			return { room, player: room.player1 }
		else if room.player2 and room.player2.socket.id is socketId
			return { room, player: room.player2 }
	console.log('no room found')
	return { room: null, player: null }

removeRoom = (socketId) ->
	{ room, player } = getRoomFromSocketId(socketId)
	console.log('PLAY', player)
	if player then otherPlayer = getOtherPlayerFromPlayerId(room, player.id)
	console.log 'otherPlayer', otherPlayer
	if otherPlayer then otherPlayer.socket.emit('endOfGame')
	if room then rooms.splice(rooms.indexOf(room), 1)



io.sockets.on('connection', (socket) ->
	console.log ('Nouvel utilisateur connecté')
	socket.on 'pseudo', (pseudo) ->
		roomId = placePlayerInRoom(pseudo, socket)
	socket.on 'shipsPositions', (shipsPositions) ->
		pseudo = shipsPositions[0]
		sendEnemy(pseudo)
		putGridForPlayer(pseudo, shipsPositions[1])
	# TP
	socket.on 'selectedCell', (selectedCell) ->
		room = getRoomFromPseudo selectedCell[0]
		getResultFromTarget selectedCell[1], room, selectedCell[0], socket
	socket.on 'disconnect', () ->
		console.log 'disconnect server'
		removeRoom(socket.id)

)

app.get('/', (req, res) -> res.sendFile(path.join __dirname, 'public', 'index.html'))
app.use(express.static(path.join __dirname, 'public'))