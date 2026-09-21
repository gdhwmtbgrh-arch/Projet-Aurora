import Phaser from "phaser";
import { GAME_WIDTH, GAME_HEIGHT } from "../main";
import { TOTEMS } from "../data/totems";

/**
 * Socle d'exploration minimal : un personnage déplaçable et quatre bornes-totems
 * qui révèlent une ligne de lore à l'approche. Ce n'est PAS un système de combat,
 * d'inventaire ou de quête — rien de tout cela n'existe encore.
 */
export class PrologueScene extends Phaser.Scene {
  private player!: Phaser.Physics.Arcade.Image;
  private cursors!: Phaser.Types.Input.Keyboard.CursorKeys;
  private keys!: Record<string, Phaser.Input.Keyboard.Key>;
  private infoText!: Phaser.GameObjects.Text;
  private totemMarkers: { x: number; y: number; vertu: string; nom: string }[] = [];

  constructor() {
    super("PrologueScene");
  }

  create(): void {
    this.add.rectangle(GAME_WIDTH / 2, GAME_HEIGHT / 2, GAME_WIDTH - 40, GAME_HEIGHT - 40, 0x141a2e);

    this.add
      .text(GAME_WIDTH / 2, 40, "Prologue — Le clocher d'Aurora", {
        fontFamily: "Georgia, serif",
        fontSize: "26px",
        color: "#ffd36e",
      })
      .setOrigin(0.5);

    this.add
      .text(GAME_WIDTH / 2, 74, "Flèches / ZQSD pour explorer · approchez un totem", {
        fontFamily: "system-ui, sans-serif",
        fontSize: "15px",
        color: "#8f9bb3",
      })
      .setOrigin(0.5);

    const positions = [
      { x: 220, y: 200 },
      { x: GAME_WIDTH - 220, y: 200 },
      { x: 220, y: GAME_HEIGHT - 150 },
      { x: GAME_WIDTH - 220, y: GAME_HEIGHT - 150 },
    ];
    TOTEMS.forEach((totem, i) => {
      const p = positions[i];
      this.add.circle(p.x, p.y, 28, totem.couleur).setStrokeStyle(3, 0x0b0e1a);
      this.add
        .text(p.x, p.y + 44, `${totem.nom} · ${totem.vertu}`, {
          fontFamily: "system-ui, sans-serif",
          fontSize: "14px",
          color: "#c8d0e4",
        })
        .setOrigin(0.5);
      this.totemMarkers.push({ x: p.x, y: p.y, vertu: totem.vertu, nom: totem.nom });
    });

    this.physics.world.setBounds(30, 90, GAME_WIDTH - 60, GAME_HEIGHT - 120);
    this.player = this.physics.add.image(GAME_WIDTH / 2, GAME_HEIGHT / 2, "dot-player");
    this.player.setCollideWorldBounds(true);

    this.infoText = this.add
      .text(GAME_WIDTH / 2, GAME_HEIGHT - 32, "", {
        fontFamily: "system-ui, sans-serif",
        fontSize: "17px",
        color: "#ffd36e",
      })
      .setOrigin(0.5);

    this.cursors = this.input.keyboard!.createCursorKeys();
    this.keys = this.input.keyboard!.addKeys("W,A,S,D,Z,Q") as Record<
      string,
      Phaser.Input.Keyboard.Key
    >;
  }

  update(): void {
    const speed = 220;
    const body = this.player.body as Phaser.Physics.Arcade.Body;
    body.setVelocity(0);

    const leftKey = this.cursors.left.isDown || this.keys.A.isDown || this.keys.Q.isDown;
    const rightKey = this.cursors.right.isDown || this.keys.D.isDown;
    const upKey = this.cursors.up.isDown || this.keys.W.isDown || this.keys.Z.isDown;
    const downKey = this.cursors.down.isDown || this.keys.S.isDown;

    if (leftKey) body.setVelocityX(-speed);
    else if (rightKey) body.setVelocityX(speed);
    if (upKey) body.setVelocityY(-speed);
    else if (downKey) body.setVelocityY(speed);
    body.velocity.normalize().scale(speed);

    let near: { vertu: string; nom: string } | null = null;
    for (const m of this.totemMarkers) {
      if (Phaser.Math.Distance.Between(this.player.x, this.player.y, m.x, m.y) < 70) {
        near = m;
        break;
      }
    }
    this.infoText.setText(
      near ? `Totem ${near.nom} — vertu : ${near.vertu}. (Une sparkle scintille…)` : "",
    );
  }
}
