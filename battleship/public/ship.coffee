# Placer les bateaux

# TODO : placer des bateaux à plusieurs cases et choisir dans quel sens les mettre

cases = []
width = 800 / 3
height = 800 / 3

createGrid = () ->
  for i in [0..2]
    do (i) ->
      for j in [0..2]
        do (j) ->
          coor = { x: i * (800 / 3), y: j * (800 / 3) }
          cases.push coor

drawGrid = (graphics) ->
  for i in [0..2]
    do (i) ->
      for j in [0..2]
        do (j) -> graphics.drawRect(i * (800 / 3), j * (800 / 3), 800 / 3, 800 / 3)

drawShip = (mouseX, mouseY) ->
  cases.forEach(( c ) ->
    if (c.x <= mouseX and mouseX < c.x + width) and (c.y <= mouseY and mouseY < c.y + height)
      ship = game.add.sprite(c.x + (width / 2), c.y + (height  / 2), 'ship').anchor.set(0.5)
  )

window.shipState = {
	preload: () ->
		console.log 'preload ship'
		createGrid()

	create: () ->
		console.log('create ship')
		graphics = game.add.graphics()
		graphics.lineStyle(2, 0xAAAAAA, 1)
		drawGrid(graphics)

	update: () ->
		if game.input.mousePointer.isDown
			drawShip(game.input.mousePointer.x, game.input.mousePointer.y)

}