# Mise en place du jeu et des états

# on initialise la variable de jeu Phaser
window.game = new Phaser.Game(1600, 1600, Phaser.AUTO, '', {}, true)

# on initialise la socket coté client
window.socket = io.connect()

# on déclare la liste des états du jeu
game.state.add('start', startState)
game.state.add('ship', shipState)
game.state.add('play', playState)
game.state.add('end', endState)

# on lance le premier état du jeu
game.state.start('start')