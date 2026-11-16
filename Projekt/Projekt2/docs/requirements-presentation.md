# Requirements: preliminary presentation (P2W)

> Extract of `PROJECT_BRIEF.md` v1.2, sections 1.2 to 1.5 and 1.8, translated to English. Sources are `materials/Projekt_2.pdf` (`Projekt_2`), `materials/zasady_zaliczenia_projektu_v1.pdf` (`zasady`) and `materials/harmonogram_2026_v3.pdf` (`harmonogram`). The PDFs win on conflict. Edit the brief first, then regenerate this file (brief 5.2). Every page reference below was re-checked against the PDFs on 2026-11-16.

## 1. Scored content, 2 points

The preliminary deck is worth 2 points, all of them for "introduction and AI collaboration" and 0 for "methods and results" (`zasady` p. 1, table 2).

The split into five elements of 0.4 points is an **assumption carried over from Projekt 1** (`../Projekt1/materials/Projekt_1.pdf` p. 9, table 1). `Projekt_2` gives no such split. It says only that 4 points of the whole project cover, across both presentations, the theoretical basis of the algorithms, selected effects of the AI collaboration and the AI review (`Projekt_2` p. 1, section 2). Effort is spread evenly over the five elements.

| Element (0.4 each, assumption) | Acceptance criterion | Source |
|---|---|---|
| Introduction, three methods | at least three slides, one per method. LU, the idea of factorization. Jacobi, the iteration formula, use of values from the previous iteration, convergence conditions. Gauss-Seidel, the iteration formula, use of updated values, convergence conditions. Symbols explained, no proofs | `Projekt_2` p. 3, section 4. `zasady` speaks of "about three slides" (`zasady` p. 2, section 4, condition 7) |
| Way of working and AI setup | choice of tools, work organization, agent roles. One topic described well rather than a hundred briefly | `zasady` p. 4, section 5.2 |
| Selected prompt, result, evaluation | one concrete prompt with its real result and our evaluation | `zasady` p. 4, section 5.2 ("ciekawe prompty i rezultaty ich wykonania") |
| AI-error report | about three slides describing an example of erroneous AI behaviour. If no error occurred, the literal declaration of `zasady` p. 4, section 5.3 in masculine form, „W trakcie prac nad projektem nie zauważyłem błędnego działania AI." | `zasady` p. 4, section 5.3 |
| AI review | how the reviewer is defined and its criteria, the review prompt or fragments of it, a verbal and a numeric 1-10 grade, preferably on one slide. About four slides recommended | `zasady` p. 5, section 6.3 |

Further facts.

- **The preliminary deck needs no code and no computed results** (`Projekt_2` p. 3, section 4). Discussing a code fragment is optional and is skipped. `zasady` allows program results in a preliminary deck, always tied to the AI tools (`zasady` p. 4, section 5.2). This deck shows none.
- **Title slide.** Topic, author name and „Prezentacja wstępna". `Projekt_2` has no such rule. It is an assumption carried over from `Projekt_1.pdf` p. 5, section 4.1 and kept by user decision.
- Content is graded, not the delivery (`zasady` p. 2, section 4). The AI reviewer's grade does not determine points (`zasady` p. 5, section 6.3).

## 2. Mandatory conditions (fail gates)

Missing any of these means the presentation fails until corrected (`zasady` p. 2, section 4, conditions 1-8).

- Attendance, also when not drawn to present (condition 1, who presents is described in `zasady` p. 4, section 5.1).
- At least 50% of the points.
- PDF built by compiling LaTeX.
- Compilation defined in a `Makefile`.
- Slide numbering "n/N" on every slide.
- Three slide groups. An introduction on the algorithm, AI errors or the declaration, the AI review.
- A ZIP with the PDF, the `Makefile` and the files needed to compile, submitted to eNauczanie.

Format (`zasady` p. 4-5, section 6.1).

- 16:9 (`aspectratio=169`), prepared for full screen on 4K UHD.
- About 8 minutes of talk.
- Legible from the audience seats. High resolution does not replace large text.
- Fonts embedded.
- PDF checked in full-screen mode for legibility, cropping, overlapping content and symbols.

## 3. Deadlines

| Item | What | When |
|---|---|---|
| P4 | Preliminary presentation of Projekt 2 (`zasady` p. 1, table 1) | Wednesday **2026-11-18, 11:15-13:00**, group `pro_gr3a` (`harmonogram` p. 3, table 2 and the group list) |
| P2W ZIP deadline | one ZIP | one hour before class at the latest, so **2026-11-18, 10:15** (`zasady` p. 3, section 4.1, example 8:15 and 7:15). **Internal target 10:00** |

Lateness costs 0.2 points per started 24 hours of ZIP delay and 0.2 points per day of talk delay, whichever is larger (`zasady` p. 3, section 4.1). The schedule may change and a change is announced on eNauczanie (`harmonogram` p. 3).

## 4. Packaging whitelist

The ZIP is built from a whitelist, never from a directory with exclusions.

| File | Contents |
|---|---|
| `zambrzycki_projekt2_wstepna.zip` | `slides/preliminary/main.pdf`, `slides/preliminary/Makefile`, every `slides/preliminary/*.tex` including `review.tex`, `slides/common/mnstyle.sty`. Directory structure kept so `make` works after unpacking |

Never packed. `materials/`, `docs/`, `.claude/`, `CLAUDE.md`, `PROJECT_BRIEF.md`, `KICKOFF.md`, `plan_wystapienia.md`, LaTeX auxiliary files (`*.aux`, `*.log`, `*.nav`, `*.out`, `*.snm`, `*.toc`, `*.vrb`). Files that configure AI tools, for example `*.md`, must not be submitted (`zasady` p. 2, end of section 4). The PDF, the `Makefile` and the files needed to compile are required (`zasady` p. 2, section 4, condition 8).

Output folder outside the repo is `~/Downloads/MN-Projekt2/`. It holds the ZIP and `plan_wystapienia.md`.

## 5. Verified theory for slides 2 to 5

Literature. Y. Saad, *Iterative Methods for Sparse Linear Systems*, 2nd ed., SIAM 2003 (named by the lecturer in `Projekt_2` p. 3, section 4, chapter 4 covers Jacobi, Gauss-Seidel and convergence). Second source for Gauss-Seidel with SPD matrices is the lecture notes *Numerical Analysis, Part II*, Cambridge, Fawzi 2021, Cor. 4.13. For LU the source is UCLA EE133A notes (Vandenberghe, lecture 7) and a standard textbook fact. Only the lecturer's PDFs were re-checked in this session, not the literature.

### 5.1 Notation

- Matrices bold uppercase, vectors bold lowercase, scalars plain (`Projekt_2` p. 1, footnote 1). In LaTeX `\mathbf`.
- From Saad, the splitting A = D − E − F, the iteration matrices G_JA and G_GS and the method names.
- Components as the lecturer writes them, x_i, b_i, a_ij (`Projekt_2` p. 8, A.2), not Saad's ξ_i, β_i.
- Iteration index **j**, as in the lecturer's formula (2) (`Projekt_2` p. 3). Saad writes k. Slide 2 states this mapping in one line.
- One index convention in the whole deck.

### 5.2 Slide 2, context

- Ax = b, A ∈ R^{N×N}, x, b ∈ R^N, A (sparse) and b known, x sought (`Projekt_2` p. 1, formula (1)). N is the number of unknowns, not the number of triangles (p. 3, section 5.1).
- For the heat-conduction model A is sparse, symmetric and positive definite (SPD) after eliminating prescribed temperatures, under the assumptions of appendix A (p. 3, section 5.1, p. 8, A.2). SPD does not automatically hold for the electromagnetic problem (p. 3). The slide does not discuss that problem.
- Residual r^(j) = b − A x^(j), relative norm η_j = ‖r^(j)‖₂ / ‖b‖₂, condition η_j ≤ ε, ε = 10⁻⁸ (recommended value) (`Projekt_2` p. 3, formula (2)).
- Constants from the instruction (ε = 10⁻⁸, equation numbers) are definitions, not results.
- Saad uses ‖r_k‖/‖r_0‖ (Example 6.1, p. 167), which equals the course definition only for x_0 = 0. The slides use the course definition.

### 5.3 Slide 3, LU

- A = LU, L lower triangular with ones on the diagonal, U upper triangular. Ax = b is solved in two steps. Ly = b by forward substitution, then Ux = y by back substitution.
- With (row) pivoting, PA = LU exists for every nonsingular matrix. For a nonsingular matrix, LU without pivoting exists if and only if all leading principal minors are nonzero (textbook fact). For a singular matrix the condition is not necessary (counterexample by the AI reviewer, iteration 1, `docs/ai-log.md`).
- For a dense matrix the factorization costs about (2/3) N³ operations and each solve of the two triangular systems O(N²). One factorization therefore serves many right-hand sides (Vandenberghe, lecture 7).
- For a sparse matrix, elimination creates nonzeros in places of zeros (fill-in), and reordering rows and columns reduces it (Saad, section 3.6, p. 96, Example 3.3, p. 82-83).
- **Do not put** unverified fill-in orders or operation counts for a 2D FEM matrix on slides.

### 5.4 Slide 4, Jacobi

- Splitting A = D − E − F. D is the diagonal of A, −E its strictly lower part, −F its strictly upper part (Saad, eq. (4.2), p. 105). Assume a_ii ≠ 0 (p. 106).
- Component formula (Saad, eq. (4.4), p. 106) in our notation x_i^(j+1) = (b_i − Σ_{l≠i} a_il x_l^(j)) / a_ii. It uses only values from the previous iteration (p. 112). The summation index differs from i, for example l.
- Vector form x^(j+1) = D⁻¹(E + F) x^(j) + D⁻¹ b (eq. (4.5)). Iteration matrix G_JA = I − D⁻¹A (eq. (4.19), p. 112).
- Convergence. The iteration x^(j+1) = G x^(j) + f converges for every x^(0) and f if and only if the spectral radius ρ(G) < 1 (Saad, Thm 4.1, p. 115). A sufficient condition is strict or irreducible diagonal dominance of A, written row-wise |a_ii| > Σ_{l≠i} |a_il| (Saad, Thm 4.9, p. 121, noting that Saad's definition 4.5 is written column-wise).
- **SPD does not guarantee Jacobi convergence** (`Projekt_2` p. 5, section 6.1). A sufficient condition for SPD A is that 2D − A is also SPD (Fawzi, Cor. 4.13(2)). The textbook theorem number for this condition is **not verified**, so the slide cites Fawzi's notes or gives no number.

### 5.5 Slide 5, Gauss-Seidel

- Forward version (Saad, eq. (4.7), p. 107). Components with index l < i use new values, l > i old values. A new component is used immediately after it is computed (p. 106-107). In our notation x_i^(j+1) = (b_i − Σ_{l<i} a_il x_l^(j+1) − Σ_{l>i} a_il x_l^(j)) / a_ii.
- Matrix form (D − E) x^(j+1) = F x^(j) + b (eq. (4.8)). Iteration matrix G_GS = I − (D − E)⁻¹ A (eq. (4.20)).
- It overwrites components in place, so it needs less memory, and it usually converges faster than Jacobi (Saad, p. 112).
- Convergence. The same ρ(G) < 1 (Thm 4.1) and diagonal dominance (Thm 4.9, p. 121) as for Jacobi. For SPD A Gauss-Seidel converges, because it is SOR with ω = 1 and SOR converges for 0 < ω < 2 for symmetric positive definite A (Saad, Thm 4.10, p. 122). Fawzi, Cor. 4.13(1) states it directly. `Projekt_2` p. 5, section 6.1 states it with the qualifier „w arytmetyce dokładnej", and the slide keeps that qualifier.

### 5.6 What the intro slides do not do

They prove no theorems (`Projekt_2` p. 3, section 4). They give no computed numbers. They do not claim that one method wins on the FEM matrices, because that is a P5 experiment result. They name no specific structures.
