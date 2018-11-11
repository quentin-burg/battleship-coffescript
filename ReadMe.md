Code écrit en CoffeeScript et compilé en JS
-> Lancer le test.html pour pouvoir jouer au jeu.

CheatSheet pour phaser.io
https://gist.github.com/woubuc/6ef002051aeef453a95b

# TODO

## Drag and drop

- dessiner un bateau lorsqu'on lache le drag@drop dans les cases correspondantes - ajouter les bateaux (4 ou 5 bateaux)
  => Il reste à gérer qq cas d'erreur comme avoir placer tous les bateaux avant de jouer
- verifier que deux bateaux ne soient pas sur la meme case

=> DESSIN BATEAUX SUR LA GRILLE

## Grille

- Remplacer le nombre de cases par une variable
- une fois les bateaux placés on clique sur un bouton pour finir et cela redessine une grille vierge pour jouer
- Gerer le clic sur une case pour dire "je veux attaquer ici"
- disable notre grille pendant que l autre joue et lorsqu'on a cliqué

## Communication client / serveur

- Envoyer le pseudo sur le serveur
- Envoyer les positions des bateaux sur le serveur
- Envoyer la position du clic pour attaquer
- Recupérer l'etat de la case et l'afficher sur la grille

## Serveur

- Creer une partie quand il y a deux joueurs connectés
- lorsqu'un client se deconnecte la partie se termine
- Gerer le tour d'un joueur
- Gerer le touché / coulé / dans l'eau
- Gérer la fin de la partie

# TODFOJGOER

- afficher notre grille et celle ou il y a nos bateaux pour voir ou l'adeversaire joue
