aleat = (min,max) -> return Math.floor(min + (max-min+1)*Math.random());

jeu = (num) -> 
        msg = "C'est compris entre 1 et 63"
        saisie = parseInt(prompt(msg))
        if saisie == num then return "Vous avez gagné" 
        else 
          if saisie < num then alert "C'est plus"
          else alert "C'est moins"
          return jeu(num)
            
          
res = aleat(1,63)        
alert jeu(res)