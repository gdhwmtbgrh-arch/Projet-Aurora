# 00 — Avant de commencer

## Objectif

Avoir Godot 4 qui s’ouvre, et savoir créer un projet vide.

## Installer sans droits administrateur

1. Va sur [https://godotengine.org/download](https://godotengine.org/download).
2. Télécharge **Godot Engine**, version **standard** (pas .NET), pour ton système. Sur Windows, prends le fichier `.zip` 64 bits.
3. Décompresse-le dans un dossier à toi, par exemple `Documents/Godot`.
4. Lance `Godot.exe` (ou `Godot` sur Linux / macOS). Aucune installation système n’est nécessaire.

Si le navigateur ou le disque d’entreprise bloque le téléchargement, copie le zip depuis une clé ou un autre poste, puis décompresse-le au même endroit.

## Premier projet

1. Dans le Gestionnaire de projets : **Nouveau projet**.
2. Nom : `Ruelles`.
3. Dossier : `Documents/GodotProjets/Ruelles` (un dossier que tu peux écrire).
4. Rendu : **Compatibilité** pour ce premier projet 2D. On changera plus tard pour le HD-2D.
5. **Créer et modifier**.

Tu dois voir quatre zones :

- **Système de fichiers** (en bas à gauche) : les fichiers du jeu.
- **Scène** (en haut à gauche) : l’arbre des nœuds de la scène ouverte.
- **Vue** (au centre) : le jeu.
- **Inspecteur** (à droite) : les réglages du nœud sélectionné.

## Raccourcis à connaître

| Action | Raccourci |
| --- | --- |
| Lancer le jeu | `F5` (la première fois, choisis la scène principale) |
| Lancer la scène ouverte | `F6` |
| Arrêter | `F8` |
| Ajouter un nœud | `Ctrl+A` |
| Sauvegarder la scène | `Ctrl+S` |
| Annuler | `Ctrl+Z` |

## Règle de rangement

Dès le premier projet, crée trois dossiers dans `res://` (clic droit dans Système de fichiers → **Nouveau dossier**) :

- `scenes`
- `scripts`
- `art`

Une scène = un objet réutilisable (joueur, étincelle, garde). Le script porte le même nom que la scène.

## Exercice

Crée le projet `Ruelles`, les trois dossiers, et une scène `scenes/main.tscn` dont la racine est un nœud `Node2D` nommé `Main`. Enregistre-la. Avec `F5`, choisis cette scène comme scène principale. La fenêtre de jeu s’ouvre, vide : c’est normal.

## Bloqué ?

- Godot ne démarre pas : lance le binaire qui est **dans le zip**, pas un installeur.
- « Accès refusé » : le projet est sur un disque protégé. Déplace-le sous `Documents`.
- La vue est grise : tu n’as pas encore de nœud visible. La leçon suivante en ajoute un.
