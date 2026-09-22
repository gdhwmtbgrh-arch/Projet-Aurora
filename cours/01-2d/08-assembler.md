# 08 — Assembler et vérifier

## Objectif

Repasser la boucle entière et corriger la scène avant de passer à la 3D.

## Arbre attendu

`main.tscn` ressemble à ceci :

```text
Main (Node2D, scripts/main.gd)
├── Sol (Polygon2D)
├── Mur, Mur2, … (StaticBody2D + collision + polygone)
├── Etincelles (Node2D)
│   ├── Etincelle, Etincelle2, Etincelle3
├── Joueur (instance)
├── Garde (instance)
└── CanvasLayer
    └── Score (Label)
```

## Liste de contrôle

Lance `F5` et coche :

- [ ] Les flèches déplacent le joueur, la caméra suit.
- [ ] Les murs arrêtent le joueur et le garde.
- [ ] Chaque étincelle disparaît une seule fois.
- [ ] Le texte passe de `0 / 3` à `La ruelle s'ouvre.`
- [ ] Toucher le garde affiche la défaite, puis recharge.
- [ ] Après un rechargement, les 3 étincelles sont revenues.

## Ranger le projet

- Scènes dans `scenes/`, scripts dans `scripts/`.
- Un script par objet. `main.gd` orchestre, il ne déplace pas le joueur.
- Les nombres que tu veux régler (`speed`, `objectif`) sont des `@export` ou des variables en haut du fichier, pas des valeurs cachées au milieu d’une fonction.

## Ce que tu réutiliseras

| Idée 2D | Plus tard |
| --- | --- |
| `CharacterBody` + `velocity` + `move_and_slide` | Le même schéma en 3D |
| `Area` + `body_entered` + groupe | Le totem et les sparkles |
| Signal `collected` | L’inventaire |
| `CanvasLayer` + `Label` | Le combat au tour par tour |
| Scène rechargée | Retour exploration après le combat |

## Exercice final

Change une seule règle et fais-la marcher de bout en bout : l’objectif passe à 5, tu places 5 étincelles, le texte suit. Si tu changes l’objectif sans ajouter d’étincelles, la victoire devient impossible : c’est un bon test pour voir si tu lis encore le compteur.

Corrigé des scripts : [solutions/2d](../solutions/2d/).

Ensuite ouvre [la partie 3D](../02-3d/README.md). **Nouveau projet**, ne transforme pas `Ruelles` en 3D.
