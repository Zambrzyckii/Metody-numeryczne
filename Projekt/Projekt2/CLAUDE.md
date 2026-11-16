# Projekt 2, linear systems (Metody Numeryczne)

Paths are relative to this directory (`Projekt/Projekt2/`). The repository root is `~/Metody-numeryczne`.

## Scope

This setup was created for the preliminary deck (P2W) and its submission. Python code, the FEM program, the structure choice, experiments, measurements, charts and the final deck (P5) need their own brief and the user's decisions (brief 6.6).

## Sources of truth

A higher source wins and every discrepancy is reported to the user.

1. `materials/Projekt_2.pdf`, `materials/zasady_zaliczenia_projektu_v1.pdf`, `materials/harmonogram_2026_v3.pdf`
2. `PROJECT_BRIEF.md`, the genesis document. Read a specific section when needed, do not load it whole.
3. `docs/requirements-presentation.md`, `docs/presentation-style.md`
4. `.claude/agents/*.md`

Changes flow downward only. Edit the brief first, then `docs/` and the agent files (brief 5.2).

## Orchestration protocol

1. The main session is the orchestrator. It delegates through task cards (brief 2.4). Slides go to `latex-assistant`, then to `presentation-reviewer`. `coder` and `code-reviewer` are defined for P5.
2. The orchestrator runs the verification itself (`make`, `pdffonts`, `pdfimages`, `pdfinfo`, `pdftoppm`) and passes the output and the PNG pages to the reviewer.
3. Agent files created inside a running session are not loaded by it. In that case each role runs as a `general-purpose` agent that reads `.claude/agents/<role>.md`, and reviewers are read-only by instruction only (brief 2.2).
4. Decisions taken in place of the user are logged and shown at the single stop before submission. Nothing is submitted without the user's explicit "tak" (brief 0.1, 6.3).

## Non-negotiable rules

- No computed result and no unsourced claim on a slide. Constants from `Projekt_2.pdf` are definitions.
- `docs/ai-log.md` gets an entry after every stage and every delegated task. AI errors are logged only when real, with how they were detected.
- Commits follow `~/.claude/rules/git.md` with no AI marker. Only the orchestrator commits.
- ZIPs are built only from the whitelist (brief 1.5) and tested by unpacking and `make -B` (brief 6.4).
- English for code, identifiers, commits, `docs/` and agent instructions. Polish for slides, `docs/ai-log.md`, the talk plan and talking to the user.

## Key facts

| Item | Value |
|---|---|
| Author | Bartosz Zambrzycki |
| P4 (preliminary talk) | 2026-11-18, 11:15-13:00, group `pro_gr3a` |
| P2W ZIP deadline | 2026-11-18 10:15, internal target 10:00 |
| eNauczanie | course 8051, assignment `P2W`, id 27573 |
| Deliverables folder | `~/Downloads/MN-Projekt2/` |
| ZIP name | `zambrzycki_projekt2_wstepna.zip` |
