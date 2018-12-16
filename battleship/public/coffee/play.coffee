# Jouer à la bataille navale


# Au début, le joueur ne peut pas joueur si l'autre joueur n'est pas prêt
canPlay = false
sprite = ""

getCellByCoordinates = (x, y) ->
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

getCoordinatesByCell = (cell) ->
	letter = cell[0]
	number = cell[1]
	x = 0
	y = 0
	switch letter
		when "A" then x = 40
		when "B" then x = 173
		when "C" then x = 300
		when "D" then x = 440
		when "E" then x = 573
		else x = 700
	switch number
		when "1" then y = 40
		when "2" then y = 173
		when "3" then y = 300
		when "4" then y = 440
		when "5" then y = 573
		else y = 700
	return { x: x, y: y }

drawGrid = (graphics) ->
	style = { font: "20px Arial", fill: "#808080", align: "center" }
	for i in [0..nbCases - 1]
		do (i) ->
		for j in [0..nbCases - 1]
			do (j) ->
				graphics.drawRect(i * (800 / nbCases), j * (800 / nbCases), 800 / nbCases, 800 / nbCases)
				game.add.text((i * (800 / nbCases)) + width / 2,
				(j * (800 / nbCases)) + height / 2, cases[i][j].label, style)

isACell = (x, y) ->
	return (40 < x < 93 or 173 < x < 226 or 300 < x < 360 or 440 < x < 497 or
	573 < x < 620 or 700 < x < 760) and (40 < y < 93 or 173 < y < 226 or
	300 < y < 360 or 440 < y < 497 or 573 < y < 620 or 700 < y < 760)

#Question 9
drawResultShoot = (x, y, result) ->
	sprite.destroy()
	resSprite = game.add.sprite(x, y, result)
	resSprite.width = 80
	resSprite.height = 80
#Question 9

window.playState = {
	preload: () ->
		console.log 'play preload'

	# TP
	update: () ->
		# C'est ton tour !
		socket.on 'canPlay', () ->
			canPlay = true
		#Question 10
		mouse = game.input.mousePointer
		event = socket.on 'resultShoot', (resultShoot) ->
			coordinates = getCoordinatesByCell resultShoot.cell
			x = coordinates.x
			y = coordinates.y
			if resultShoot.result is "O"
				drawResultShoot(x, y, 'water')
			else if resultShoot.result is "T"
				drawResultShoot(x, y, 'explosion')
			else if resultShoot.result is "C"
				drawResultShoot(x, y, 'wreckship')
				if !(resultShoot.cell in touchedShips)
					window.touchedShips.push(resultShoot.cell)
					if (window.touchedShips.length is 3)
						game.state.start('end')
			canPlay = false
		#Question 10

		#Question 3
		if (mouse.isDown)
			if (isACell(mouse.positionDown.x, mouse.positionDown.y) and canPlay)
				selectedCell = getCellByCoordinates(mouse.positionDown.x, mouse.positionDown.y)
				missile = game.add.sprite(mouse.positionDown.x - 40, mouse.positionDown.y - 40, 'missile')
				sprite = missile
				missile.width = 80
				missile.height = 80
				canPlay = false
				socket.emit 'selectedCell', { pseudo: pseudo, cell: selectedCell }
		#Question 3

	create: () ->
		socket.on 'readyToPlay', (enemy) ->
			game.add.text(900, 400, "Vous jouez contre " + enemy)
		socket.on 'disconnected', () ->
			console.log('Socket client disconnected')
		socket.on 'endOfGame', () ->
			game.state.start('end')
		graphics = game.add.graphics()
		graphics.lineStyle(2, 0xAAAAAA, 1)
		drawGrid(graphics)
		window.touchedShips = []



}