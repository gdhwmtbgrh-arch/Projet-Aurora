export interface Totem {
  id: "ours" | "hibou" | "cerf" | "panthere";
  nom: string;
  vertu: string;
  couleur: number;
}

export const TOTEMS: Totem[] = [
  { id: "ours", nom: "Ours", vertu: "Courage", couleur: 0xc0562e },
  { id: "hibou", nom: "Hibou", vertu: "Connaissance", couleur: 0x3f6fb0 },
  { id: "cerf", nom: "Cerf", vertu: "Partage", couleur: 0x4c9b6a },
  { id: "panthere", nom: "Panthère", vertu: "Instinct", couleur: 0x7a4ca0 },
];
