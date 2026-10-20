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
