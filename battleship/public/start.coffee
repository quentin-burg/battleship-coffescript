# Entrer le pseudo et attendre le début d'une partie
window.startState = {
	preload: () ->
		console.log 'preload', game
		game.load.image('ship1', 'assets/boat1.png')
		game.load.image('ship2', 'assets/boat2.png')
		game.load.image('ship3', 'assets/boat3.png')
		game.load.image('ship5', 'assets/boat5.png')
		game.load.spritesheet('button', 'assets/button-arrow.png')
		game.load.image('missile', 'assets/missile.png')
		game.load.image('water', 'assets/water.png')
		game.load.image('explosion', 'assets/explosion.png')
		game.load.image('wreckship', 'assets/wreckship.png')


	create: () ->
		# TODO : Fix nameLabel display
		nameLabel = game.add.text(80, 80, 'BattleShip', { font: '50px Arial', fill: '#000000' })
		pseudo = prompt('Votre nom')
		window.pseudo = pseudo
		socket.emit 'pseudo',pseudo
		console.log pseudo
		# attend la réponse du serveur pour lancer une partie
		game.state.start('ship')

}
