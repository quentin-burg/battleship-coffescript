socket = io.connect()

# Tableau avec toutes les coordonnées des cases = [ {x, y} ...]
# La largeur et la hauteur des cases = permet de calculer les autres coordonnées des cases
# Vérifier que le nombre de cases en entrée est bien un carré parfait (sinon case manquante)
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

drawShip = (mouseX, mouseY) ->
  cases.forEach(( c ) ->
    if (c.x <= mouseX and mouseX < c.x + width) and (c.y <= mouseY and mouseY < c.y + height)
      ship = game.add.sprite(c.x + (width / 2), c.y + (height  / 2), 'ship').anchor.set(0.5)
  )

drawGrid = () ->
  for i in [0..2]
    do (i) ->
      for j in [0..2]
        do (j) -> graphics.drawRect(i * (800 / 3), j * (800 / 3), 800 / 3, 800 / 3)

preload = () ->
	game.load.image('ship', 'ship.png')


create = () ->
  createGrid()
  socket.emit 'create', 'Quentin'
  graphics = game.add.graphics()
  graphics.lineStyle(2, 0xAAAAAA, 1)
  for i in [0..2]
    do (i) ->
      for j in [0..2]
        do (j) -> graphics.drawRect(i * (800 / 3), j * (800 / 3), 800 / 3, 800 / 3)

update = () ->
  if game.input.mousePointer.isDown
    drawShip(game.input.mousePointer.x, game.input.mousePointer.y)
    # game.add.sprite(game.input.mousePointer.x, game.input.mousePointer.y, 'ship').anchor.set(0.5)

game = new Phaser.Game(800, 800, Phaser.AUTO, '', { create: create , preload: preload, update: update }, true)




# 400 x 300

# sprite.x = game.input.mousePointer.x;
# sprite.y = game.input.mousePointer.y;


# var image = game.add.sprite(game.world.centerX, game.world.centerY, 'einstein');

#     //  Moves the image anchor to the middle, so it centers inside the game properly
#     image.anchor.set(0.5);

#     //  Enables all kind of input actions on this image (click, etc)
#     image.inputEnabled = true