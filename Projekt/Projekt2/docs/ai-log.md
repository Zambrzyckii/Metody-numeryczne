# Dziennik pracy z AI, Projekt 2 (układy równań liniowych)

Status: etap 2 (talia wstępna) zakończony. Ostatni zweryfikowany krok to talia z 11 slajdami, commit `df29a84`. Następny jest etap 3, iteracja 1 recenzji.

Dziennik ma dwie warstwy.

1. **Rejestr decyzji.** Jeden wpis na etap pracy orkiestratora (główna sesja Claude Code), z decyzjami podjętymi zamiast użytkownika.
2. **Zadania agentów.** Wpis według szablonu z `PROJECT_BRIEF.md` 2.6 dla każdego zadania delegowanego subagentowi oraz błędy AI z fazy pisania briefu.

Narzędzie to Claude Code. Repozytorium `~/Metody-numeryczne`, katalog projektu `Projekt/Projekt2/`.

---

## Rejestr decyzji

### Etap 1 · Szkielet projektu (2026-11-16)

**Polecenie**

- Prompt startowy z `KICKOFF.md`. Przeczytać sekcję 0 briefu i ją wykonać. Zakres to wyłącznie prezentacja wstępna P2W i jej wysłanie. Etapy 1 do 4 bez zatrzymywania, jeden przystanek przed wysłaniem do eNauczania.

**Weryfikacja wstępna**

- `git status` czysty, gałąź `master`, remote `https://github.com/Zambrzyckii/Metody-numeryczne.git`.
- `kpsewhich` znajduje `tgheros.sty` i `fancyvrb.sty`. `which` znajduje `make`, `pdflatex`, `pdftoppm`, `pdffonts`, `pdfimages`, `pdfinfo`, `pdftotext`, `zip`, `unzip` i `sha256sum`.
- Trzy PDF-y prowadzącego leżą w `materials/` (`Projekt_2.pdf` 11 stron, `zasady_zaliczenia_projektu_v1.pdf` 6 stron, `harmonogram_2026_v3.pdf` 3 strony).
- `git check-ignore -v materials/Projekt_2.pdf` zwraca regułę `.gitignore:1:materials/`, więc `.gitignore` nie wymaga zmian.
- Sesja zaczęła się 2026-11-16 o 20:03, przed progiem 2026-11-18 08:00 z briefu 0.3.

**Weryfikacja odnośników do stron (brief 0)**

- Każdy odnośnik z sekcji 1 i 4 briefu sprawdzono poleceniem `pdftotext -layout -f N -l N` na wskazanej stronie. Wszystkie się zgadzają, więc brief pozostaje w wersji 1.1 bez zmian.
- Spostrzeżenie bez wpływu na brief. `zasady` s. 5, p. 6.3 odsyła do poradników „z punktu 6.3.1", a lista poradników jest w p. 7 na s. 6. Brief 3.1 cytuje poprawnie p. 7.
- Twierdzenia o literaturze w briefie 1.8 (Saad, Fawzi, Vandenberghe) nie były sprawdzane w tej sesji, zgodnie z briefem 1.8.

**Sprawdzenie typów agentów (brief 2.2)**

- Dostępne typy agentów w tej sesji to `claude`, `claude-code-guide`, `claushh-implementer`, `claushh-planner`, `claushh-reviewer`, `Explore`, `general-purpose`, `Plan`, `repo-docs-writer`, `statusline-setup`, `typeracer-docs-writer` i `web-fetch`.
- Żadnej z czterech ról (`coder`, `code-reviewer`, `latex-assistant`, `presentation-reviewer`) nie ma na liście. Pliki ról z `../Projekt1/.claude/agents/` też nie są załadowane.
- Wniosek. Każda rola działa jako agent `general-purpose`, który czyta `.claude/agents/<rola>.md`. Model i effort ustawia wywołanie. Recenzent ma pełny zestaw narzędzi i jest tylko do odczytu na mocy instrukcji, nie listy narzędzi.

**Wynik**

- `CLAUDE.md`, `docs/requirements-presentation.md` (angielski wyciąg briefu 1.2 do 1.5 i 1.8), `docs/presentation-style.md` (dosłowny wyciąg sekcji 3), ten dziennik.
- `.claude/agents/` z czterema plikami ról. Wyciągnięte skryptem z bloków briefu 2.7, każdy plik jest dosłownym fragmentem briefu (sprawdzone porównaniem podciągów).
- `slides/common/mnstyle.sty` skopiowany z `../Projekt1/slides/common/mnstyle.sty`, `cmp` nie pokazuje różnic.
- Błędy AI z fazy pisania briefu (Appendix D) przeniesione do warstwy „Zadania agentów".
- Status: zaakceptowano, kryteria wyjścia etapu 1 spełnione. Commit `90562d8`.

### Etap 2 · Talia wstępna (2026-11-16)

**Polecenie**

- Brief 6.2, etap 2. Dwie karty dla `latex-assistant` (sonnet, effort high). Karta A to szkielet i slajdy 1 do 5, karta B to slajdy 6 do 12.

**Decyzje**

- Decyzja orkiestratora, zatwierdzona przez autora na przystanku przed wysłaniem.
  Pytanie: jakie tytuły dostają slajdy 2 do 5.
  Opcje: propozycje z briefu 1.7 albo nowe tytuły.
  Wybór i powód: propozycje z briefu 1.7 bez zmian, bo każda jest tezą w jednym zdaniu i zgadza się z treścią z briefu 1.8.
  Źródło: brief 1.7, 1.8
- Decyzja orkiestratora, zatwierdzona przez autora na przystanku przed wysłaniem.
  Pytanie: jak opisać warunek dominacji przekątniowej na slajdzie Jacobiego.
  Opcje: „ścisła albo nieredukowalna dominacja" przy wzorze z nierównością ostrą albo sama ścisła dominacja.
  Wybór i powód: sama ścisła dominacja wierszowa. Wzór |a_ii| > Σ|a_il| opisuje tylko przypadek ścisły, więc słowa zgadzają się ze wzorem i slajd nie twierdzi więcej niż wzór.
  Źródło: brief 1.8 (Saad, tw. 4.9)
- Decyzja orkiestratora, zatwierdzona przez autora na przystanku przed wysłaniem.
  Pytanie: czy dzielić gęsty slajd 4 (Jacobi) na dwa, o co pytał agent.
  Opcje: podział na slajd wzorów i slajd zbieżności albo jeden slajd.
  Wybór i powód: jeden slajd. Mieści się bez `\scriptsize`, a brief dopuszcza podział tylko wtedy, gdy budżet tekstu bez `\scriptsize` się nie mieści.
  Źródło: brief 1.7 (akapit pod układem talii)
- Cel `clean` w `Makefile` usuwa też `main.pdf`, inaczej niż w projekcie 1. Przyjęte, bo etap 4 i tak buduje talię od nowa poleceniem `make clean && make`.
- Decyzja orkiestratora, zatwierdzona przez autora na przystanku przed wysłaniem.
  Pytanie: które błędy AI z dziennika dostają slajdy.
  Opcje: trzy błędy z fazy pisania briefu (dwa z nich mają tę samą drogę wykrycia), znalezisko nit z karty A, przyszłe znaleziska recenzenta.
  Wybór i powód: błąd o podziale punktów (sprawdzanie stron PDF przez agenta piszącego brief) i błąd o katalogu pobierania (niezależny agent sprawdzający schemat narzędzia). Mają różne drogi wykrycia i wagę major. Błąd o slajdzie tytułowym ma tę samą drogę co pierwszy, a znalezisko z karty A ma wagę nit, więc zostają w dzienniku. Trzecie miejsce czeka na rzeczywisty błąd tej sesji z trzecią drogą wykrycia.
  Źródło: brief 5.4
- Decyzja orkiestratora, zatwierdzona przez autora na przystanku przed wysłaniem.
  Pytanie: jakie tytuły dostają slajdy 6 do 11 i który prompt trafia na slajd 7.
  Opcje: propozycje z briefu 1.7 albo tytuły z faktycznego przebiegu. Na slajd 7 karta A albo inna karta.
  Wybór i powód: slajd 6 z propozycji briefu, bo zgadza się z przebiegiem. Slajd 7 cytuje kartę A (cel i dwa punkty listy kontrolnej), a tytuł mówi o sprawdzaniu pracy agenta poleceniami, bo tak odebrano kartę A. Slajdy 8 i 9 mają tytuły z treści błędów. Slajd 10 opisuje faktyczną konfigurację recenzenta, a slajd 11 podaje ocenę z makr.
  Źródło: brief 1.7, 6.2 (etap 2)

**Wynik**

- Talia ma 11 slajdów. Wstęp to slajdy 1 do 5, praca z AI slajdy 6 i 7, błędy AI slajdy 8 i 9, recenzja AI slajdy 10 i 11.
- Commity `dd70825` (karta A) i `df29a84` (karta B). Kontrole 3.8 przechodzą po każdej karcie, wszystkie strony obejrzane.
- Status: zaakceptowano, kryteria wyjścia etapu 2 spełnione.

---

## Zadania agentów

### 2026-11-16 · orkiestrator (faza pisania briefu) · Plan briefu, punktacja P2W

Wpis przeniesiony z `PROJECT_BRIEF.md` Appendix D, faza pisania briefu, 2026-11-16. Pełny prompt tej fazy nie jest częścią repozytorium.

**Błędy AI**

- Finding: The orchestrator's plan stated that `zasady_zaliczenia_projektu_v1.pdf` scores the preliminary deck "like P1W table 1 (5 × 0,4)". Neither `zasady` nor `Projekt_2.pdf` contains that split. It exists only in `Projekt_1.pdf` s. 9, tab. 1.
  Severity: major
  Requirement: `zasady` s. 1, tab. 2. `Projekt_2.pdf` s. 1-2, p. 2
  Detected by: the writer agent checked every page reference with `pdftotext -f N -l N` while writing the brief and found no such table. The orchestrator confirmed it with `grep` over the full text of both PDFs.
  Fix: section 1.2 marks the split as an assumption carried over from Projekt 1, with its real source.

**Kandydat na slajd**

- Raport o błędach AI. Droga wykrycia to sprawdzanie stron PDF przez agenta piszącego brief.

### 2026-11-16 · orkiestrator (faza pisania briefu) · Plan briefu, slajd tytułowy

Wpis przeniesiony z `PROJECT_BRIEF.md` Appendix D, faza pisania briefu, 2026-11-16.

**Błędy AI**

- Finding: The same plan line attributed the rule "title slide with Prezentacja wstępna" to `zasady`. Neither `zasady` nor `Projekt_2.pdf` states it. It comes from `Projekt_1.pdf` s. 5, p. 4.1.
  Severity: minor
  Requirement: `Projekt_1.pdf` s. 5, p. 4.1
  Detected by: the same page-by-page check of the writer agent, confirmed by `grep`.
  Fix: section 1.2 records it as an assumption kept by user decision.

**Kandydat na slajd**

- Raport o błędach AI. Ta sama droga wykrycia co w poprzednim wpisie.

### 2026-11-16 · orkiestrator (faza pisania briefu) · Brief v1.0, pobranie pliku z eNauczania

Wpis przeniesiony z `PROJECT_BRIEF.md` Appendix D, faza pisania briefu, 2026-11-16.

**Błędy AI**

- Finding: Brief v1.0 (sections 0.6 and 6.5, step 5) told the session to download the submitted ZIP back into a fresh scratch directory. The eNauczanie tool `download_file(course_id, fileurl)` takes no destination and always saves into `~/enauczanie-mcp/downloads/<course>/`.
  Severity: major (an instruction that cannot be executed in the submission check)
  Requirement: tool schema of `download_file`. `~/enauczanie-mcp/enauczanie_mcp/config.py:37`
  Detected by: a fresh builder-check agent (opus, effort high) read only the brief, loaded the tool schema and found the parameter missing. The orchestrator confirmed the directory in the server code.
  Fix: brief v1.1 (6.5, step 5 and 0.6) hashes the file where the tool saves it.

**Kandydat na slajd**

- Raport o błędach AI. Droga wykrycia to niezależny agent sprawdzający brief ze schematem narzędzia.

### 2026-11-16 · latex-assistant · Deck skeleton and intro slides 1 to 5

- Goal: `slides/preliminary/` zawiera `main.tex`, `Makefile` i `intro.tex`, które kompilują się do czystego PDF-u z pięcioma slajdami (tytułowy i cztery slajdy równań).
- Launch: `general-purpose` czytający plik roli `.claude/agents/latex-assistant.md`, sonnet / high.
- Prompt / brief: polecenie uruchomienia i pełna karta zadania poniżej, dosłownie.

<details>
<summary>Polecenie uruchomienia agenta</summary>

```text
Read /home/bob/Metody-numeryczne/Projekt/Projekt2/.claude/agents/latex-assistant.md and follow it as your role definition. Your working directory is /home/bob/Metody-numeryczne/Projekt/Projekt2 and all paths in the card are relative to it. Your task card is the file /home/bob/.claude/jobs/458e5e91/tmp/cards/card-a.md. Read it in full and carry it out. Do not run any git command that changes anything. Finish with the report in the card's format.
```

</details>

<details>
<summary>Pełna karta zadania</summary>

```markdown
## Task card: Deck skeleton and intro slides 1 to 5
Role: latex-assistant (read .claude/agents/latex-assistant.md first)
Launch: sonnet / high
Goal: slides/preliminary/ holds main.tex, Makefile and intro.tex that compile to a clean five-slide PDF with the title slide and four equation slides.
Requirements slice (with refs):
  - Class options exactly \documentclass[t,aspectratio=169,11pt]{beamer} and \usepackage{mnstyle}. Footline n/N comes from slides/common/mnstyle.sty, do not edit that file (docs/presentation-style.md 3.3, 3.4. zasady p. 2, section 4, condition 6)
  - Makefile. Plain pdflatex -interaction=nonstopmode -halt-on-error run twice, TEXINPUTS := ../common: exported, targets all and clean, main.pdf depends on $(wildcard *.tex) and ../common/mnstyle.sty. No latexmk (brief ADR-8)
  - main.tex. Title slide in a [c] frame with \title{Projekt 2: Rozwiązywanie układów równań liniowych}, \subtitle{Prezentacja wstępna}, \author{Bartosz Zambrzycki}, \institute{Metody numeryczne}, \date{18 listopada 2026} typed literally, never \today. Then \input{intro.tex} only. A later card adds ai-work.tex, ai-errors.tex and ai-review.tex (brief 1.7, slide 1)
  - You may read ../Projekt1/slides/preliminary/Makefile and main.tex for structure only. Do not copy any text, comment or formatting from Projekt 1 .tex files, they break current rules (semicolons, plain verbatim, footnotes)
  - intro.tex holds slides 2 to 5 below. Equation slide type. At most three displayed equations, a symbol legend of at most four lines, at most three short bullets, an optional source line in \footnotesize (docs/presentation-style.md 3.1, 3.5)
  - Notation. Matrices and vectors in \mathbf, components x_i, b_i, a_{il}, iteration index j, summation index l. One convention in the whole deck (Projekt_2.pdf p. 1 footnote 1, p. 8 A.2, p. 3 formula (2))
  - Slide text below is the content. Keep its meaning and wording. You may shorten it. Do not add any claim, theorem number, page or number that is not below
  - Layout. Body \normalsize. Legend and source line may be \footnotesize. A two-column layout (columns) is allowed. If slide 4 or 5 cannot fit without \scriptsize, move its three convergence bullets to a new slide right after it, titled "Metoda Jacobiego zbiega, gdy promień spektralny macierzy iteracji jest mniejszy od 1" or "Dla macierzy SPD metoda Gaussa-Seidla zbiega w arytmetyce dokładnej", and report it

Slide 2
  Title: Układ Ax = b z modelu ciepła ma rzadką macierz SPD, a jego rozwiązanie oceniamy względnym residuum
  (in the title write the math as $\mathbf{A}\mathbf{x} = \mathbf{b}$)
  Equation (1), tagged (1):
    \mathbf{A}\mathbf{x} = \mathbf{b}, \qquad \mathbf{A} \in \mathbb{R}^{N \times N}, \quad \mathbf{x}, \mathbf{b} \in \mathbb{R}^{N}
  Equation (2), tagged (2):
    \mathbf{r}^{(j)} = \mathbf{b} - \mathbf{A}\mathbf{x}^{(j)}, \qquad \eta_j = \frac{\|\mathbf{r}^{(j)}\|_2}{\|\mathbf{b}\|_2}, \qquad \eta_j \le \varepsilon, \quad \varepsilon = 10^{-8} \ \text{(wartość zalecana)}
  Legend:
    $\mathbf{A}$ - znana rzadka macierz układu, $\mathbf{b}$ - znany wektor prawej strony
    $\mathbf{x}$ - szukany wektor, $N$ - liczba niewiadomych, nie liczba trójkątów siatki
    $\mathbf{r}^{(j)}$, $\eta_j$ - residuum i jego względna norma dla przybliżenia $\mathbf{x}^{(j)}$
    $j$ - numer iteracji (k u Saada to j u nas)
  Bullet:
    Dla modelu przewodzenia ciepła $\mathbf{A}$ jest rzadka, symetryczna i dodatnio określona (SPD) po eliminacji zadanych temperatur.
  Source line: Źródło: Projekt_2.pdf, wzory (1) i (2), s. 1 i 3, dodatek A.2.

Slide 3
  Title: Rozkład LU rozwiązuje układ dwoma szybkimi podstawieniami po jednej faktoryzacji
  Equations:
    \mathbf{A} = \mathbf{L}\mathbf{U}
    \mathbf{L}\mathbf{y} = \mathbf{b} \quad \text{(podstawienie w przód)}
    \mathbf{U}\mathbf{x} = \mathbf{y} \quad \text{(podstawienie wstecz)}
  Legend:
    $\mathbf{L}$ - macierz dolna trójkątna z jedynkami na przekątnej
    $\mathbf{U}$ - macierz górna trójkątna, $\mathbf{y}$ - wektor pomocniczy
    $\mathbf{P}$ - macierz permutacji wierszy
  Bullets:
    Z wyborem elementu głównego rozkład $\mathbf{P}\mathbf{A} = \mathbf{L}\mathbf{U}$ istnieje dla każdej macierzy nieosobliwej. Bez wyboru istnieje wtedy i tylko wtedy, gdy wszystkie minory główne wiodące są niezerowe.
    Dla macierzy gęstej faktoryzacja kosztuje około $\frac{2}{3}N^3$ operacji, a para podstawień $O(N^2)$. Jedna faktoryzacja obsługuje więc wiele prawych stron.
    W macierzy rzadkiej eliminacja tworzy niezerowe elementy w miejscu zer (fill-in). Przestawienie wierszy i kolumn go zmniejsza.
  Source line: Źródło: Vandenberghe, EE133A, wykład 7. Saad, p. 3.6 i przykład 3.3.

Slide 4
  Title: Metoda Jacobiego liczy nowe przybliżenie wyłącznie z wartości poprzedniej iteracji
  Equations:
    \mathbf{A} = \mathbf{D} - \mathbf{E} - \mathbf{F}
    x_i^{(j+1)} = \frac{1}{a_{ii}} \Bigl( b_i - \sum_{l \ne i} a_{il} \, x_l^{(j)} \Bigr), \qquad i = 1, \dots, N
    \mathbf{x}^{(j+1)} = \mathbf{D}^{-1} (\mathbf{E} + \mathbf{F}) \, \mathbf{x}^{(j)} + \mathbf{D}^{-1} \mathbf{b}, \qquad \mathbf{G}_{JA} = \mathbf{I} - \mathbf{D}^{-1} \mathbf{A}
  Legend:
    $\mathbf{D}$ - przekątna $\mathbf{A}$, zakładamy $a_{ii} \ne 0$
    $-\mathbf{E}$, $-\mathbf{F}$ - ściśle dolna i ściśle górna część $\mathbf{A}$
    $x_i$, $b_i$, $a_{il}$ - składowe $\mathbf{x}$ i $\mathbf{b}$, elementy $\mathbf{A}$, $l$ - wskaźnik sumowania
    $\mathbf{G}_{JA}$ - macierz iteracji, $\mathbf{I}$ - macierz jednostkowa
  Bullets:
    Iteracja zbiega dla każdego $\mathbf{x}^{(0)}$ i $\mathbf{b}$ wtedy i tylko wtedy, gdy promień spektralny $\rho(\mathbf{G}_{JA}) < 1$.
    Wystarcza ścisła dominacja przekątniowa wierszowa $|a_{ii}| > \sum_{l \ne i} |a_{il}|$.
    Sama SPD nie gwarantuje zbieżności. Wystarcza, by $\mathbf{A}$ i $2\mathbf{D} - \mathbf{A}$ były SPD.
  Source line: Źródło: Saad, rozdz. 4, wzory (4.2), (4.4), (4.5), (4.19), tw. 4.1 i 4.9. Fawzi, Cor. 4.13. Projekt_2.pdf, s. 5.

Slide 5
  Title: Metoda Gaussa-Seidla od razu używa świeżo obliczonych składowych
  Equations:
    x_i^{(j+1)} = \frac{1}{a_{ii}} \Bigl( b_i - \sum_{l < i} a_{il} \, x_l^{(j+1)} - \sum_{l > i} a_{il} \, x_l^{(j)} \Bigr)
    (\mathbf{D} - \mathbf{E}) \, \mathbf{x}^{(j+1)} = \mathbf{F} \, \mathbf{x}^{(j)} + \mathbf{b}, \qquad \mathbf{G}_{GS} = \mathbf{I} - (\mathbf{D} - \mathbf{E})^{-1} \mathbf{A}
  Legend:
    $l < i$ - składowe już obliczone w iteracji $j+1$
    $l > i$ - składowe z poprzedniej iteracji $j$
    $\mathbf{D}$, $\mathbf{E}$, $\mathbf{F}$ - jak w metodzie Jacobiego, $\mathbf{G}_{GS}$ - macierz iteracji
  Bullets:
    Nowe składowe nadpisują stare w miejscu, więc metoda potrzebuje mniej pamięci i zwykle zbiega szybciej niż metoda Jacobiego.
    Warunek konieczny i wystarczający to $\rho(\mathbf{G}_{GS}) < 1$, warunek wystarczający to ścisła dominacja przekątniowa, jak u Jacobiego.
    Dla $\mathbf{A}$ SPD metoda zbiega w arytmetyce dokładnej, bo jest metodą SOR z $\omega = 1$, a SOR zbiega dla $0 < \omega < 2$.
  Source line: Źródło: Saad, rozdz. 4, wzory (4.7), (4.8), (4.20), tw. 4.1, 4.9 i 4.10. Fawzi, Cor. 4.13. Projekt_2.pdf, s. 5.

Files to touch: slides/preliminary/main.tex, slides/preliminary/Makefile, slides/preliminary/intro.tex
Files NOT to touch: slides/common/mnstyle.sty, docs/, .claude/, materials/, PROJECT_BRIEF.md, CLAUDE.md, anything under ../Projekt1/
Acceptance checklist:
  - [ ] make in slides/preliminary/ ends with 0 overfull, 0 underfull and 0 LaTeX warnings in main.log
  - [ ] The PDF has the title slide and the four equation slides, each footline reads n/N
  - [ ] Every formula matches this card symbol for symbol, with j as the iteration index
  - [ ] Every title is one sentence of at most two lines, and no slide text breaks the writing rules
  - [ ] No computed result, no code and no claim that is not on this card
Report format: what was done · files changed · what was NOT done and why · open questions
```

</details>

**Rezultat**

- Nowe pliki `slides/preliminary/main.tex`, `Makefile`, `intro.tex` i `main.pdf`, commit `dd70825`.
- Agent dodał w `intro.tex` trzy makra układu (`\src` dla linii źródła, `\tightdisplays` dla odstępów wokół wzorów, `\eqtop` dla pustej linii nad pierwszym wzorem). Slajdy 3 i 4 były najpierw przepełnione (22,9 pt i 8,7 pt). Agent usunął to kolumnami na slajdzie 3 i mniejszymi odstępami wokół wzorów na slajdzie 4, bez `\scriptsize` i bez podziału slajdów.
- Agent zapytał, czy podzielić slajd 4, czy cel `clean` może usuwać `main.pdf` i co zrobić z plikami pomocniczymi LaTeX-a. Rozstrzygnięcia są w rejestrze decyzji, etap 2.

**Ocena względem listy kontrolnej**

- Wszystkie punkty spełnione. Orkiestrator przebudował talię (`make -B`) i powtórzył kontrole 3.8. Log ma 0 wpisów Overfull, Underfull i Warning, `pdffonts` pokazuje `emb yes` w każdym wierszu, `pdfimages -list` jest pusty, 5 stron i stopki od 1/5 do 5/5. Obejrzane wszystkie strony PNG (80 dpi), bez przycięć i nakładania.
- Wzory w `intro.tex` porównane z kartą symbol po symbolu, zgodne.

**Błędy AI**

- Finding: The agent's report stated "There is no .gitignore" and asked whether to ignore the LaTeX auxiliary files, but the repository root `.gitignore` already ignores them.
  Severity: nit
  Requirement: brief 6.2, stage 1, step 1 (the root `.gitignore` ignores the auxiliary files)
  Detected by: the orchestrator ran `git check-ignore -v slides/preliminary/main.aux slides/preliminary/main.log`, which matched `.gitignore:4:*.aux` and `.gitignore:5:*.log`.
  Fix: no file change needed. The wrong statement is corrected here.

**Kandydat na slajd**

- Wybrany prompt (slajd 7). Lista kontrolna karty pozwoliła odebrać pracę poleceniami (`grep` na logu, `pdffonts`, `pdfimages`, porównanie wzorów).

### 2026-11-16 · latex-assistant · AI slides 6 to 11 and provisional grade

- Goal: w `slides/preliminary/` są `ai-work.tex`, `ai-errors.tex`, `ai-review.tex` i `review.tex`, a talia kompiluje się czysto do 11 slajdów z trzema obowiązkowymi grupami.
- Launch: `general-purpose` czytający plik roli `.claude/agents/latex-assistant.md`, sonnet / high.
- Prompt / brief: polecenie uruchomienia i pełna karta zadania poniżej, dosłownie.

<details>
<summary>Polecenie uruchomienia agenta</summary>

```text
Read /home/bob/Metody-numeryczne/Projekt/Projekt2/.claude/agents/latex-assistant.md and follow it as your role definition. Your working directory is /home/bob/Metody-numeryczne/Projekt/Projekt2 and all paths in the card are relative to it. Your task card is the file /home/bob/.claude/jobs/458e5e91/tmp/cards/card-b.md. Read it in full and carry it out. Do not run any git command that changes anything. Finish with the report in the card's format.
```

</details>

<details>
<summary>Pełna karta zadania</summary>

```markdown
## Task card: AI slides 6 to 11 and provisional grade
Role: latex-assistant (read .claude/agents/latex-assistant.md first)
Launch: sonnet / high
Goal: slides/preliminary/ gains ai-work.tex, ai-errors.tex, ai-review.tex and review.tex, and the deck compiles cleanly to 11 slides with the three mandatory slide groups.
Requirements slice (with refs):
  - Three slide groups. Intro (exists), AI errors, AI review (zasady p. 2, section 4, condition 7)
  - main.tex gets \input{ai-work.tex}, \input{ai-errors.tex} and \input{ai-review.tex} after \input{intro.tex}. ai-review.tex inputs review.tex. Change nothing else in main.tex, intro.tex or Makefile
  - Slide types from docs/presentation-style.md 3.5. AI work has at most four bullets. Prompt has a Verbatim excerpt of at most 10 lines plus result and evaluation in two lines. AI error has the fields „Co się stało", „Jak to wykryto", „Jak naprawiono", use a description list with those three labels. AI review has the reviewer definition and a prompt excerpt, or the grade
  - Verbatim blocks use fancyvrb exactly as in your role file, \begin{Verbatim}[commandchars=\\\{\},fontsize=\footnotesize], frames with Verbatim are [fragile], nothing after \end{Verbatim} on its line. Copy the Verbatim lines below character for character, keep their line breaks, add nothing, remove nothing
  - Grade values appear only through the macros in review.tex. The grade slide has no footnote (brief 1.7, slide 12. brief ADR-9)
  - Slide text below is the content. Keep its meaning and wording. You may shorten it. Do not add any claim or number that is not below
  - Body \normalsize, Verbatim \footnotesize. If slide 10 cannot fit without \scriptsize, split it into two slides, the first with the bullets and the title below, the second with the Verbatim block titled "Prompt recenzji wskazuje trzy źródła kryteriów i kończy się oceną słowną i liczbową", and report it

Slide 6 (ai-work.tex)
  Title: Prezentację przygotował orkiestrator z dwoma agentami, a autor zatwierdza ją w jednym punkcie
  Bullets:
    Narzędzie to Claude Code. Sesja główna jest orkiestratorem, deleguje pracę kartami zadań i sama uruchamia polecenia sprawdzające.
    Zdefiniowano cztery role (coder, code-reviewer, latex-assistant, presentation-reviewer). Przy tej prezentacji pracowały dwie, latex-assistant i presentation-reviewer.
    Pliki ról powstały w trakcie sesji, więc sesja ich nie wczytała. Każda rola działała jako agent ogólnego przeznaczenia czytający swój plik, a recenzent był tylko do odczytu na mocy instrukcji.
    Źródła prawdy w kolejności ważności to PDF-y prowadzącego, brief, docs/ i instrukcje agentów. Autor zatwierdza całość w jednym punkcie, przed wysłaniem.

Slide 7 (ai-errors.tex, first frame)
  Title: Karta zadania z listą kontrolną pozwala sprawdzić pracę agenta poleceniami, a nie na oko
  Verbatim lines:
## Task card: Deck skeleton and intro slides 1 to 5 [...]
Goal: slides/preliminary/ holds main.tex, Makefile and intro.tex that compile
to a clean five-slide PDF with the title slide and four equation slides.
[...]
Acceptance checklist:
  - [ ] make in slides/preliminary/ ends with 0 overfull, 0 underfull and
        0 LaTeX warnings in main.log [...]
  - [ ] Every formula matches this card symbol for symbol, with j as the
        iteration index [...]
  Two lines under the block:
    Wynik: talia z pięcioma slajdami skompilowana bez ostrzeżeń, wzory zgodne z kartą.
    Ocena: orkiestrator sprawdził każdy punkt listy poleceniem albo porównaniem, bez oceny na oko.

Slide 8 (ai-errors.tex)
  Title: AI przypisało zasadom zaliczenia podział punktów, który istnieje tylko w instrukcji projektu 1
  Co się stało: Podczas pisania briefu plan orkiestratora twierdził, że zasady zaliczenia dzielą 2 pkt za prezentację wstępną na pięć części po 0,4 pkt. Takiego podziału nie ma w zasadach ani w instrukcji projektu 2. Jest tylko w instrukcji projektu 1.
  Jak to wykryto: Agent piszący brief sprawdzał każdy odnośnik poleceniem pdftotext na wskazanej stronie PDF-u i nie znalazł tej tabeli. Orkiestrator potwierdził to wyszukiwaniem w pełnym tekście obu PDF-ów.
  Jak naprawiono: Brief opisuje podział jako założenie przeniesione z projektu 1, z prawdziwym źródłem.

Slide 9 (ai-errors.tex)
  Title: AI kazało pobrać plik do katalogu, którego narzędzie eNauczania nie pozwala wskazać
  Co się stało: Pierwsza wersja briefu kazała pobrać wysłany ZIP z eNauczania do nowego, pustego katalogu. Narzędzie download_file nie ma parametru katalogu docelowego i zawsze zapisuje plik we własnym katalogu serwera.
  Jak to wykryto: Niezależny agent sprawdzający brief (opus, effort high) wczytał schemat narzędzia i zauważył brak tego parametru. Orkiestrator potwierdził katalog w kodzie serwera.
  Jak naprawiono: Brief w wersji 1.1 każe liczyć sumę SHA-256 pliku tam, gdzie zapisało go narzędzie.

Slide 10 (ai-review.tex)
  Title: Recenzent AI ocenia talię według trzech źródeł kryteriów tym samym promptem w każdej iteracji
  Bullets:
    Agent presentation-reviewer (opus, effort high) czyta PDF, źródła .tex, strony PNG i wyniki poleceń sprawdzających. Jest tylko do odczytu na mocy instrukcji.
    Kryteria pochodzą z zasad zaliczenia, instrukcji projektu 2 i przewodnika stylu prezentacji.
    Rdzeń promptu poniżej jest ten sam w każdej iteracji. Zmienia się tylko akapit ze ścieżkami plików i numerem iteracji.
  Verbatim lines:
[...]
Review slides/preliminary/main.pdf and its .tex sources against three sources
of criteria. (1) materials/zasady_zaliczenia_projektu_v1.pdf, the mandatory
conditions and slide groups. (2) materials/Projekt_2.pdf, section 4 on page 3,
the content of the preliminary deck. (3) docs/presentation-style.md,
assertion-evidence titles, text budget, palette, banned elements. Report
findings with severity and a suggested fix. End with a verbal grade and a
score 1-10.
[...]

Slide 11 (ai-review.tex)
  Title: Recenzent AI ocenił prezentację wstępną na \resReviewScore{} / 10
  Body: the verbal grade in Polish quotation marks, „\resReviewVerbal”, as a plain paragraph
  Below it, one line in mnMuted \footnotesize: Przebieg iteracji: \resReviewHistory

review.tex (provisional, exactly these three macros and nothing else)
  \newcommand{\resReviewScore}{0}
  \newcommand{\resReviewVerbal}{brak oceny, trwa pierwsza iteracja}
  \newcommand{\resReviewHistory}{brak}

Files to touch: slides/preliminary/main.tex (three \input lines only), slides/preliminary/ai-work.tex, slides/preliminary/ai-errors.tex, slides/preliminary/ai-review.tex, slides/preliminary/review.tex
Files NOT to touch: slides/preliminary/intro.tex, slides/preliminary/Makefile, slides/common/mnstyle.sty, docs/, .claude/, materials/, PROJECT_BRIEF.md, CLAUDE.md, anything under ../Projekt1/
Acceptance checklist:
  - [ ] make in slides/preliminary/ ends with 0 overfull, 0 underfull and 0 LaTeX warnings in main.log
  - [ ] The PDF has 11 slides (12 if slide 10 was split), each footline reads n/N
  - [ ] Both Verbatim blocks match this card line for line
  - [ ] Every title is one sentence of at most two lines, and no slide text breaks the writing rules
  - [ ] No grade value is typed outside review.tex
Report format: what was done · files changed · what was NOT done and why · open questions
```

</details>

**Rezultat**

- Nowe pliki `ai-work.tex`, `ai-errors.tex`, `ai-review.tex` i `review.tex` (oceny tymczasowe), trzy linie `\input` w `main.tex`, commit `df29a84`.
- Slajd 10 zmieścił się bez `\scriptsize`, więc nie został podzielony. Agent zgłosił, że linia przebiegu iteracji na slajdzie 11 stoi w połowie strony, bo `\vfill` nie działa w ramce wyrównanej do góry.

**Ocena względem listy kontrolnej**

- Wszystkie punkty spełnione. Orkiestrator przebudował talię (`make -B`) i powtórzył kontrole 3.8. Log ma 0 wpisów Overfull, Underfull i Warning, wszystkie fonty osadzone, brak obrazów rastrowych, 11 stron i stopki od 1 / 11 do 11 / 11. Obejrzane wszystkie strony PNG.
- Cytat na slajdzie 7 sprawdzony skryptem. Po normalizacji białych znaków każdy fragment między znacznikami [...] występuje w kolejności w karcie A zapisanej w tym dzienniku.
- Agent nie obejrzał strony 9 i nie sprawdził cytatu. Zrobił to orkiestrator.

**Błędy AI**

- Brak.

**Kandydat na slajd**

- -
