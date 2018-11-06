# Placer les bateaux

# TODO : placer des bateaux à plusieurs cases et choisir dans quel sens les mettre
# TODO : pouvoir changer de sens les bateaux avant de les placer (horizontal ou vertical)
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
	shipDrag.events.onDragStart.add(onDragStart, this);
	shipDrag.events.onDragStop.add(onDragStop, this);

onDragStart = (sprite, pointer) ->
	console.log 'onDragStart'

onDragStop = (sprite, pointer) ->
	console.log 'onDragStop', sprite

window.shipState = {
	preload: () ->
		console.log 'preload ship'
		createGrid()

	create: () ->
		group = game.add.group()
		group.inputEnableChildren = true
		drawShip(900, 80, 200, 83, 'ship2', group)
		drawShip(900, 250, 200, 83, 'ship3', group)
		drawShip(900, 400, 200, 83, 'ship4', group)
		drawShip(900, 570, 200, 83, 'ship5', group)

		graphics = game.add.graphics()
		graphics.lineStyle(2, 0xAAAAAA, 1)
		drawGrid(graphics)

	update: () ->
		# if game.input.mousePointer.isDown
		# 	drawShip(game.input.mousePointer.x, game.input.mousePointer.y)
}