# Jouer à la bataille navale

getCellByCoordinates = (x,y) ->
	letter = ''
	number = 0
	if (x < 133.3)
		letter = 'A'
	else if (x < 266.6)
		letter = 'B'
	else if (x <= 399.9)
		letter = 'C'
	else if (x < 533.3)
		letter = 'D'
	else if (x < 666.6)
		letter = 'E'
	else 
		letter = 'F'
	if (y < 133.3)
		number = 1
	else if (y < 266.6)
		number = 2
	else if (y < 399.9)
		number = 3
	else if (y < 533.3)
		number = 4
	else if (y < 666.6)
		number = 5
	else 
		number = 6
	return letter + number

drawGrid = (graphics) ->
	style = { font: "20px Arial", fill: "#808080", align: "center" }
	for i in [0..nbCases - 1]
		do (i) ->
		for j in [0..nbCases - 1]
			do (j) ->
				graphics.drawRect(i * (800 / nbCases), j * (800 / nbCases), 800 / nbCases, 800 / nbCases)
				game.add.text((i * (800 / nbCases)) + width / 2, (j * (800 / nbCases)) + height / 2, cases[i][j].label, style)

window.playState = {
	preload: () ->
		console.log 'play preload'
		

	update: () -> 
		mouse = game.input.mousePointer
		if (mouse.isDown)
			selectedCell = getCellByCoordinates(mouse.positionDown.x,mouse.positionDown.y)
			missile = game.add.sprite(mouse.positionDown.x, mouse.positionDown.y, 'missile');
			missile.width = 80
			missile.height = 80
			socket.emit 'selectedCell', [window.pseudo,selectedCell]

	create: () ->
		game.add.text(400, 700, "Vous jouez contre ", style)
		graphics = game.add.graphics()
		graphics.lineStyle(2, 0xAAAAAA, 1)
		drawGrid(graphics)



}