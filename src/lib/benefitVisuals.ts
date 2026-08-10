import type { BenefitCategory } from "../types/benefit";

// Kobler hver kategori til den tilhørende lokale illustration.
export function getBenefitIllustration(category: BenefitCategory): string {
  switch (category) {
    case "natur":
      return "/illustrations/nature.svg";

    case "butikker":
      return "/illustrations/shops.svg";

    case "beredskab":
      return "/illustrations/offline.svg";
  }
}
