# Projekt 1 — MACD (Metody Numeryczne)

Paths are relative to this directory (`Projekt/Projekt1/`). The repository root is `~/Metody-Numeryczne`.

## Sources of truth

Order of precedence; a higher source wins and every discrepancy is reported to the user:

1. `materials/Projekt_1.pdf` and `materials/zasady_zaliczenia_projektu_v1.pdf`
2. `PROJECT_BRIEF.md` — the genesis document. Read a specific section when needed; do not load it whole.
3. `docs/requirements-code.md`, `docs/requirements-charts.md`, `docs/requirements-presentation.md`, `docs/presentation-style.md`
4. `.claude/agents/*.md`

Changes flow downward only: edit the brief first, then regenerate or update `docs/` (brief §5.2).

## Orchestration protocol

The main session is the orchestrator.

1. **Delegation.** Production work goes to subagents through a task card (brief §2.4):
   - code → `coder`, then `code-reviewer`,
   - slides → `latex-assistant`, then `presentation-reviewer`.
2. **Verification.** The orchestrator runs verification scripts itself (`verify_ema.py`, `make`, `pdffonts`, `pdfimages`) and passes their output to the reviewers. Reviewers are read-only.
3. **Stages.** Work follows brief §6.2. At each checkpoint (CP1–CP5, brief §6.3) the orchestrator stops and waits for the user.
4. **Decisions stay with the user.** Interpretive theses and design decisions are the user's. The user sees a plan before each stage, a report after it, and diffs in digestible portions.

## Non-negotiable rules

- **Numbers.** No number on a slide is typed by hand. Values come from `results/*.tex` macros.
- **Plagiarism.** Any external template or snippet goes into `zrodla.md` in the same commit that introduces it.
- **Records.** After every stage, and after every delegated task, update `docs/ai-log.md` (brief §5.3). AI errors are recorded only when real, with how they were detected.
- **Commits** follow `~/.claude/rules/git.md`. The orchestrator commits; subagents never do. Generated `charts/` and `results/` files go in the same commit as the code that produced them, and the log entry goes in the following commit.
- **Packing.** ZIPs are built only from the whitelist (brief §1.5) and tested by unpacking and rebuilding (brief §6.4). `materials/`, `docs/`, `.claude/`, `CLAUDE.md` and the brief are never packed.
- **Language.** English for code, identifiers, commits, `docs/` and agent instructions. Polish for slides, `readme.md`, `zrodla.md`, the AI log and communication with the user.

## Key facts

| Item | Value |
|---|---|
| Instrument | PKO BP, daily, PLN, stooq.pl |
| MACD parameters | (12, 26, 9) |
| Signals | from sample 101 |
| Execution delay | d = 1 |
| Author | Bartosz Zambrzycki |
| P2 | 2026-10-21, 11:00–13:00; ZIP by 10:00 |
| Experiment dataset | `MN_DATA_DIR`, default `materials/dane_pro1/` (never committed or packed) |
