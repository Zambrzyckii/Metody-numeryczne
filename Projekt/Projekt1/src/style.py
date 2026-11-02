"""Palette, matplotlib settings and fonts, presentation-style.md 3.2, 3.6."""
from pathlib import Path

import numpy as np
from matplotlib import font_manager, rcParams, ticker
from matplotlib.axis import Axis

PRIMARY = "#173D56"
TEXT = "#182A3B"
MUTED = "#4E6B7E"
BUY = "#00856A"
SELL = "#C13F4B"
BUY_LIGHT = "#6EB9AA"
SELL_LIGHT = "#DB9198"
SIGNAL_LINE = "#C26A1A"
PRICE = "#9AA5B1"
GRID = "#DCE3E8"

FULL_SIZE_MM = (144.0, 62.0)
PAIR_SIZE_MM = (144.0, 68.0)

FONT_DIR = Path("/usr/share/texmf-dist/fonts/opentype/public/tex-gyre")
FONT_FILES = ("texgyreheros-regular.otf", "texgyreheros-bold.otf")
FONT_FAMILY = "TeX Gyre Heros"

_BASE_PARAMS = {
    "pdf.fonttype": 3,
    "figure.facecolor": "white",
    "axes.facecolor": "white",
    "savefig.facecolor": "white",
    "text.color": TEXT,
    "font.size": 8,
    "axes.labelsize": 9,
    "axes.labelcolor": MUTED,
    "axes.titlesize": 9,
    "axes.titleweight": "bold",
    "axes.titlecolor": TEXT,
    "axes.titlelocation": "left",
    "axes.edgecolor": MUTED,
    "axes.spines.top": False,
    "axes.spines.right": False,
    "axes.grid": True,
    "axes.grid.axis": "y",
    "axes.axisbelow": True,
    "grid.color": GRID,
    "grid.linewidth": 0.8,
    "xtick.labelsize": 8,
    "ytick.labelsize": 8,
    "xtick.color": MUTED,
    "ytick.color": MUTED,
    "lines.linewidth": 1.4,
    "lines.markersize": 6,
    "legend.frameon": False,
    "legend.fontsize": 8,
}


def _load_font() -> bool:
    """Register TeX Gyre Heros when its files exist, presentation-style 3.6."""
    paths = [FONT_DIR / name for name in FONT_FILES]
    if not all(path.is_file() for path in paths):
        return False
    for path in paths:
        font_manager.fontManager.addfont(str(path))
    return True


def apply() -> None:
    """Set the chart style, docs/presentation-style.md 3.6."""
    params = dict(_BASE_PARAMS)
    if _load_font():
        params["font.family"] = FONT_FAMILY
    rcParams.update(params)


def _decimals_needed(ticks: np.ndarray) -> int:
    """Fewest decimals that show every tick value exactly."""
    for decimals in range(5):
        if np.allclose(ticks, np.round(ticks, decimals), atol=1e-9):
            return decimals
    return 4


def _format_tick(value: float, decimals: int) -> str:
    """Decimal comma, no-break space thousands from five digits."""
    text = f"{abs(value):.{decimals}f}"
    whole, _, fraction = text.partition(".")
    if len(whole) >= 5:
        whole = f"{int(whole):,}".replace(",", " ")
    result = f"{whole},{fraction}" if fraction else whole
    if value < 0 and float(text) != 0.0:
        result = "−" + result
    return result


def decimal_comma(axis: Axis) -> None:
    """Polish decimal comma on tick labels, docs/presentation-style.md 3.3."""
    axis.set_major_formatter(
        ticker.FuncFormatter(
            lambda value, _: _format_tick(
                value, _decimals_needed(axis.get_majorticklocs())
            )
        )
    )
