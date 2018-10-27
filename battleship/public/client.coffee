socket = io.connect()

socket.emit('bonjour')

preload = () ->
	game.load.image('ship', 'ship.png')


drawGrid = () ->
  for i in [0..2]
    do (i) ->
      for j in [0..2]
        do (j) -> graphics.drawRect(i * (800 / 3), j * (800 / 3), 800 / 3, 800 / 3)

create = () ->
  graphics = game.add.graphics()
  graphics.lineStyle(2, 0xAAAAAA, 1)
  for i in [0..2]
    do (i) ->
      for j in [0..2]
        do (j) -> graphics.drawRect(i * (800 / 3), j * (800 / 3), 800 / 3, 800 / 3)

update = () ->
  if game.input.mousePointer.isDown
    game.add.sprite(game.input.mousePointer.x, game.input.mousePointer.y, 'ship').anchor.set(0.5)

game = new Phaser.Game(800, 800, Phaser.AUTO, '', { create: create , preload: preload, update: update }, true)

# 400 x 300


# sprite.x = game.input.mousePointer.x;
# sprite.y = game.input.mousePointer.y;


# var image = game.add.sprite(game.world.centerX, game.world.centerY, 'einstein');

#     //  Moves the image anchor to the middle, so it centers inside the game properly
#     image.anchor.set(0.5);

#     //  Enables all kind of input actions on this image (click, etc)
#     image.inputEnabled = true