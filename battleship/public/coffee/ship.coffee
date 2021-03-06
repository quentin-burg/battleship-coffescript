# Placer les bateaux

# TODO : placer des bateaux à plusieurs cases et choisir dans quel sens les mettre
# TODO : pouvoir changer de sens les bateaux avant de les placer (horizontal ou vertical)

window.nbCases = 6

alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

window.cases = []
window.width = 800 / nbCases
window.height = 800 / nbCases

posXShip1 = 80
posXShip2 = 250
posXShip3 = 400

error = false

createGrid = () ->
	# TO FIX : améliorer la boucle
	for i in [0 .. nbCases - 1]
		do (i) ->
		temp = []
		letter = alphabet[i]
		for j in [0 .. nbCases - 1]
			do (j) ->
			raw = j + 1
			label = letter + raw
			coor = { x: i * (800 / nbCases), y: j * (800 / nbCases), label, ship: '', i, j }
			temp.push coor
		cases.push temp

drawGrid = (graphics) ->
	style = { font: "20px Arial", fill: "#808080", align: "center" }
	# TO FIX : améliorer la boucle
	for i in [0..nbCases - 1]
		do (i) ->
		for j in [0..nbCases - 1]
			do (j) ->
				graphics.drawRect(i * (800 / nbCases), j * (800 / nbCases), 800 / nbCases, 800 / nbCases)
				game.add.text((i * (800 / nbCases)) + width / 2,
				(j * (800 / nbCases)) + height / 2, cases[i][j].label, style)

drawShip = (posX, posY, width, height, name, group) ->
	shipDrag = group.create(posX, posY, name)
	shipDrag.width = width
	shipDrag.height = height
	shipDrag.inputEnable = true
	shipDrag.input.enableDrag()
	shipDrag.events.onDragStart.add(onDragStart, this)
	shipDrag.events.onDragStop.add(onDragStop, this)

onDragStart = (sprite, pointer) ->

onDragStop = (sprite, pointer) ->
	posX = sprite.position.x
	posY = sprite.position.y
	cases.forEach(( raw ) ->
		raw.forEach(( c ) ->
			if (c.x <= posX and posX < c.x + width) and (c.y <= posY and posY < c.y + height)
				try
					if (sprite.key is 'ship1')
						c.hasShip = sprite.key
						if !(sprite.key in ships)
							ships.push(sprite.key)
					else if (sprite.key is 'ship2')
						c.hasShip = sprite.key
						cases[c.i + 1][c.j].hasShip = sprite.key
						if !(sprite.key in ships)
							ships.push(sprite.key)
					else if (sprite.key is 'ship3')
						c.hasShip = sprite.key
						cases[c.i + 1][c.j].hasShip = sprite.key
						cases[c.i + 2][c.j].hasShip = sprite.key
						if !(sprite.key in ships)
							ships.push(sprite.key)
					error = false
				catch err
					alert("Position invalide du bateau")
					group = game.add.group()
					group.inputEnableChildren = true
					if (sprite.key is 'ship1')
						sprite.destroy()
						drawShip(900, posXShip1, width - 10, 83, 'ship1', group)
					if (sprite.key is 'ship2')
						sprite.destroy()
						drawShip(900, posXShip2, (width * 2) - 10, 83, 'ship2', group)
					if (sprite.key is 'ship3')
						sprite.destroy()
						drawShip(900, posXShip3, (width * 3) - 10, 83, 'ship3', group)
					error = true
			)
	)

handleClick = () ->
	if (ships.length isnt 3)
		alert "Vous devez placer les trois bateaux"
	else
		if (not error)
			# on lance l'état suivant du jeu : la bataille
			game.state.start('play')
		socket.emit 'shipsPositions', { pseudo: pseudo, cells: cases }

window.shipState = {
	preload: () ->
		console.log 'preload ship'
		# on dessine la grille
		createGrid()

	create: () ->
		# on dessine les différents bateaux et le bouton
		group = game.add.group()
		group.inputEnableChildren = true
		drawShip(900, posXShip1, width - 50, 83, 'ship1', group)
		drawShip(900, posXShip2, (width * 2) - 50, 83, 'ship2', group)
		drawShip(900, posXShip3, (width * 3) - 50, 83, 'ship3', group)

		window.ships = []

		graphics = game.add.graphics()
		graphics.lineStyle(2, 0xAAAAAA, 1)
		drawGrid(graphics)
		# TO FIX : remonter le bouton pour ne pas avoir à dézommer
		button = game.add.button(1000, 900, 'button', handleClick)
		button.width = 50
		button.height = 50

		# Event reçu si la socket coté client est déconnectée
		socket.on 'disconnected', () ->
			console.log('Socket client disconnected')
		# Si l'adversaire se déconnecte, la partie prend fin (on reçoit enOfGame du serveur)
		socket.on 'endOfGame', () ->
			game.state.start('end')
}