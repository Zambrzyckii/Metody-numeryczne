# PROJECT_BRIEF — Projekt 1 (MACD), Metody Numeryczne

Version 0.4 · 2026-10-20 · status: sections 0–4 and appendices complete; sections 5–6 are placeholders.

---

## 0. How to use this brief

This is a **one-time genesis document**. A new Claude Code session reads it once and materializes the project scaffold from it:

- a short `CLAUDE.md` (orchestration protocol + pointers to `docs/`),
- `docs/*.md` (requirement extracts, style, AI log),
- `.claude/agents/*.md` (role definitions copied from section 2).

After that, sessions work from `CLAUDE.md` and `docs/`. This file stays in the repo as the record of the original intent and is not loaded into every session.

**Source-of-truth hierarchy.** On conflict, the higher source wins and the discrepancy is reported to the user:

1. Lecturer's PDFs in `materials/`: `Projekt_1.pdf`, `zasady_zaliczenia_projektu_v1.pdf`
2. This brief
3. `docs/*.md`
4. Agent instructions

**Rules for any session using this brief:**

- Every statement about a requirement carries a reference `file p. N`. A claim without a reference is treated as suspect.
- A section marked *placeholder* is not filled in by the agent on its own initiative. Ask the user.
- Do not guess APIs, file names or requirements. Check the source or say "I don't know".
- Code, identifiers, comments, commits and agent instructions are in English. Communication with the user and slide content are in Polish.

**Relation to the user's global `~/.claude/CLAUDE.md`** *(proposal — confirm or strike)*. The global rules ("explain the plan before code", "deliver in batches of a few dozen lines") govern **what the orchestrator shows the user**:

- a plan before each stage,
- a report after each stage,
- diffs summarized in digestible portions.

Git is handled by the orchestrator only, following `~/.claude/rules/git.md`: a commit after each finished and verified step, no AI markers in commit messages. Subagents never commit.

Subagents implement a full task card. The orchestrator then presents the result to the user in portions.

---

## 1. Cele

### 1.1 Cel nadrzędny

Zaliczyć projekt 1 tak, żeby pokazać, że w dobrze ustawionych warunkach AI przyspiesza żmudną pracę bez utraty jakości. Każda liczba na slajdzie musi pochodzić z programu, każde twierdzenie musi mieć źródło, a każdy błąd AI musi zostać wykryty i opisany.

Decyzje projektowe i interpretację wyników podejmuje użytkownik. Agenci wykonują produkcję: kod, wykresy, LaTeX i recenzje.

### 1.2 Cele punktowane

Wysiłek rozkładamy proporcjonalnie do punktów.

**Prezentacja wstępna — 2 pkt** (`Projekt_1.pdf` s. 9, tab. 1):

| Element (0,4 pkt każdy) | Kryterium akceptacji | Źródło |
|---|---|---|
| Wstęp: opis MACD | ok. 3 slajdy: czym jest MACD, do czego służy, jak się go oblicza; równania EMA (1), MACD (2), SIGNAL (3) z objaśnieniem symboli; ogólne znaczenie algorytmu bez każdego szczegółu | `Projekt_1.pdf` s. 5, p. 4.1 |
| Sposób pracy i konfiguracja AI | wybór narzędzi, organizacja pracy, role agentów; jedno zagadnienie opisane dobrze zamiast stu skrótowo | `zasady` s. 4, p. 5.2 |
| Wybrany prompt, rezultat, ocena | jeden konkretny prompt z rzeczywistym wynikiem i naszą oceną | `Projekt_1.pdf` s. 8, p. 6.1 |
| Raport o błędach AI | ok. 3 slajdy z opisem przykładu błędnego działania AI; jeśli błędu nie było, to dosłowna deklaracja: *„W trakcie prac nad projektem nie zauważyłem/zauważyłam błędnego działania AI."* | `zasady` s. 4, p. 5.3 |
| Recenzja AI | ok. 4 slajdy: opis recenzenta i jego kryteriów, prompt recenzji (lub fragmenty), ocena słowna + liczbowa 1–10; preferowany jeden slajd z oceną | `zasady` s. 5, p. 6.3 |

Slajd tytułowy: temat, imię i nazwisko, informacja „prezentacja wstępna" (`Projekt_1.pdf` s. 5, p. 4.1).

**Prezentacja końcowa — 8 pkt** (`Projekt_1.pdf` s. 9, tab. 2):

| Element | Pkt | Źródło szczegółów |
|---|---|---|
| Wstęp i opis współpracy z AI (jak w tab. 1) | 2,0 | j.w. |
| Czytelna interpretacja wykresów A1, B1, C1, C2 | 1,5 | `Projekt_1.pdf` s. 6, p. 4.2 A–C |
| Analiza wybranej transakcji, wykres D1 | 0,5 | s. 6, p. 4.2 D |
| Symulacja całego szeregu: E1, E2, statystyki i wnioski ze slajdu F | 2,0 | s. 6–7, p. 4.2 E–F, p. 4.4 |
| Część eksperymentalna: uzasadnienie i opis (0,5), analiza zbioru wektorów cen (1,0), przykład lokalny (0,5) | 2,0 | s. 7–8, p. 5 |

Część eksperymentalna złożona wyłącznie z porównania z „kup i trzymaj" daje maksymalnie 0,5 pkt (`Projekt_1.pdf` s. 9).

Ocenie podlega jakość analizy i zgodność z wymaganiami. Wysokość zysku ani liczba narzędzi AI nie wpływają na ocenę (`Projekt_1.pdf` s. 8, p. 6.2). Ocena recenzenta AI nie wyznacza punktów (`zasady` s. 5, p. 6.3).

### 1.3 Bramki niezaliczenia

Brak któregokolwiek z poniższych elementów oznacza niezaliczenie do czasu poprawy (`zasady` s. 2).

**Każda prezentacja:**

- obecność na zajęciach,
- PDF skompilowany z LaTeX-a,
- kompilacja zdefiniowana w `Makefile`,
- numeracja na każdym slajdzie w formacie „n/N",
- trzy grupy slajdów: wstęp o algorytmie, błędy AI lub deklaracja, recenzja AI,
- ZIP z PDF-em, źródłami, `Makefile` i plikami potrzebnymi do kompilacji.

**Format** (`zasady` s. 4–5, p. 6.1):

- 16:9 (`aspectratio=169`), czytelność na 4K,
- około 8 minut wystąpienia,
- wykresy wektorowe, bez zrzutów ekranu,
- czcionki osadzone,
- PDF sprawdzony w trybie pełnoekranowym.

**Projekt** (`zasady` s. 2–3; `Projekt_1.pdf` s. 9, p. 6.3):

- kod wyłącznie w plikach `.py` (notebooki Jupyter są niedozwolone),
- program odtwarza dane prezentowane na slajdach,
- `readme.md` zawiera polecenie generujące **każdy** wykres, z oznaczeniami A1–E2,
- przy użyciu szablonów lub materiałów pomocniczych: `zrodla.md` w głównym katalogu kodu,
- plagiat kodu Python lub LaTeX = wyzerowanie projektu.

### 1.4 Terminy

| Termin | Co | Kiedy |
|---|---|---|
| P2 | Prezentacja wstępna; ZIP ze slajdami | zajęcia 2026-10-21 (godzina: *do uzupełnienia*); ZIP **godzinę przed** zajęciami |
| P3 | Prezentacja końcowa; ZIP nr 1 (slajdy) + ZIP nr 2 (kod) | *do uzupełnienia* (ok. 2 tygodnie po P2); ZIP-y godzinę przed zajęciami |

Spóźnienie kosztuje 0,2 pkt za każde rozpoczęte 24 h opóźnienia ZIP-a lub za każdy dzień opóźnienia wystąpienia (`zasady` s. 3, p. 4.1).

### 1.5 Pakowanie: biała lista

Pakujemy według białej listy. Nie wykluczamy wszystkich plików `*.md`, bo dwa z nich są obowiązkowe.

| ZIP | Zawiera |
|---|---|
| Prezentacja (P2 i P3 nr 1) | `slides/<preliminary|final>/` (PDF, `.tex`, `Makefile`, użyte wykresy) oraz `slides/common/` (wspólny plik stylu), `charts/` (wykresy użyte na slajdach) i `results/*.tex` (liczby wstawiane do slajdów) — wszystko potrzebne do kompilacji, z zachowaniem struktury katalogów |
| Kod (P3 nr 2) | `src/`, dane wejściowe części podstawowej z `data/`, `readme.md`, `zrodla.md` (jeśli dotyczy), plik zależności |

Nigdy nie pakujemy: `.venv/`, `CLAUDE.md`, `PROJECT_BRIEF.md`, `docs/`, `.claude/`, `materials/` (materiały prowadzącego, w tym wspólny zbiór `dane_pro1.zip`) (`Projekt_1.pdf` s. 9; `zasady` s. 2).

### 1.6 Czego świadomie nie robimy

Każdy z tych punktów zwiększa ryzyko slopu bez zysku punktowego:

- testy jednostkowe (wyjątek: jeden skrypt porównujący własną rekurencję EMA z `pandas ewm(adjust=False)`),
- animacje i overlaye Beamera,
- drugi wskaźnik w części eksperymentalnej,
- CI, pre-commit, git worktree,
- skille ponad cztery role z sekcji 2,
- wykres świecowy w A1 (opcjonalny — tylko jeśli zostanie czas i użytkownik zdecyduje).

### 1.7 Otwarte decyzje użytkownika

| Decyzja | Rekomendacja | Kiedy |
|---|---|---|
| Instrument części podstawowej | stooq.pl, np. PKO BP lub WIG20 (`Projekt_1.pdf` s. 4) | po P2 |
| Opóźnienie wykonania d | d = 1, wariant sugerowany (`Projekt_1.pdf` s. 3–4) | po P2 |
| Kierunek eksperymentu | RSI jako dodatkowy warunek decyzji, kierunek zalecany (`Projekt_1.pdf` s. 7) | po P2 |
| Data P3 | — | uzupełnić |

---

## 2. Agents

### 2.1 Orchestration model

The main Claude Code session is the orchestrator. There is no separate orchestrator agent (see Appendix A, ADR-1). The orchestrator:

1. Talks to the user and brings back decisions, stage reports and requests for interpretive theses.
2. Delegates work via **task cards** (2.4).
3. Routes every work product through the matching reviewer:
   - `coder` → `code-reviewer`
   - `latex-assistant` → `presentation-reviewer`
4. Runs verification scripts itself and hands their output to reviewers, since reviewers cannot execute anything.
5. Appends an **ai-log entry** (2.6) after every delegated task.
6. Adds an entry to `zrodla.md` immediately whenever an external template or snippet is used.

### 2.2 Enforced vs. conventional boundaries

This distinction is stated honestly because it will be presented on a slide.

- **Enforced by the tool:** the `tools:` whitelist in an agent's frontmatter. An agent without `Edit`, `Write` or `Bash` cannot modify files.
- **Conventional (instruction only):** path scopes such as "edit only `slides/`". The `tools:` field has no path scoping, and `settings.json` permissions apply to the whole project, not to a single agent.
- **Consequence:** both reviewers get only `Read, Glob, Grep`, so their read-only status is enforced, not promised.

| Role | `tools` (enforced) | `model` / `effort` | Conventional scope | Needed before P2 |
|---|---|---|---|---|
| `coder` | Read, Glob, Grep, Edit, Write, Bash | inherit / medium | `src/`, `charts/`, `results/`; only from a task card | no |
| `code-reviewer` | Read, Glob, Grep | opus / high | checklist in `docs/requirements-code.md` | no |
| `latex-assistant` | Read, Glob, Grep, Edit, Write, Bash | inherit / medium | `slides/` only; Bash only for `make` | **yes** |
| `presentation-reviewer` | Read, Glob, Grep | opus / high | criteria from three sources (`zasady` p. 5, 6.3) | **yes** |

Model choice rationale: reviewers get the stronger model and higher effort, because a missed defect costs more than a slower review. Producers inherit the session model. Frontmatter fields used below (`name`, `description`, `model`, `effort`, `tools`) were verified against agent files installed on this machine.

### 2.3 Rules shared by all agents (anti-slop)

- **No invented facts.** No invented numbers, citations, API names or requirements. If a fact is not in the repo or the lecturer's PDFs, say so.
- **Traceable numbers.** Every number that appears on a slide comes from a file in `results/` generated by the program. Never type a result by hand.
- **Plain technical tone.** No filler, no marketing tone, no emoji, no decorative icons.
- **Small scope.** Do only what the task card says. Report anything else you notice as a finding, and do not fix it.
- **Stop and ask.** When a requirement is ambiguous or two sources conflict, stop and report instead of choosing silently.
- **Honest reports.** If something failed or was skipped, say so explicitly.

### 2.4 Template: task card

The orchestrator fills this in for every delegation.

```markdown
## Task card: <short title>
Goal: <one sentence — what exists after this task that did not exist before>
Requirements slice (with refs):
  - <requirement> — <file p. N>
Files to touch: <paths>
Files NOT to touch: <paths>
Acceptance checklist:
  - [ ] <verifiable criterion>
  - [ ] <verifiable criterion>
Report format: what was done · files changed · what was NOT done and why · open questions
```

### 2.5 Template: reviewer finding

Every finding uses these fields. They map 1:1 onto ai-log fields, so the "AI errors report" slide can be built straight from the log.

```markdown
- Finding: <what is wrong, one sentence>
  Severity: blocker | major | minor | nit
  Requirement: <file p. N, or "style guide §X">
  Detected by: <how — e.g. comparing formula (3) with the code, reading the compile log>
  Suggested fix: <one sentence; reviewers never apply fixes>
```

Severity scale:

- **blocker:** breaks a mandatory condition (section 1.3).
- **major:** loses points under section 1.2.
- **minor:** hurts readability.
- **nit:** cosmetic.

### 2.6 Template: ai-log entry (`docs/ai-log.md`)

```markdown
### <YYYY-MM-DD> · <agent> · <task title>
- Goal: <from the task card>
- Prompt / brief: <verbatim or key fragment>
- Result: <what came back, links to files>
- Evaluation: <did it meet the acceptance checklist; our assessment>
- AI errors detected: <findings in 2.5 format, or "none">
- Slide candidate: <which graded element from section 1.2 this can illustrate, or "—">
```

### 2.7 Agent definitions

Copy each block below verbatim into `.claude/agents/<name>.md`.

#### `coder`

```markdown
---
name: coder
description: Implements one task card at a time in the Python code of the MACD project (src/, charts/, results/). Use for any code-writing task; never for review.
model: inherit
effort: medium
tools: Read, Glob, Grep, Edit, Write, Bash
---
You implement exactly one task card for a numerical-methods student project (MACD indicator and trading simulation).

Before writing code:
- Read the task card and the requirement slices it references in docs/requirements-code.md.
- If the card conflicts with the docs or the lecturer's PDFs, stop and report. Do not choose silently.

While writing code:
- Python scripts only (.py), no notebooks.
- Follow the conventions in docs/ and the existing code. New code must not stand out.
- Use the symbol names from the instruction where the instruction gives them (cash, position_qty, equity).
- Any number that will appear on a slide is written by the program to results/, never printed for manual copying.
- Charts are saved as vector PDF to charts/.

Out of scope:
- Do not touch files outside the paths listed on the card.
- Do not install packages.
- Do not write tests unless the card asks for them.
- Do not commit.

Finish with a report in the card's format: what was done · files changed · what was NOT done and why · open questions.
```

#### `code-reviewer`

```markdown
---
name: code-reviewer
description: Read-only reviewer that checks MACD project code against the lecturer's requirements and the project's conventions. Use after every coder task; it reports findings and never edits.
model: opus
effort: high
tools: Read, Glob, Grep
---
You review code for compliance with requirements, not for taste. You cannot run code. If you need execution output, ask the orchestrator for it.

Primary checklist: docs/requirements-code.md. Pay particular attention to the places where AI-generated code typically goes wrong in this project:
- EMA recursion and initial value per formula (1). pandas must use adjust=False.
- Signals counted only from sample 101. Sample 100 sets the initial portfolio state.
- Sign-change conditions for buy and sell per formula (4) and the rules on p. 2. No interpolation of crossings.
- Execution delay d. With d = 1, a signal at the last sample is not executed.
- Initial cash C_100 = 1000 * x_100.
- Full capital commitment: buy with all cash, sell the whole position.
- Return formulas (6) and (7). r = 0 counts as profitable.

Report every finding in this exact format:
- Finding: <one sentence>
  Severity: blocker | major | minor | nit
  Requirement: <file p. N or docs section>
  Detected by: <how you found it>
  Suggested fix: <one sentence>

End with a verdict: APPROVE or CHANGES REQUIRED, and a one-line justification. Do not pad the review. If you found nothing, say so plainly.
```

#### `latex-assistant`

```markdown
---
name: latex-assistant
description: Builds and edits the Beamer presentations (slides/) and their Makefiles for the MACD project. Use for any slide creation, layout or compilation task.
model: inherit
effort: medium
tools: Read, Glob, Grep, Edit, Write, Bash
---
You produce Beamer slides in Polish for a numerical-methods project presentation. Your scope is slides/ only. Use Bash only to run make and read compile logs.

Hard requirements (mandatory — missing any of them fails the presentation):
- aspectratio=169.
- Slide number "n/N" on every slide.
- Compiled through a Makefile.
- Fonts embedded.
- Figures included as vector PDF from charts/, never screenshots.

Content rules:
- Follow docs/presentation-style.md. If it does not exist yet, ask the orchestrator. Do not invent a visual style.
- Never type a numerical result by hand. Pull it from results/ (e.g. via \input of a generated .tex file).
- One message per slide: the title states the takeaway and the body is the evidence.
- No decorative icons, emoji, animations or overlays.

Process:
- After each change, compile and read the log.
- Report overfull boxes, missing figures and warnings, and do not hide them.
- If you use any external template or snippet, report its source so the orchestrator can add it to zrodla.md.

Finish with: what changed · compile status (clean / warnings with list) · open questions.
```

#### `presentation-reviewer`

```markdown
---
name: presentation-reviewer
description: Read-only AI reviewer of the project presentations. Grades a compiled PDF and its LaTeX sources against the course rules, the project instruction and presentation-quality guidelines; outputs a verbal grade and a 1-10 score. Never edits.
model: opus
effort: high
tools: Read, Glob, Grep
---
You review a student presentation (Polish, Beamer, 16:9, about 8 minutes) for a numerical-methods course. Your criteria come from three sources, as required by the course rules:
1. materials/zasady_zaliczenia_projektu_v1.pdf — mandatory conditions and slide groups.
2. materials/Projekt_1.pdf — the project instruction (preliminary vs. final presentation content).
3. docs/presentation-style.md and the presentation-guide principles it cites — readability, one message per slide, assertion-evidence titles.

Read both the compiled PDF and the .tex sources. Evaluate:
- Compliance with mandatory elements. Any missing mandatory element is a blocker.
- Comprehensibility of the MACD introduction.
- Layout and legibility at full screen: font sizes, contrast, overlaps, cropping.
- Correctness and readability of formulas and charts.
- Whether the conclusions follow from the evidence shown.
- Volume relative to 8 minutes.

Do not award course points. Your grade is advisory.

Report findings in this exact format:
- Finding: <one sentence>
  Severity: blocker | major | minor | nit
  Requirement: <file p. N or style-guide section>
  Detected by: <slide number and what you observed>
  Suggested fix: <one sentence>

End with:
- Verbal grade: <two or three sentences>
- Score: <integer 1-10> / 10, with a one-line justification
- Top 3 improvements, ordered by impact
```

---

## 3. Presentation visual style

This section is the visual contract for:

- `latex-assistant`, which builds slides,
- `coder`, which builds charts,
- `presentation-reviewer`, which uses it as the third source of criteria.

It is materialized as `docs/presentation-style.md`. Anything not allowed here is not used.

### 3.1 Principles

- **Assertion–evidence.** The frame title is a full-sentence claim of at most two lines, for example *„MACD reaguje na zmianę trendu z opóźnieniem kilku sesji"*. The body is the evidence for that claim: a chart, an equation or a table. Topic-only titles ("Wyniki", "Wykres B1") are not allowed on content slides.
- **One message per slide.** If a slide needs two claims, it becomes two slides.
- **Text budget.**
  - Result slides: at most two short sentences of text under the evidence.
  - Other slides: at most four bullets.
  - No paragraphs anywhere.
- **Length.** About 8 minutes (`zasady` p. 4, 6.1).
  - Preliminary deck: about 12–15 slides.
  - Final deck: about 20–25 slides.
  - The PDF may document more detail than is spoken. Detail slides are marked as such in the speaker's plan, not on the slide.
- **Third source for review criteria.** The presentation guides listed in `zasady` p. 6, section 7 (e.g. Naegle, Doumont, the Penn State assertion–evidence checklist). The principles above are taken from these guides' titles and descriptions. The guides themselves have not been reviewed in detail.

### 3.2 Palette

Colours are taken from the lecturer's own materials, measured from rendered pages. Contrast ratios are WCAG ratios against a white background.

| LaTeX name | Hex | Role | Source | Contrast |
|---|---|---|---|---|
| `mnPrimary` | `#173D56` | frame titles, accent rule, MACD line, equity line | heading colour in `Projekt_1.pdf` | 11.4:1 |
| `mnText` | `#182A3B` | body text | text colour in `charts_pro1.pdf` | 14.7:1 |
| `mnMuted` | `#4E6B7E` | footer, axis labels, secondary text, buy-and-hold line | secondary tone in `Projekt_1.pdf` | 5.6:1 |
| `mnBuy` | `#00856A` | buy signals, profitable results | up candle in `charts_pro1.pdf` | 4.6:1 |
| `mnSell` | `#C13F4B` | sell signals, losses | down candle in `charts_pro1.pdf` | 5.2:1 |
| `mnBuyLight` | `#6EB9AA` | histogram bars H > 0 | light up tone in `charts_pro1.pdf` | 2.3:1 (fills only) |
| `mnSellLight` | `#DB9198` | histogram bars H < 0 | light down tone in `charts_pro1.pdf` | 2.5:1 (fills only) |
| `mnSignal` | `#C26A1A` | SIGNAL line (dashed), modified algorithm in the experiment | orange dashed SIGNAL convention of `Projekt_1.pdf` fig. 1, darkened to reach 3:1 | 3.9:1 |
| `mnPrice` | `#9AA5B1` | price as the light background line in B1 | own choice; B1 requires a light background line (`Projekt_1.pdf` p. 6) | 2.5:1 (deliberate exception) |
| `mnGrid` | `#DCE3E8` | grid lines, thin rules | own choice | — |

Background is white. Copy the definitions verbatim:

```latex
\definecolor{mnPrimary}{HTML}{173D56}
\definecolor{mnText}{HTML}{182A3B}
\definecolor{mnMuted}{HTML}{4E6B7E}
\definecolor{mnBuy}{HTML}{00856A}
\definecolor{mnSell}{HTML}{C13F4B}
\definecolor{mnBuyLight}{HTML}{6EB9AA}
\definecolor{mnSellLight}{HTML}{DB9198}
\definecolor{mnSignal}{HTML}{C26A1A}
\definecolor{mnPrice}{HTML}{9AA5B1}
\definecolor{mnGrid}{HTML}{DCE3E8}
```

Rules:

- **Text colours.** Text uses only `mnText`, `mnPrimary`, `mnMuted`, `mnBuy` and `mnSell`, the colours with contrast of at least 4.5:1. The light colours, `mnSignal` and `mnPrice` are never used for text.
- **Buy and sell.** Buy and sell always differ by colour **and** by marker shape, ▲ for buy and ▼ for sell (`Projekt_1.pdf` p. 7, 4.5). This also keeps the charts readable for red–green colour-blind viewers.
- **Hex values.** No colours outside this table. If a new role appears, extend the table in this brief before using it.

### 3.3 Typography

- Engine: `pdflatex` with `[T1]{fontenc}`, `[polish]{babel}`, `lmodern` and `tgheros` as the sans family.
- Text is set in TeX Gyre Heros. Mathematics is set in Latin Modern serif (`\usefonttheme[onlymath]{serif}`).
- Class options: `\documentclass[aspectratio=169,11pt]{beamer}`.
- Font sizes:

  | Element | Size |
  |---|---|
  | Frame title | `\large`, bold, `mnPrimary` |
  | Body text | `\normalsize` |
  | Footer and source notes | `\footnotesize` (smallest allowed) |
  | `\scriptsize`, `\tiny` | not allowed |

- Polish typography: quotation marks „…", the long dash for ranges and asides, a decimal comma in running text. Numbers inserted from `results/` follow the same convention, which is the generator's responsibility.

### 3.4 Slide layout

- **Base.** The default Beamer theme stripped of decoration, with a custom style file `slides/common/mnstyle.sty` shared by both decks. No external Beamer theme, so `zrodla.md` needs no entry for it.
- **Frame title.** Left-aligned, `mnPrimary`, with a thin rule in `mnGrid` under it, full text width.
- **Footline.**
  - Left: `Imię Nazwisko · Projekt 1: MACD`, in `mnMuted` and `\footnotesize`.
  - Right: `\insertframenumber\,/\,\inserttotalframenumber`. This "n/N" number is a mandatory element (`zasady` p. 2).
- **Margins.** 8 mm left and right. Navigation symbols are off.
- **Title slide.** Topic, author, *„Prezentacja wstępna"* or *„Prezentacja końcowa"* (`Projekt_1.pdf` p. 5, 4.1), course name and date. No logo and no background image.
- **No overhead slides.** No agenda slide, section-divider slides or "Dziękuję"/"Pytania?" slide. Every slide carries content.

### 3.5 Slide types

These are the only allowed layouts.

| Type | Content |
|---|---|
| Title | as in 3.4 |
| Equation | claim title; at most three displayed equations, numbered as in `Projekt_1.pdf`; a symbol legend of at most four lines |
| Chart | claim title; one chart at full text width; at most two lines of conclusion |
| Stacked charts | claim title; two charts sharing the x-range, for C1/C2 and E1/E2 (`Projekt_1.pdf` p. 6) |
| Table | claim title; one `booktabs` table whose values come from `results/` via `\input` |
| Prompt | claim title; prompt excerpt in a monospace box of at most 10 lines (English, per ADR-5); result and evaluation in two lines |
| AI error | claim title; the finding fields from 2.5 (what, how it was detected, fix), one error per slide |
| AI review | claim title; reviewer configuration or prompt excerpt, or the verbal grade with the score shown as `N / 10` |

### 3.6 Chart style (matplotlib)

- **Format.** Vector PDF only, with no rasterized artists. Generated at the **exact final size** it will occupy on the slide and included without scaling (`\includegraphics{...}`, no `width=`). Font sizes on charts then equal the sizes set in the code.
  - Full width: 144 × 62 mm.
  - Stacked pair: 144 × 34 mm each.
- **Font.** TeX Gyre Heros, loaded with `matplotlib.font_manager.addfont` from the TeX Live path if the file exists. Otherwise fall back silently to the matplotlib default. The lecturer may run the code on Windows, so a missing font file must never crash generation.
- **Sizes.** Tick labels 8 pt, axis labels 9 pt, chart title 9 pt bold. Line width 1.2–1.6 pt. Signal markers 6 pt.
- **Required elements** (`Projekt_1.pdf` p. 7, 4.5):
  - an in-figure title naming the chart ID, the quantity and the instrument, e.g. `B1 · PKO BP — cena zamknięcia i MACD(12,26,9)`,
  - both axes labelled with units, for example `Cena [PLN]` or `Indeks próbki` / dates,
  - a legend covering every line, bar and marker.
- **Dual axis (B1).** Price on the left axis, MACD and SIGNAL on the right. Each axis label is coloured like its series, and legend entries name their axis.
- **Axes.** Top and right spines removed, except the right spine on dual-axis charts. Horizontal grid in `mnGrid`. Legend without a frame.
- **Signal markers.**
  - Executed signals: filled markers.
  - Signals not executed: hollow markers of the same shape and colour (`Projekt_1.pdf` p. 6, E1).
  - Before sample 101: no markers. The range 0–100 may be shaded in `mnGrid` and labelled as excluded (`Projekt_1.pdf` p. 6, A1).
- **Shared x-range.** C1/C2 and E1/E2 use `sharex` with an identical x-range.

### 3.7 Banned (anti-slop list)

The reviewer treats any occurrence as a finding of at least *minor* severity:

- **Imagery:** icons, emoji, clipart, stock photos, AI-generated images, logos, decorative shapes or background images.
- **Motion:** animations, transitions, `\pause`, overlays, `\only`/`\uncover` reveals.
- **Decoration:** gradients, shadows, rounded or shaded boxes, 3D charts, pie charts, seaborn or other preset chart styles.
- **Hard-coded values:** any colour or font size not defined in this section.
- **Unsourced content:** a number on a slide that does not come from `results/`; screenshots of code, terminals or charts.
- **Weak titles:** a topic-only title on a content slide.
- **Writing:** marketing or hype vocabulary ("rewolucyjny", "potężny", "przełomowy"), exclamation marks, rhetorical questions, filler sentences.
- **Unfinished work:** placeholder text, `TODO`, `???` or overfull boxes in the compiled PDF.

### 3.8 Verification

| Check | How | Who |
|---|---|---|
| Compiles cleanly | `make` without errors and without overfull box warnings | `latex-assistant` |
| Fonts embedded | `pdffonts <deck>.pdf` shows `emb: yes` on every row (`zasady` p. 5) | orchestrator; output passed to the reviewer |
| Vector charts | `pdfimages -list <deck>.pdf` lists no raster images | orchestrator |
| Content against this section and section 1 | full review | `presentation-reviewer` |
| Full-screen view | readability, cropping, overlaps (`zasady` p. 5) | user, last step before packing |

## 4. Code conventions

This is the contract for `coder` and the source of the `code-reviewer` checklist. It is materialized as `docs/requirements-code.md`, together with the requirement extracts from section 1.

### 4.1 Environment and dependencies

- **Python.** Development runs on Python 3.14. Code must stay compatible with Python 3.10 or newer, because the lecturer's environment is unknown. No syntax newer than 3.10.
- **Dependencies.** `numpy`, `pandas` and `matplotlib` only. They are listed in `requirements.txt` with minimum versions (`numpy>=1.24`, `pandas>=2.0`, `matplotlib>=3.7`) rather than exact pins.
  - Trade-off: installability on the lecturer's machine wins over bit-exact reproducibility. The computations are deterministic arithmetic, so this costs nothing in practice.
- **Tooling.** No new package, linter or formatter is installed without the user's approval. PEP 8 is checked by review, which matches the instruction's reference [9] in `Projekt_1.pdf`.

### 4.2 Layout of `src/`

Modules are flat, run from the project root and import each other directly:

| File | Responsibility |
|---|---|
| `config.py` | constants: `MACD_PARAMS = (12, 26, 9)`, `START_INDEX = 100`, `DELAY`, paths, `MN_DATA_DIR` |
| `data.py` | loading CSV files and validating them |
| `macd.py` | `ema`, MACD/SIGNAL/histogram, signal detection |
| `simulation.py` | portfolio simulation and the list of trades |
| `stats.py` | R, r and the seven summary items |
| `export.py` | writing `results/*.json` and `results/*.tex` |
| `style.py` | palette and matplotlib settings from 3.6; font loading with fallback |
| `charts.py` | one function per chart: A1, B1, C1, C2, D1, E1, E2 |
| `basic.py` | entry point for the basic part |
| `experiment.py` | entry point for the experimental part |
| `verify_ema.py` | independent check of the EMA implementation |

What each entry point produces:

| Command | Produces |
|---|---|
| `python src/basic.py` | the basic part end to end: computations, simulation, `results/basic.*`, every chart from A1 to E2 |
| `python src/experiment.py` | the experimental part: `results/experiment.*`, charts X1, X2, … |

Chart IDs X1… are our convention, because the instruction assigns no IDs to experiment charts. A single command may generate all charts (`Projekt_1.pdf` p. 9).

### 4.3 Numerical conventions

- **EMA is implemented from formula (1) as an explicit recursion**, with E₀ = x₀ (`Projekt_1.pdf` p. 1).
  - `pandas Series.ewm(span=N, adjust=False).mean()` is used **only** in `verify_ema.py`, as an independent reference.
  - Acceptance criterion: the maximum absolute difference is ≤ 1e-9.
- **The computational core works on `numpy` float64 arrays** indexed exactly like the instruction: i = 0…L−1, with dates in a parallel array.
  - `pandas` is used only for CSV input.
  - This removes the `.loc`/`.iloc` off-by-one class of errors.
- **Signals** are an `int8` array:
  - `+1` buy, `−1` sell, `0` none,
  - computed from the sign change of H for i ≥ 1, per formula (4) and the rules on p. 2,
  - no interpolation of the crossing time.
- **Simulation** follows the five steps of `Projekt_1.pdf` p. 5, 3.3 literally:
  - Signals are considered from sample 101.
  - Initial cash: C₁₀₀ = 1000 · x₁₀₀.
  - Buy with all cash; sell the whole position.
  - With `DELAY = 1`, a signal at the last sample is not executed.
- **Portfolio vectors.** `cash`, `position_qty` and `equity` have length L and hold `NaN` for i < 100. They are never plotted there.
- **Trades.** Each trade is a `dataclass` holding the signal index, execution index, side and price. Closed trades are buy→sell pairs.
- **Invariants checked at run time.** These checks use `if … raise`, because `assert` is stripped by `python -O`:
  - V_i = C_i + Q_i·x_i at every step,
  - C and Q never negative,
  - never sell without a position.
- **Statistics.**
  - r = 0 counts as profitable (`Projekt_1.pdf` p. 5, 3.4).
  - The largest loss is reported as a positive percentage, e.g. "największa strata: 8%" (`Projekt_1.pdf` p. 7, 4.4).
  - No rounding during computation; rounding happens only at export.
- **Data validation**, failing with a clear `ValueError`:
  - the basic-part data has 1000–1200 rows (`Projekt_1.pdf` p. 4, 3.1),
  - dates are strictly increasing,
  - no duplicate dates,
  - no missing or non-positive closes,
  - no filling of gaps between sessions.

### 4.4 Naming and style

- PEP 8 and English identifiers.
- Symbols map to the instruction as follows:

| Instruction symbol | Identifier |
|---|---|
| x | `close` |
| E⁽ᴺ⁾ | `ema(values, n)` |
| M | `macd` |
| S | `signal` |
| H | `hist` |
| C | `cash` |
| Q | `position_qty` |
| V | `equity` |
| R | `portfolio_return_pct` |
| r | `trade_return_pct` |
| d | `DELAY` |

- Public functions have type hints and a one-line docstring that cites the formula, e.g. `"""EMA per formula (1), Projekt_1.pdf p. 1."""`. Other comments appear only where they state a constraint the code cannot show.
- Computation is pure; input and output are isolated. `macd.py`, `simulation.py` and `stats.py` do no file access, plotting or printing. Only the entry points print, as a short summary.
- No classes except `dataclass` records. No mutable module-level state.

### 4.5 Results export (ADR-4)

- **Files.** `export.py` writes two files per part:
  - `results/<part>.json` — every number,
  - `results/<part>.tex` — one LaTeX macro per value shown on slides.
- **Macro names** contain letters only (LaTeX does not allow digits in macro names) and are prefixed `\res`. Examples:
  - `\resInitialCapital`, `\resFinalEquity`, `\resReturnPct`,
  - `\resProfitableCount`, `\resLosingCount`, `\resWinRatePct`,
  - `\resMaxLossPct`, `\resMaxGainPct`, `\resOpenPosition`,
  - `\resTradeBuyDate`, `\resTradeSellDate`, `\resTradeReturnPct` for D1.
- **Formatting.** Macros hold formatted numbers without units:
  - Polish decimal comma,
  - two decimals for money and for percentages.
  
  The slide adds the unit.
- **Generated artifacts are committed.** `charts/*.pdf` and `results/*` go into git, so slides compile from the repo without running Python.
  - Trade-off: generated files in history, accepted for a reproducible deck.

### 4.6 Input data

- **Basic part.** `data/<instrument>.csv` holds at least `date` and `close`, plus `open`, `high`, `low` if a candlestick A1 is chosen.
- **What `readme.md` states about the instrument** (`Projekt_1.pdf` p. 4, 3.1):
  - name and unit,
  - source URL,
  - date range,
  - any corporate-action adjustments.
- **Experimental part.** Read from the directory given by the environment variable `MN_DATA_DIR`. The default is `materials/dane_pro1/`, the unzipped `dane_pro1.zip`. Files have the columns `date, open, high, low, close, volume` (`Projekt_1.pdf` p. 8, 5.2). This data is never copied into the repo or a ZIP.
- **Read-only data.** Code never writes into data directories.

### 4.7 Build conventions

- **Slides `Makefile`.**
  - Calls plain `pdflatex` twice, because "n/N" needs the total frame count from the first pass.
  - No `latexmk`: the lecturer's recommended Windows setup is MiKTeX + MSYS2 (`zasady` p. 2), where `latexmk`'s Perl dependency is not guaranteed.
  - Targets: `all` and `clean`.
- **The `Makefile` does not run Python.** Charts and results are generated beforehand and shipped in the presentation ZIP (1.5).
- **`.gitignore`** adds the following to `materials/`:
  - `__pycache__/`,
  - `.venv/`,
  - LaTeX auxiliaries: `*.aux`, `*.log`, `*.nav`, `*.out`, `*.snm`, `*.toc`, `*.vrb`.
- **`readme.md`** lists:
  - requirements,
  - the data location and `MN_DATA_DIR`,
  - the command for every chart by ID (`Projekt_1.pdf` p. 9),
  - the command for `verify_ema.py`.

### 4.8 Verification for each code task

| Check | Pass criterion |
|---|---|
| `python src/verify_ema.py` | maximum difference against pandas ≤ 1e-9 for N = 12, 26, 9 |
| `python src/basic.py` | runs without errors or warnings; every expected file in `charts/` and `results/` is created |
| Invariants (4.3) | no exception raised on the chosen instrument |
| `code-reviewer` | verdict APPROVE against `docs/requirements-code.md` |

## 5. Documentation & AI-log protocol

*Placeholder.* The ai-log entry format is already defined in 2.6.

## 6. Stages & checkpoints

*Placeholder.*

---

## Appendix A: Decision log (ADR-lite)

**ADR-1. No separate orchestrator agent.**

- **Decision:** the main session orchestrates.
- **Why:** a subagent orchestrator adds two lossy hand-offs per task (brief → report). It also hides work from the user, and it adds no capability the main session lacks.
- **Trade-off:** the main session's context grows. This is mitigated by delegating the heavy work to subagents.

**ADR-2. Four roles instead of many module-level agents.**

- **Decision:** coder, code-reviewer, latex-assistant, presentation-reviewer. These match the roles suggested in `zasady` p. 5, 6.2.
- **Why:** module-level agents lose the whole-codebase view, and their interfaces drift.
- **Trade-off:** each role's prompt must be good enough to handle varied tasks.

**ADR-3. Specialize through permissions and task cards, not through the number of agents.**

- **Decision:** narrow tool whitelists plus a per-task card carrying the exact requirement slice.
- **Why:** quality comes from narrow context and narrow permissions, which these provide without multiplying hand-offs.
- **Trade-off:** path scopes remain conventional, not enforced (2.2).

**ADR-4. Zero hand-copied numbers.**

- **Decision:** results flow `program → results/ → \input in Beamer`.
- **Why:** the lecturer verifies that the code reproduces the slides, and a mismatch can zero the score (`zasady` p. 2). This also removes a whole class of AI transcription errors.
- **Trade-off:** slightly more setup in the LaTeX pipeline.

**ADR-5. Agent instructions in English, human-facing content in Polish.**

- **Decision:** as stated.
- **Why:** consistency with code and identifiers, and precise technical vocabulary.
- **Trade-off:** prompts shown on slides are in English.

**ADR-6. Own EMA recursion; pandas only as an independent reference.**

- **Decision:** `ema()` implements formula (1) directly. `pandas ewm(adjust=False)` is used only in `verify_ema.py`.
- **Why:** this is a numerical-methods course, so the implementation must show the formula. Two independent implementations that agree are evidence of correctness, which a single library call cannot provide.
- **Trade-off:** a Python loop is slower than vectorised pandas, which is negligible at about 1000 samples × 117 instruments.

**ADR-7. numpy arrays in the computational core, indexed like the instruction.**

- **Decision:** pandas only for CSV input. The core uses arrays with i = 0…L−1.
- **Why:** code indices then match the formula indices one to one (sample 100, signals from 101, d = 1). This removes the off-by-one errors typical of mixed label- and position-based indexing.
- **Trade-off:** dates are carried in a parallel array.

**ADR-8. Slides `Makefile` uses plain `pdflatex` twice, not `latexmk`.**

- **Decision:** as stated.
- **Why:** the lecturer's recommended Windows setup is MiKTeX + MSYS2 (`zasady` p. 2). There, `latexmk`'s Perl dependency is not guaranteed, and two passes are enough for "n/N".
- **Trade-off:** no automatic rebuild on changed dependencies.

## Appendix B: Brief changelog

| Version | Date | Change | Reason |
|---|---|---|---|
| 0.1 | 2026-10-20 | Sections 0, 1, 2 and appendices; 3–6 as placeholders | Initial brief |
| 0.2 | 2026-10-20 | Lecturer's files moved to `materials/`; orchestrator commits per `~/.claude/rules/git.md` | Project folder made self-contained; user's git rules changed |
| 0.3 | 2026-10-20 | Section 3 (presentation visual style); presentation ZIP includes `slides/common/` | Visual contract required before P2 |
| 0.4 | 2026-10-20 | Section 4 (code conventions); ADR-6 to ADR-8; presentation ZIP includes `charts/` and `results/*.tex` | Code contract for implementation; slides must compile from the ZIP alone |
