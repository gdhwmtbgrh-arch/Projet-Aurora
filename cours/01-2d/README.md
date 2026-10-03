# Partie 1 — Jeu 2D « Ruelles »

Tu construis un petit jeu en vue de dessus. Un personnage marche dans une ruelle, ramasse 3 étincelles et évite un garde. Si le garde le touche, la scène recommence.

C’est le même genre de boucle que l’exploration d’un JRPG, en plus simple : **se déplacer, interagir avec le monde, échouer, recommencer**.

## Leçons

1. [L’éditeur : nœuds et scènes](01-editeur.md)
2. [Le minimum de GDScript](02-gdscript.md)
3. [Le joueur se déplace](03-joueur.md)
4. [Le monde et les murs](04-monde.md)
5. [Ramasser avec un signal](05-collecte.md)
6. [Un garde qui patrouille](06-ennemi.md)
7. [Score et défaite](07-interface.md)
8. [Assembler et vérifier](08-assembler.md)

## Projet

Ouvre le projet `Ruelles` créé dans la leçon 00. Rendu **Compatibilité**. Scène principale : `scenes/main.tscn`.

## Résultat attendu

`F5` : tu te déplaces avec les flèches, tu ramasses les étincelles, le texte compte `0 / 3` puis `3 / 3`, le garde fait des allers-retours, le contact recharge la scène.
