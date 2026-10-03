# 07 — Relier ça à Aurora

## Objectif

Savoir ce que le slice démontre, et quoi construire ensuite sans changer de moteur.

## Ce que tu as entre les mains

| Leçon | Système de jeu |
| --- | --- |
| 2D Ruelles | Déplacement, murs, ramassage, échec, interface |
| 3D Sanctuaire | Les mêmes règles en volume, avec une caméra JRPG |
| HD-2D | Le look : pixels nets, sprite dans la lumière, bloom, brouillard |
| Totem | Une sparkle équipée, liée à une vertu |
| Combat | Un tour, une intention qui lit cette sparkle |

Le lore déjà posé (quatre totems, culte, prologue de Naya) n’a pas besoin d’être réécrit dans le code. Le code n’en utilise qu’un morceau : **Ours / Courage**, **Elora**, une sparkle, un garde.

## Suite utile, dans l’ordre

1. Quatre totems, pas quatre scripts : des `@export` sur la même scène.
2. Deux personnages en combat, pas encore quatre. Une intention chacun.
3. Remplacer le dessin généré par de vrais PNG (Piskel ou équivalent).
4. Une maison en quelques `BoxMesh`, textures nearest, plutôt qu’un cube gris.
5. Le combat dans la même scène 3D : deux `Sprite3D`, une `OmniLight3D` qui s’allume quand l’intention part.

Le point 5 est ce qui rapprochera le combat de la vidéo Kanto. La règle du tour par tour, elle, est déjà là.

## Ce qu’il ne faut pas faire maintenant

- Changer pour Unreal. Le frein n’est pas le moteur, c’est le nombre de scènes et de dessins.
- Copier les djinns de Golden Sun système par système. La sparkle ici est une intention équipée, pas un inventaire de 50 invocations.
- Écrire le roman dans le dépôt avant d’avoir une deuxième pièce où marcher.

## Exercice final

Duplique le totem. Le second donne `Sparkle du Hibou`, intention `Connaissance`, bonus `6`. Marche de l’un à l’autre et vérifie que `GameState` ne garde que la dernière sparkle équipée. Écris en une phrase, dans `art/notes.txt`, si le jeu doit **empiler** les sparkles ou **remplacer** celle qui est équipée. Les deux sont des jeux différents. Choisis avant d’en coder un troisième.

Le corrigé de cette partie est dans [solutions/hd2d](../solutions/hd2d/). Il correspond aux leçons 2 à 6, avec un seul totem.
