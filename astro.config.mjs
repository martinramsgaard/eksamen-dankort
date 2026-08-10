import { defineConfig } from "astro/config";

// Fælles Astro-konfiguration.
export default defineConfig({
  // Den endelige offentlige adresse bruges bl.a. til korrekte absolutte URL'er.
  site: "https://eksamen-dankort.netlify.app",

  // Static betyder, at Astro genererer færdige HTML-filer under build.
  output: "static",
});
