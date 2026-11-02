# Projekt 1: wskaźnik MACD i symulacja inwestycji

## Do czego służy kod

Program oblicza wskaźnik MACD(12, 26, 9) dla notowań jednego instrumentu, wyznacza sygnały kupna i sprzedaży z przecięć histogramu H, symuluje portfel i zapisuje wyniki.

- Średnie EMA, MACD, SIGNAL i histogram H liczone są rekurencyjnie od pierwszej próbki (wzory (1)-(4) z instrukcji).
- Symulacja startuje w próbce 100 z kapitałem 1000 jednostek instrumentu i uwzględnia sygnały od próbki 101. Transakcja następuje na kursie zamknięcia kolejnej sesji (opóźnienie d = 1), za cały dostępny kapitał lub całą pozycję.
- Z wyników powstają zestawienie liczbowe (slajd F) oraz wykresy A1, B1, C1, C2, D1, E1 i E2.
- Wszystkie liczby na slajdach program zapisuje do `results/basic.tex` (makra LaTeX) i `results/basic.json` (wartości bez zaokrągleń).

## Wymagania

- Python 3.10 lub nowszy.
- Pakiety `numpy`, `pandas` i `matplotlib`, instalowane poleceniem

```
pip install -r requirements.txt
```

- Opcjonalnie czcionka TeX Gyre Heros (pliki `texgyreheros-regular.otf` i `texgyreheros-bold.otf`). Wykresy ładują ją wyłącznie z katalogu `/usr/share/texmf-dist/fonts/opentype/public/tex-gyre/` (ścieżka w `src/style.py`). Gdy plików tam nie ma, wykresy używają domyślnej czcionki matplotlib i generowanie przebiega bez błędu.

Wszystkie polecenia poniżej uruchamia się z katalogu głównego projektu (tego, w którym leży ten plik).

## Dane części podstawowej

Plik `data/pko.csv` jest dołączony do projektu.

| Pole | Wartość |
|---|---|
| Instrument | PKO BP, notowania dzienne |
| Jednostka ceny | PLN |
| Źródło | https://stooq.pl/ |
| Zakres dat | od 19.10.2022 do 20.10.2026 (1001 sesji) |
| Kolumny | `date`, `open`, `high`, `low`, `close`, `volume` |

Ceny są skorygowane wstecznie przez stooq (korekta o zdarzenia typu dywidenda). Ostatnia korekta nastąpiła 04.08.2026 i objęła 945 z 1001 sesji, czyli wszystkie do 03.08.2026. Z tego samego powodu wolumen z tych sesji jest ułamkowy. Wiersze pochodzą ze źródła bez zmian, a program używa ich w takiej postaci. Między sesjami nie ma uzupełnień sztucznymi cenami.

## Polecenia

Część podstawowa, wykresy A1, B1, C1, C2, D1, E1 i E2 oraz liczby do slajdu F.

```
python src/basic.py
```

Jedno polecenie tworzy wszystkie poniższe pliki.

| Wykres | Plik |
|---|---|
| A1 | `charts/A1.pdf` |
| B1 | `charts/B1.pdf` |
| C1 i C2 | `charts/C1_C2.pdf` (dwa wykresy jeden nad drugim, wspólna oś czasu) |
| D1 | `charts/D1.pdf` |
| E1 i E2 | `charts/E1_E2.pdf` (dwa wykresy jeden nad drugim, wspólna oś czasu) |
| liczby do slajdu F i opisy transakcji | `results/basic.tex`, `results/basic.json` |

Wykresy są zapisywane jako grafika wektorowa PDF w rozmiarze, w jakim trafiają na slajd. Kolejne uruchomienia dają identyczne pliki.

Niezależna kontrola implementacji EMA względem biblioteki pandas (maksymalna różnica nie większa niż 1e-9).

```
python src/verify_ema.py
```

## Część eksperymentalna

Część eksperymentalna korzysta ze wspólnego zbioru danych prowadzącego. Zbiór nie jest dołączony do projektu.

- Dane to rozpakowany plik `dane_pro1.zip`. Domyślnie program szuka ich w katalogu `materials/dane_pro1/`.
- Aby wskazać inną lokalizację, należy ustawić zmienną środowiskową `MN_DATA_DIR` na katalog z plikami CSV (kolumny `date`, `open`, `high`, `low`, `close`, `volume`).
  - Linux i macOS: `export MN_DATA_DIR=/sciezka/do/dane_pro1`
  - Windows (PowerShell): `$env:MN_DATA_DIR = "C:\sciezka\do\dane_pro1"`
- Program tylko czyta ten katalog i niczego do niego nie zapisuje.

Algorytm zmodyfikowany odrzuca sygnał kupna MACD, gdy RSI(14) w sesji sygnału wynosi co najmniej 70. Sygnały sprzedaży pozostają bez zmian, a odrzucony sygnał kupna nie jest przenoszony na późniejszą sesję. Oba algorytmy działają na tej samej symulacji (C_100 = 1000·x_100, opóźnienie d = 1, sygnały od próbki 101) i są uruchamiane na każdym pliku CSV zbioru. Przykłady X3 i X4 pochodzą ze spółek z dokładnie jedną zablokowaną zamkniętą transakcją. X3 to największa, a X4 najmniejsza zmiana R (remisy rozstrzyga ticker).

Obliczenia i wykresy części eksperymentalnej uruchamia polecenie

```
python src/experiment.py
```

Wyniki trafiają do `results/experiment.json` i `results/experiment.tex`.

Wykresy X1, X2, X3 i X4: `python src/experiment.py`. Każdy powstaje tym samym poleceniem i trafia do katalogu `charts/` jako grafika wektorowa PDF.

| Wykres | Plik | Zawartość |
|---|---|---|
| X1 | `charts/X1.pdf` | zmiana stopy zwrotu R po filtrze RSI dla każdej spółki (w punktach procentowych), ze średnią i medianą |
| X2 | `charts/X2.pdf` | rozkład stopy zwrotu transakcji: wszystkie transakcje algorytmu podstawowego i transakcje zablokowane przez filtr |
| X3 | `charts/X3.pdf` | przykład, w którym filtr poprawił wynik: cena i RSI wokół zablokowanej transakcji (dwa wykresy jeden nad drugim) |
| X4 | `charts/X4.pdf` | przykład, w którym filtr pogorszył wynik: cena i RSI wokół zablokowanej transakcji (dwa wykresy jeden nad drugim) |

## Układ katalogów

| Ścieżka | Zawartość |
|---|---|
| `src/` | kod źródłowy (m.in. `config.py`, `data.py`, `macd.py`, `rsi.py`, `simulation.py`, `stats.py`, `export.py`, `style.py`, `charts.py`, `experiment_charts.py`, `basic.py`, `experiment.py`, `verify_ema.py`) |
| `data/` | dane części podstawowej |
| `charts/` | wygenerowane wykresy PDF |
| `results/` | wygenerowane liczby (`.json` i `.tex`) |
