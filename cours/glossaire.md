# Glossaire

| Mot | Sens dans Godot |
| --- | --- |
| Nœud | Une brique (image, collision, caméra, lumière). |
| Scène | Un arbre de nœuds enregistré dans un fichier `.tscn`. On peut l’instancier plusieurs fois. |
| Instance | Une copie vivante d’une scène, posée dans une autre scène. |
| Racine | Le nœud tout en haut de la scène. |
| Script | Un fichier `.gd` en GDScript, attaché à un nœud. |
| Signal | Un message envoyé par un nœud (« le joueur est entré », « le bouton est pressé »). Un autre script peut l’écouter. |
| Groupe | Une étiquette (`player`, `guard`) pour reconnaître un nœud sans connaître son nom. |
| Collision | Forme invisible qui bloque ou détecte un contact. L’image ne collisionne pas toute seule. |
| `CharacterBody2D` / `CharacterBody3D` | Corps que **tu** déplaces avec `velocity` et `move_and_slide()`. |
| `StaticBody2D` / `StaticBody3D` | Mur ou sol qui ne bouge pas. |
| `Area2D` / `Area3D` | Zone qui détecte une entrée, sans bloquer le mouvement. |
| Sprite | Image du personnage ou de l’objet. `Sprite2D` en 2D, `Sprite3D` dans un monde 3D. |
| Billboard | Le sprite 3D se tourne toujours vers la caméra. |
| Nearest | Filtre de texture qui garde les pixels nets (pas de flou). |
| Autoload | Script global, disponible sous un nom (`GameState`) dans toutes les scènes. |
| HD-2D | Monde 3D modélisé et éclairé, personnages dessinés en pixel art, plus bloom, brouillard et flou de profondeur. |
