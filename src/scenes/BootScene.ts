import Phaser from "phaser";

/**
 * Génère les seules "textures" du socle de façon procédurale afin de ne
 * dépendre d'aucun asset binaire. Aucun contenu de gameplay ici.
 */
export class BootScene extends Phaser.Scene {
  constructor() {
    super("BootScene");
  }

  create(): void {
    this.makeDot("dot-player", 0xe8e6df);
    this.makeDot("dot-totem", 0xffd36e);
    this.scene.start("TitleScene");
  }

  private makeDot(key: string, color: number): void {
    const size = 24;
    const g = this.make.graphics({ x: 0, y: 0 }, false);
    g.fillStyle(color, 1);
    g.fillRoundedRect(0, 0, size, size, 6);
    g.generateTexture(key, size, size);
    g.destroy();
  }
}
