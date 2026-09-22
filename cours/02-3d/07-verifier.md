# 07 — Vérifier la scène

## Arbre attendu

```text
Monde (Node3D, scripts/monde.gd)
├── Sol (MeshInstance3D, PlaneMesh)
├── SolBody (StaticBody3D + CollisionShape3D)
├── Repere, Mur, Mur2, … 
├── Orbes
│   └── Orbe × 3
├── Joueur
├── CameraJRPG (cible = Joueur)
├── DirectionalLight3D
├── WorldEnvironment
├── OmniLight3D
└── CanvasLayer
    └── Score
```

## Liste de contrôle

- [ ] La capsule marche avec les flèches et ne tombe pas à travers le sol.
- [ ] La caméra suit en oblique, sans passer en vue épaule.
- [ ] Les murs bloquent. Le décor sans collision ne bloque pas.
- [ ] Les orbes se ramassent et le texte va jusqu’à `Le sanctuaire répond.`
- [ ] On distingue une face éclairée, une face à l’ombre, et une ombre au sol.

## Ce qui change au HD-2D

Tu gardes ce monde. Tu remplaces la capsule par un **sprite pixel** planté dans la scène 3D. Les lumières, le sol et la caméra restent.

Corrigé : [solutions/3d](../solutions/3d/).

Suite : [partie HD-2D](../03-hd2d/README.md).
