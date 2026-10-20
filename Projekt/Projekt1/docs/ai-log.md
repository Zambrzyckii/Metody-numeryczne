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
- Status: oczekuje na akceptację.

---

## Zadania agentów

Brak wpisów. Do tej pory nie delegowano zadań subagentom.
