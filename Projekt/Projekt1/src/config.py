"""Project constants and paths, per docs/requirements-code.md B.2 and B.6."""
import os
from pathlib import Path

MACD_PARAMS: tuple[int, int, int] = (12, 26, 9)
START_INDEX: int = 100
DELAY: int = 1

PROJECT_ROOT: Path = Path(__file__).resolve().parent.parent
DATA_FILE: Path = PROJECT_ROOT / "data" / "pko.csv"
RESULTS_DIR: Path = PROJECT_ROOT / "results"
CHARTS_DIR: Path = PROJECT_ROOT / "charts"

EXPERIMENT_DATA_DIR: Path = Path(
    os.environ.get("MN_DATA_DIR")
    or str(PROJECT_ROOT / "materials" / "dane_pro1")
)
