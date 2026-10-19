# Er det egentlig Dankort?

https://eksamen-dankort.netlify.app

Et digitalt kampagnesite udviklet som 2. semester-eksamensprojekt på Multimediedesign.

Løsningen tager udgangspunkt i spørgsmålet om, hvorvidt unge ved, hvilket betalingskort der faktisk ligger bag deres betaling – særligt når kortet bruges gennem en mobil wallet.

Sitet guider brugeren gennem tre overordnede trin:

1. **Tjek mærket** – undersøg hvilket kort der ligger bag betalingen.
2. **Se forskellen** – læs om forskellige sider af Dankort.
3. **Vælg med vilje** – undersøg mulighederne og tag selv stilling til næste skridt.

## Teknologi

Projektet er bygget med:

- Astro
- HTML
- CSS
- JavaScript
- TypeScript-typer i Astro
- Supabase
- Netlify

Der er ikke anvendt et JavaScript-framework som React eller Vue.

Supabase-data hentes med almindelig `fetch()` fra Supabases REST API.

## Supabase

De tre historier om:

- dansk natur
- danske butikker
- betalingsberedskab

ligger i Supabase-tabellen `benefit_stories`.

Astro henter de publicerede historier under build, og `getStaticPaths()` bruges til at generere én dynamisk historieside for hver `slug`.

Den lokale fil:

```text
SUPABASE_SETUP.sql
```

indeholder tabellens struktur, Row Level Security-policy og startindhold.

### Miljøvariabler

Projektet kræver to miljøvariabler:

```env
PUBLIC_SUPABASE_URL=
PUBLIC_SUPABASE_PUBLISHABLE_KEY=
```

`.env.example` viser den nødvendige struktur.

Den rigtige `.env`-fil er tilføjet til `.gitignore` og skal ikke pushes til GitHub.

## Korttjek

Forsiden indeholder et korttjek med tre spørgsmål.

Korttjekket bruger almindelig JavaScript og arbejder kun med de svar, brugeren vælger i browseren. Brugeren skal ikke indtaste kortnummer, bankoplysninger eller login.

Resultatet er vejledende og hjælper brugeren videre til enten historierne om Dankort eller den praktiske guide.

## Projektstruktur

```text
public/
├── illustrations/
├── dankort-logo.svg
├── favicon.svg
└── robots.txt

src/
├── components/
├── layouts/
├── lib/
├── pages/
│   ├── derfor-dankort/
│   │   ├── [slug].astro
│   │   └── index.astro
│   ├── 404.astro
│   ├── index.astro
│   └── saadan-faar-du-dankort.astro
├── styles/
└── types/

SUPABASE_SETUP.sql
astro.config.mjs
netlify.toml
package.json
```

## Responsivt layout

Løsningen er bygget mobile-first.

Det primære breakpoint ligger ved:

```css
@media (min-width: 800px);
```

Her skifter centrale layouts fra én kolonne til desktop-layout med flere kolonner.

## Kør projektet lokalt

Installer dependencies:

```bash
npm install
```

Opret en `.env`-fil ud fra `.env.example` og indsæt projektets Supabase-værdier.

Start derefter udviklingsserveren:

```bash
npm run dev
```

Astro viser herefter den lokale adresse, normalt:

```text
http://localhost:4321/
```

## Build

Et produktions-build laves med:

```bash
npm run build
```

De færdige statiske filer genereres i:

```text
dist/
```

Buildet genererer også de dynamiske historiesider ud fra de publicerede Supabase-data.

## Formatering

Projektet bruger Prettier.

Koden kan formatteres med:

```bash
npm run format
```

## Deployment

Projektet er konfigureret til Netlify.

`netlify.toml` bruger:

```text
Build command: npm run build
Publish directory: dist
```

Projektets konfigurerede Netlify-adresse er:

```text
https://eksamen-dankort.netlify.app
```
