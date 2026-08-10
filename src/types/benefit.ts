// De tre kategorier, som historierne kan tilhøre.
export type BenefitCategory = "natur" | "butikker" | "beredskab";

// Beskriver de data, som en historie hentes med fra Supabase.
export interface BenefitStory {
  id: number;
  slug: string;
  title: string;
  eyebrow: string;
  summary: string;
  body: string;
  takeaways: string[];
  category: BenefitCategory;
  sort_order: number;
  published: boolean;
}
