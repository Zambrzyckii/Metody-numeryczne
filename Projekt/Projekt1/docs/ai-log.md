# Dziennik pracy z AI — Projekt 1 (MACD)

Dziennik zawiera dwie warstwy:

1. **Rejestr decyzji** — polecenia, decyzje i wyniki kolejnych etapów pracy z orkiestratorem (główna sesja Claude Code).
2. **Zadania agentów** — wpisy według szablonu z `PROJECT_BRIEF.md` §2.6 dla każdego zadania delegowanego subagentowi.

Narzędzie: Claude Code. Repozytorium: `~/Metody-Numeryczne`.

---

## Rejestr decyzji

### Etap 1 · Plik wsadowy: cele i agenci (2026-10-20)

**Polecenia**

- Utworzyć plik wsadowy `PROJECT_BRIEF.md`, przekazywany nowej sesji jako punkt startowy projektu.
- Zakres pliku:
  - role, uprawnienia i szablony agentów,
  - sposób pisania kodu,
  - sposób dokumentowania i odnotowywania zmian,
  - styl prezentacji.
- Budować plik partiami: najpierw cele, potem agenci.
- Instrukcje dla agentów pisać po angielsku. Treści dla ludzi i slajdy pisać po polsku.

**Decyzje**

- Brief jest jednorazowym dokumentem genezy. Na jego podstawie powstają `CLAUDE.md`, `docs/` i `.claude/agents/`, a kolejne sesje nie ładują go w całości.
- Hierarchia źródeł prawdy: PDF-y prowadzącego, następnie brief, następnie `docs/`, na końcu instrukcje agentów.
- Cele wyprowadzono z tabel punktacji (`Projekt_1.pdf` s. 9). Każdy cel ma kryteria akceptacji i referencję do strony.
- Pakowanie ZIP odbywa się według białej listy. `readme.md` i `zrodla.md` są obowiązkowe.
- Cztery role agentów:
  - `coder`,
  - `code-reviewer`,
  - `latex-assistant`,
  - `presentation-reviewer`.
- Recenzenci mają wyłącznie narzędzia odczytu (`Read`, `Glob`, `Grep`).
- Ograniczenia ścieżek dla agentów opisano jako umowne, nie wymuszone przez narzędzie.
- Wspólne szablony: karta zadania, znalezisko recenzenta, wpis dziennika.
- Specjalizacja agentów odbywa się przez uprawnienia i karty zadań, a nie przez liczbę agentów.
- Orkiestratorem jest główna sesja. Nie tworzy się osobnego agenta-orkiestratora.

**Wynik**

- `PROJECT_BRIEF.md` v0.1: sekcje 0–2 oraz załączniki A (dziennik decyzji) i B (historia zmian). Sekcje 3–6 pozostały jako zaślepki.
- Wykonanie zaakceptowano.

### Etap 2 · Środowisko i struktura katalogu projektu (2026-10-20)

**Polecenia**

- Przygotować środowisko kompilacji LaTeX.
- Przenieść materiały prowadzącego do katalogu projektu.

**Decyzje**

- Materiały prowadzącego znajdują się w `Projekt1/materials/`.
- `Projekt1/materials/` jest wykluczony z repozytorium i z archiwów ZIP.

**Wynik**

- TeX Live zainstalowany. Dostępne: `pdflatex`, `xelatex`, `lualatex`, `latexmk`, Beamer.
- `PROJECT_BRIEF.md` v0.2: ścieżki zaktualizowane do `materials/`.

### Etap 3 · Repozytorium i zasady pracy z gitem (2026-10-20)

**Polecenia**

- Zainicjować repozytorium w `~/Metody-Numeryczne`, wspólne dla całego przedmiotu.
- Commity wykonuje Claude zgodnie z `~/.claude/rules/git.md`.
- Prowadzić dziennik pracy z AI od etapu tworzenia briefu, w repozytorium, w dwóch warstwach: rejestr decyzji oraz zadania agentów.

**Wynik**

- Repozytorium zainicjowane.
- `.gitignore` wyklucza katalogi `materials/`.
- Commit `1348f8f`: `PROJECT_BRIEF.md` v0.2.
- Brief zaktualizowano: commity wykonuje wyłącznie orkiestrator, bez oznaczeń AI. Subagenci nie commitują.

### Etap 4 · Plik wsadowy: styl prezentacji (2026-10-20)

**Polecenia**

- Opracować sekcję 3 briefu: kolory, ikony, animacje i układ slajdów, tak aby ograniczyć AI slop.

**Decyzje**

- Motyw własny i minimalny, oparty na domyślnym Beamerze, ze wspólnym plikiem stylu `slides/common/mnstyle.sty`.
- Paleta pochodzi z materiałów prowadzącego. Kolory zmierzono z wyrenderowanych stron:
  - `#173D56` — nagłówki w `Projekt_1.pdf`,
  - `#00856A` i `#C13F4B` — świece w `charts_pro1.pdf`.
- Tekst wolno pisać tylko kolorami o kontraście co najmniej 4,5:1 (WCAG).
- Kolor linii SIGNAL zmieniono z `#D9822B` (kontrast 2,9:1) na `#C26A1A` (3,9:1), aby spełnić próg 3:1 dla elementów graficznych.
- Kolor ceny w tle (`#9AA5B1`) jest świadomym wyjątkiem od progu kontrastu, wynikającym z wymogu jasnej linii ceny na wykresie B1.
- Typografia:
  - TeX Gyre Heros dla tekstu,
  - Latin Modern dla matematyki,
  - kompilacja `pdflatex`,
  - najmniejszy dozwolony rozmiar to `\footnotesize`.
- Tytuły slajdów merytorycznych mają formę tezy (assertion–evidence). Dozwolony jest zamknięty katalog typów slajdów.
- Wykresy generowane są jako wektorowy PDF w docelowym rozmiarze i wstawiane bez skalowania.
- Font wykresów jest ładowany z TeX Live, a gdy pliku brak, używany jest font domyślny. Generowanie nie może się wtedy przerwać, bo kod może być uruchamiany na systemie Windows.
- Zakazano ikon, emoji, grafik dekoracyjnych, animacji i nakładek (overlays), gradientów, cieni, wykresów 3D i kołowych, słownictwa marketingowego oraz liczb spoza `results/`.
- Archiwum ZIP prezentacji obejmuje `slides/common/`.

**Weryfikacja**

- Testowa kompilacja specyfikacji zakończyła się bez błędów i bez ostrzeżeń overfull.
- `pdffonts`: wszystkie fonty osadzone.

**Wynik**

- `PROJECT_BRIEF.md` v0.3, commit `737cdca`.
- Wykonanie zaakceptowano.

### Etap 5 · Plik wsadowy: konwencje kodu (2026-10-20)

**Polecenia**

- Kontynuować planowanie od kolejnej sekcji briefu.
- Wyniki i decyzje każdej sekcji zapisywać w briefie zgodnie z przyjętą konwencją: treść sekcji, załącznik A i historia zmian.

**Decyzje**

- Priorytet mają elementy wymagane na P2. Prezentacja końcowa obowiązuje na P3.
- Zależności:
  - tylko `numpy`, `pandas` i `matplotlib`, z wersjami minimalnymi zamiast przypiętych,
  - kod zgodny z Pythonem 3.10 lub nowszym,
  - bez instalowania nowych narzędzi.
- Płaska struktura `src/`: osobne moduły dla danych, wskaźnika, symulacji, statystyk, eksportu, stylu i wykresów. Dwa punkty wejścia: `basic.py` i `experiment.py`.
- EMA implementowana jako jawna rekurencja według wzoru (1). Funkcja `pandas ewm(adjust=False)` służy wyłącznie jako niezależna referencja w `verify_ema.py`, z tolerancją 1e-9 (ADR-6).
- Rdzeń obliczeniowy działa na tablicach `numpy` indeksowanych tak jak w instrukcji (ADR-7).
- Niezmienniki symulacji są sprawdzane w trakcie działania programu (`if … raise`, nie `assert`).
- Liczby trafiają na slajdy wyłącznie przez makra `\res…` generowane do `results/*.tex`, z polskim przecinkiem dziesiętnym.
- Wygenerowane wykresy i wyniki są commitowane do repozytorium.
- Dane części eksperymentalnej są wczytywane z katalogu wskazanego zmienną środowiskową `MN_DATA_DIR`.
- `Makefile` slajdów wywołuje `pdflatex` dwukrotnie, bez `latexmk`, ze względu na środowisko MiKTeX + MSYS2 zalecane przez prowadzącego (ADR-8).
- Archiwum ZIP prezentacji obejmuje `charts/` i `results/*.tex`, aby kompilacja nie zależała od uruchomienia kodu.

**Wynik**

- `PROJECT_BRIEF.md` v0.4, commit `8415847`.
- Wykonanie zaakceptowano.

### Etap 6 · Decyzje projektowe i protokół dokumentacji (2026-10-20)

**Polecenia**

- Instrument części podstawowej: PKO BP (stooq.pl, notowania dzienne, PLN).
- Opóźnienie wykonania transakcji: d = 1.
- Autor prezentacji: Bartosz Zambrzycki.
- Termin P2: 2026-10-21, 11:00–13:00. Archiwum ZIP wysłać do 10:00.
- Opracować sekcję 5 briefu: protokół dokumentacji i dziennika.

**Decyzje**

- Każdy dokument ma właściciela, ustalony język oraz określony status względem archiwów ZIP. `readme.md` i `zrodla.md` są po polsku i trafiają do archiwum kodu.
- Zmiany przechodzą w jednym kierunku: PDF-y prowadzącego, potem brief, potem `docs/`, na końcu instrukcje agentów. Dokumentów w `docs/` nie edytuje się z pominięciem briefu.
- Dziennik, warstwa 1: jeden wpis na etap. Odrzucenia pozostają w historii wraz z powodem.
- Dziennik, warstwa 2: jeden wpis na delegację. Wpis zawiera:
  - pełną kartę zadania,
  - ocenę względem kryteriów akceptacji,
  - rozstrzygnięcie każdego znaleziska recenzenta,
  - ocenę recenzenta prezentacji z każdej iteracji.
- Błędy AI dokumentuje się wyłącznie rzeczywiste, z obowiązkowym polem „sposób wykrycia”. Błędów nie wywołuje się ani nie inscenizuje na potrzeby slajdów.
- Commity:
  - jeden zweryfikowany krok to jeden commit,
  - wygenerowane wykresy i wyniki trafiają do tego samego commita co kod, który je wytworzył,
  - wpis dziennika trafia do osobnego, następnego commita.
- Plik `zrodla.md` powstaje przy pierwszym użyciu materiału zewnętrznego. Jeśli takich materiałów nie było, plik zawiera stosowną informację.
- Przed każdym spakowaniem archiwum ZIP wykonuje się wszystkie polecenia z `readme.md`.

**Wynik**

- `PROJECT_BRIEF.md` v0.5, commit `07f54bd`.
- Wykonanie zaakceptowano.

### Etap 7 · Plik wsadowy: etapy i punkty kontrolne (2026-10-20)

**Polecenia**

- Opracować sekcję 6 briefu: etapy realizacji i punkty kontrolne.
- Zachować profesjonalny charakter dokumentacji.

**Decyzje**

- Siedem etapów:
  1. szkielet projektu,
  2. dane wejściowe,
  3. obliczenia części podstawowej,
  4. prezentacja wstępna i archiwum na P2,
  5. wykresy A1–E2,
  6. część eksperymentalna,
  7. prezentacja końcowa i archiwa na P3.
- Obliczenia części podstawowej poprzedzają prezentację wstępną. Slajdy o współpracy z AI opierają się dzięki temu na rzeczywistej pracy agentów, a nie na przykładach hipotetycznych.
- Archiwum na P2 ma pierwszeństwo przed pozostałymi etapami. Etap zagrażający terminowi (2026-10-21, 10:00) jest wstrzymywany.
- Pięć punktów kontrolnych użytkownika:
  - weryfikacja danych z niezależnym źródłem,
  - zrozumienie kodu obliczeniowego,
  - akceptacja tez slajdów i kontrola PDF w trybie pełnoekranowym,
  - wybór kierunku eksperymentu,
  - interpretacje wyników.
- Interpretacje wyników nie są delegowane agentom.
- Każde archiwum ZIP jest budowane z białej listy i testowane przez rozpakowanie w pustym katalogu oraz ponowną kompilację lub uruchomienie.

**Wynik**

- `PROJECT_BRIEF.md` v1.0 — brief kompletny. Commit `18ce765`.
- Brief zaakceptowano.

### Etap 8 · Realizacja: etap 1 — szkielet projektu (2026-10-20)

**Polecenia**

- Wykonać etap 1 według sekcji 6.2 briefu.

**Decyzje**

- `docs/presentation-style.md` i cztery definicje agentów w `.claude/agents/` wyodrębniono z briefu skryptem, bez ręcznego przepisywania. Wyklucza to rozbieżność kopii z oryginałem.
- `docs/requirements-code.md` składa się z dwóch części:
  - wyciągu z instrukcji: wzory (1)–(7), algorytm symulacji, podsumowanie liczbowe,
  - konwencji kodu z sekcji 4 briefu.
- `docs/requirements-charts.md` zawiera wymagania dla wykresów A1–E2, slajdu F i wykresów eksperymentu. Styl wykresów pozostaje wyłącznie w `docs/presentation-style.md`.
- `docs/requirements-presentation.md` opisuje warunki obowiązkowe, punktację obu prezentacji, raport o błędach AI, recenzję AI oraz terminy.
- `CLAUDE.md` zawiera wyłącznie protokół orkiestracji, zasady nienegocjowalne i kluczowe parametry projektu, a do pozostałych informacji odsyła do `docs/` i briefu.
- `.gitignore` rozszerzono o `__pycache__/`, `.venv/` i pliki pomocnicze LaTeX.

**Weryfikacja**

- Definicje agentów i `docs/presentation-style.md` są identyczne z odpowiednimi fragmentami briefu (porównanie automatyczne).

**Ustalenia**

- Agenci zdefiniowani w `Projekt1/.claude/agents/` są wczytywani wyłącznie w sesji Claude Code uruchomionej w katalogu projektu. W sesji uruchomionej w innym katalogu nie są dostępni.

**Wynik**

- Commit `8f1aa28`.
- Wykonanie zaakceptowano.

### Etap 9 · Realizacja: etap 2 — dane wejściowe (2026-10-20)

**Polecenia**

- Wykonać etap 2 w bieżącej sesji.

**Źródło danych**

- Notowania dzienne PKO BP ze stooq.pl, pełna historia od 2004-11-10.
- Plik pobrano ręcznie przez przeglądarkę, ponieważ serwis blokuje pobieranie automatyczne (weryfikacja JavaScript).
- Plik źródłowy: `pko_d.csv`, 5492 sesje, SHA-256 `222e072b684752f52fc75b2350ad215a38ff4f4ad478ec0e77ef52ba440f15e7`.

**Decyzje**

- Okno danych obejmuje 1001 ostatnich sesji (L = 1001, indeksy 0…1000), zgodnie z przykładem w instrukcji: 2022-10-19 … 2026-10-20.
- Nagłówki ujednolicono do `date, open, high, low, close, volume`, w formacie zbioru `dane_pro1`.
- Wiersze danych są identyczne treściowo ze źródłem. Zmieniono jedynie znak końca wiersza (CRLF na LF).
- Ceny stooq są skorygowane wstecznie. Ostatnia korekta przypada na 2026-08-04 i obejmuje 945 z 1001 sesji okna. Dane pozostawiono bez zmian. Korekta zostanie opisana w `readme.md` (`Projekt_1.pdf` s. 4).

**Weryfikacja**

- 1001 wierszy.
- Daty ściśle rosnące, bez duplikatów.
- Brak braków danych.
- Ceny dodatnie, spójność OHLC zachowana.
- Najdłuższa przerwa między sesjami wynosi 6 dni kalendarzowych.

**Błędy AI**

- **Znalezisko:** Pierwsza wersja skryptu przygotowującego dane zapisywała plik przez pandas, co zmieniało zapis liczb (np. `117` → `117.0`). Plik przestawał być wierną kopią źródła.
  - Waga: minor.
  - Wymaganie: identyfikowalność danych wejściowych (`Projekt_1.pdf` s. 4).
  - Sposób wykrycia: porównanie wierszy pliku wynikowego z plikiem źródłowym przed commitem.
  - Poprawka: zapis surowych wierszy źródła z podmienionym nagłówkiem.
- **Znalezisko:** Kontrola danych zakładała całkowite wartości wolumenu, co jest nieprawdziwe dla danych skorygowanych wstecznie. Poprawne dane zostałyby odrzucone.
  - Waga: minor.
  - Wymaganie: kryteria danych z `Projekt_1.pdf` s. 4, które nie obejmują wolumenu.
  - Sposób wykrycia: niepowodzenie walidacji i analiza wierszy wokół daty 2026-08-04.
  - Poprawka: kontrolę zmieniono na informacyjną, a wartości pozostawiono bez zmian.

**Wynik**

- `data/pko.csv`, commit `7d8b207`.

**Punkt kontrolny CP1**

- Dane zgodne z niezależnym źródłem.
- Decyzja: w obliczeniach stosuje się ceny skorygowane wstecznie przez stooq. Korekta zostanie opisana w `readme.md`.
- Decyzję zapisano w briefie (v1.1, sekcja 1.7) i w `docs/requirements-code.md`, commit `ffe8e51`.
- Wykonanie zaakceptowano.

### Etap 10 · Realizacja: etap 3 — obliczenia części podstawowej (2026-10-20)

**Polecenia**

- Zweryfikować dostępność agentów `coder` i `code-reviewer`, następnie wykonać etap 3 według sekcji 6.2 briefu, zaczynając od planu kart zadań.

**Decyzje**

- Etap podzielono na cztery karty zadań według grupowania artefaktów z briefu §6.2: (1) `config.py` + `data.py`, (2) `macd.py` + `verify_ema.py`, (3) `simulation.py` + `stats.py` + `export.py`, (4) `basic.py` + `results/basic.*`. Karty realizowano sekwencyjnie, każda w cyklu coder, weryfikacja orkiestratora, code-reviewer, rozstrzygnięcie znalezisk, commit.
- Moduły `src/` importują się płasko (`import config`), a skrypty uruchamia się wyłącznie jako `python src/<skrypt>.py`. Forma uruchamiania ma zostać zapisana w `readme.md` w etapie 5.
- Obowiązuje limit 79 znaków PEP 8 (`Projekt_1.pdf` s. 9, odnośnik [9]).
- Slajd F zasila dwanaście makr `\res…` (od `InitialCapital` do `OpenValue`). Liczniki całkowite zapisywane są bez części dziesiętnej, pozycje bez wartości jako „nie dotyczy" (`Projekt_1.pdf` s. 7, 4.4).
- `basic.py` przerywa działanie, gdy dane nie dają żadnej zamkniętej transakcji (`Projekt_1.pdf` s. 5, 3.4).
- Wybór makr należy do punktu wejścia. `export.py` dostarcza wyłącznie mechanizm formatowania i zapisu, wspólny dla części podstawowej i eksperymentalnej.
- Makra części eksperymentalnej otrzymają prefiks `Exp…` (rozstrzygnięcie znaleziska, do karty etapu 6).

**Weryfikacja**

- Niezależna implementacja referencyjna orkiestratora (EMA przez `pandas ewm`, dosłowna transkrypcja algorytmu z `Projekt_1.pdf` s. 5, bez użycia modułów `src/`): sygnały, wektory C, Q, V i lista egzekucji zgodne co do bitu z modułami na `data/pko.csv`.
- `python src/verify_ema.py`: maksymalna różnica 0.0 dla N = 12, 26, 9.
- `python src/basic.py`: bez błędów i ostrzeżeń (`-W error::UserWarning`), dwa przebiegi dają pliki identyczne co do bajtu (sha256).
- Wyniki części podstawowej: C₁₀₀ = 23547,90 PLN, V₁₀₀₀ = 44415,21 PLN, R = 88,62 %, 34 zamknięte transakcje (19 zyskownych, 15 stratnych), skuteczność 55,88 %, największy zysk 26,13 %, największa strata 8,64 %, bez pozycji otwartej na końcu. Kryterium „co najmniej jedna zamknięta transakcja" spełnione (`Projekt_1.pdf` s. 5).

**Ustalenia**

- Literalna reguła sygnałów z `Projekt_1.pdf` s. 2 dopuszcza sygnał także wtedy, gdy histogram dotyka zera i wraca na tę samą stronę (H₍ᵢ₋₁₎ = 0 spełnia warunek nieostrej nierówności). Kod odwzorowuje regułę dosłownie. Na danych PKO przypadek nie wystąpił.
- Rozbieżności dokumentacji z kodem, do rozstrzygnięcia przez brief: `docs/requirements-code.md` B.2 opisuje `basic.py` generujący wykresy A1–E2, co jest stanem docelowym po etapie 5, oraz B.5 wymienia przykład `\resOpenPosition` wobec faktycznych `\resOpenQty` i `\resOpenValue`.

**Błędy AI**

- Czternaście znalezisk recenzenta (dwa minor, dwanaście nit, bez blockerów i majorów) udokumentowano wraz z rozstrzygnięciami w warstwie „Zadania agentów" (cztery wpisy z 2026-10-20).

**Punkt kontrolny CP2**

- Oczekuje: omówienie `ema`, detekcji sygnałów i pętli symulacji linia po linii (`zasady_zaliczenia_projektu_v1.pdf` s. 2).

**Wynik**

- Artefakty: `src/config.py`, `src/data.py`, `src/macd.py`, `src/verify_ema.py`, `src/simulation.py`, `src/stats.py`, `src/export.py`, `src/basic.py`, `requirements.txt`, `results/basic.json`, `results/basic.tex`.
- Commity kroków: `df4292d`, `2f3b5fe`, `4acc666`, `8ba19f2`.
- Status: wstrzymano na punkcie kontrolnym CP2 (zrozumienie kodu obliczeniowego).

---

## Zadania agentów

### 2026-10-20 · coder · Project constants and data loading

**Karta zadania**

<details>
<summary>Pełna karta zadania</summary>

```markdown
## Task card: Project constants and data loading
Goal: `src/config.py` and `src/data.py` exist, giving later modules the project
constants and a validated load of `data/pko.csv` into numpy arrays.

Requirements slice (with refs):
  - Constants `MACD_PARAMS = (12, 26, 9)`, `START_INDEX = 100`, `DELAY = 1`,
    project paths, experiment data dir from env `MN_DATA_DIR` with default
    `materials/dane_pro1/` — docs/requirements-code.md B.2, B.6; brief 1.7
  - Data rules: 1000–1200 rows, dates strictly increasing, no duplicate dates,
    no missing or non-positive closes, gaps between sessions never filled —
    docs/requirements-code.md A.1, B.3; Projekt_1.pdf p. 4
  - pandas only reads the CSV; callers get numpy arrays (float64 prices,
    datetime64 dates), indexed i = 0…L−1 — docs/requirements-code.md B.3
  - Validation failures raise ValueError naming the broken rule —
    docs/requirements-code.md B.3
  - Code never writes into data directories — docs/requirements-code.md B.6
  - Python 3.10+ syntax; only numpy and pandas imported here —
    docs/requirements-code.md B.1
  - PEP 8, English identifiers, type hints, one-line docstrings citing the
    requirement; no classes except dataclass records; no printing —
    docs/requirements-code.md B.4
  - `requirements.txt` with numpy>=1.24, pandas>=2.0, matplotlib>=3.7 —
    docs/requirements-code.md B.1

Files to touch: src/config.py, src/data.py, requirements.txt
Files NOT to touch: data/pko.csv, docs/**, materials/**, CLAUDE.md, PROJECT_BRIEF.md

Acceptance checklist:
  - [ ] config.py defines MACD_PARAMS = (12, 26, 9), START_INDEX = 100, DELAY = 1,
        paths for data/pko.csv, results/ and charts/, and MN_DATA_DIR resolution
  - [ ] data.py exposes one public loader returning a dataclass of parallel numpy
        arrays: dates (datetime64), open, high, low, close, volume (float64), length L
  - [ ] Loading data/pko.csv succeeds with L = 1001
  - [ ] Each validation rule rejects a broken input: row count outside 1000–1200,
        non-increasing or duplicate dates, missing close, close ≤ 0
  - [ ] ValueError messages name the broken rule
  - [ ] No writes into data directories, no printing, no matplotlib import
  - [ ] Rejection cases are checked with throwaway inputs outside the repo;
        no test files are committed

Report format: what was done · files changed · what was NOT done and why · open questions
```

</details>

**Rezultat**

- Nowe pliki `src/config.py`, `src/data.py` i `requirements.txt`, commit `df4292d`.
- `load_prices` zwraca zamrożony `dataclass` `PriceSeries` z równoległymi tablicami numpy. Daty mają typ `datetime64[D]`, ceny i wolumen `float64`, L = 1001.
- Po recenzji wykonano dwie rundy poprawek, opisane w znaleziskach poniżej.

**Ocena względem listy kontrolnej akceptacji**

- Wszystkie punkty listy spełnione. Weryfikacja orkiestratora: wczytanie `data/pko.csv` daje L = 1001 bez ostrzeżeń (`python -W error::UserWarning`), jedenaście zepsutych wariantów danych odrzucono z komunikatem wskazującym złamaną regułę i stronę instrukcji, puste oraz ustawione `MN_DATA_DIR` rozwiązywane są poprawnie, kontrola `awk 'length > 79'` nie zwraca wyników.

**Znaleziska recenzenta (code-reviewer)**

Iteracja 1, werdykt APPROVE:

- **Znalezisko:** Niesparsowalna data, nienumeryczna cena zamknięcia lub brak wymaganej kolumny kończyły się ogólnym błędem pandas/numpy zamiast `ValueError` wskazującego regułę.
  - Waga: minor.
  - Wymaganie: `docs/requirements-code.md` B.3 (czytelny `ValueError`).
  - Sposób wykrycia: analiza kodu przez recenzenta. Ścieżka nie była pokryta dowodami z uruchomień.
  - Poprawka: kontrola obecności sześciu kolumn oraz opakowanie konwersji daty i ceny zamknięcia w nazwane `ValueError`. Poprawiono w commicie `df4292d`.
- **Znalezisko:** Loader wymaga bezwarunkowo sześciu kolumn, a `docs/requirements-code.md` B.6 gwarantuje dla części podstawowej jedynie `date` i `close`.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.6.
  - Sposób wykrycia: porównanie kodu z B.6.
  - Poprawka: odrzucono zmianę zachowania, ponieważ oba rzeczywiste zbiory danych (`data/pko.csv`, `dane_pro1`) mają komplet sześciu kolumn. Wymóg udokumentowano w docstringu w commicie `df4292d`.
- **Znalezisko:** Puste `MN_DATA_DIR` dawało `Path("")` zamiast ścieżki domyślnej.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.6 (domyślny katalog `materials/dane_pro1/`).
  - Sposób wykrycia: analiza kodu przez recenzenta (`os.environ.get` zwraca pusty łańcuch zamiast wartości domyślnej).
  - Poprawka: zamiana na `os.environ.get("MN_DATA_DIR") or <domyślna>`. Poprawiono w commicie `df4292d`.

Iteracja 2, werdykt APPROVE (potwierdzenie poprawek):

- **Znalezisko:** Pięć linii przekracza limit 79 znaków PEP 8, w tym dwie obecne już w pierwszej iteracji i wtedy przeoczone przez recenzenta.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.1 i B.4 (PEP 8 sprawdzany w recenzji).
  - Sposób wykrycia: pomiar długości linii przez recenzenta w drugiej iteracji.
  - Poprawka: zawinięcie sygnatury, długich `raise` i skrócenie docstringów, bez zmiany zachowania. Poprawiono w commicie `df4292d`.

**Kandydat na slajd**

- Raport o błędach AI (`Projekt_1.pdf` s. 9, tabela punktacji). Znalezisko minor z iteracji 1 wraz z przeoczeniem recenzenta z iteracji 2 pokazują rzeczywisty cykl recenzji.

Status: oczekuje na akceptację.

### 2026-10-20 · coder · MACD indicator and EMA verification

**Karta zadania**

<details>
<summary>Pełna karta zadania</summary>

```markdown
## Task card: MACD indicator and EMA verification
Goal: `src/macd.py` computes EMA, MACD, SIGNAL, histogram and trading signals
from a close-price array, and `src/verify_ema.py` independently confirms the
EMA implementation against pandas.

Requirements slice (with refs):
  - EMA per formula (1): alpha_N = 2/(N+1), E_0 = x_0, explicit recursion —
    docs/requirements-code.md A.2, B.3; Projekt_1.pdf p. 1
  - MACD per formula (2), SIGNAL per formula (3) with S_0 = M_0, histogram per
    formula (4) — docs/requirements-code.md A.2
  - Parameters come from config.MACD_PARAMS = (12, 26, 9); all curves computed
    from sample 0, full history kept — docs/requirements-code.md A.2
  - Signals for i >= 1: buy when H_{i-1} <= 0 and H_i > 0, sell when
    H_{i-1} >= 0 and H_i < 0, H_i = 0 gives no new signal, assigned to the
    first sample after the crossing, no interpolation —
    docs/requirements-code.md A.2; Projekt_1.pdf p. 2
  - Signals are an int8 array: +1 buy, -1 sell, 0 none; element 0 is 0.
    Considering signals only from sample 101 is the simulation's job (card 3),
    detection covers all i >= 1 — docs/requirements-code.md B.3
  - macd.py is pure computation on numpy float64: no file access, no plotting,
    no printing — docs/requirements-code.md B.4
  - verify_ema.py compares ema() with pandas Series.ewm(span=N,
    adjust=False).mean() on the closes of data/pko.csv for N = 12, 26, 9;
    pass when max abs diff <= 1e-9; pandas ewm appears only in this file;
    it prints a short result and exits nonzero on failure —
    docs/requirements-code.md B.3, B.8
  - Naming per the symbol map: ema(values, n), macd, signal, hist —
    docs/requirements-code.md B.4
  - PEP 8 with the 79-character limit, type hints, one-line docstrings citing
    the formula, Python 3.10+ syntax — docs/requirements-code.md B.1, B.4

Files to touch: src/macd.py, src/verify_ema.py
Files NOT to touch: src/config.py, src/data.py, data/pko.csv, requirements.txt,
docs/**, materials/**

Acceptance checklist:
  - [ ] ema(values, n) implements formula (1) as an explicit recursion with E_0 = x_0
  - [ ] macd.py returns macd, signal and hist arrays of length L, computed from sample 0
  - [ ] Signal detection returns int8 (+1/-1/0) per the rules above, signals[0] = 0
  - [ ] python src/verify_ema.py reports max abs diff <= 1e-9 for N = 12, 26, 9
        on data/pko.csv and exits 0; it exits nonzero when the tolerance fails
  - [ ] pandas ewm is absent from macd.py (and every file except verify_ema.py)
  - [ ] macd.py does no I/O and no printing; only verify_ema.py prints
  - [ ] awk 'length > 79' finds nothing in the two files; Python 3.10 compatible

Report format: what was done · files changed · what was NOT done and why · open questions
```

</details>

**Rezultat**

- Nowe pliki `src/macd.py` i `src/verify_ema.py`, commit `2f3b5fe`.
- `ema` jako jawna rekurencja wzoru (1), `compute_macd` liczy M, S i H według wzorów (2)–(4), przy czym S powstaje przez `ema(macd, 9)`, co realizuje wzór (3) wraz z S₀ = M₀. `detect_signals` zwraca tablicę `int8` według reguł zmiany znaku histogramu.
- Przyjęto konwencję płaskich importów między modułami `src/` (`import config`, `import data`), zgodną z `docs/requirements-code.md` B.2. Skrypty uruchamia się jako `python src/<skrypt>.py`.
- Jedna runda poprawek po recenzji, opisana w znaleziskach poniżej.

**Ocena względem listy kontrolnej akceptacji**

- Wszystkie punkty listy spełnione. Weryfikacja orkiestratora: `python3 src/verify_ema.py` daje maksymalną różnicę 0.0 (zgodność bitowa) dla N = 12, 26, 9 i kod wyjścia 0, bez ostrzeżeń pod `-W error::UserWarning`. Ścieżka niepowodzenia weryfikacji przetestowana przez codera (sztuczne przesunięcie wartości o 1e-6 daje FAIL i kod 1). `ewm` występuje wyłącznie w `verify_ema.py`. Kontrola przebiegu na `data/pko.csv`: długości tablic 1001, `signals[0] = 0`, 39 sygnałów kupna i 39 sprzedaży. Przypadek brzegowy H = [-1, 0, 0, 1, -2, 0, 3, 3] daje [0, 0, 0, 1, -1, 0, 1, 0], zgodnie z regułami ze s. 2 instrukcji.

**Znaleziska recenzenta (code-reviewer)**

Iteracja 1, werdykt APPROVE:

- **Znalezisko:** Docstring `compute_macd` cytował „Projekt_1.pdf p. 1", a wzory (2)–(4) znajdują się na s. 2.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.4; `Projekt_1.pdf` s. 2.
  - Sposób wykrycia: porównanie cytatów ze stronami 1–2 PDF przez recenzenta, potwierdzone niezależnie przez orkiestratora w PDF.
  - Poprawka: cytat zmieniono na s. 2. Poprawiono w commicie `2f3b5fe`.
- **Znalezisko:** Docstring `main` w `verify_ema.py` nie cytował wymagania, wbrew konwencji pozostałych funkcji publicznych.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.4.
  - Sposób wykrycia: analiza kodu przez recenzenta.
  - Poprawka: dodano cytat B.8. Poprawiono w commicie `2f3b5fe`.
- **Znalezisko:** Płaski import `import data` może przy odwrotnej kolejności `sys.path` (korzeń projektu przed `src/`) wskazać katalog `data/` jako pakiet przestrzeni nazw zamiast modułu `src/data.py`.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.2.
  - Sposób wykrycia: analiza rozwiązywania importów przez recenzenta.
  - Poprawka: odrzucono zmianę kodu, ponieważ konwencja płaskich importów jest zgodna z B.2, a udokumentowane polecenia `python src/<skrypt>.py` ustawiają `src/` na początku `sys.path`. Wymóg uruchamiania w tej formie zostanie zapisany w `readme.md` w etapie 5, a kontrole orkiestratora używają od teraz tej samej formy.

Iteracja 2 (potwierdzenie poprawek przez orkiestratora): `verify_ema.py` bez zmian wyniku, limit 79 znaków zachowany.

**Kandydat na slajd**

- Weryfikacja obliczeń niezależnym odniesieniem: zgodność bitowa własnej rekurencji EMA z `pandas ewm(adjust=False)` dla trzech okresów (`Projekt_1.pdf` s. 2, wzmianka o `Series.ewm`; s. 9, tabela punktacji).

Status: oczekuje na akceptację.

### 2026-10-20 · coder · Portfolio simulation, statistics and results export

**Karta zadania**

<details>
<summary>Pełna karta zadania</summary>

```markdown
## Task card: Portfolio simulation, statistics and results export
Goal: `src/simulation.py` simulates the portfolio per the five-step algorithm,
`src/stats.py` computes R, r and the seven summary items, and `src/export.py`
writes results JSON and LaTeX macro files.

Requirements slice (with refs):
  - Vectors C (cash), Q (position_qty), V (equity) of length L; formula (5)
    V_i = C_i + Q_i*x_i; initial state at sample 100: C_100 = 1000*x_100,
    Q_100 = 0, V_100 = C_100, no transaction at sample 100; elements 0..99
    unused and set to NaN — docs/requirements-code.md A.3, B.3;
    Projekt_1.pdf p. 4-5
  - Algorithm steps 1-5: signals considered from sample 101; process
    i = 101..L-1; if i - d >= 101 check the signal at sample i - d
    (d = config.DELAY = 1, so the first possible execution is at i = 102);
    buy when signal is buy and C_{i-1} > 0: Q_i = C_{i-1}/x_i, C_i = 0;
    sell when signal is sell and Q_{i-1} > 0: C_i = Q_{i-1}*x_i, Q_i = 0;
    otherwise carry C and Q forward; record signal index, execution index,
    side and execution price; a signal at the last sample is not executed —
    docs/requirements-code.md A.4; Projekt_1.pdf p. 5
  - Full capital commitment, fractional units allowed, no commissions, never
    sell an instrument that is not held — docs/requirements-code.md A.3
  - Each execution is a dataclass record (signal index, execution index, side,
    price); closed trades are buy->sell pairs; an open position at the end is
    reported separately — docs/requirements-code.md B.3, A.5
  - Invariants checked at run time with if ... raise (not assert):
    V_i = C_i + Q_i*x_i, C and Q never negative, never sell without a
    position — docs/requirements-code.md B.3
  - stats: R per formula (6) from C_100 and V_{L-1}; r per formula (7) from
    the buy and sell execution prices; r >= 0 counts as profitable; the seven
    summary items of slide F, with "nie dotyczy" for items that do not apply;
    largest loss reported as a positive percentage; no rounding during
    computation — docs/requirements-code.md A.5, B.3; Projekt_1.pdf p. 5-7
  - export: write_results(part, numbers, macros, results_dir) writes
    results/<part>.json (every number, unrounded) and results/<part>.tex
    (one \res<Name> macro per slide value, macro names letters only);
    formatting helper gives Polish decimal comma and two decimals for money
    and percentages; macros hold numbers without units —
    docs/requirements-code.md B.5
  - simulation.py and stats.py do no file access, plotting or printing;
    export.py is the only module that writes files and creates the target
    directory when missing — docs/requirements-code.md B.4, B.5
  - Flat imports (import config, import macd), scripts run as
    python src/<script>.py; PEP 8 with the 79-char limit, type hints,
    one-line docstrings citing formula or requirement, Python 3.10+ —
    docs/requirements-code.md B.1, B.2, B.4

Files to touch: src/simulation.py, src/stats.py, src/export.py
Files NOT to touch: src/config.py, src/data.py, src/macd.py,
src/verify_ema.py, data/**, docs/**, materials/**, requirements.txt

Acceptance checklist:
  - [ ] Simulation on data/pko.csv with (12, 26, 9), START_INDEX = 100 and
        DELAY = 1 completes with no invariant raised
  - [ ] cash, position_qty, equity have length 1001 and NaN exactly for i < 100
  - [ ] C_100 = 1000 * x_100, Q_100 = 0, V_100 = C_100, no transaction at 100
  - [ ] Every execution index is in [102, L-1] and equals its signal index + 1
  - [ ] A signal at the last sample produces no execution (shown structurally
        or with a constructed input)
  - [ ] Buy with no cash and sell with no position leave C and Q unchanged
  - [ ] Closed trades pair each buy with the next sell; an open position at the
        end is excluded from trade stats
  - [ ] R matches formula (6) and r matches formula (7) on execution prices;
        r = 0 counts as profitable; largest loss returned as a positive number
  - [ ] The seven summary items are produced, with "nie dotyczy" where empty
  - [ ] Export writes <part>.json and <part>.tex; macros are \res + letters
        only; sample value 1234.5 formats as "1234,50"
  - [ ] simulation.py and stats.py have no I/O and no printing; during checks
        export writes only to the scratchpad, never to results/ in the repo
  - [ ] awk 'length > 79' finds nothing in the three files; Python 3.10
        compatible

Report format: what was done · files changed · what was NOT done and why · open questions
```

</details>

**Rezultat**

- Nowe pliki `src/simulation.py`, `src/stats.py` i `src/export.py`, commit `4acc666`.
- `simulate` realizuje pięciokrokowy algorytm z `Projekt_1.pdf` s. 5, z niezmiennikami `if … raise`. Egzekucje są rekordami `dataclass` (indeks sygnału, indeks wykonania, strona, cena). `stats.summarize` zwraca siedem pozycji podsumowania jako dane, `export.write_results` zapisuje `results/<część>.json` i `.tex` z makrami `\res…` (tylko litery, polski przecinek, dwa miejsca).
- Jedna runda poprawek po recenzji, opisana w znaleziskach poniżej.

**Ocena względem listy kontrolnej akceptacji**

- Wszystkie punkty listy spełnione. Weryfikacja orkiestratora przeciwko niezależnej referencji (EMA przez `pandas ewm`, dosłowna transkrypcja algorytmu ze s. 5, bez użycia modułów codera): sygnały, wektory C, Q, V (łącznie z układem NaN) i pełna lista egzekucji identyczne co do bitu na `data/pko.csv`. Wyniki: C₁₀₀ = 23547,90, V₁₀₀₀ = 44415,21, R = 88,62 %, 68 egzekucji, 34 zamknięte transakcje (19 zyskownych, 15 stratnych), brak pozycji otwartej, największy zysk 26,13 %, największa strata 8,64 %. Sygnał w ostatniej próbce nie jest wykonywany, egzekucje wyłącznie w zakresie [102, L−1] z indeksem sygnału + 1. Kryterium etapu „co najmniej jedna zamknięta transakcja" spełnione (`Projekt_1.pdf` s. 5).

**Znaleziska recenzenta (code-reviewer)**

Iteracja 1, werdykt APPROVE:

- **Znalezisko:** Żaden moduł nie generował tekstu „nie dotyczy" dla pustych pozycji podsumowania. `Summary` zwraca `None`, a `format_number` rzuciłby `TypeError`.
  - Waga: minor.
  - Wymaganie: `Projekt_1.pdf` s. 7, 4.4; `docs/requirements-code.md` A.5.
  - Sposób wykrycia: analiza kodu przez recenzenta. Na danych PKO każda pozycja ma wartość, więc dowody z uruchomień nie pokrywały tej ścieżki.
  - Poprawka: dodano `export.format_optional`, zwracający „nie dotyczy" dla `None`. Poprawiono w commicie `4acc666`.
- **Znalezisko:** `closed_trades` parował `(None, sell)` bez błędu, gdy sprzedaż nie miała wcześniejszego kupna, a statystyki zgłosiłyby wtedy `AttributeError` zamiast nazwanego niezmiennika.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.3.
  - Sposób wykrycia: analiza kodu przez recenzenta.
  - Poprawka: `closed_trades` rzuca `ValueError` przy sprzedaży bez oczekującego kupna. Kontrola w `simulate` pozostała bez zmian. Poprawiono w commicie `4acc666`.
- **Znalezisko:** Ilość i wartość pozycji otwartej (pozycja 7 podsumowania) były odłożone do punktu wejścia, choć B.2 przypisuje siedem pozycji podsumowania modułowi `stats.py`.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.2, B.4.
  - Sposób wykrycia: porównanie podziału odpowiedzialności z B.2 przez recenzenta.
  - Poprawka: `Summary` rozszerzono o `open_qty` i `open_value` liczone w `summarize`. Poprawiono w commicie `4acc666`.
- **Znalezisko:** `json.dumps` z domyślnym `allow_nan=True` zapisałby wartości NaN jako niepoprawny JSON, gdyby eksportowano wektory portfela (NaN dla i < 100).
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.5, B.3.
  - Sposób wykrycia: zestawienie kodu eksportu z układem NaN wektorów przez recenzenta.
  - Poprawka: `allow_nan=False`, błąd zgłaszany przed zapisem pliku. Poprawiono w commicie `4acc666`.

Iteracja 2 (potwierdzenie poprawek przez orkiestratora): pełna regresja względem referencji bez zmian wyników, nowe ścieżki („nie dotyczy", odrzucenie NaN, `ValueError` w `closed_trades`, pola pozycji otwartej) sprawdzone na danych skonstruowanych.

**Kandydat na slajd**

- Weryfikacja symulacji niezależną implementacją referencyjną (zgodność bitowa wektorów i listy transakcji) oraz znalezisko minor o „nie dotyczy" wykryte wyłącznie analizą kodu, poza ścieżką danych rzeczywistych (`Projekt_1.pdf` s. 9, tabela punktacji).

Status: oczekuje na akceptację.

### 2026-10-20 · coder · Basic-part entry point and results

**Karta zadania**

<details>
<summary>Pełna karta zadania</summary>

```markdown
## Task card: Basic-part entry point and results
Goal: `src/basic.py` runs the whole basic part end to end (no charts) and
writes `results/basic.json` and `results/basic.tex`.

Requirements slice (with refs):
  - Flow: load data/pko.csv -> compute_macd -> detect_signals -> simulate ->
    summarize -> write_results("basic", ...); parameters only from config —
    docs/requirements-code.md B.2; PROJECT_BRIEF.md 6.2 stage 3 (no charts)
  - At least one closed trade is required; raise ValueError otherwise —
    docs/requirements-code.md A.5; Projekt_1.pdf p. 5
  - Macros in results/basic.tex, exactly these names, via format_number /
    format_optional (counts as plain integers without decimals):
    InitialCapital, FinalEquity, ProfitAmount, ReturnPct, ClosedCount,
    ProfitableCount, LosingCount, WinRatePct, MaxLossPct, MaxGainPct,
    OpenQty, OpenValue — docs/requirements-code.md B.5; Projekt_1.pdf p. 7
  - results/basic.json holds every number unrounded: all Summary numeric
    fields, the closed trades (signal/execution indices, prices, r per
    formula (7)) and the execution count; None becomes null, never NaN —
    docs/requirements-code.md B.5
  - basic.py is the only printing module: a short summary to stdout —
    docs/requirements-code.md B.4
  - main() -> int and sys.exit(main()) like verify_ema.py; flat imports;
    PEP 8 with the 79-char limit, type hints, docstrings citing requirements,
    Python 3.10+ — docs/requirements-code.md B.1, B.2, B.4

Files to touch: src/basic.py (code); results/basic.json and results/basic.tex
are generated by running it and stay in the working tree for the orchestrator
to commit
Files NOT to touch: src/config.py, src/data.py, src/macd.py, src/simulation.py,
src/stats.py, src/verify_ema.py, data/**, docs/**, materials/**,
requirements.txt

Acceptance checklist:
  - [ ] python src/basic.py exits 0 with no warnings (clean under
        -W error::UserWarning) and creates results/basic.json and
        results/basic.tex
  - [ ] Running it twice produces byte-identical files (deterministic)
  - [ ] basic.tex holds exactly the twelve \res macros above, Polish comma,
        two decimals for money and percentages, integer counts bare,
        OpenQty/OpenValue as "nie dotyczy" when no open position
  - [ ] basic.json parses with json.load, holds nulls (never NaN) and the
        closed-trade list with 34 entries on the PKO data
  - [ ] The no-closed-trade guard raises ValueError (checked with a
        constructed signals array in a scratchpad run)
  - [ ] Printed summary is a few lines and contains no number typed by hand
        (every printed value comes from Summary)
  - [ ] python src/verify_ema.py still passes; awk 'length > 79' finds
        nothing in src/basic.py; Python 3.10 compatible

Report format: what was done · files changed · what was NOT done and why · open questions
```

</details>

**Rezultat**

- Nowy plik `src/basic.py` oraz wygenerowane `results/basic.json` i `results/basic.tex`, commit `8ba19f2`.
- `basic.py` spina moduły etapu w całość bez wykresów, zapisuje dwanaście makr `\res…` dla slajdu F i pełny zapis liczbowy w JSON (podsumowanie, 34 zamknięte transakcje z indeksami, cenami i stopą r, licznik egzekucji, pozycja otwarta).
- Jedna runda poprawek po recenzji, opisana w znaleziskach poniżej.

**Ocena względem listy kontrolnej akceptacji**

- Wszystkie punkty listy spełnione. Weryfikacja orkiestratora: dwa przebiegi `python3 -W error::UserWarning src/basic.py` dają pliki identyczne co do bajtu (sha256), wartości JSON równe niezależnej referencji, makra z polskim przecinkiem i licznikami bez części dziesiętnej, `OpenQty`/`OpenValue` jako „nie dotyczy". Strażnik braku zamkniętych transakcji rzuca `ValueError` na danych skonstruowanych. `verify_ema.py` nadal przechodzi z różnicą 0.0.

**Znaleziska recenzenta (code-reviewer)**

Iteracja 1, werdykt APPROVE:

- **Znalezisko:** Przykładowa lista makr w `docs/requirements-code.md` B.5 wymienia `\resOpenPosition`, a implementacja używa `\resOpenQty` i `\resOpenValue`, więc slajd pisany według przykładów z B.5 odwołałby się do niezdefiniowanego makra.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.5; `Projekt_1.pdf` s. 7, poz. 7.
  - Sposób wykrycia: porównanie nazw w `results/basic.tex` z listą przykładów B.5 przez recenzenta.
  - Poprawka: odrzucono zmianę kodu. Karty zadań `latex-assistant` otrzymają faktyczne nazwy makr. Rozbieżność przykładów B.5 z implementacją zgłoszono użytkownikowi do rozstrzygnięcia przez brief.
- **Znalezisko:** Przy pozycji otwartej na końcu JSON nie zawierał indeksów i ceny otwierającego kupna.
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.5 („every number"), A.5 poz. 7.
  - Sposób wykrycia: analiza kodu przez recenzenta. Na danych PKO pozycja otwarta nie występuje, więc dowody z uruchomień nie pokrywały tej ścieżki.
  - Poprawka: do JSON dodano pole `open_trade` (indeks sygnału, indeks wykonania, cena albo `null`). Poprawiono w commicie `8ba19f2`.
- **Znalezisko:** Nazwy makr nie mają prefiksu części, więc jednoczesne wczytanie `results/basic.tex` i przyszłego `results/experiment.tex` z tymi samymi nazwami zakończyłoby się błędem LaTeX „Command already defined".
  - Waga: nit.
  - Wymaganie: `docs/requirements-code.md` B.5.
  - Sposób wykrycia: analiza schematu nazw eksportu przez recenzenta.
  - Poprawka: odrzucono zmianę w tym zadaniu. Karta zadania części eksperymentalnej (etap 6) otrzyma wymóg nazw z prefiksem `Exp…`.

Iteracja 2 (potwierdzenie poprawki przez orkiestratora): przebiegi deterministyczne, `open_trade: null` w JSON, `basic.tex` bez zmian co do bajtu, ścieżka z pozycją otwartą sprawdzona na danych skonstruowanych.

**Kandydat na slajd**

- Zasada „żadna liczba na slajdzie nie jest przepisywana ręcznie": dwanaście makr `\res…` generowanych przez program wprost z wyników symulacji (`Projekt_1.pdf` s. 9, 6.3, wymóg odtwarzalności wyników).

Status: oczekuje na akceptację.
