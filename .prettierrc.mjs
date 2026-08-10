/** @type {import("prettier").Config} */
export default {
  // Pluginet lærer Prettier at formatere .astro-filer korrekt.
  plugins: ["prettier-plugin-astro"],

  // Astro-parseren anvendes eksplicit på alle .astro-filer.
  overrides: [
    {
      files: "*.astro",
      options: {
        parser: "astro",
      },
    },
  ],
};
