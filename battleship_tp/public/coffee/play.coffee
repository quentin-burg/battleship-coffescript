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

window.playState = {
	preload: () ->
		console.log 'play preload'

	# TP
	update: () ->
		# C'est ton tour !
		socket.on 'canPlay', () ->
			canPlay = true


		#### QUESTION 3 ####



		#### QUESTION 10 ####


	create: () ->
		socket.on('readyToPlay', (enemy) ->
			game.add.text(900, 400, "Vous jouez contre " + enemy)
		)
		socket.on 'disconnected', () ->
			console.log('Socket client disconnected')
		socket.on 'endOfGame', () ->
			game.state.start('end')
		graphics = game.add.graphics()
		graphics.lineStyle(2, 0xAAAAAA, 1)
		drawGrid(graphics)
		window.touchedShips = []



}