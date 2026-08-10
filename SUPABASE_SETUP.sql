-- ============================================================================
-- SUPABASE-OPSÆTNING TIL "ER DET EGENTLIG DANKORT?"
-- Kør hele filen i Supabase SQL Editor ved første opsætning.
-- Tabellen indeholder kun offentlig, redaktionel kampagnedata.
-- ============================================================================

-- Scriptet nulstiller tabellen, så både første og gentagne testkørsler får
-- præcis den samme enkle struktur. Brug derfor ikke scriptet efter, at rigtige
-- redaktionelle ændringer er lavet uden først at tage en kopi af dataene.
drop table if exists public.benefit_stories cascade;

-- Opretter tabellen med de tekstfelter, som Astro-sitet henter.
-- Visuelle valg som farve og illustration ligger bevidst i kode/CSS.
create table public.benefit_stories (
  id bigint generated always as identity primary key,
  slug text unique not null,
  title text not null,
  eyebrow text not null,
  summary text not null,
  body text not null,
  takeaways text[] not null default '{}',
  category text not null check (category in ('natur', 'butikker', 'beredskab')),
  sort_order integer not null default 0,
  published boolean not null default true,
  created_at timestamptz not null default now()
);

-- Row Level Security gør, at adgang skal styres gennem en policy.
alter table public.benefit_stories enable row level security;

-- Anonyme besøgende må læse tabellen, men ikke oprette, ændre eller slette.
grant select on table public.benefit_stories to anon;
revoke insert, update, delete on table public.benefit_stories from anon;

-- Policyen begrænser den offentlige læseadgang til rækker med published = true.
create policy "Public can read published benefit stories"
on public.benefit_stories
for select
to anon
using (published = true);

-- ============================================================================
-- INDHOLD: DANSK NATUR
-- ============================================================================
insert into public.benefit_stories
  (slug, title, eyebrow, summary, body, takeaways, category, sort_order, published)
values
  (
    'dansk-natur',
    'Små betalinger. En fælles naturindsats.',
    'Dankort Øremærket',
    'Når mange små bidrag lægges sammen, kan hverdagens betalinger blive til noget større for dansk natur.',
    $$Et øre lyder ikke af meget. Men når mange Dankort-betalinger lægges sammen, bliver de små bidrag til en fælles indsats. Med Dankort Øremærket går 1 øre pr. gennemført Dankort-betaling til Den Danske Naturfond.

Du behøver ikke købe eller betale mere end normalt. Pointen er, at en betaling, du allerede foretager, kan få en lille ekstra værdi, når mange gør det samme.

Det første skridt er derfor bare at vide, om din betaling faktisk går gennem Dankort.$$,
    array[
      'Små bidrag kan blive til noget større, når mange deltager.',
      'Du behøver ikke ændre dit forbrug for at bidrage.',
      'Start med at undersøge, om din betaling går gennem Dankort.'
    ],
    'natur',
    1,
    true
  );

-- ============================================================================
-- INDHOLD: DANSKE BUTIKKER
-- ============================================================================
insert into public.benefit_stories
  (slug, title, eyebrow, summary, body, takeaways, category, sort_order, published)
values
  (
    'danske-butikker',
    'Et kortvalg kan også betyde noget for butikken.',
    'Danske butikker',
    'Dankort kan være et billigere alternativ for mange danske butikker end store internationale betalingskort.',
    $$Når du betaler, er oplevelsen ofte den samme: kortet eller mobilen hen til terminalen, og betalingen er gennemført. Bag den enkle handling ligger der forskellige betalingssystemer og omkostninger.

Dankort kan være et billigere alternativ for mange danske butikker end store internationale betalingskort. Som kunde ser du ikke nødvendigvis forskellen ved kassen, men for en butik med mange betalinger kan små forskelle i omkostninger samle sig over tid.

Det betyder, at dit kortvalg også kan have betydning for de steder, du allerede bruger — fra caféer og butikker til webshops.$$,
    array[
      'Betalingsomkostninger ligger bag den betaling, du ser ved kassen.',
      'Små forskelle kan få betydning, når en butik har mange betalinger.',
      'Dit kortvalg kan derfor også have betydning for butikken.'
    ],
    'butikker',
    2,
    true
  );

-- ============================================================================
-- INDHOLD: OFFLINEBETALING OG BEREDSKAB
-- ============================================================================
insert into public.benefit_stories
  (slug, title, eyebrow, summary, body, takeaways, category, sort_order, published)
values
  (
    'offline-betaling',
    'Betaling, når forbindelsen ikke gør.',
    'Beredskab',
    'Dankort er en del af det danske betalingsberedskab og kan understøtte offlinebetaling i særlige situationer.',
    $$De fleste betalinger sker uden, at vi tænker over infrastrukturen bag dem. Netværk, terminaler og betalingssystemer arbejder i baggrunden, indtil noget midlertidigt ikke fungerer.

Dankort har mulighed for offlinebetaling i særlige situationer som en del af det danske betalingsberedskab. Det betyder, at et betalingsmiddel også kan have værdi, når normale forbindelser midlertidigt er udfordrede.

Det handler ikke om at forvente nedbrud, men om robusthed. Offlinebetaling er én af flere forskelle, der kan være værd at kende, når du vælger betalingskort.$$,
    array[
      'Offlinebetaling er en praktisk beredskabsfunktion.',
      'Funktionen er især relevant i særlige situationer.',
      'Det er endnu en forskel, der kan være værd at kende.'
    ],
    'beredskab',
    3,
    true
  );