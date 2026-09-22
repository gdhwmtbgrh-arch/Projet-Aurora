# 04 — Caméra, bloom, brouillard

## Objectif

Donner à la scène la profondeur d’un diorama.

## Caméra

Garde le script de suivi de la partie 3D. Réglages qui marchent bien pour ce style :

- `offset = (0, 8, 10)`
- `fov` de la caméra : `40` (inspecteur, projection perspective)
- La caméra regarde le buste, pas le sol entre les pieds

Un champ étroit (35 à 45) ressemble plus à une longue focale de cinéma. Un champ large (70 et plus) ressemble à une GoPro : les maisons gonflent sur les bords.

## Environnement

Sur le `WorldEnvironment` :

- Fond : couleur `#141a2e`, ou un **PanoramaSky** si tu as une image de ciel peinte.
- Ambiante : `#5b6b93`, énergie `0.45`.
- Tonemap : **Filmic**.
- **Glow** activé. Intensity `0.8`, Bloom `0.15`. Si toute l’image devient laiteuse, baisse l’intensité. Le bloom ne doit éclairer que ce qui est déjà clair (l’orbe, le totem).
- **Fog** activé. Couleur `#243056`, densité `0.02`. Le fond de la cour se noie un peu. Si tu ne vois plus le joueur, la densité est trop haute.

## Flou de profondeur

Ça se règle sur la **caméra**, pas sur l’environnement. Sélectionne `CameraJRPG` → **Attributes** → **Nouveau CameraAttributesPractical**.

- Far Enabled
- Far Distance : `12`
- Far Transition : `8`
- Blur Amount : `0.08`

Le joueur, au centre, reste net. Les cubes loin derrière se ramollissent. Si le sprite bave alors qu’il est au milieu, vérifie `alpha_cut` de la leçon précédente.

Le flou est faible ou absent en rendu **Compatibilité**. Reste en **Forward+** sur ton PC.

## Soleil

`DirectionalLight3D`, rotation `(-55, -35, 0)`, énergie `1.2`, couleur `#fff2d6`, ombres activées.

Une `OmniLight3D` jaune, énergie `3`, au-dessus de l’endroit où sera le totem. C’est elle qui doit « bloommer », pas tout l’écran.

## Exercice

Règle le bloom trop fort exprès, prends une capture mentale (« ça bave »), puis redescends jusqu’à ce que seuls les objets émissifs débordent. Note les trois nombres (intensity, bloom, densité du fog) dans `art/notes.txt`. Ce sont tes réglages, pas une loi.

## Bloqué ?

- Aucun glow : le rendu n’est pas Forward+, ou Glow n’est pas coché.
- L’ombre du sprite est un rectangle plein : `alpha_cut` est encore sur Opaque / Disabled. Passe en Opaque Prepass.
- La caméra entre dans le sol : l’offset Y est trop petit pour la distance Z.
