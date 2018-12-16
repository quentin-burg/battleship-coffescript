# TP CoffeeScript 

##Quentin Burg, Alexia Omietanski

### Première partie
Le but de cette première partie est de vous familiariser avec la syntaxe de CoffeeScript. 
Pour cela, nous vous proposons d'implémenter le jeu **Plus ou Moins**. Ce jeu consiste à deviner un nombre généré aléatoirement en suivant les indications du système qui vous dira si le nombre que vous avez donné est plus grand ou plus petit que celui qu'il faut deviner. 

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
Le code que l'on vous a fourni vous permet de vous connecter, de placer vos bateaux mais il ne vous permet pas de jouer. Ça va être à vous de gérer cette partie afin de pouvoir défier vos collègues! ;-) 

#### Question 3
La première chose à gérer est le tir d'un missile dans la fonction **update** du fichier **play.coffee**.
N'hésitez pas à parcourir les fonctions du fichier, certaines vous seront surement utiles.
L'évènement *mouse.isDown* vous permet de savoir lorsqu'un clic a été fait sur la page. 
Afin de récupérer les coordonnées de la souris, vous disposez des attributs *mouse.positionDown.x* et *mouse.positionDown.y*. 
Vous devez alors: 
- Vérifier si les coordonnées du clic correspondent à une case de la grille et que le joueur était autorisé à jouer
- Si c'est le cas il faut récupérer et stocker la case correspondant aux coordonnées du clic
- Dessiner le missile en utilisant la fonction *game.add.sprite(x,y,{nom de l'image})* et stocker le tout dans une variable appelée *sprite* déclarée plus haut. (Cela nous permettra ensuite de l'effacer quand on dessinera le résultat à la question 9). **On vous conseille de soustraire 40 aux coordonnées x et y du clic afin que le dessin soit centré au milieu de la case.**
- Changer la taille de l'image à 80x80 en utilisant les attributs *width* et *height* de la valeur stockée précedemment.
- Ne plus autoriser le joueur à jouer. 
- Emettre la case sélectionnée et stockée précedemment ainsi que le pseudo au serveur via la socket à l'aide de la fonction *emit*. (On vous conseille d'utiliser un objet afin de pouvoir traiter les informations plus facilement côté serveur)

Vous pouvez à présent tester le code écrit en lançant le serveur. Lorsque vous cliquez sur une case, un petit missile doit se dessiner sur cette case.

#### Question 4
Maintenant que vous savez quelle case a été choisie par le joueur et que le serveur le connaît également, vous allez pouvoir traiter cette information pour renvoyer le résultat au joueur qui vient de tirer. 
Pour cela vous devez d'abord récupérer les informations précédemment envoyées. Placez-vous dans le fichier **index.coffee** qui contient le code du serveur. 
Vous y trouverez des exemples de récupération de données telles que le pseudo par exemple, vous pouvez (et devez) vous en inspirer afin de récupérer le pseudo et la case touchée que vous avez envoyé à la question 3. 

Pour tester ce que vous venez d'écrire, vous pouvez utiliser *console.log* pour afficher le contenu de ce que vous avez récupéré.

#### Question 5
La prochaine étape est de traiter les données reçues, ce qui sera fait dans le corps de la fonction dont vous avez dû écrire l'en-tête à la question 4.
Cependant, avant toute chose, il va falloir que vous signaliez à l'autre joueur qu'il peut à présent jouer (fait dans la question 8). 
Pour cela, vous disposez de l'objet *Room* qui est composé d'un ID et de deux joueurs.
Vous devez donc vous débrouiller pour récupérer l'objet *Room* dans laquelle se trouve le joueur ayant tiré.
Stockez ce résultat dans une variable, vous en aurez besoin pour la question 6.

Si vous souhaitez tester ce que vous venez d'écrire, vous pouvez également utiliser *console.log* pour afficher les id des deux joueurs de la *Room*.


#### Question 6
A présent, le joueur a envie de connaître le résultat de son tir, de savoir si il a touché ou coulé un bateau ou si le tir est dans l'eau. 
Vous allez alors écrire une fonction qui prendra deux paramètres:
- Une grille contenant toutes les cases ainsi que les informations sur les positions des bateaux
- L'étiquette d'une case (A1 par exemple)

Une grille est composée de listes que l'on appelera "colonnes", qui elles-mêmes sont composées de listes qu'on appelera "cellules" ou "cases". Chacune de ces cases est composée d'une étiquette (A2 par exemple), de coordonnées x et y mais vous n'avez pas besoin de vous en occuper ici et enfin d'un champ *hasShip* si il y a un bateau sur cette case, sinon il est inexistant. La valeur de *hasShip* contient le nom du bateau qui est dessus. La case d'étiquette A1 aura un champ hasShip qui aura pour valeur *ship1* si vous avez placé votre bateau de taille 1 dessus.
Il vous faut donc parcourir *chaque cellule* de *chaque colonne* et pour chacune de ces cellules: tester si l'étiquette de cette cellule correspond à l'étiquette passée en paramètre, et si c'est le cas, tester si cette cellule a un bateau. *Si ce n'est pas le cas*, alors on retourne "O" pour dans l'eau. Si il y a bien un bateau, il faut à présent tester si le bateau est simplement *touché* ou *coulé*. 
Vous pouvez commencer par ajouter un champ *state* à la cellule avec la valeur "T" afin de déclarer que le bateau de cette cellule a été touché et passer à la question suivante pour gérer le cas où le bateau est coulé.

Pour tester ce que vous venez d'écrire, vous pouvez encore une fois utiliser *console.log* afin de vérifier que lorsque vous cliquez sur une case sans bateau vous obtenez bien "O"

#### Question 7
Afin de savoir si le bateau est coulé, vous allez devoir écrire un prédicat qui renverra vrai si le bateau est coulé et faux sinon. 
Ce prédicat prendra deux paramètres:
- Une grille contenant toutes les cases
- Le nom du bateau (ship1, ship2 ou ship3)

Il va d'abord falloir récupérer la taille du bateau et la stocker dans une variable. Pour cela vous pouvez simplement récupérer le numéro dans le nom du bateau. 
Lors de la question précédente, vous avez ajouté un champ *state* à la cellule lorsqu'elle a été touchée, vous devez donc trouver un moyen de savoir si le bateau est coulé à l'aide de ce champ qui dit si le bateau a été touché, la taille du bateau et le nom du bateau.
Rajouter ensuite le test de ce prédicat dans la fonction écrite précemment. Vous allez donc pouvoir retourner *"T"* pour *touché* si le prédicat renvoie *faux* et *"C"* pour *coulé* si le prédicat renvoie *vrai*.

Vous pouvez tester de la même façon que la question précédente.

#### Question 8
A présent, vous allez devoir envoyer le résultat du tir au joueur concerné mais également devoir dire à son adversaire que c'est à son tour de jouer.
Pour cela, vous allez devoir écrire une fonction qui prendra 4 paramètres:
- La case touchée
- L'objet *Room* récupéré de la fonction de la question 5
- Le pseudo du joueur qui a effectué le tir
- L'objet socket qui lui est associé. (Ne vous prenez pas trop la tête pour cet objet, c'est la socket sur laquelle on émet et sur laquelle on écoute nommée simplement *socket*)

Vous allez donc devoir: 
- Récupérer l'objet *Player* du joueur adverse à partir de l'objet *Room*. Une fonction présente dans le fichier **index.coffee** vous y aidera
- Stocker la grille de ce joueur dans une variable
- Récupérer et stocker le résultat du tir en appelant la fonction de la question 7
- Envoyer le résultat au joueur qui a effectué le tir
- Envoyer au joueur adverse qu'il peut jouer en émettant sur sa socket (stockée dans l'objet *Player*)

Vous pouvez ensuite appeler cette fonction avec les paramètres décrits plus haut dans le résultat du tir du joueur dont vous avez écrit l'en-tête à la question 4 et que vous avez complétée avec l'appel de la fonction écrite à la question 5.

#### Question 9
C'est terminé pour la partie serveur. Vous entrez dans la dernière ligne droite avant de pouvoir (enfin) jouer. Il faut à présent traiter les informations que le client (joueur) vient de recevoir du serveur pour pouvoir l'afficher. Pour cela, placez-vous dans le fichier **play.coffee**.
Premièrement, il faut que vous géreriez le dessin d'une image sur la grille. Pour cela, vous allez devoir écrire une fonction qui prend 3 paramètres:
- La coordonnée x de la cellule dans laquelle vous voulez dessiner l'image
- La coordonnée y de cette même cellule
- Le nom de l'image que vous voulez dessiner

Cette fonction devra d'abord supprimer le *sprite* du missile que vous avez dû stocker dans la variable *sprite* lors de la question 3 puis dessiner le *sprite* du nom en paramètre aux coordonnées x,y et enfin en changer la taille en 80x80.

#### Question 10
Enfin, vous allez devoir récupérer les données envoyées par le serveur comme vous avez pu le faire dans le fichier **index.coffee** en utilisant l'objet *socket*. Cela se fait toujours dans la fonction **update** du fichier **play.coffee**.
Dans le traitement de ces données, il va falloir tester la valeur de retour du tir:
- Si c'est dans l'eau vous devez dessiner l'image *water*
- Si c'est touché vous devez dessiner l'image *explosion*
- Si c'est coulé vous devez dessiner l'image *wreckship*

De plus, il faut tester si tous les bateaux sont coulés afin de détecter la fin du jeu. Pour cela vous disposez de la liste *touchedShips*. Lorsque cette liste a une taille égale au nombre total de bateaux (3), la partie est terminée. Pour cela il faut simplement changer l'état du jeu avec *game.state.start('end')* pour entrer dans l'état appelé *end*.

⚠️  Attention, la fonction **update** est appelée plusieurs fois à la suite, faites bien attention à n'ajouter qu'une seule fois les bateaux, sinon vous n'aurez jamais le bon résultat... ⚠️

Voilà, c'est terminé. 🎉 
Vous avez réussi le challenge et vous pouvez à présent vous amuser avec votre jeu **Bataille Navale**. :-D