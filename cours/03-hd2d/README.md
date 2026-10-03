# Partie 3 — HD-2D « AuroraSlice »

Nouveau projet : `AuroraSlice`. Rendu : **Forward+**. C’est le look d’Octopath et de la vidéo Kanto : un **décor 3D** éclairé, des **personnages en pixels** qui font face à la caméra, du **bloom**, du **brouillard**, un peu de **flou** au loin.

Tu ne dessines pas encore tout le jeu. Tu fabriques une scène que tu peux relancer : marcher, lire un totem, recevoir une sparkle, entrer dans un combat au tour par tour, revenir.

## Leçons

1. [Ce qu’est le HD-2D](01-principes.md)
2. [Pixels nets](02-pixels.md)
3. [Le personnage en Sprite3D](03-sprite3d.md)
4. [Caméra, bloom, brouillard](04-post-process.md)
5. [Le totem et la sparkle](05-totem.md)
6. [Combat au tour par tour](06-combat.md)
7. [Relier ça à Aurora](07-vers-aurora.md)

## Résultat attendu

Un sprite pixel marche sur un sol texturé, éclairé, un peu flou au fond. Devant le totem, `E` donne une sparkle. Une zone de rencontre ouvre un combat : Attaquer, Intention (plus forte si une sparkle est équipée), Garde. `E` après la fin revient à l’exploration. Le personnage s’appelle **Elora**.

Corrigé : [solutions/hd2d](../solutions/hd2d/).
