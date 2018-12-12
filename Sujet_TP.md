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

