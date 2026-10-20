# Presentation visual style

> Extract of `PROJECT_BRIEF.md` v1.0, section 3. Edit the brief first, then regenerate this file (brief §5.2).

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
  - Left: `Bartosz Zambrzycki · Projekt 1: MACD`, in `mnMuted` and `\footnotesize`.
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
