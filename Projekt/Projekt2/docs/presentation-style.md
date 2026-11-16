> Literal extract of `PROJECT_BRIEF.md` v1.2, section 3. Edit the brief first, then regenerate this file (brief 5.2).

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
