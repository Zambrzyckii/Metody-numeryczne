# Dziennik pracy z AI, Projekt 2 (układy równań liniowych)

Status: etap 1 (szkielet) zakończony. Ostatni zweryfikowany krok to szkielet projektu. Następny jest etap 2, talia wstępna, karta A.

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
- Status: zaakceptowano, kryteria wyjścia etapu 1 spełnione.

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
