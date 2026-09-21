# Projet-Aurora — notes dev (prototype HD-2D)

Vertical slice **Godot 4** (moteur figé, pas Unreal). Priorité : jouable > lore.
Le lore complet reste discuté hors dépôt ; ici, seulement ce qui sert au code.

## Lancer

Nécessite Godot 4.7+ (renderer OpenGL « Compatibility »).

```bash
# Éditeur
godot --path .

# Exécuter directement la scène principale
godot --path . res://scenes/Exploration.tscn

# Sans GPU (VM/CI), forcer le pilote logiciel :
godot --rendering-driver opengl3 --path .
```

## Contenu du slice

- `scenes/Exploration.tscn` (`scripts/exploration.gd`) : monde 3D low-poly texturé
  pixel, perso **Sprite3D billboard**, caméra JRPG en angle, lumière directionnelle,
  **bloom + DOF + brouillard** (recette HD-2D). Contient un totem et une rencontre.
- `scenes/Player.tscn` (`scripts/player.gd`) : `CharacterBody3D` + `Sprite3D` billboard,
  déplacement ZQSD / flèches.
- `scenes/Totem.tscn` (`scripts/totem.gd`) : borne-totem (stub) ; `[E]` offre une
  **sparkle équipable**.
- `scenes/Combat.tscn` (`scripts/combat.gd`) : **combat tour par tour minimal** (1 ennemi).
  L'action « Intention » utilise la sparkle équipée.
- `scripts/game_state.gd` : autoload (entrées, inventaire, sparkle équipée, transitions).
- `scripts/sparkle.gd` : ressource `Sparkle` (nom, totem, intention, bonus).

## Boucle visée (stub)

explorer → recueillir des sparkles → équiper → intentions → combos d'équipe.

## Lore figé (référence courte)

4 totems : Ours/Courage, Hibou/Connaissance, Cerf/Partage, Panthère/Instinct.
Sparkles = inspiration djinn (pas une copie). Hiérarchie : Père → Pape → archevêques
→ Kael/Sora. Prologue = deuil de Naya (ch.1–5), ch.6 Pape, ch.7 bonus.
