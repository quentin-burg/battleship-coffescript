# Entrer le pseudo et attendre le début d'une partie
window.startState = {
	preload: () ->
		console.log 'preload', game
		game.load.image('ship', 'ship.png')


	create: () ->
		nameLabel = game.add.text(80, 80, 'BattleShip', { font: '50px Arial', fill: '#FFFFFF' })
		pseudo = prompt('Votre nom')
		console.log pseudo
		# attend la réponse du serveur pour lancer une partie
		game.state.start('ship')

}