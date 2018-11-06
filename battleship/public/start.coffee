# Entrer le pseudo et attendre le début d'une partie
window.startState = {
	preload: () ->
		console.log 'preload', game
		#game.load.image('ship', 'ship.png')
		game.load.image('ship2', 'boats/boat2.png')
		game.load.image('ship3', 'boats/boat3.png')
		game.load.image('ship4', 'boats/boat4.png')
		game.load.image('ship5', 'boats/boat5.png')


	create: () ->
		# TODO : Fix nameLabel display
		nameLabel = game.add.text(80, 80, 'BattleShip', { font: '50px Arial', fill: '#000000' })
		pseudo = prompt('Votre nom')
		console.log pseudo
		# attend la réponse du serveur pour lancer une partie
		game.state.start('ship')

}
