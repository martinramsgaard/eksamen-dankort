import type { BenefitStory } from "../types/benefit";

// Forbindelsen til Supabase hentes fra projektets miljøvariabler.
const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
const supabaseKey = import.meta.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY;

// Kun de felter, som sitet bruger, hentes fra databasen.
const selectedFields = [
  "id",
  "slug",
  "title",
  "eyebrow",
  "summary",
  "body",
  "takeaways",
  "category",
  "sort_order",
  "published",
].join(",");

// Henter alle publicerede historier fra Supabase.
export async function getBenefitStories(): Promise<BenefitStory[]> {
  // Hvis forbindelsen mangler, returneres en tom liste.
  if (!supabaseUrl || !supabaseKey) {
    console.warn(
      "Supabase er ikke forbundet. Tilføj PUBLIC_SUPABASE_URL og PUBLIC_SUPABASE_PUBLISHABLE_KEY.",
    );
    return [];
  }

  // Historierne hentes og sorteres efter deres rækkefølge i databasen.
  const endpoint = `${supabaseUrl}/rest/v1/benefit_stories?select=${selectedFields}&published=eq.true&order=sort_order.asc`;

  try {
    const response = await fetch(endpoint, {
      headers: {
        apikey: supabaseKey,
      },
    });

    // Ved fejl skrives status i terminalen, og sitet får en tom liste.
    if (!response.ok) {
      console.error(
        `Supabase kunne ikke hente historier. HTTP-status: ${response.status}`,
      );
      return [];
    }

    const stories = (await response.json()) as BenefitStory[];
    return stories;
  } catch (error) {
    // Håndterer fx manglende netværksforbindelse under build.
    console.error(
      "Der opstod en netværksfejl ved hentning fra Supabase.",
      error,
    );
    return [];
  }
}
