# Mise en place du jeu et des états

window.game = new Phaser.Game(800, 800, Phaser.AUTO, '')


console.log game
game.state.add('start', startState)
game.state.add('ship', shipState)

game.state.start('start')


# game.state.add('play', playState)
# game.state.add('end', endState)
# game.add.plugin(PhaserInput.Plugin)