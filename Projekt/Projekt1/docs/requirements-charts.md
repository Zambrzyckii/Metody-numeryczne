# Requirements: charts

> Extracted from `materials/Projekt_1.pdf` p. 6–7 (4.2, 4.5); the PDF wins on conflict. The visual style (sizes, fonts, colours, markers) is defined in `docs/presentation-style.md` §3.6 and is not repeated here.

## Charts of the basic part (`Projekt_1.pdf` p. 6, 4.2)

Charts are labelled by slide letter and number: C1 is the first chart on slide C, C2 the second.

| ID | Content | Specific requirements |
|---|---|---|
| A1 | Input data | Price for all L samples; instrument name, unit and date range. Line chart of closes, or candlestick chart (optional). The initial range 0…100, where signals are not used, may be marked. |
| B1 | Price and indicator | One shared time axis. Price as a **light background line**; MACD and SIGNAL as distinct foreground lines. Price on the **left** y-axis, MACD/SIGNAL on the **right**. Axis labels and the legend unambiguously assign each series to its axis. Crossings of the price with the indicator lines carry no signal meaning. |
| C1 | Signals | MACD and SIGNAL with buy and sell signals marked. No signals marked up to and including sample 100. |
| C2 | Histogram | Hᵢ as bars with the zero level. Shares the time range with C1, optionally without the first 100 samples. |
| D1 | Selected trade | Zoom of B1 around an actual buy, the following sell, and the samples before and after them. Mark the executions on the price curve and their signals. Slide text: dates and prices of both operations and the trade return r (formula (7)), plus how MACD behaviour led to the trade. The trade must be both opened and closed in the simulation; if none exists, the input data is changed. |
| E1 | Whole simulation: signals | Price with buy and sell signals, distinguishing **executed** from **not executed** signals. With d = 1, the signal moment may be distinguished from the execution moment. |
| E2 | Whole simulation: portfolio | Portfolio value Vᵢ over time. Shares the time range with E1. The range may start at sample 0 or 100; 100 is the suggested option. If it starts at 0, E2 is empty for 0…99, because no portfolio value is plotted before sample 100. |
| F | Numerical summary (slide, not chart) | The seven items of `docs/requirements-code.md` A.5, plus a conclusion on how MACD performed for the instrument. |

The most important observations for a chart go on the same slide or on the slides that directly follow it.

## Features of a correctly prepared chart (`Projekt_1.pdf` p. 7, 4.5)

- The title states the quantity shown and the instrument.
- Every axis has a label and a unit. The time axis shows dates or sample indices.
- The legend explains lines, bars and markers.
- Buy and sell differ by **colour and marker shape**.
- A chart with two y-axes clearly assigns each series to its axis.
- Text, line widths and marker sizes are legible on the slide.
- Data on charts, in trade descriptions and in the numerical summary come from **the same program run with the same settings**.
- Charts are saved as **vector graphics** (PDF), not raster.

## Experiment charts (`Projekt_1.pdf` p. 8, 5.2)

IDs X1, X2, … (project convention, brief 4.2). Required content:

- **Global result.** A comparison across all instruments of the dataset, for example the return change in percentage points:
  - mean and median of the change,
  - number of instruments where the modification helped, hurt or changed nothing.
- **Local example.** A zoom showing a changed decision and its effect on a trade, with the selection criterion stated and a reference to the whole dataset. Where it occurred, also show a case where a closed trade's return got worse.
- **Units.** Differences of returns are expressed in percentage points. Capitals in different units are never summed.
