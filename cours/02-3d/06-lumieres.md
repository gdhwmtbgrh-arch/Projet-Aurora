# 06 — Lumières

## Objectif

Éclairer la cour pour que les volumes se lisent. Sans lumière dédiée, tout est plat et gris.

## Soleil

Sous `Monde`, ajoute `DirectionalLight3D`.

- Rotation : `(-50, -40, 0)` degrés.
- **Shadow Enabled**.
- Energy : `1.2`.
- Color : `#fff2d6` (soleil un peu chaud).

Tu dois voir une face claire et une face sombre sur les cubes, et une ombre sur le sol.

## Ambiance

Ajoute `WorldEnvironment`. Dans **Environment** → **Nouveau Environment**.

- Background Mode : **Color**, couleur `#141a2e`.
- Ambient Light Source : **Color**.
- Ambient Light Color : `#5b6b93`, énergie `0.5`.

La lumière ambiante évite que les faces à l’ombre deviennent noires. Le soleil donne la direction. Les deux ensemble font un volume lisible.

## Une lampe locale

Ajoute `OmniLight3D` près d’une orbe, position un peu au-dessus du sol, énergie `2`, couleur `#ffd36e`, ombre activée. L’orbe éclaire le sol autour d’elle. C’est le même principe que les sorts d’Octopath : une lumière ponctuelle en plus de l’effet visuel.

## Exercice

Désactive le soleil (coche **Visibility** du nœud, icône œil) et regarde la scène seulement avec l’ambiante, puis seulement avec l’omni. Remets les trois.

## Bloqué ?

- Pas d’ombres : **Shadow Enabled** est décoché, ou le rendu du projet est **Compatibilité** avec des réglages trop bas. Passe le projet en Forward+ : Projet → Paramètres → Rendu → Méthode de rendu.
- Tout est blanc : énergie du soleil trop forte, ou plusieurs soleils superposés. Un seul `DirectionalLight3D`.
- Le fond reste gris : le `WorldEnvironment` n’a pas d’Environment assigné.
