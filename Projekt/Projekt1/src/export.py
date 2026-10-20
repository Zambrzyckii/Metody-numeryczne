"""Results export to JSON and LaTeX macros, docs/requirements-code.md B.5."""
import json
from pathlib import Path

import config


def format_number(value: float, decimals: int = 2) -> str:
    """Polish decimal comma, two decimals, docs/requirements-code.md B.5."""
    return f"{value:.{decimals}f}".replace(".", ",")


def format_optional(value: float | None, decimals: int = 2) -> str:
    """Format or report 'nie dotyczy', Projekt_1.pdf p. 7, 4.4."""
    if value is None:
        return "nie dotyczy"
    return format_number(value, decimals)


def write_results(
    part: str,
    numbers: dict,
    macros: dict[str, str],
    results_dir: Path = config.RESULTS_DIR,
) -> None:
    """Write results/<part>.json and .tex, docs/requirements-code.md B.5."""
    results_dir.mkdir(parents=True, exist_ok=True)

    json_path = results_dir / f"{part}.json"
    json_path.write_text(
        json.dumps(numbers, ensure_ascii=False, indent=2, allow_nan=False)
        + "\n",
        encoding="utf-8",
    )

    lines = []
    for name, text in macros.items():
        if not (name.isascii() and name.isalpha()):
            raise ValueError(f"macro name '{name}' must be letters only")
        lines.append(f"\\newcommand{{\\res{name}}}{{{text}}}")
    tex_path = results_dir / f"{part}.tex"
    tex_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
