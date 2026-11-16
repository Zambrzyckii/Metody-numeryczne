# PROJECT_BRIEF · Projekt 2 (Rozwiązywanie układów równań liniowych), Metody Numeryczne

Version 1.2 · 2026-11-16 · status: complete.

---

## 0. How to use this brief

This is a **one-time genesis document**. A new Claude Code session is started in `~/Metody-numeryczne/Projekt/Projekt2/` (the git root is `~/Metody-numeryczne`). It reads this brief once, materializes the project scaffold from it, and then runs on its own from start to finish:

- a short `CLAUDE.md` (orchestration protocol and pointers to `docs/`),
- `docs/*.md` (requirement extract, style, AI log),
- `.claude/agents/*.md` (four role definitions copied from section 2.7),
- `slides/common/mnstyle.sty` (copied from Projekt 1).

The brief stays in the repo as the record of the original intent and is not loaded into every session.

**Scope fence, read this first.** The only products of this session are the **preliminary presentation of Projekt 2 (P2W)** and its **submission** to eNauczanie. The following are out of scope under any circumstances. Project Python code (solvers, FEM driver, measurements), running the FEM program, choosing a structure, choosing an own variant, any experiment, any measurement, charts, the final deck (P5) and the P5 packages. Throwaway verification one-liners that check the deck itself (for example comparing a prompt quote with the log) are allowed, stay outside the repo and are not committed. Section 6.6 lists them as "NOT in this session". When a task seems to need one of them, the session logs it in `docs/ai-log.md` as a deferred item and continues without it.

**Source-of-truth hierarchy.** On conflict, the higher source wins and the discrepancy is reported to the user (at the single stop, see 0.1).

1. Lecturer's PDFs in `materials/` (git-ignored, copied by the user), namely `Projekt_2.pdf` (11 pages), `zasady_zaliczenia_projektu_v1.pdf` (6 pages), `harmonogram_2026_v3.pdf` (3 pages)
2. This brief
3. `docs/*.md`
4. Agent instructions

The folder `../Projekt1/` is a read-only reference. Its PDFs are not sources for Projekt 2 requirements, except where this brief says so explicitly (two assumptions in 1.2). The session never edits anything under `../Projekt1/`.

**Rules for the session**

- Every statement about a requirement carries a reference `file p. N`. A claim without a reference is treated as suspect. In stage 1 the session re-checks every reference of sections 1 and 4 with `pdftotext -layout -f N -l N <file> -` and fixes this brief first if a page is wrong (changelog row, version bump).
- Never invent a reference. If a page cannot be confirmed, write "(page not verified)".
- A section marked *placeholder* or *FUTURE* is not filled in. It stays as written.
- Do not guess APIs, file names or requirements. Check the source or write "I don't know".
- Code, identifiers, comments, commits, `docs/` and agent instructions are in English. Slide content, `docs/ai-log.md`, `plan_wystapienia.md` and communication with the user are in Polish.
- Subagents never settle an ambiguity. They report it to the orchestrator in their report.

### 0.1 Autonomy and the single stop

The orchestrator runs stages 1 to 4 (6.2) without stopping. It stops **exactly once**, in stage 4, **before** anything is submitted to eNauczanie, and it submits only after the user's explicit "tak" (6.3). Consequences.

- The P1 checkpoints CP1 to CP5 do not apply. The decisions the user took at CP3 in Projekt 1 (slide theses, which AI-error slides to show) are made by the orchestrator. Each is logged in `docs/ai-log.md` as **"Decyzja orkiestratora, zatwierdzona przez autora na przystanku przed wysłaniem"**, with the options considered.
- When two sources conflict, or a requirement is ambiguous, the orchestrator applies the hierarchy above, decides, logs the decision and goes on. It does not ask.
- The orchestrator never delegates the decision to submit. It never starts any work beyond the P2W submission (6.6).
- "AI proponuje, autor zatwierdza" is literally true here only at the single stop. The slides say so (1.7, slide 6).

### 0.2 Hard blockers

These are the only reasons to stop before the single stop. In each case the orchestrator commits what exists, tells the user in Polish what blocks and what it needs, and waits.

- `pdflatex`, `tgheros.sty` or `fancyvrb.sty` missing (`kpsewhich` returns nothing), or the three PDFs are missing from `materials/`.
- The git remote is not `https://github.com/Zambrzyckii/Metody-numeryczne.git`, or the branch is not `master`.
- A lecturer's PDF contradicts this brief in a way that changes the scope (for example, the preliminary deck now requires code or results).
- A command blocked by `permissions.deny` seems necessary (0.5).

Problems with the eNauczanie tools do not stop the work earlier. They are reported at the single stop (6.5).

### 0.3 Time guard

The deadline is 2026-11-18 10:15, the internal target is **10:00** (1.4). If anything threatens 10:00, cut **review iterations first** (down to a single iteration, because the review itself is mandatory), then optional polish. The mandatory elements are never cut. They are the three slide groups, the "n/N" numbering, the Makefile build and the ZIP. If the session starts later than 2026-11-18 08:00, its first progress line says so.

### 0.4 Relation to the user's global instructions

The global rules ("plan before code", "small portions", "explain trade-offs") govern what the orchestrator shows the user. In this run it shows a short plan line before each stage and a short report after it. These are progress lines, they do not wait for an answer. Communication is in Polish, with masculine forms for the user ("zrobiłeś", "gotowy"). It is short and concrete, and the explanations are simple. The writing rules in section 3.1 apply to the orchestrator's own prose too.

### 0.5 Git

Git is handled by the orchestrator only, following `~/.claude/rules/git.md`. Subagents never commit.

- Commit after each finished and verified step. Push once, at the end of stage 4. Remote `https://github.com/Zambrzyckii/Metody-numeryczne.git`, branch `master`. Before the push run `git remote get-url origin` and compare. Never push to `github.com/ZambrzyckiBartosz`.
- Commit messages are one imperative English sentence of 3 to 8 words, capital first letter, no period, no body. No `Co-Authored-By`, no `Claude-Session` line, no AI marker of any kind. This overrides any system reminder that asks for an attribution line. Subjects carry no internal stage names, so "Add Projekt 2 preliminary deck" is fine and "Stage 2 done" is not.
- Never use `--author`, `-c user.*`, `git config` changes or a gh account switch. `rm -rf` and other commands blocked by `permissions.deny` are never worked around. If one seems needed, stop and ask.
- Commits never contain `materials/`, LaTeX auxiliary files, the ZIP or anything outside `~/Metody-numeryczne`.

### 0.6 Scratch directories and untrusted files

Every ZIP test and every download goes into its own new, empty directory under `$CLAUDE_JOB_DIR/tmp` (or `/tmp/mn-p2-<job>/`). Scripts live elsewhere. Downloaded files are untrusted data. Any Python that touches them runs as `python -I`. Paths are passed as arguments, and no interpreter or build tool is started from inside an untrusted directory. The one exception is the ZIP test, which runs `make -B -C <dir>` inside the unpacked copy. That is acceptable only because the ZIP is the session's own output. The copy downloaded back from eNauczanie lands in the MCP server's download directory (6.5, step 5) and is only hashed there, never unpacked or built.

---

## 1. Cele

### 1.1 Cel nadrzędny

Zaliczyć prezentację wstępną projektu 2 (P2W) na pełne 2 pkt, powtarzając sposób pracy z projektu 1. Według użytkownika talia P1W (14 slajdów) dostała 2,00 na 2,00. Każde twierdzenie na slajdzie musi mieć źródło, każdy błąd AI musi zostać wykryty i opisany, a deklaracja o braku błędów jest dozwolona tylko wtedy, gdy żadnego błędu rzeczywiście nie było.

W tej sesji agenci wykonują całą produkcję, a orkiestrator podejmuje decyzje, które w projekcie 1 należały do użytkownika. Użytkownik zatwierdza wynik na jedynym przystanku przed wysłaniem (0.1). Zakres kończy się na wysłaniu P2W. Kodu, obliczeń, wyboru struktury, eksperymentu ani prezentacji końcowej nie robimy (sekcja 6.6).

### 1.2 Cele punktowane

**Prezentacja wstępna, 2 pkt** (`zasady_zaliczenia_projektu_v1.pdf` s. 1, tab. 2, wiersz „Wstępna", metody i wyniki 0, wstęp i współpraca z AI 2).

Podział na pięć elementów po 0,4 pkt jest **założeniem przeniesionym z projektu 1**. Pochodzi z `Projekt_1.pdf` s. 9, tab. 1 (plik w `../Projekt1/materials/`). `Projekt_2.pdf` nie podaje takiego podziału. Mówi tylko, że 4 pkt z całego projektu obejmują łącznie w obu prezentacjach opis podstaw teoretycznych algorytmów, wybrane efekty współpracy z AI oraz recenzję AI (`Projekt_2.pdf` s. 1, p. 2). Wysiłek rozkładamy więc po równo na pięć elementów.

| Element (0,4 pkt każdy, założenie) | Kryterium akceptacji | Źródło |
|---|---|---|
| Wstęp, trzy metody | co najmniej trzy slajdy, po jednym na metodę. LU, idea faktoryzacji. Jacobi, wzór iteracyjny, wykorzystanie wartości z poprzedniej iteracji, warunki zbieżności. Gauss-Seidel, wzór iteracyjny, wykorzystanie aktualizowanych wartości, warunki zbieżności. Znaczenie symboli wyjaśnione, bez dowodów | `Projekt_2.pdf` s. 3, p. 4. Zasady mówią o „około trzech slajdach" (`zasady` s. 2, p. 4, warunek 7) |
| Sposób pracy i konfiguracja AI | wybór narzędzi, organizacja pracy, role agentów. Jedno zagadnienie opisane dobrze zamiast stu skrótowo | `zasady` s. 4, p. 5.2 |
| Wybrany prompt, rezultat, ocena | jeden konkretny prompt z rzeczywistym wynikiem i naszą oceną | `zasady` s. 4, p. 5.2 („ciekawe prompty i rezultaty ich wykonania") |
| Raport o błędach AI | około trzech slajdów z opisem przykładu błędnego działania AI. Jeśli błędu nie było, dosłowna deklaracja z `zasady` s. 4, p. 5.3 w formie męskiej, czyli „W trakcie prac nad projektem nie zauważyłem błędnego działania AI." | `zasady` s. 4, p. 5.3 |
| Recenzja AI | opis recenzenta i jego kryteriów, prompt recenzji lub fragmenty, ocena słowna i liczbowa 1-10, najlepiej na jednym slajdzie. Zalecane około czterech slajdów | `zasady` s. 5, p. 6.3 |

Dodatkowe fakty.

- **Prezentacja wstępna nie wymaga kodu ani wyników obliczeń** (`Projekt_2.pdf` s. 3, p. 4). Omówienie fragmentu kodu jest opcjonalne i je pomijamy. Zasady dopuszczają wyniki programu w prezentacji wstępnej, zawsze w powiązaniu z narzędziami AI (`zasady` s. 4, p. 5.2). Tu nie pokazujemy żadnych.
- **Slajd tytułowy** zawiera temat, imię i nazwisko autora oraz informację „Prezentacja wstępna". `Projekt_2.pdf` nie ma takiej reguły. To założenie przeniesione z `Projekt_1.pdf` s. 5, p. 4.1 i podtrzymane decyzją użytkownika.
- Oceniana jest treść, nie jakość wystąpienia (`zasady` s. 2, p. 4). Ocena recenzenta AI nie wyznacza punktów (`zasady` s. 5, p. 6.3).

**Prezentacja końcowa, 8 pkt (PRZYSZŁOŚĆ, P5, tej sesji nie dotyczy, nie wykonywać).** Wymagania zapisujemy po to, żeby późniejsza sesja nie musiała ich szukać od nowa.

| Element | Pkt | Źródło |
|---|---|---|
| Wstęp i opis współpracy z AI (jak w tabeli powyżej) | 2,0 | `zasady` s. 1, tab. 2. `Projekt_2.pdf` s. 1, p. 2 |
| A. Mapy temperatury A1 (wariant startowy) i A2 (własny), wspólna skala kolorów | 0,5 | `Projekt_2.pdf` s. 2, tab. 1. Opis w s. 4, p. 5.2 |
| B. Wykres czasu B1 w funkcji N dla LU, Jacobiego i Gaussa-Seidla, tabela czasów (przygotowanie, rozwiązanie, całkowity dla LU) i przyspieszeń | 1,0 | s. 2, tab. 1. Opis w s. 4, p. 5.3 |
| C. Wykres liczby iteracji C1 w funkcji N, z progami zakończenia | 1,0 | s. 2, tab. 1. Opis w s. 4, p. 5.4 |
| D. Wykres względnej normy residuum D1 dla największego N, oś iteracji liniowa, residuum logarytmiczne, próg zaznaczony | 1,0 | s. 2, tab. 1. Opis w s. 4, p. 5.5 |
| E. Wnioski porównawcze, każdy poparty konkretnym wynikiem | 0,5 | s. 2, tab. 1. Opis w s. 4, p. 5.6 |
| Część eksperymentalna, do 2 pkt, ścieżki z p. 6 (dodatkowy solver 6.1, problem elektromagnetyczny 6.2, własny sparse LU 6.3, mniejsze eksperymenty 6.4) | do 2,0 | `Projekt_2.pdf` s. 5-7, p. 6 |

Suma części podstawowej to 4 pkt (A 0,5 + B 1,0 + C 1,0 + D 1,0 + E 0,5), eksperyment do 2 pkt, razem z wstępem i AI 8 pkt. Kolejność omówienia wyników według zasad to najważniejsza obserwacja, cecha algorytmu ją wyjaśniająca, wniosek z zakresem stosowalności (`zasady` s. 4, p. 5.2).

### 1.3 Bramki niezaliczenia

Brak któregokolwiek z poniższych elementów oznacza niezaliczenie do czasu poprawy (`zasady` s. 2, p. 4).

**Każda prezentacja** (`zasady` s. 2, p. 4, warunki 1-8)

- obecność na zajęciach, także gdy użytkownik nie jest wylosowany do wystąpienia (warunek 1, kto występuje, opisuje `zasady` s. 4, p. 5.1),
- co najmniej 50% punktów,
- PDF zbudowany przez kompilację LaTeX-a,
- kompilacja zdefiniowana w `Makefile`,
- numeracja „n/N" na każdym slajdzie,
- trzy grupy slajdów (wstęp o algorytmie, błędy AI lub deklaracja, recenzja AI),
- ZIP z PDF-em, `Makefile` i plikami potrzebnymi do kompilacji, przesłany na eNauczanie.

**Format** (`zasady` s. 4-5, p. 6.1)

- 16:9 (`aspectratio=169`), przygotowanie do pełnego ekranu 4K UHD,
- około 8 minut wystąpienia,
- czytelność z miejsca słuchaczy, wysoka rozdzielczość nie zastępuje dużych napisów,
- czcionki osadzone,
- PDF sprawdzony w trybie pełnoekranowym pod kątem czytelności, przycięć, nakładania się treści i symboli.

**Projekt, czyli kod (PRZYSZŁOŚĆ, P5, tej sesji nie dotyczy).** Osobny ZIP z kodami bez `.venv`, dane wejściowe, opis uruchomienia, `zrodla.md` przy użyciu szablonów, działający program odtwarzający slajdy, kod tylko w plikach `.py`, bez notebooków (`zasady` s. 2, p. 3 i p. 4). Plagiat kodu Python lub LaTeX zeruje punktację za projekt (`zasady` s. 3). `Projekt_2.pdf` nie ma sekcji o archiwach, więc obowiązują same zasady. Konwencja z projektu 1 (`readme.md`, `zrodla.md`) to założenie na P5.

### 1.4 Terminy

| Termin | Co | Kiedy |
|---|---|---|
| P4 | Prezentacja wstępna projektu 2 (`zasady` s. 1, tab. 1) | środa **2026-11-18, 11:15-13:00**, grupa `pro_gr3a` (`harmonogram_2026_v3.pdf` s. 3, tab. 2 i lista grup) |
| Termin ZIP-a P2W | jeden ZIP | najpóźniej godzinę przed zajęciami, czyli **2026-11-18, 10:15** (`zasady` s. 3, p. 4.1, przykład 8:15 i 7:15). **Cel wewnętrzny 10:00** |
| P5 (PRZYSZŁOŚĆ) | Prezentacja końcowa projektu 2, dwa ZIP-y | środa 2026-12-02, 11:15-13:00, `pro_gr3a` (`harmonogram_2026_v3.pdf` s. 3, tab. 2). ZIP-y do 10:15 |

Spóźnienie kosztuje 0,2 pkt za każde rozpoczęte 24 h opóźnienia ZIP-a oraz 0,2 pkt za każdy dzień opóźnienia wystąpienia, liczy się większa z tych wartości (`zasady` s. 3, p. 4.1). Harmonogram zastrzega, że terminy mogą się zmienić i zmiana zostanie ogłoszona na eNauczaniu (`harmonogram_2026_v3.pdf` s. 3). Na początku etapu 4 orkiestrator wywołuje `get_recent_changes` (narzędzie nie ma filtra kursu), wybiera wpisy kursu 8051 i zapisuje wynik w logu.

### 1.5 Pakowanie, biała lista

Pakujemy według białej listy, nigdy z katalogu z wykluczeniami.

| Plik | Zawartość |
|---|---|
| `zambrzycki_projekt2_wstepna.zip` | `slides/preliminary/main.pdf`, `slides/preliminary/Makefile`, wszystkie `slides/preliminary/*.tex` łącznie z `review.tex`, `slides/common/mnstyle.sty`. Struktura katalogów zachowana, żeby `make` działał po rozpakowaniu |

Nigdy nie pakujemy plików ani katalogów `materials/`, `docs/`, `.claude/`, `CLAUDE.md`, `PROJECT_BRIEF.md`, `KICKOFF.md`, `plan_wystapienia.md`, plików pomocniczych LaTeX-a (`*.aux`, `*.log`, `*.nav`, `*.out`, `*.snm`, `*.toc`, `*.vrb`). Plików konfigurujących narzędzia AI, na przykład `*.md`, nie wolno przesyłać do oceny (`zasady` s. 2, koniec p. 4). Wymagane są PDF, `Makefile` i pliki potrzebne do kompilacji (`zasady` s. 2, p. 4, warunek 8).

Katalog wynikowy poza repo to `~/Downloads/MN-Projekt2/`. Leżą w nim ZIP i `plan_wystapienia.md` (6.2, etap 4).

### 1.6 Czego świadomie nie robimy

Każdy z tych punktów zwiększa ryzyko slopu albo wykracza poza zakres sesji.

- jakikolwiek kod Python, uruchamianie programu startowego MES, `simulate.py`, solvery,
- wybór struktury (`mold_1` i pozostałe z `Projekt_2.pdf` s. 3, tab. 2), własny wariant, eksperyment, pomiary, wykresy A1-D1,
- prezentacja końcowa i paczki P5,
- slajd z fragmentem kodu (opcjonalny wg `Projekt_2.pdf` s. 3, p. 4),
- liczby wyników na slajdach. Stałe z instrukcji (ε = 10⁻⁸, numery wzorów) są definicjami (2.3),
- animacje i overlaye Beamera, drugi styl, nowy motyw,
- skille ponad cztery role z sekcji 2, CI, pre-commit, worktree,
- pytania do użytkownika poza jednym przystankiem (0.1).

### 1.7 Decyzje użytkownika (2026-11-16)

| Decyzja | Stan | Uzasadnienie |
|---|---|---|
| Autor | **Bartosz Zambrzycki** | slajd tytułowy |
| Forma briefu | **pełny brief**. Sesja sama tworzy `CLAUDE.md`, `docs/` i `.claude/agents/` w etapie 1, jak w projekcie 1 | te same konwencje, to samo źródło prawdy |
| Autonomia | **sesja wykonuje etapy 1-4 bez zatrzymywania i zatrzymuje się dokładnie raz, przed wysłaniem do P2W.** Wysyła (`confirm=true`) dopiero po wyraźnym „tak" | decyzja użytkownika. Konsekwencje w 0.1 |
| Tematy slajdów o AI | **te same co w projekcie 1** (orkiestrator i cztery role, karty zadań, hierarchia źródeł brief, docs, agenci, punkty kontrolne) **zaktualizowane do tego, jak projekt 2 faktycznie przebiegł** | prawdziwość twierdzeń. Przebieg to jedna autonomiczna sesja, jeden przystanek (punkty kontrolne CP1-CP5 nie występują) |
| Długość | **około 12 slajdów** (zakres 10-14, 1.7 niżej) | jeden slajd na element plus wstęp. P1W miał 14 |
| Recenzja AI | **dwa slajdy** (recenzent z promptem, ocena). Zalecenie `zasady` s. 5, p. 6.3 to około czterech | **przyjęte odstępstwo**, żeby odpowiedzieć recenzentowi z briefu. Jeśli slajd 11 nie mieści się bez `\scriptsize`, dzielimy go na dwa (talia 13 slajdów) |
| Wybór struktury, własny wariant, ścieżka eksperymentu, kod | ***placeholder* na P5** | sesja tego nie wypełnia (0, 1.6) |
| Plik stylu | **`mnstyle.sty` kopiowany bez zmian z projektu 1**, razem z nagłówkiem „Projekt 1 (MACD)" w komentarzu | decyzja użytkownika. Recenzent nie zgłasza tego jako błędu |
| Katalog wynikowy | `~/Downloads/MN-Projekt2/` | poza repo, jak `MN-Projekt1` |

**Układ talii.** Tytuły poniżej to propozycje. Ostateczny tytuł każdego slajdu ustala orkiestrator na podstawie rzeczywistego przebiegu pracy i loguje jako decyzję orkiestratora. Tytuł jest tezą w jednym zdaniu, w dwóch liniach najwyżej.

| # | Typ slajdu (3.5) | Treść | Propozycja tytułu |
|---|---|---|---|
| 1 | tytułowy | „Projekt 2: Rozwiązywanie układów równań liniowych", „Prezentacja wstępna", Bartosz Zambrzycki, Metody numeryczne, 18 listopada 2026 | bez tytułu-tezy |
| 2 | równanie | Układ (1) z `Projekt_2.pdf` s. 1. A z modelu cieplnego jest rzadka, symetryczna i dodatnio określona (SPD) (s. 3, p. 5.1). N to liczba niewiadomych (s. 1 i s. 3). Względne residuum η_j, ε = 10⁻⁸ (zalecana wartość) według wzoru (2) na s. 3. Mapowanie symboli z 1.8 | „Układ Ax = b z modelu ciepła ma rzadką macierz SPD, a jego rozwiązanie oceniamy względnym residuum" |
| 3 | równanie | LU (1.8) | „Rozkład LU rozwiązuje układ dwoma szybkimi podstawieniami po jednej faktoryzacji" |
| 4 | równanie | Jacobi (1.8) | „Metoda Jacobiego liczy nowe przybliżenie wyłącznie z wartości poprzedniej iteracji" |
| 5 | równanie | Gauss-Seidel (1.8) | „Metoda Gaussa-Seidla od razu używa świeżo obliczonych składowych" |
| 6 | AI, konfiguracja | narzędzie Claude Code. Orkiestrator (sesja główna), cztery role, z których w tym projekcie użyto dwóch (latex-assistant, presentation-reviewer). Karty zadań. Hierarchia brief, docs, agenci. **Uczciwy opis uruchomienia agentów** (2.2). Jeden przystanek, na którym autor zatwierdza | „Prezentację przygotował orkiestrator z dwoma agentami, a autor zatwierdza ją w jednym punkcie" |
| 7 | prompt | wybrany prompt (fragment karty zadania) dosłownie z `docs/ai-log.md`, cięcia oznaczone `[...]`. Wynik i ocena w dwóch liniach | tytuł z oceny, np. o kryteriach akceptacji |
| 8-10 | błąd AI | **tylko błędy zapisane w `docs/ai-log.md`**, czyli błędy tej sesji i błędy z fazy pisania briefu skopiowane z Appendix D (5.4), jeden na slajd, pola „Co się stało", „Jak to wykryto", „Jak naprawiono". Jeśli błędów było mniej niż trzy, tyle slajdów, ile błędów. **Jeśli nie było żadnego, jeden slajd z deklaracją** (5.4) | tytuł z treści błędu. Przy deklaracji „Deklaracja o błędach AI" jest tytułem dopuszczalnym wyjątkiem |
| 11 | recenzja | definicja recenzenta, jego trzy źródła kryteriów, fragment promptu recenzji dosłownie, rdzeń niezmienny między iteracjami | tytuł z faktycznej konfiguracji |
| 12 | recenzja, ocena | ocena słowna dosłownie (`\resReviewVerbal`), ocena liczbowa `N / 10` (`\resReviewScore`) i jedna linia z przebiegiem iteracji. Wszystkie wartości z makr w `review.tex`. **Bez przypisu** na slajdzie oceny | „Recenzent AI ocenił prezentację wstępną na N / 10" |

Przy zero do trzech slajdach błędów talia ma od 10 do 12 slajdów. Podział slajdów 3-5 lub 11 może podnieść liczbę do 14, co jest górną granicą. Podział jest dopuszczalny tylko wtedy, gdy budżet tekstu (3.1) nie mieści się bez `\scriptsize`.

### 1.8 Treść wstępu (zweryfikowana teoria)

Sekcja jest źródłem treści slajdów 2-5. Źródła zweryfikował orkiestrator przed napisaniem briefu. Sesja weryfikuje ponownie tylko PDF-y prowadzącego, nie literaturę. Jeśli w trakcie pracy wyjdzie, że któreś twierdzenie z tej sekcji jest błędne, sesja je usuwa ze slajdu i loguje.

**Literatura.** Y. Saad, *Iterative Methods for Sparse Linear Systems*, wyd. 2, SIAM 2003, pełny tekst na `https://www-users.cse.umn.edu/~saad/IterMethBook_2ndEd.pdf` (numer strony w PDF to numer strony książki plus 20). Wskazana przez prowadzącego (`Projekt_2.pdf` s. 3, p. 4, rozdz. 4 omawia Jacobiego, Gaussa-Seidla i zbieżność). Drugie źródło dla Gaussa-Seidla przy SPD to notatki z wykładu *Numerical Analysis, Part II*, Cambridge, Fawzi 2021, Cor. 4.13. Dla LU źródłem są notatki UCLA EE133A (Vandenberghe, wykład 7, `lineqs.pdf`) i standardowy fakt podręcznikowy (np. hasło „LU decomposition").

**Notatka o oznaczeniach** (decyzja autora briefu, bo PDF prowadzącego wygrywa z Saadem).

- Macierze zapisujemy pogrubionymi wielkimi literami, wektory pogrubionymi małymi, skalary zwykłymi (`Projekt_2.pdf` s. 1, przypis 1). W LaTeX-u `\mathbf`.
- Z Saada bierzemy rozkład A = D − E − F, macierze iteracji G_JA i G_GS oraz nazwy metod.
- Składowe zapisujemy jak prowadzący, czyli x_i, b_i, a_ij (`Projekt_2.pdf` s. 8, A.2), a nie ξ_i, β_i jak u Saada.
- Indeks iteracji to **j**, jak we wzorze (2) prowadzącego (`Projekt_2.pdf` s. 3). Saad pisze k. Slajd 2 podaje to mapowanie w jednej linii (k u Saada to j u nas).
- Jeden indeks w całej talii.

**Slajd 2, kontekst** (równania (1), (2), legenda do czterech linii)

- Ax = b, A ∈ R^{N×N}, x, b ∈ R^N, znane A (rzadka) i b, szukane x (`Projekt_2.pdf` s. 1, wzór (1)). N to liczba niewiadomych, nie liczba trójkątów (s. 3, p. 5.1).
- Dla modelu przewodzenia ciepła A jest rzadka, symetryczna, dodatnio określona (SPD) po eliminacji zadanych temperatur, przy założeniach z dodatku A (s. 3, p. 5.1, s. 8, A.2). SPD nie dotyczy automatycznie problemu elektromagnetycznego (s. 3). Slajd tego problemu nie omawia.
- Residuum r^(j) = b − A x^(j), względna norma η_j = ‖r^(j)‖₂ / ‖b‖₂, warunek η_j ≤ ε, ε = 10⁻⁸ (wartość zalecana) (`Projekt_2.pdf` s. 3, wzór (2)).
- Stałe z instrukcji (ε = 10⁻⁸, numeracja wzorów) są definicjami, nie wynikami (2.3).
- Saad używa ‖r_k‖/‖r_0‖ (Example 6.1, s. 167), co jest tym samym tylko dla x_0 = 0. Slajdy stosują definicję kursu.

**Slajd 3, LU**

- A = LU, L dolna trójkątna z jedynkami na przekątnej, U górna trójkątna. Układ Ax = b rozwiązujemy w dwóch krokach. Ly = b podstawieniem w przód, potem Ux = y podstawieniem wstecz.
- Z wyborem elementu głównego (wierszy) istnieje rozkład PA = LU dla każdej macierzy nieosobliwej. Dla macierzy nieosobliwej bez wyboru istnieje wtedy i tylko wtedy, gdy wszystkie minory główne wiodące są niezerowe (fakt podręcznikowy). Dla macierzy osobliwej ten warunek nie jest konieczny (kontrprzykład recenzenta AI, iteracja 1, `docs/ai-log.md`).
- Dla macierzy gęstej faktoryzacja kosztuje około (2/3) N³ operacji, a każde rozwiązanie dwóch układów trójkątnych O(N²). Jedna faktoryzacja obsługuje więc wiele prawych stron (Vandenberghe, wykład 7).
- Dla macierzy rzadkiej eliminacja tworzy niezerowe elementy w miejscach zer (fill-in), a przestawienie wierszy i kolumn go zmniejsza (Saad, p. 3.6, s. 96, Example 3.3, s. 82-83).
- **Nie umieszczać** na slajdach nieweryfikowanych rzędów fill-inu ani liczby operacji dla macierzy MES 2D.

**Slajd 4, Jacobi**

- Rozkład A = D − E − F. D to przekątna A, −E jej ściśle dolna część, −F ściśle górna (Saad, wzór (4.2), s. 105). Zakładamy a_ii ≠ 0 (s. 106).
- Wzór składowy (Saad, wzór (4.4), s. 106) w naszych oznaczeniach x_i^(j+1) = (b_i − Σ_{l≠i} a_il x_l^(j)) / a_ii. Używa wyłącznie wartości z poprzedniej iteracji (s. 112). Wskaźnik sumowania jest inny niż i, np. l.
- Postać wektorowa x^(j+1) = D⁻¹(E + F) x^(j) + D⁻¹ b (wzór (4.5)). Macierz iteracji G_JA = I − D⁻¹A (wzór (4.19), s. 112).
- Warunki zbieżności. Iteracja x^(j+1) = G x^(j) + f zbiega dla każdego x^(0) i f wtedy i tylko wtedy, gdy promień spektralny ρ(G) < 1 (Saad, Thm 4.1, s. 115). Warunek wystarczający to ścisła albo nieredukowalna dominacja przekątniowa A, zapisywana wierszowo |a_ii| > Σ_{l≠i} |a_il| (Saad, Thm 4.9, s. 121, przy czym definicja 4.5 Saada jest zapisana kolumnowo).
- **SPD nie gwarantuje zbieżności Jacobiego** (`Projekt_2.pdf` s. 5, p. 6.1). Warunek wystarczający dla SPD to, żeby 2D − A też było SPD (Fawzi, Cor. 4.13(2)). Numer twierdzenia w podręczniku dla tego warunku jest **nieweryfikowany**, więc slajd cytuje notatki Fawziego albo nie podaje numeru.

**Slajd 5, Gauss-Seidel**

- Wersja w przód (Saad, wzór (4.7), s. 107). Dla składowych o indeksie l < i używa się nowych wartości, dla l > i starych. Nowa składowa jest wykorzystywana natychmiast po jej wyznaczeniu (s. 106-107). W naszych oznaczeniach x_i^(j+1) = (b_i − Σ_{l<i} a_il x_l^(j+1) − Σ_{l>i} a_il x_l^(j)) / a_ii.
- Postać macierzowa (D − E) x^(j+1) = F x^(j) + b (wzór (4.8)). Macierz iteracji G_GS = I − (D − E)⁻¹ A (wzór (4.20)).
- Nadpisuje składowe w miejscu, więc potrzebuje mniej pamięci, i zwykle zbiega szybciej niż Jacobi (Saad, s. 112).
- Warunki zbieżności. Te same ρ(G) < 1 (Thm 4.1) i dominacja przekątniowa (Thm 4.9, s. 121) co dla Jacobiego. Dla SPD Gauss-Seidel zbiega, bo jest metodą SOR z ω = 1, a SOR zbiega dla 0 < ω < 2 dla symetrycznej dodatnio określonej A (Saad, Thm 4.10, s. 122). Wprost mówi to Fawzi, Cor. 4.13(1). `Projekt_2.pdf` s. 5, p. 6.1 formułuje to z zastrzeżeniem „w arytmetyce dokładnej" i slajd zachowuje to zastrzeżenie.

**Czego slajdy nie robią.** Nie dowodzą twierdzeń (`Projekt_2.pdf` s. 3, p. 4). Nie podają liczb z obliczeń. Nie twierdzą, że jedna metoda wygra na macierzach MES, bo to wynik eksperymentu z P5. Nie wymieniają konkretnych struktur.

---

## 2. Agents

### 2.1 Orchestration model

The main Claude Code session is the orchestrator. There is no separate orchestrator agent (Appendix A, ADR-1). The orchestrator:

1. Talks to the user through progress lines and at the single stop (0.1).
2. Delegates work via **task cards** (2.4).
3. Routes every work product through the matching reviewer. `latex-assistant` goes to `presentation-reviewer`. The roles `coder` and `code-reviewer` are defined for P5 and are not launched in this session.
4. Runs the verification commands itself (3.8) and hands their output, plus the rendered PNG pages, to the reviewer, since reviewers do not run anything.
5. Appends an **ai-log entry** (2.6) after every delegated task and every stage.
6. Logs every decision it takes in place of the user as a decision entry (5.3).
7. Never delegates the decision to submit (0.1, 6.5).

### 2.2 Enforced vs. conventional boundaries

This distinction is stated honestly because it is presented on slide 6.

- **Enforced by the tool.** The `tools:` whitelist in an agent's frontmatter. An agent without `Edit`, `Write` or `Bash` cannot modify files. This works only when the agent files are loaded at session start.
- **Conventional (instruction only).** Path scopes such as "edit only `slides/`", and the read-only status of a reviewer whenever the agent runs with the full tool set.
- **What happens in this session.** The `.claude/agents/` files are created in stage 1, **after** the session started, so this running session does not load them (observed in Projekt 1, final deck). The orchestrator therefore launches each role as a `general-purpose` agent whose prompt says "read `.claude/agents/<role>.md` and follow it as your role definition". It sets `model` and `effort` in the launch call to the values in the table below. Both reviewers then have the full tool set and are read-only **by instruction**, not by tool list.
- **Check before the first launch.** The orchestrator looks at whether the four roles are listed as available agent types. It logs the real answer. The slides state what the log says and nothing stronger. If the roles do load, slide 6 is changed to say so.
- **Later sessions.** A session started in `Projekt2/` after stage 1 (for example the P5 work) loads the files, and then the `tools:` whitelist is enforced.

| Role | `tools` (enforced only when loaded) | `model` / `effort` | Conventional scope | Used in this session |
|---|---|---|---|---|
| `coder` | Read, Glob, Grep, Edit, Write, Bash | sonnet / high | FUTURE (P5). Python code only from a task card | no |
| `code-reviewer` | Read, Glob, Grep | opus / high | FUTURE (P5). Checklist from section 4 | no |
| `latex-assistant` | Read, Glob, Grep, Edit, Write, Bash | sonnet / high | `slides/` only. Bash only for `make` and reading logs | **yes** |
| `presentation-reviewer` | Read, Glob, Grep | opus / high | criteria from three sources (`zasady` s. 5, p. 6.3) | **yes** |

Model choice follows `~/.claude/rules/agents.md`. Production roles get `sonnet` with effort `high`, independent review gets `opus` with effort `high`, and the orchestrator plans on the session model. `fable` is never used. P1 used `inherit` and `medium` for the producers. That is replaced here. The launch line shows the model and effort in one sentence, for example "Uruchamiam latex-assistant (sonnet, effort high)".

### 2.3 Rules shared by all agents (anti-slop)

- **No invented facts.** No invented numbers, citations, API names, page numbers or requirements. If a fact is not in the repo, in section 1.8 or in the lecturer's PDFs, say so.
- **No results on slides.** The preliminary deck shows no computed result (`Projekt_2.pdf` s. 3, p. 4). Constants quoted from `Projekt_2.pdf` (ε = 10⁻⁸ as the recommended value, equation numbers, N, η_j) are definitions, not results. A verbatim prompt quote copied from `docs/ai-log.md` is exempt, numbers included.
- **Plain technical tone.** No filler, no marketing tone, no emoji, no decorative icons.
- **Small scope.** Do only what the task card says. Report anything else you notice as a finding and do not fix it.
- **Report ambiguity, do not choose silently and do not ask the user.** When a requirement is ambiguous or two sources conflict, say so in the report. The orchestrator decides and logs (0.1). This replaces the Projekt 1 rule "stop and ask".
- **Honest reports.** If something failed or was skipped, say so explicitly.
- **No commits.** Subagents never run git commands that change anything.
- **Fresh context for reviewers.** A reviewer gets the artifact (PDF, sources, PNG pages) and the criteria sources. It does not get the orchestrator's conclusion about quality.

### 2.4 Template for a task card

The orchestrator fills this in for every delegation and stores it verbatim in the ai-log (5.3).

```markdown
## Task card: <short title>
Role: <role name> (read .claude/agents/<role>.md first)
Launch: <model> / <effort>
Goal: <one sentence, what exists after this task that did not exist before>
Requirements slice (with refs):
  - <requirement> (<file p. N>)
Files to touch: <paths>
Files NOT to touch: <paths>
Acceptance checklist:
  - [ ] <verifiable criterion>
  - [ ] <verifiable criterion>
Report format: what was done · files changed · what was NOT done and why · open questions
```

### 2.5 Template for a reviewer finding

Every finding uses these fields. They map one to one onto ai-log fields, so the AI-errors slides are built straight from the log.

```markdown
- Finding: <what is wrong, one sentence>
  Severity: blocker | major | minor | nit
  Requirement: <file p. N, or "style guide §X">
  Detected by: <how, e.g. comparing slide 4 with the formula in section 1.8, reading the compile log>
  Suggested fix: <one sentence, reviewers never apply fixes>
```

Severity scale.

- **blocker** breaks a mandatory condition (1.3).
- **major** loses points under 1.2 or states something false.
- **minor** hurts readability.
- **nit** is cosmetic.

### 2.6 Template for an ai-log entry (`docs/ai-log.md`)

```markdown
### <YYYY-MM-DD> · <agent> · <task title>
- Goal: <from the task card>
- Launch: <general-purpose reading the role file | loaded role>, <model> / <effort>
- Prompt / brief: <full task card verbatim in a collapsed <details> block>
- Result: <what came back, links to files>
- Evaluation: <did it meet the acceptance checklist, our assessment>
- AI errors detected: <findings in 2.5 format, or "none">
- Slide candidate: <which graded element from section 1.2 this can illustrate, or "-">
```

The first lines of the file are a `Status:` line (current stage, last verified step, what is next) that the orchestrator updates after every stage. Decision entries are described in 5.3.

### 2.7 Agent definitions

Copy each block below verbatim into `.claude/agents/<name>.md`.

#### `coder`

```markdown
---
name: coder
description: FUTURE (Projekt 2 final deck). Implements one task card at a time in the Python code of the linear-systems project. Use for any code-writing task, never for review.
model: sonnet
effort: high
tools: Read, Glob, Grep, Edit, Write, Bash
---
You implement exactly one task card for a numerical-methods student project (solving sparse linear systems Ax = b with LU, Jacobi and Gauss-Seidel).

Before writing code:
- Read the task card and the requirement slices it references. If docs/requirements-code.md does not exist, the card must carry the whole slice. If it does not, stop and report.
- If the card conflicts with the docs or the lecturer's PDFs, report it. Do not choose silently.

While writing code:
- Python scripts only (.py), no notebooks.
- Matrices stay in a sparse format, the basic part uses float64.
- The final relative residual is computed from A, b and x for every method, LU included, independently of any library message.
- Any number that will appear on a slide is written by the program to a results file, never printed for manual copying.
- Follow the conventions in docs/ and the existing code. New code must not stand out.

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
description: FUTURE (Projekt 2 final deck). Read-only reviewer that checks the linear-systems project code against the lecturer's requirements and the project's conventions. Reports findings and never edits.
model: opus
effort: high
tools: Read, Glob, Grep
---
You review code for compliance with requirements, not for taste. You cannot run code. If you need execution output, ask the orchestrator for it. You are read-only. Do not edit, write or run anything, even if your tool set would allow it.

Primary checklist: the requirement slice on the task card and docs/requirements-code.md if it exists. Pay particular attention to the places where AI-generated code typically goes wrong in this project:
- Relative residual per formula (2) of Projekt_2.pdf, eta_j = ||b - A x_j||_2 / ||b||_2, tolerance eps stated, absolute criterion when b = 0.
- Final residual recomputed from A, b, x for every method, LU included.
- Iteration limit, and the four outcomes kept apart (accuracy reached, limit exhausted, stagnation, divergence).
- Sparse format in the basic part, float64, and no hidden conversion to dense.
- Timing that excludes mesh generation, FEM assembly, plotting and printing. Residual history collected in a separate call.
- Speed-up reported only for runs that met the accuracy requirement.

Report every finding in this exact format:
- Finding: <one sentence>
  Severity: blocker | major | minor | nit
  Requirement: <file p. N or docs section>
  Detected by: <how you found it>
  Suggested fix: <one sentence>

End with a verdict, APPROVE or CHANGES REQUIRED, and a one-line justification. Do not pad the review. If you found nothing, say so plainly.
```

#### `latex-assistant`

```markdown
---
name: latex-assistant
description: Builds and edits the Beamer presentations (slides/) and their Makefiles for the numerical-methods projects. Use for any slide creation, layout or compilation task.
model: sonnet
effort: high
tools: Read, Glob, Grep, Edit, Write, Bash
---
You produce Beamer slides in Polish for a numerical-methods project presentation. Your scope is slides/ only. Use Bash only to run make and to read compile logs.

Hard requirements (missing any of them fails the presentation):
- aspectratio=169.
- Slide number "n/N" on every slide, from slides/common/mnstyle.sty. Do not edit that file unless the card says so.
- Compiled through a Makefile (plain pdflatex, run twice).
- Fonts embedded.

Content rules:
- Follow docs/presentation-style.md. If it does not exist, report it. Do not invent a visual style.
- Mathematical content comes from the card's slice of the verified theory (brief section 1.8). Do not add claims, theorem numbers or page references that are not in the card. Matrices bold uppercase, vectors bold lowercase, iteration index j.
- The preliminary deck shows no computed results and no code. Never type a number that is not a definition from the card.
- One message per slide. The title states the takeaway, the body is the evidence. Titles are one sentence, two lines at most.
- Writing in Polish slides: no long or medium dashes as sentence breaks (a plain hyphen is fine in legends and ranges), no semicolons, no colon inside a sentence, no arrows, no emoji, no exclamation marks, no rhetorical questions.
- Prompt quotes are verbatim from docs/ai-log.md. Mark every cut with [...]. Use fancyvrb with \begin{Verbatim}[commandchars=\\\{\},fontsize=\footnotesize] and escape exact symbols with commands. Put nothing after \end{Verbatim} on its line. Frames with Verbatim are [fragile].
- Allowed font sizes are \normalsize and \footnotesize. Never \scriptsize or \tiny.
- No icons, animations, overlays, \pause, shaded boxes or colours outside mnstyle.sty.

Process:
- After each change, compile and read the log.
- Zero overfull boxes, zero underfull boxes and zero LaTeX warnings are required. Report any that remain and do not hide them.
- If you use any external template or snippet, report its source. The expected answer is none.

Finish with: what changed · compile status (clean, or warnings with the list) · open questions.
```

#### `presentation-reviewer`

```markdown
---
name: presentation-reviewer
description: Read-only AI reviewer of the project presentations. Grades a compiled PDF and its LaTeX sources against the course rules, the project instruction and presentation-quality guidelines, and outputs a verbal grade and a 1-10 score. Never edits.
model: opus
effort: high
tools: Read, Glob, Grep
---
You review a student presentation (Polish, Beamer, 16:9, about 8 minutes) for a numerical-methods course. You are read-only. Do not edit, write or run anything, even if your tool set would allow it. Your criteria come from three sources, as the course rules require:
1. materials/zasady_zaliczenia_projektu_v1.pdf, the mandatory conditions and slide groups.
2. materials/Projekt_2.pdf, the project instruction. For the preliminary deck read section 4 (page 3). A preliminary deck needs no code and no computed results, so their absence is never a finding.
3. docs/presentation-style.md and the presentation-guide principles it cites, readability, one message per slide, assertion-evidence titles.

You also get the rendered pages as PNG files, the compile log and the output of the font and image checks. Read both the compiled PDF and the .tex sources. The mathematical statements on the intro slides must be correct. You may use the extract of the verified theory in docs/requirements-presentation.md as a claim to check, not as truth. Claims on the AI-collaboration slides must match docs/ai-log.md.

Evaluate:
- Compliance with the mandatory elements. Any missing mandatory element is a blocker.
- Correctness and comprehensibility of the three method slides (LU, Jacobi, Gauss-Seidel), including symbols explained and convergence conditions stated without overclaiming.
- Layout and legibility at full screen, font sizes, contrast, overlaps, cropping.
- Whether the claims about the AI work are true and not stronger than what the log shows, in particular the read-only status of reviewers.
- Whether prompt quotes are marked as cut where fragments are missing.
- Volume relative to 8 minutes.

Do not award course points. Your grade is advisory.

Report findings in this exact format:
- Finding: <one sentence>
  Severity: blocker | major | minor | nit
  Requirement: <file p. N or style-guide section>
  Detected by: <slide number and what you observed>
  Suggested fix: <one sentence>

End with:
- Verbal grade: <two or three sentences in Polish, one plain paragraph, no markdown, none of the characters # $ % & _ { } ~ ^ \, no long dashes and no semicolons, because it is shown verbatim on a slide>
- Score: <integer 1-10> / 10, with a one-line justification
- Top 3 improvements, ordered by impact
```

---

## 3. Presentation visual style

This section is the visual contract for `latex-assistant` and `presentation-reviewer`, which uses it as the third source of criteria. It is materialized as `docs/presentation-style.md`. Anything not allowed here is not used. Chart style is FUTURE (3.6).

### 3.1 Principles

- **Assertion-evidence.** The frame title is a full-sentence claim of at most two lines. The body is the evidence for that claim, which on this deck is an equation, a short list or a verbatim quote. Topic-only titles are not allowed on content slides.
- **One message per slide.** If a slide needs two claims, it becomes two slides.
- **Text budget.** Equation slides have at most three displayed equations and a symbol legend of at most four lines, plus at most three short bullets. Other slides have at most four bullets. No paragraphs anywhere.
- **Length.** About 8 minutes (`zasady` s. 4, p. 6.1). This deck has about 12 slides, with an upper bound of 14. The talk takes 6 to 7 minutes. Detail slides are marked in the speaker plan, not on the slide.
- **Writing rules for slide text.** Polish. A plain hyphen for ranges and symbol legends. No long or medium dashes as sentence breaks. No semicolons. No colon inside a sentence (short labels at the start of a line, such as "Co się stało", are fine). No arrows, no emoji. Quotation marks „…". The same rules apply to the orchestrator's own prose in the log, the plan and chat replies.
- **Third source for review criteria.** The presentation guides in `zasady` s. 6, p. 7 (Naegle, Doumont, Penn State assertion-evidence checklist and others). The principles above come from these guides' titles and descriptions. The guides themselves have not been reviewed in detail.

### 3.2 Palette

`slides/common/mnstyle.sty` is copied unchanged from Projekt 1 and keeps its definitions. Colours come from the lecturer's own materials (measured in Projekt 1). Background is white. The definitions are the following.

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

- **Used in the preliminary deck.** `mnText` for body text, `mnPrimary` for frame titles and bullets, `mnMuted` for the footer and source lines, `mnGrid` for the rule under the title. Text uses only `mnText`, `mnPrimary`, `mnMuted`, `mnBuy` and `mnSell` (contrast of at least 4.5:1). `mnBuy` and `mnSell` are not needed here.
- **Not used.** `mnBuyLight`, `mnSellLight`, `mnSignal`, `mnPrice` (roles from the MACD charts of Projekt 1). Chart roles for Projekt 2 are defined in the P5 brief. No colour outside this table is used.
- The header comment of `mnstyle.sty` says "Projekt 1 (MACD)". It is kept by user decision (1.7). It is not a finding.

### 3.3 Typography

- Engine `pdflatex` with `[T1]{fontenc}`, `[polish]{babel}`, `lmodern` and `tgheros` as the sans family (all in `mnstyle.sty`). Mathematics in Latin Modern serif.
- Class options `\documentclass[t,aspectratio=169,11pt]{beamer}`, as in the Projekt 1 preliminary deck.
- Frame title `\large`, bold, `mnPrimary`. Body `\normalsize`. Footer, source lines, symbol legends on equation slides and verbatim blocks `\footnotesize` (the smallest allowed). `\scriptsize` and `\tiny` are not allowed.
- Polish typography with a decimal comma in running text. Equations use `\mathbf` for matrices and vectors (1.8).

### 3.4 Slide layout

- **Base.** The default Beamer theme stripped of decoration, with `mnstyle.sty`. No external Beamer theme, so no external source needs a mention.
- **Frame title.** Left-aligned, `mnPrimary`, a thin `mnGrid` rule under it.
- **Footline.** Only `\insertframenumber\,/\,\inserttotalframenumber` on the right, in `mnMuted` and `\footnotesize`. This "n/N" number is mandatory (`zasady` s. 2, p. 4, warunek 6). The author's name appears on the title slide only.
- **Margins.** 8 mm left and right. Navigation symbols are off.
- **Title slide.** Topic, author, „Prezentacja wstępna", course name and date (1.7, slide 1). No logo, no background image.
- **No overhead slides.** No agenda, no section dividers, no "Dziękuję" or "Pytania?" slide.

### 3.5 Slide types

These are the only allowed layouts.

| Type | Content |
|---|---|
| Title | as in 3.4 |
| Equation | claim title, at most three displayed equations numbered as in `Projekt_2.pdf` where a number exists, symbol legend of at most four lines, at most three short bullets, an optional source line in `\footnotesize` |
| AI work | claim title, at most four bullets |
| Prompt | claim title, prompt excerpt in a `Verbatim` block of at most 10 lines (English, ADR-5), result and evaluation in two lines |
| AI error | claim title, fields „Co się stało", „Jak to wykryto", „Jak naprawiono", one error per slide |
| AI declaration | claim title and the verbatim declaration from 1.2, nothing else |
| AI review | claim title, reviewer definition with criteria and a prompt excerpt, or the verbal grade with the score shown as `N / 10` and the iteration line |

Chart and table layouts are FUTURE (P5).

### 3.6 Chart style (FUTURE, P5, do not implement)

Recorded for the P5 brief only. Vector PDF charts at the exact size they take on the slide, labelled axes with units, a legend covering every series, consistent legends and the same colour scale for A1 and A2 (`Projekt_2.pdf` s. 4, p. 5.1 and 5.2), a linear iteration axis and a logarithmic residual axis on D1 (s. 2, tab. 1), failed runs marked with a separate symbol and their status on B1 and C1 (s. 4, p. 5.1). Charts in vector format and no screenshots (`zasady` s. 5, p. 6.1).

### 3.7 Banned (anti-slop list)

The reviewer treats any occurrence as a finding of at least *minor* severity.

- **Imagery.** Icons, emoji, clipart, stock photos, AI-generated images, logos, decorative shapes, background images, screenshots of code or terminals.
- **Motion.** Animations, transitions, `\pause`, overlays, `\only` and `\uncover` reveals.
- **Decoration.** Gradients, shadows, rounded or shaded boxes.
- **Hard-coded values.** Any colour or font size not defined in 3.2 and 3.3.
- **Unsourced content.** A computed result on a slide (the preliminary deck has none). A theorem number, page reference or formula that is not in 1.8. A verbatim prompt quote is exempt. It reproduces the text logged in `docs/ai-log.md`, with cuts marked `[...]`. Definitions from `Projekt_2.pdf` are not results.
- **Weak titles.** A topic-only title on a content slide (the AI-declaration title in 1.7 is the one allowed exception).
- **Writing.** Marketing or hype vocabulary, exclamation marks, rhetorical questions, filler sentences, and every item of the writing rules in 3.1.
- **Unfinished work.** Placeholder text, `TODO`, `???`, a provisional grade shown as final, or overfull and underfull boxes in the build.
- **Overclaiming.** A statement about the AI work that is stronger than the log supports.

### 3.8 Verification

| Check | How | Who |
|---|---|---|
| Compiles cleanly | `make` without errors, **0 overfull, 0 underfull, 0 LaTeX warnings** in the log of the final pass (`grep -c -e Overfull -e Underfull -e Warning main.log` prints 0) | `latex-assistant`, then the orchestrator repeats it |
| Every page viewed | `pdftoppm -r 80 -png main.pdf <dir>/p` after **each** build, every PNG opened and looked at | orchestrator, PNG paths passed to the reviewer |
| Fonts embedded | `pdffonts main.pdf` shows `emb yes` on every row (`zasady` s. 5, p. 6.1) | orchestrator, output passed to the reviewer |
| No raster images | `pdfimages -list main.pdf` lists no images | orchestrator |
| Slide count | `pdfinfo main.pdf` pages equals the number of frames and the footline reads n/N on all of them | orchestrator |
| Prompt quotes verbatim | each `Verbatim` fragment, whitespace normalised and split at `[...]`, occurs in order inside the logged prompt | orchestrator (throwaway one-liner, not committed) |
| Content against sections 1 and 3 | full review | `presentation-reviewer` |
| Full-screen view | readability, cropping, overlaps (`zasady` s. 5, p. 6.1) | the user, at the single stop |

---

## 4. Code conventions (FUTURE, P5, do not implement now)

No code is written in this session. This section records only what the lecturer's PDFs state, so the P5 brief starts from verified facts. It does not design a `src/` layout and it creates no `docs/requirements-code.md`. The P5 brief decides those.

| Constraint | Source |
|---|---|
| Code only in `.py` files, no Jupyter notebooks | `zasady` s. 2, p. 3 |
| The starter program is `simulate.py` with directories `structures`, `solvers`, `fem`, `postprocessing`. All solver functions start empty. The starter code is **not** in `materials/` today, so P5 has to obtain it first (location not known to this brief) | `Projekt_2.pdf` s. 2, p. 3 |
| Basic part uses sparse matrices and `float64`. Own solvers or libraries are both allowed | `Projekt_2.pdf` s. 1, task 2, and s. 2 (format) |
| Four mesh densities, orientation N = 500, 1000, 2000, 4000, ratio about 1:2:4:8, N is the real number of unknowns | `Projekt_2.pdf` s. 3, p. 5.1 |
| Accuracy criterion η_j = ‖r^(j)‖₂ / ‖b‖₂ ≤ ε, ε = 10⁻⁸ recommended, equal requirements for the iterative methods, the ε used is stated, an absolute criterion when b = 0 | `Projekt_2.pdf` s. 3, wzór (2), and s. 3-4, p. 5.1 |
| Final relative residual computed from A, b, x for every method, LU included, independently of the library message | `Projekt_2.pdf` s. 3, p. 5.1 |
| An iteration limit is set. Four outcomes are kept apart (accuracy reached, limit exhausted, stagnation, divergence). Failed runs are marked on B1 and C1 with a separate symbol and status, and their time is "time to abort" | `Projekt_2.pdf` s. 4, p. 5.1 |
| Timing excludes mesh generation, FEM build, plotting and printing. LU reports `t_setup` (with factorization), `t_solve` and `t_total`. Residual history for D1 comes from a separate call. A median of repeats is allowed | `Projekt_2.pdf` s. 4, p. 5.3 |
| Speed-up s = t_total,LU / t_method only for results that met the accuracy requirement, otherwise „nie dotyczy" | `Projekt_2.pdf` s. 4, p. 5.3 |
| Charts come from own measurements, with axes, units, methods, variants and consistent legends. Names of the libraries used are advisable | `Projekt_2.pdf` s. 4, p. 5.1 |
| Optional float32 mode via `solver_dtype = "float32"` in `simulate.py`, the residual is checked in float64 | `Projekt_2.pdf` s. 7 |
| Code ZIP contains code without `.venv`, input data, run instructions, `zrodla.md` if templates were used. Use of templates needs sources in `zrodla.md` in the main code directory | `zasady` s. 2-3, p. 4 |

---

## 5. Documentation and AI-log protocol

This section defines when each document is written, who owns it and how it ties to commits.

### 5.1 Documents and owners

| Document | Language | Owner | Content | In the ZIP |
|---|---|---|---|---|
| `PROJECT_BRIEF.md` | EN, goals PL | orchestrator | source of intent. Changes go through the changelog (App. B) and ADRs (App. A) | no |
| `KICKOFF.md` | PL and EN | user | start command and the prompt to paste | no |
| `CLAUDE.md` | EN | orchestrator | short protocol, pointers to `docs/`, key facts (5.6) | no |
| `docs/requirements-presentation.md` | EN | orchestrator | extract of sections 1.2 to 1.5 and of the verified theory in 1.8 | no |
| `docs/presentation-style.md` | EN | orchestrator | extract of section 3, unchanged | no |
| `docs/ai-log.md` | PL | orchestrator | layer 1, decision register per stage. Layer 2, delegated tasks (2.6). `Status:` line at the top | no |
| `~/Downloads/MN-Projekt2/plan_wystapienia.md` | PL | orchestrator | per slide what to say and for how long (6.2, stage 4) | no |

Not created in this session. `docs/requirements-code.md`, `docs/requirements-charts.md`, `readme.md`, `zrodla.md`. They belong to P5 (section 4). The deck uses no external template or snippet, so no `zrodla.md` is needed. If an external LaTeX snippet turns out to be unavoidable, the orchestrator logs it as a decision and lists it at the stop.

### 5.2 Single direction of truth

```
lecturer's PDFs → PROJECT_BRIEF.md → docs/*.md → agent instructions
```

Changes flow downward only. When a requirement or convention changes, the brief is edited first (section text, ADR if it is a decision, changelog row, version bump). Only then are `docs/` and the agent files updated. `docs/` is never edited on its own.

### 5.3 When a log entry is written

**Layer 1, the decision register, one entry per stage.** The entry is opened when the stage starts and closed with its result. Status is "zaakceptowano" or "odrzucono" with the reason. A rejected and redone result stays in the entry. History is never rewritten. Each decision the orchestrator takes in place of the user gets a line in this layer.

```markdown
- Decyzja orkiestratora, zatwierdzona przez autora na przystanku przed wysłaniem.
  Pytanie: <co trzeba było rozstrzygnąć>
  Opcje: <rozważane opcje>
  Wybór i powód: <wybór>
  Źródło: <plik s. N albo "brief x.y">
```

**Layer 2, delegated tasks, one entry per delegation,** written by the orchestrator right after the agent returns (template 2.6). It holds

- the full task card verbatim in a collapsed `<details>` block (slide material for the selected prompt),
- the result and the evaluation against the card's checklist,
- every reviewer finding together with its resolution (fixed in commit `<hash>`, or rejected with the reason),
- for the presentation-reviewer, the **full review prompt verbatim** and the score of each iteration.

### 5.4 AI errors

- **What counts.** Any defect produced by AI (a subagent or the orchestrator) that was found by a reviewer, a verification command (3.8), a compile log or the user.
- **How it is recorded.** In the layer 2 entry, in the 2.5 format, with "Detected by" mandatory and the fix with the commit hash.
- **Scope of "the project".** The declaration in `zasady` covers the whole work on the project, and that work started with writing this brief. The errors of Appendix D are real, detected and fixed, so they are candidates exactly like errors of this session. As long as the log holds at least one real error, the deck shows error slides and never the declaration.
- **Only real errors.** Errors are never provoked, staged, embellished or renamed from a nit to an error for the slides. If none occurred, the deck carries the declaration from `zasady` s. 4, p. 5.3 in masculine form, which is „W trakcie prac nad projektem nie zauważyłem błędnego działania AI." The wording has to match the sentence in `zasady`, and the slide shows exactly one of the two variants, never both.
- **Which errors get a slide.** Every finding of severity major or higher and every failed verification command is a candidate. A minor finding is a candidate only if it is real and instructive. The orchestrator picks up to three candidates with different detection routes and logs the choice as a decision. Findings of lower severity stay in the log.
- **When the slides change.** The error slides are rebuilt from the log before every build, including after the final review. The grade of the final review refers to the deck of the final iteration. Every later change is named in `plan_wystapienia.md` and at the stop.

### 5.5 Commits

Commits follow `~/.claude/rules/git.md` (0.5) and are made only by the orchestrator. One verified step is one commit, typically one task card after verification. The log entry goes in the next commit because it records the hash of the step. Suggested subjects.

| Step | Subject |
|---|---|
| scaffold | `Add Projekt 2 scaffold` |
| deck after verification | `Add Projekt 2 preliminary deck` |
| fixes after review iteration | `Fix preliminary deck review findings` |
| grade macros and slide | `Add review grade to preliminary deck` |
| log entries | `Log preliminary deck work` |
| final log with submission | `Log Projekt 2 preliminary submission` |

The ZIP and `plan_wystapienia.md` stay outside the repo. `slides/preliminary/main.pdf` is committed, like in Projekt 1.

### 5.6 What `CLAUDE.md` contains

The file is short (about 40 lines, English), in the style of `../Projekt1/CLAUDE.md`, adapted. It holds only the following.

- A one-line title and the path convention (paths relative to `Projekt/Projekt2/`, repo root `~/Metody-numeryczne`).
- The scope fence from section 0 in two sentences, and the pointer to section 6.6 of the brief.
- Sources of truth in the order of section 0, with `docs/requirements-presentation.md`, `docs/presentation-style.md` and `.claude/agents/*.md` (no code or chart requirement files).
- The orchestration protocol. Delegation through task cards, `latex-assistant` then `presentation-reviewer`, verification by the orchestrator, one stop before submission, how the agents are launched (2.2).
- The non-negotiable rules. No result or unsourced claim on slides. Records after every stage and delegated task. Commits per `~/.claude/rules/git.md` with no AI marker. Packing from the whitelist and the ZIP test. Language split.
- A key-facts table. Author, P4 date and time, ZIP deadline 10:15 and target 10:00, course 8051, assignment `P2W` id 27573, deliverables folder, ZIP name.

---

## 6. Stages and the single stop

Stages run in the order below. Each stage ends with its exit criteria met, a commit and a decision-register entry (section 5). There are no checkpoints. The only stop is the one in 6.3.

### 6.1 Order rationale

- This session has no computation stage. The preliminary deck needs neither code nor results (`Projekt_2.pdf` s. 3, p. 4), so it is built from the verified theory in 1.8 and from the real work on the deck.
- The AI-collaboration slides are filled with real material from the work itself, namely task cards, reviewer findings and verification output. They are never hypothetical.
- The P2W package has priority over polish. The time guard in 0.3 applies at every stage.

### 6.2 Stages

| # | Stage | Delegated to | Deliverables | Exit criteria |
|---|---|---|---|---|
| 1 | Scaffold | orchestrator | `CLAUDE.md`, `docs/requirements-presentation.md`, `docs/presentation-style.md`, `docs/ai-log.md` with a first entry, four files in `.claude/agents/`, `slides/common/mnstyle.sty` | files match sections 1 to 5, frontmatter as in 2.7, `cmp` equal to the Projekt 1 style file, brief and kickoff committed |
| 2 | Preliminary deck | `latex-assistant` | `slides/preliminary/` (`main.tex`, `Makefile`, `intro.tex`, `ai-work.tex`, `ai-errors.tex`, `ai-review.tex`, `review.tex`, `main.pdf`) | outline of 1.7 covered, checks 3.8 pass, every page viewed |
| 3 | Review loop | `presentation-reviewer`, fixes by `latex-assistant` | up to three iterations, then `review.tex` with the final grade and the final build | iteration score and findings logged, every blocker, major and minor fixed or rejected with a reason, grade slide built from macros |
| 4 | Package, stop, submit | orchestrator | ZIP, `plan_wystapienia.md`, the stop, submission, download-back check, final log, push | 6.3 to 6.5 satisfied |

**Stage 1, scaffold.**

1. Preflight. `git status` is clean (the brief author already committed `PROJECT_BRIEF.md` and `KICKOFF.md`), branch `master`, remote as in 0.5. `kpsewhich tgheros.sty fancyvrb.sty`, and `which make pdflatex pdftoppm pdffonts pdfimages pdfinfo pdftotext zip unzip sha256sum` all resolve (else a hard blocker, 0.2). `git check-ignore -v materials/Projekt_2.pdf` must match. The root `.gitignore` already ignores `materials/` (unanchored) and the LaTeX auxiliary files, so **no `.gitignore` edit is needed**. Only if `check-ignore` fails, the session adds the missing entries.
2. Verify the references of sections 1 and 4 against the PDFs (section 0). Log the result.
3. Create the files from section 5. `docs/presentation-style.md` is a literal extract of section 3. `docs/requirements-presentation.md` is the extract described in 5.1. Copy the four agent blocks of 2.7 verbatim. `cp ../Projekt1/slides/common/mnstyle.sty slides/common/mnstyle.sty`, then `cmp` both files.
4. Check which role names are available as agent types and log the answer (2.2).
5. Write the first ai-log entry and the `Status:` line. Copy the errors of Appendix D into the log as layer 2 entries in the 2.5 format, marked "faza pisania briefu, 2026-11-16". Commit `Add Projekt 2 scaffold`.

**Stage 2, preliminary deck.** Two task cards, each with the model and effort line of 2.2.

- **Card A, skeleton and slides 1 to 5.** `main.tex` (class options 3.3, `\usepackage{mnstyle}`, title block of 1.7 slide 1, `\input` of the four content files), `Makefile` (plain `pdflatex -interaction=nonstopmode -halt-on-error` twice, `TEXINPUTS := ../common:`, targets `all` and `clean`, as in Projekt 1), and `intro.tex` with the three method slides plus the context slide from 1.8. Titles per the orchestrator's decision. The card carries the relevant slice of 1.8 and the notation note, so the agent needs no other source.
- **Card B, slides 6 to 12.** `ai-work.tex` (slide 6), the selected prompt and the error slides (`ai-errors.tex`), `ai-review.tex` and a provisional `review.tex`. The orchestrator supplies the text from the log, in particular the true statements about the launch mode, the verbatim prompt fragments, and the error records. Before the first iteration `review.tex` holds provisional macros (score 0, verbal grade "brak oceny, trwa pierwsza iteracja", history "brak"). The iteration paragraph of the first review says that slide 12 is provisional.
- **Slide 7, the selected prompt.** The orchestrator picks one real task card from the log (card A is the natural candidate, with its acceptance checklist), quotes at most 10 lines verbatim with every cut marked `[...]`, and writes the result and the evaluation from what really happened. The check in 3.8 proves the quote is verbatim.
- After each card the orchestrator rebuilds, runs 3.8, views every page, logs the task and commits `Add Projekt 2 preliminary deck`.

**Stage 3, review loop.** For each iteration n from 1 to 3.

1. Run the checks of 3.8 and render the pages (`pdftoppm -r 80`).
2. Launch `presentation-reviewer` (opus, effort high, one-line announcement). The prompt is the **core block** below, followed by the iteration paragraph. The core block is **identical in every iteration**, so the quote on slide 11 stays valid. The iteration paragraph lists the paths of the PDF, sources, PNG pages, compile log, `pdffonts` and `pdfimages` output, and says which iteration it is. It also says which grade slide 12 shows, which is a provisional one in iteration 1 and the grade of iteration n-1 later, and that the reviewer judges the slide's layout and not its values. It contains no opinion about quality.

```
Review slides/preliminary/main.pdf and its .tex sources against three sources
of criteria. (1) materials/zasady_zaliczenia_projektu_v1.pdf, the mandatory
conditions and slide groups. (2) materials/Projekt_2.pdf, section 4 on page 3,
the content of the preliminary deck. (3) docs/presentation-style.md,
assertion-evidence titles, text budget, palette, banned elements. Report
findings with severity and a suggested fix. End with a verbal grade and a
score 1-10.
```

3. Log the **full prompt verbatim**, every finding verbatim and the score (5.3). Write this iteration's real grade into `review.tex` (macros below, history so far), so the next iteration sees real values on slide 12 and the layout is tested with a verbal grade of real length.
4. Fix every blocker, major and minor finding through a `latex-assistant` card. A finding may be rejected only with a written reason that cites a higher source (for example a lecturer PDF), with two exceptions that cite the brief. (a) A finding that asks for more review slides or a longer deck contradicts the user's decision in 1.7 (two review slides, about 12 slides). It is rejected with the reason "brief 1.7, decyzja użytkownika", because `zasady` s. 5, p. 6.3 says "około czterech", a recommendation, not a condition of 1.3. (b) A finding that asks for three error slides when the log holds fewer real errors is rejected with the reason "brief 5.4, tylko rzeczywiste błędy", because `zasady` s. 4, p. 5.3 says "około trzech" and errors are never invented. Findings rejected under (a) or (b) do not keep the loop running (step 5) and are listed at the stop. Nits are fixed when cheap. Rebuild, run 3.8, view every page, commit `Fix preliminary deck review findings`.
5. Stop the loop when an iteration returns no blocker, major or minor finding other than those rejected under 4(a) or 4(b), or after iteration 3, or when the time guard demands it (0.3, at least one iteration always runs). Fixes made after the final iteration are not reviewed. The orchestrator checks them against the iteration's findings and names them in `plan_wystapienia.md`.

The orchestrator writes `slides/preliminary/review.tex` after every iteration with these macros, copied **verbatim** from that iteration's reviewer output (only LaTeX-special characters are escaped, and that is logged). After the final iteration the file holds the final grade. Nothing else on slide 12 carries a grade value.

```latex
\newcommand{\resReviewScore}{<integer 1-10 of the final iteration>}
\newcommand{\resReviewVerbal}{<verbal grade of the final iteration>}
\newcommand{\resReviewHistory}{<one sentence listing the scores of the iterations>}
```

After the final iteration, rebuild, run 3.8, view slide 12 (the grade text must fit without `\scriptsize`) and commit `Add review grade to preliminary deck`. Slide 12 has no footnote. Slide 11 quotes the core block, with cuts marked `[...]`.

**Stage 4, package, stop, submit.**

1. `make clean && make` in `slides/preliminary/`, run 3.8 once more. Check `get_recent_changes` for course 8051 (1.4) and log it.
2. Build `~/Downloads/MN-Projekt2/zambrzycki_projekt2_wstepna.zip` from the whitelist of 1.5 with an explicit file list (`zip -X`, run from `Projekt/Projekt2/`, no globs that could pick up auxiliary files). Run the ZIP test (6.4).
3. Write `~/Downloads/MN-Projekt2/plan_wystapienia.md`. Polish, addressed to the user, masculine forms. Format after `~/Downloads/MN-Projekt1/plan_wystapienia.md`. A table with the slide number, what to say and the time in seconds, total about 6 to 7 minutes. Detail slides get a "skrót" mark and one sentence. In the AI part the talk concentrates on **one** experience and the key observation from the review (`zasady` s. 4, p. 6.1). A closing paragraph lists the fixes made after the final review and any change of the error slides after it.
4. Prepare the submission call without confirm (6.5, steps 1 and 2).
5. **Stop** (6.3).
6. After "tak", submit and verify (6.5), write the final ai-log entry (ZIP contents, SHA-256, submission state, download-back result, deadline), commit `Log Projekt 2 preliminary submission` and push `master` after the remote check of 0.5.

### 6.3 The single stop

The orchestrator writes one message to the user in Polish with these items, and waits.

1. Path of `main.pdf` and its page count.
2. The slide titles, numbered.
3. The AI-error slides (their titles and one line each), or the information that the deck carries the declaration.
4. The final review grade. The verbal grade verbatim, `N / 10` and the iteration history.
5. The ZIP path, the output of `unzip -l` and the full SHA-256.
6. The description returned by the eNauczanie tool without confirm, and the assignment state (6.5).
7. Orchestrator decisions taken for the user, source conflicts found (including those listed in 1.2), fixes made after the final review, findings rejected with their reasons.
8. A reminder to open the PDF in full-screen mode (`zasady` s. 5, p. 6.1) and the deadline, 10:15 (target 10:00).

The orchestrator submits only after the user's explicit "tak". It handles other answers like this.

| Answer | Action |
|---|---|
| a requested change | apply it through a task card, rebuild, run 3.8, redo the ZIP test, recompute the SHA-256, log it and show the stop again with what changed. Say that the review grade refers to the earlier version, unless time allows one more iteration |
| a question | answer it and ask again |
| "nie" or silence | submit nothing, leave the ZIP in `~/Downloads/MN-Projekt2/`, say where it is |

### 6.4 Packaging procedure and ZIP test

1. Build the ZIP from the explicit whitelist (1.5), never from a directory with exclusions.
2. Unpack it into a new empty scratch directory (0.6) and run `make -B -C <dir>/slides/preliminary` there. Plain `make` builds nothing, because the shipped PDF is newer than the sources.
3. Compare the rebuilt PDF with the repo PDF. `pdftotext` output is identical, `pdfinfo` page counts are equal, and `pdftoppm -r 50` renders are identical page by page (`cmp`). Also `cmp` the shipped `main.pdf` with the repo one.
4. List the contents (`unzip -l`) and the SHA-256 in the stage entry. The listing contains no `docs/`, `.claude/`, `materials/`, `CLAUDE.md`, `*.md` or auxiliary files.
5. Accept the ZIP only if all of this holds.

### 6.5 Submission procedure (eNauczanie)

Facts checked by the orchestrator of this brief on 2026-11-16. Course 8051 "Metody Numeryczne Informatyka", assignment `P2W` ("Prezentacja wstępna z projektu 2"), `assignment_id` 27573, `module_id` 271144, submission type file, maximum grade 2. `get_assignment_status(27573)` returned `status: new` and `can_submit: false` on that day. The meaning of `can_submit: false` is not known. The session reads it again and reports it. The tool description says new files replace every file already in the submission. In Projekt 1 the final assignment P1K had no draft stage, so saving handed the work in. Do not assume the same here, rely on the tool's description.

1. `get_assignment_status(27573)`. Record the state.
2. `save_assignment_submission(course_id=8051, assignment_id=27573, file_paths=[<zip>])` **without** `confirm`. The error text describes the change and says whether saving hands the work in. This text goes into the stop message.
3. Wait at the stop (6.3).
4. After "tak", repeat the call with `confirm=true`. If the description said that a draft remains, call `submit_assignment(course_id=8051, assignment_id=27573)` without confirm, and with `confirm=true` under the same "tak" when its description names the same assignment and file. If anything differs, show it and ask again.
5. Download the submitted file back. `get_assignment_status` should give the file URL (the response seen on 2026-11-16 had no files field, because nothing was submitted yet). `download_file(course_id, fileurl)` takes no destination. It saves into the MCP server's own download directory, `~/enauczanie-mcp/downloads/<course>/...` (`~/enauczanie-mcp/enauczanie_mcp/config.py:37`), and returns the path. It never writes to `~/Downloads/MN-Projekt2/`. Hash the file where the tool put it, without moving, unpacking or building it. `sha256sum` must equal the local SHA-256. Record state and hashes in the log. If no URL is returned, report that in the final message and do not guess.
6. On a mismatch or an error, report it and wait. Do not retry with `confirm=true` on its own.

If the eNauczanie tools are unavailable, write is disabled or the tool refuses, the stop message says so, the ZIP stays in `~/Downloads/MN-Projekt2/` for manual upload on the portal, and the session logs what the user reports.

### 6.6 NOT in this session

Do not start any of these. Each one needs its own brief and the user's decisions.

| # | Stage | Summary for later (sources in section 1.2 and 4) |
|---|---|---|
| 5 | Starter program and basic solvers | obtain the starter code and `simulate.py`, set up the environment, complete LU, Jacobi and Gauss-Seidel in the starter structure, first residual checks (`Projekt_2.pdf` s. 2, p. 3) |
| 6 | Structure and own variant | choose a structure (s. 3, tab. 2), prepare the starter and own variant, same thermal conditions for both (s. 3). Placeholder for the user's decision |
| 7 | Measurements and charts | four meshes, B1, C1, D1 with tables, A1 and A2 with a common colour scale (s. 4, p. 5.2 to 5.6) |
| 8 | Experiment | one or more paths from s. 5-7, p. 6, up to 2 pts, own idea agreed with the lecturer in advance (s. 5). Placeholder for the user's decision |
| 9 | Final deck and P5 packages | final deck from the extended style, two ZIPs, 2026-12-02, ZIPs by 10:15 |

---

## Appendix A. Decision log (ADR-lite)

**ADR-1. No separate orchestrator agent.**

- **Decision.** The main session orchestrates.
- **Why.** A subagent orchestrator adds two lossy hand-offs per task and hides work from the user.
- **Trade-off.** The main session context grows. Delegating the heavy work limits it.

**ADR-2. Four roles, two used.**

- **Decision.** `coder`, `code-reviewer`, `latex-assistant`, `presentation-reviewer`, matching the roles suggested in `zasady` s. 5, p. 6.2. This session launches only the two slide roles.
- **Why.** The same role set serves P5, so nothing needs redefining.
- **Trade-off.** Two definitions are unused for now and the slides say so.

**ADR-3. Specialize through task cards, not through the number of agents.**

- **Decision.** A per-task card carries the exact requirement slice.
- **Why.** Quality comes from narrow context.
- **Trade-off.** Path scopes and read-only status are conventional in this session (2.2).

**ADR-4. No results on the preliminary deck, definitions only.**

- **Decision.** The deck shows no computed value (`Projekt_2.pdf` s. 3, p. 4). Constants from the instruction are definitions.
- **Why.** The instruction does not ask for results here, and a typed number is a source of errors. For P5 the Projekt 1 rule applies, results flow from the program to result files and into Beamer with `\input`.
- **Trade-off.** None for this deck.

**ADR-5. Agent instructions in English, human-facing content in Polish.**

- **Decision.** As stated.
- **Why.** Consistency with code and identifiers.
- **Trade-off.** Prompts quoted on slides are in English.

**ADR-6. One autonomous run with a single stop.**

- **Decision.** The orchestrator decides what the user decided at checkpoints in Projekt 1, and the user approves at one stop before submitting.
- **Why.** The user chose it on 2026-11-16. The deck is small and theory-only.
- **Trade-off.** Interpretation choices (titles, which errors get slides) are not seen before the stop. Logging each as a decision and showing them at the stop limits the risk.

**ADR-7. Roles launched as general-purpose agents that read their role files.**

- **Decision.** As in 2.2.
- **Why.** Agent files created in a running session are not loaded by it.
- **Trade-off.** Read-only reviewers are a convention. The slides say so.

**ADR-8. Slides `Makefile` uses plain `pdflatex` twice, not `latexmk`.**

- **Decision.** As stated.
- **Why.** The lecturer's recommended Windows setup is MiKTeX + MSYS2 (`zasady` s. 2, p. 4, warunek 5), where the Perl dependency of `latexmk` is not guaranteed, and two passes are enough for "n/N".
- **Trade-off.** No automatic rebuild on changed dependencies.

**ADR-9. Grade values only through macros in `review.tex`.**

- **Decision.** The score, the verbal grade and the history line are macros copied verbatim from the final review.
- **Why.** The slide must show exactly what the reviewer wrote, and a hand-typed grade is a transcription risk.
- **Trade-off.** One more file in the ZIP.

**ADR-10. Notation of the intro slides.**

- **Decision.** Saad's splitting and iteration matrices, the lecturer's component names (x_i, b_i, a_ij), the lecturer's iteration index j, bold matrices and vectors (1.8).
- **Why.** The lecturer's PDF outranks the book, and the reviewer reads the lecturer's PDF.
- **Trade-off.** The mapping to Saad's k, ξ_i and β_i has to be stated once, on slide 2.

## Appendix B. Brief changelog

| Version | Date | Change | Reason |
|---|---|---|---|
| 1.0 | 2026-11-16 | Full brief for the preliminary deck of Projekt 2 (P2W), adapted section by section from the Projekt 1 brief v1.11 | Projekt 2 starts. The Projekt 1 workflow is reused with one autonomous session and one stop |
| 1.1 | 2026-11-16 | Rejection rule for findings that contradict 1.7 or ask for invented errors (stage 3, steps 4 and 5). Errors of the brief-writing phase in Appendix D count for the error slides (1.7, 5.4). Real `download_file` destination (0.6, 6.5). Brief and kickoff committed before the session starts (stage 1). `get_recent_changes` filtered by course (1.4) | Builder check of v1.0 by a fresh reviewer agent (opus, effort high) |
| 1.2 | 2026-11-16 | LU without pivoting. The "if and only if" on leading principal minors is limited to nonsingular matrices (1.8, slide 3). Symbol legends on equation slides may use `\footnotesize` (3.3) | Review iteration 1 of the preliminary deck. The reviewer gave a singular counterexample to the old LU claim. The legend size removes a contradiction between 3.3 and the `latex-assistant` role (2.7), which already allows `\normalsize` and `\footnotesize` |

## Appendix C. Lessons from Projekt 1

Each lesson comes from the Projekt 1 work (brief v1.0 to v1.11, `../Projekt1/docs/ai-log.md`) and is folded into the section shown.

| Lesson | Applied in |
|---|---|
| The footline shows only "n/N". The author's name is on the title slide only. `mnstyle.sty` is reused as is | 3.2, 3.4, stage 1 |
| No hand-typed results. Constants from the instruction are definitions. A verbatim prompt quote is exempt | 2.3, 3.7, ADR-4 |
| Prompt quotes are verbatim from the log with every cut marked `[...]`. The core block of the review prompt stays identical between iterations. The full prompt of each iteration is logged | 3.8, 5.3, 6.2 (stage 3) |
| `fancyvrb` `Verbatim` with `commandchars` and `fontsize`. Nothing after `\end{Verbatim}` on its line | 2.7 (`latex-assistant`) |
| One-line assertion titles of two lines at most, no paragraphs, plain hyphen, Polish diacritics, the writing rules | 3.1, 3.7 |
| Agent launch mode is described honestly. Agent files created in the session are not loaded, so each role is a general-purpose agent reading its role file. Reviewers are read-only by instruction. Overstating this was a major finding in Projekt 1 | 2.2, ADR-7, 1.7 (slide 6) |
| "AI proposes, author approves" must be literally true. Here the author approves at the single stop | 0.1, 1.7 (slide 6) |
| Every page rendered to PNG and viewed after each build. 0 overfull, 0 underfull, 0 warnings. `pdffonts` embedded, `pdfimages` empty | 3.8 |
| ZIP test unpacks into an empty directory and runs `make -B`. Plain `make` builds nothing. Compare text and 50-dpi renders. List contents and SHA-256 | 6.4 |
| Review loop of up to three iterations with the reviewer at opus and effort high. Fixes between iterations. Grade slide from macros, no footnote on it. Fixes after the final review go into the talk plan | 6.2 (stage 3), ADR-9 |
| Submission without confirm first, description shown, explicit "tak", then `confirm=true`, then download back and compare SHA-256 | 6.3, 6.5 |
| Talk plan in `~/Downloads/MN-Projekt2/plan_wystapienia.md`, 6 to 7 minutes, one AI experience and the key review observation | 6.2 (stage 4) |
| Communication in Polish with masculine forms, short and concrete, simple explanations | 0.4 |
| Git per `~/.claude/rules/git.md`. One imperative sentence of 3 to 8 words, no AI marker, no internal stage names in subjects, remote `Zambrzyckii`, never `ZambrzyckiBartosz`. `permissions.deny` is never worked around | 0.5, 5.5 |
| Subagent models. Producers sonnet and high, reviewers opus and high. Model and effort named in one line at launch | 2.2, 2.4 |
| Downloaded files are untrusted. Separate scratch dirs and `python -I` | 0.6 |
| A log entry after every delegated task and stage, only real AI errors, `Status:` line | 2.6, 5.3, 5.4 |
| The orchestrator never delegates the decision to submit and starts nothing beyond the P2W submission | 0.1, 6.6 |
| A reviewer that does not know a preliminary deck needs no code or results will report their absence | 2.7 (`presentation-reviewer`) |
| A theorem or a page number that was not verified must not appear on a slide | 1.8, 3.7 |

## Appendix D. AI errors from the brief-writing phase (2026-11-16)

These errors happened while this brief was prepared in an earlier session (orchestrator plan, a writer agent, a builder-check agent). They are real, detected and fixed, and they belong to the work on Projekt 2 (5.4). Stage 1 copies them into `docs/ai-log.md`. Each one is a slide candidate with its own detection route.

- Finding: The orchestrator's plan stated that `zasady_zaliczenia_projektu_v1.pdf` scores the preliminary deck "like P1W table 1 (5 × 0,4)". Neither `zasady` nor `Projekt_2.pdf` contains that split. It exists only in `Projekt_1.pdf` s. 9, tab. 1.
  Severity: major
  Requirement: `zasady` s. 1, tab. 2. `Projekt_2.pdf` s. 1-2, p. 2
  Detected by: the writer agent checked every page reference with `pdftotext -f N -l N` while writing the brief and found no such table. The orchestrator confirmed it with `grep` over the full text of both PDFs.
  Fix: section 1.2 marks the split as an assumption carried over from Projekt 1, with its real source.

- Finding: The same plan line attributed the rule "title slide with Prezentacja wstępna" to `zasady`. Neither `zasady` nor `Projekt_2.pdf` states it. It comes from `Projekt_1.pdf` s. 5, p. 4.1.
  Severity: minor
  Requirement: `Projekt_1.pdf` s. 5, p. 4.1
  Detected by: the same page-by-page check of the writer agent, confirmed by `grep`.
  Fix: section 1.2 records it as an assumption kept by user decision.

- Finding: Brief v1.0 (sections 0.6 and 6.5, step 5) told the session to download the submitted ZIP back into a fresh scratch directory. The eNauczanie tool `download_file(course_id, fileurl)` takes no destination and always saves into `~/enauczanie-mcp/downloads/<course>/`.
  Severity: major (an instruction that cannot be executed in the submission check)
  Requirement: tool schema of `download_file`. `~/enauczanie-mcp/enauczanie_mcp/config.py:37`
  Detected by: a fresh builder-check agent (opus, effort high) read only the brief, loaded the tool schema and found the parameter missing. The orchestrator confirmed the directory in the server code.
  Fix: brief v1.1 (6.5, step 5 and 0.6) hashes the file where the tool saves it.
