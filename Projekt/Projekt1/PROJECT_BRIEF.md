# PROJECT_BRIEF — Projekt 1 (MACD), Metody Numeryczne

Version 0.2 · 2026-10-20 · status: sections 0, 1, 2 and appendices complete; sections 3–6 are placeholders.

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
| Prezentacja (P2 i P3 nr 1) | `slides/<preliminary|final>/` (PDF, `.tex`, `Makefile`, użyte wykresy i pliki potrzebne do kompilacji) |
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

*Placeholder — next section to write (needed before P2).* It will define palette, typography, slide layout, chart styling and explicit bans on icons, emoji and animations.

## 4. Code conventions

*Placeholder — after P2.*

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

## Appendix B: Brief changelog

| Version | Date | Change | Reason |
|---|---|---|---|
| 0.1 | 2026-10-20 | Sections 0, 1, 2 and appendices; 3–6 as placeholders | Initial brief |
| 0.2 | 2026-10-20 | Lecturer's files moved to `materials/`; orchestrator commits per `~/.claude/rules/git.md` | Project folder made self-contained; user's git rules changed |
