import Phaser from "phaser";
import { GAME_WIDTH, GAME_HEIGHT } from "../main";
import { TOTEMS } from "../data/totems";

export class TitleScene extends Phaser.Scene {
  constructor() {
    super("TitleScene");
  }

  create(): void {
    this.add
      .text(GAME_WIDTH / 2, 90, "PROJET-AURORA", {
        fontFamily: "Georgia, serif",
        fontSize: "56px",
        color: "#ffd36e",
      })
      .setOrigin(0.5);

    this.add
      .text(GAME_WIDTH / 2, 140, "JRPG d'exploration — totems & sparkles", {
        fontFamily: "Georgia, serif",
        fontSize: "20px",
        color: "#b9c2d8",
      })
      .setOrigin(0.5);

    const startX = GAME_WIDTH / 2 - (TOTEMS.length - 1) * 100;
    TOTEMS.forEach((totem, i) => {
      const x = startX + i * 200;
      const y = 260;
      this.add.circle(x, y, 34, totem.couleur).setStrokeStyle(3, 0x0b0e1a);
      this.add
        .text(x, y + 56, totem.nom, {
          fontFamily: "Georgia, serif",
          fontSize: "22px",
          color: "#e8e6df",
        })
        .setOrigin(0.5);
      this.add
        .text(x, y + 82, totem.vertu, {
          fontFamily: "system-ui, sans-serif",
          fontSize: "16px",
          color: "#8f9bb3",
        })
        .setOrigin(0.5);
    });

    const prompt = this.add
      .text(GAME_WIDTH / 2, GAME_HEIGHT - 70, "Appuyez sur ENTRÉE pour commencer le prologue", {
        fontFamily: "system-ui, sans-serif",
        fontSize: "18px",
        color: "#e8e6df",
      })
      .setOrigin(0.5);

    this.tweens.add({
      targets: prompt,
      alpha: 0.25,
      duration: 900,
      yoyo: true,
      repeat: -1,
    });

    this.input.keyboard?.once("keydown-ENTER", () => {
      this.scene.start("PrologueScene");
    });
    this.input.once("pointerdown", () => {
      this.scene.start("PrologueScene");
    });
  }
}
