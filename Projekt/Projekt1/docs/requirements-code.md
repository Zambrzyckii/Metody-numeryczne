# Requirements: code

> Part A is extracted from `materials/Projekt_1.pdf`. Part B is extracted from `PROJECT_BRIEF.md` v1.0, section 4. On conflict the PDF wins (brief §0). This file is the `code-reviewer` checklist.

## Part A — Requirements from the instruction

### A.1 Data (`Projekt_1.pdf` p. 4, 3.1)

- Basic part: 1000–1200 consecutive **closing prices** of one instrument, with dates, in CSV.
- Ordered from oldest to newest; positive; no gaps in records and no duplicate dates.
- Gaps between sessions are **not** filled with artificial prices.
- The readme states instrument, unit, source, date range and information on price corrections (e.g. dividend adjustment).
- AI-assisted data must be verified against a trusted service (dates and selected prices).
- L denotes the number of observations, i = 0…L−1. The instruction's index 1000 means L−1.

Chosen instrument: **PKO BP**, daily, PLN, from stooq.pl (brief 1.7).

- **File:** `data/pko.csv`, 1001 sessions, 2022-10-19 … 2026-10-20, verified against an independent source (CP1).
- **Columns:** `date, open, high, low, close, volume`. Rows are verbatim from the source.
- **Adjustment:** prices are backward-adjusted by stooq, with the last adjustment on 2026-08-04, covering 945 of the 1001 sessions. Volume before that date is fractional for the same reason. The data is used as is. The adjustment is described in `readme.md`.

### A.2 Indicator (`Projekt_1.pdf` p. 1–2)

| # | Formula |
|---|---|
| (1) | α_N = 2/(N+1); E₀⁽ᴺ⁾ = x₀; Eᵢ⁽ᴺ⁾ = α_N·xᵢ + (1−α_N)·Eᵢ₋₁⁽ᴺ⁾ for i ≥ 1 |
| (2) | Mᵢ = Eᵢ⁽ᴺ¹⁾ − Eᵢ⁽ᴺ²⁾ |
| (3) | S₀ = M₀; Sᵢ = α_N₃·Mᵢ + (1−α_N₃)·Sᵢ₋₁ for i ≥ 1 |
| (4) | Hᵢ = Mᵢ − Sᵢ |

- Parameters are fixed at **(N₁, N₂, N₃) = (12, 26, 9)** for the whole basic simulation.
- All curves are computed from the first sample, keeping the full history of the averages.
- The pandas reference is `Series.ewm(span=N, adjust=False).mean()`, which is the recursive EMA of formula (1).

**Signals** (p. 2), for i ≥ 1:

| Signal | Condition |
|---|---|
| buy | H₍ᵢ₋₁₎ ≤ 0 and Hᵢ > 0 |
| sell | H₍ᵢ₋₁₎ ≥ 0 and Hᵢ < 0 |
| none | Hᵢ = 0 (no new signal) |

The signal is assigned to the first sample after the crossing. Crossing times are never interpolated.

### A.3 Portfolio (`Projekt_1.pdf` p. 4–5, 3.2)

- Vectors C (`cash`), Q (`position_qty`) and V (`equity`) of length L.
- (5) Vᵢ = Cᵢ + Qᵢ·xᵢ.
- Initial state at sample 100: C₁₀₀ = 1000·x₁₀₀, Q₁₀₀ = 0, V₁₀₀ = C₁₀₀. No transaction at sample 100.
- Elements 0…99 are not used in the simulation or on the portfolio chart.
- No commissions, taxes, interest or dividends. Fractional units are allowed. Never sell an instrument that is not held.

### A.4 Simulation algorithm (`Projekt_1.pdf` p. 5, 3.3)

The parameters stay (12, 26, 9) throughout. d is the execution delay; this project uses **d = 1** (brief 1.7).

1. Compute EMA, MACD, SIGNAL and H for all x₀…x₍L−1₎.
   - Samples 0…99 only warm up the averages; sample 100 fixes the initial portfolio state.
   - Signals are considered **from sample 101**. The first considered signal is determined from H₁₀₀ and H₁₀₁.
2. Create C, Q and V with the initial state from A.3, then process i = 101…L−1.
3. If i − d ≥ 101, check the signal at sample i − d.
   - **Buy** signal and C₍ᵢ₋₁₎ > 0: Qᵢ = C₍ᵢ₋₁₎/xᵢ, Cᵢ = 0.
   - **Sell** signal and Q₍ᵢ₋₁₎ > 0: Cᵢ = Q₍ᵢ₋₁₎·xᵢ, Qᵢ = 0.
   - Otherwise, including when i − d < 101: Cᵢ = C₍ᵢ₋₁₎, Qᵢ = Q₍ᵢ₋₁₎.
4. Compute Vᵢ by (5). Record the signal index, the execution index and the execution price.
5. Build the list of closed trades with their buy and sell prices.

Further rules:

- Full commitment of available capital: buy with all cash, sell the whole position.
- With d = 1, a signal at the last sample (L−1) is not executed, because there is no next price.

### A.5 Returns and summary (`Projekt_1.pdf` p. 5–7, 3.4 and 4.4)

- (6) R = 100·(V₍L−1₎ / C₁₀₀ − 1) %, the return of the whole portfolio.
- (7) r = 100·(x_b / x_a − 1) %, the return of a closed trade. a and b are the execution indices of the buy and the sell.
- Trades with r ≥ 0 are **profitable**, including r = 0; trades with r < 0 are losing.
- An open position at the end is excluded from the trade statistics but affects R.
- The data must yield **at least one closed trade**. Otherwise the input data is changed.

The summary on slide F (4.4) has seven items:

1. C₁₀₀ and V₍L−1₎,
2. total profit or loss as an amount, and R in %,
3. number of profitable (including r = 0) and losing closed trades,
4. % of profitable trades among all closed trades,
5. largest % loss of a single closed trade, given as a positive number ("największa strata: 8%"),
6. largest % gain of a single closed trade,
7. information on an open position at the end.

Items that do not apply are reported as „nie dotyczy".

### A.6 Program and archive (`Projekt_1.pdf` p. 9, 6.3; `zasady` p. 2)

- Only `.py` scripts; no Jupyter notebooks.
- The code must reproduce every result shown on the slides.
- `readme.md` contains a command producing every chart, by ID (A1, B1, C1, C2, D1, E1, E2). One command may produce all of them.
- `zrodla.md` lists templates and auxiliary materials, if any.
- The experiment dataset is never included in the archive. Its location is configurable (`MN_DATA_DIR`).

## Part B — Code conventions (brief section 4)

The following conventions are the contract for `coder` and the source of the `code-reviewer` checklist. It is materialized as `docs/requirements-code.md`, together with the requirement extracts from section 1.

### B.1 Environment and dependencies

- **Python.** Development runs on Python 3.14. Code must stay compatible with Python 3.10 or newer, because the lecturer's environment is unknown. No syntax newer than 3.10.
- **Dependencies.** `numpy`, `pandas` and `matplotlib` only. They are listed in `requirements.txt` with minimum versions (`numpy>=1.24`, `pandas>=2.0`, `matplotlib>=3.7`) rather than exact pins.
  - Trade-off: installability on the lecturer's machine wins over bit-exact reproducibility. The computations are deterministic arithmetic, so this costs nothing in practice.
- **Tooling.** No new package, linter or formatter is installed without the user's approval. PEP 8 is checked by review, which matches the instruction's reference [9] in `Projekt_1.pdf`.

### B.2 Layout of `src/`

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

### B.3 Numerical conventions

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

### B.4 Naming and style

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

### B.5 Results export (ADR-4)

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

### B.6 Input data

- **Basic part.** `data/<instrument>.csv` holds at least `date` and `close`, plus `open`, `high`, `low` if a candlestick A1 is chosen.
- **What `readme.md` states about the instrument** (`Projekt_1.pdf` p. 4, 3.1):
  - name and unit,
  - source URL,
  - date range,
  - any corporate-action adjustments.
- **Experimental part.** Read from the directory given by the environment variable `MN_DATA_DIR`. The default is `materials/dane_pro1/`, the unzipped `dane_pro1.zip`. Files have the columns `date, open, high, low, close, volume` (`Projekt_1.pdf` p. 8, 5.2). This data is never copied into the repo or a ZIP.
- **Read-only data.** Code never writes into data directories.

### B.7 Build conventions

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

### B.8 Verification for each code task

| Check | Pass criterion |
|---|---|
| `python src/verify_ema.py` | maximum difference against pandas ≤ 1e-9 for N = 12, 26, 9 |
| `python src/basic.py` | runs without errors or warnings; every expected file in `charts/` and `results/` is created |
| Invariants (4.3) | no exception raised on the chosen instrument |
| `code-reviewer` | verdict APPROVE against `docs/requirements-code.md` |
