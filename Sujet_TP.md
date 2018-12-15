# TP CoffeeScript 

##Quentin Burg, Alexia Omietanski

### Première partie
Le but de cette première partie est de vous familiariser avec la syntaxe de CoffeeScript. 
Pour cela, nous vous proposons d'implémenter le jeu **Plus ou Moins**. Ce jeu consiste à deviner un nombre généré aléatoirement en suivant les indications du système qui vous dira si le nombre que vous avez donné
est plus grand ou plus petit que celui qu'il faut deviner. 

#### Question 1
Commencez d'abord par écrire une fonction qui permet de générer aléatoirement un nombre. Cette fonction aura pour paramètres *une borne supérieure* et *une borne inférieure*. 
Pour cela vous disposez des librairies de JavaScript telle que la librairie **Math** qui propose la fonction *Math.random()*. Cependant elle ne renvoie qu'un chiffre entre 0 et 1, il faut donc trouver l'astuce pour que ce chiffre soit situé entre votre borne supérieure et votre borne inférieure.

#### Question 2
A présent vous pouvez commencer à implémenter le jeu. Vous devez alors:
    1. Demander à l'utilisateur d'entrer un nombre
    2. Le comparer au nombre généré aléatoirement et dire si c'est plus, si c'est moins ou si l'utilisateur a découvert le bon nombre
    3. Recommencer à l'étape 1 si la réponse n'est pas la bonne


### Partie 2
Maintenant que vous avez commencé à prendre en main la syntaxe de CoffeeScript, on va pouvoir passer aux choses sérieuses...
On vous propose donc d'écrire le code du jeu de la bataille navale. Pour ceux qui ne connaîtraient pas le principe de ce jeu, il consiste à tenter de couler la flotte adverse avant que votre adversaire n'ai coulé la vôtre. 

Bon, comme on est gentils, on a écrit la plupart du code mais il reste cependant quelques blancs à combler.
Le code que l'on vous a fourni vous permet de vous connecter, de placer vos bateaux mais il ne vous permet pas de jouer. Ça va être à vous gérer cette partie afin de pouvoir défier vos collègues! ;-) 

#### Question 3
La première chose à gérer est le tir d'un missile dans la fonction **update** du fichier **play.coffee**.
N'hésitez pas à parcourir les fonctions du fichier, certaines vous seront surement utiles.
L'évènement *mouse.isDown* vous permet de savoir lorsqu'un clic a été fait sur la page. 
Afin de récupérer les coordonnées de la souris, vous disposez des attributs *mouse.positionDown.x* et *mouse.positionDown.y*. 
Vous devez alors: 
    - Vérifier si les coordonnées du clic correspondent à une case de la grille et que le joueur était autorisé à jouer
    - Si c'est le cas il faut récupérer et stocker la case correspondant aux coordonnées du clic
    - Dessiner le missile en utilisant la fonction *game.add.sprite(x,y,{nom de l'image})* et stocker le tout dans une variable appelée *sprite* déclarée plus haut. (Cela nous permettra ensuite de l'effacer quand on dessinera le résultat). **On vous conseille de soustraire 40 aux coordonnées x et y du clic afin que le dessin soit centré au milieu de la case.**
    - Changer la taille de l'image à 80x80 en utilisant les attributs *width* et *height* de la valeur stockée précedemment.
    - Ne plus autoriser le joueur à jouer. 
    - Emettre la case sélectionnée et stockée précedemment ainsi que le pseudo au serveur via la socket. (On vous conseille d'utiliser un objet afin de pouvoir traiter les informations plus facilement côté serveur)

#### Question 4