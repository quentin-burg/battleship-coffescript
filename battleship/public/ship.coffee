# Placer les bateaux

# TODO : placer des bateaux à plusieurs cases et choisir dans quel sens les mettre
# TODO : pouvoir changer de sens les bateaux avant de les placer (horizontal ou vertical)

nbCases = 6

alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

cases = []
width = 800 / nbCases
height = 800 / nbCases

error = false

createGrid = () ->
	for i in [0 .. nbCases - 1]
		do (i) ->
		temp = []
		letter = alphabet[i]
		for j in [0 .. nbCases - 1]
			do (j) ->
			raw = j + 1
			label = letter + raw
			coor = { x: i * (800 / nbCases), y: j * (800 / nbCases), label, hasShip: false, i, j }
			temp.push coor
		cases.push temp

drawGrid = (graphics) ->
	style = { font: "20px Arial", fill: "#808080", align: "center" }
	for i in [0..nbCases - 1]
		do (i) ->
		for j in [0..nbCases - 1]
			do (j) ->
				graphics.drawRect(i * (800 / nbCases), j * (800 / nbCases), 800 / nbCases, 800 / nbCases)
				game.add.text((i * (800 / nbCases)) + width / 2, (j * (800 / nbCases)) + height / 2, cases[i][j].label, style)

drawShip = (posX, posY, width, height, name, group) ->
  # cases.forEach(( c ) ->
  #   if (c.x <= mouseX and mouseX < c.x + width) and (c.y <= mouseY and mouseY < c.y + height)
  #     ship = game.add.sprite(c.x + (width / 2), c.y + (height  / 2), 'ship').anchor.set(0.5)
  # )
	shipDrag = group.create(posX, posY, name)
	shipDrag.width = width
	shipDrag.height = height
	shipDrag.inputEnable = true
	shipDrag.input.enableDrag()
	shipDrag.events.onDragStart.add(onDragStart, this)
	shipDrag.events.onDragStop.add(onDragStop, this)

onDragStart = (sprite, pointer) ->
	console.log 'onDragStart'

onDragStop = (sprite, pointer) ->
	console.log 'onDragStop', sprite
	posX = sprite.position.x
	posY = sprite.position.y
	cases.forEach(( raw ) ->
		raw.forEach(( c ) ->
			if (c.x <= posX and posX < c.x + width) and (c.y <= posY and posY < c.y + height)
				try
					if (sprite.key is 'ship2')
						c.hasShip = true
					else if (sprite.key is 'ship3')
						c.hasShip = true
						cases[c.i + 1][c.j + 1].hasShip = true
					else if (sprite.key is 'ship4')
						c.hasShip = true
						cases[c.i + 1][c.j + 1].hasShip = true
						cases[c.i + 2][c.j + 2].hasShip = true
					error = false
				catch err
					alert("Position invalide du bateau")
					error = true
			)
	)

handleClick = () ->
	if (not error)
		game.state.start('play')

window.shipState = {
	preload: () ->
		console.log 'preload ship'
		createGrid()

	create: () ->
		group = game.add.group()
		group.inputEnableChildren = true
		drawShip(900, 80, width - 10, 83, 'ship2', group)
		drawShip(900, 250, (width * 2) - 10, 83, 'ship3', group)
		drawShip(900, 400, (width * 3) - 10, 83, 'ship4', group)
		drawShip(900, 570, 200, 83, 'ship5', group)

		graphics = game.add.graphics()
		graphics.lineStyle(2, 0xAAAAAA, 1)
		drawGrid(graphics)
		button = game.add.button(1000, 900, 'button', handleClick)
		button.width = 50
		button.height = 50

	update: () ->
		# if game.input.mousePointer.isDown
		# 	drawShip(game.input.mousePointer.x, game.input.mousePointer.y)
}