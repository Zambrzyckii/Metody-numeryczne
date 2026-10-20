"""CSV loading and validation, per docs/requirements-code.md A.1 and B.3."""
from dataclasses import dataclass
from pathlib import Path

import numpy as np
import pandas as pd

MIN_ROWS = 1000
MAX_ROWS = 1200


@dataclass(frozen=True)
class PriceSeries:
    """Parallel arrays indexed i = 0...L-1, docs/requirements-code.md B.3."""

    dates: np.ndarray
    open: np.ndarray
    high: np.ndarray
    low: np.ndarray
    close: np.ndarray
    volume: np.ndarray
    length: int


def load_prices(
    path: Path, min_rows: int = MIN_ROWS, max_rows: int = MAX_ROWS
) -> PriceSeries:
    """Load and validate a six-column price CSV, Projekt_1.pdf p. 4, 3.1."""
    frame = pd.read_csv(path)
    for column in ("date", "open", "high", "low", "close", "volume"):
        if column not in frame.columns:
            raise ValueError(
                f"missing column '{column}' (Projekt_1.pdf p. 4, 3.1)"
            )
    length = len(frame)

    if not min_rows <= length <= max_rows:
        raise ValueError(
            f"row count {length} outside {min_rows}-{max_rows}"
            " (Projekt_1.pdf p. 4, 3.1)"
        )

    try:
        parsed_dates = pd.to_datetime(frame["date"])
    except (ValueError, TypeError):
        raise ValueError(
            "unparseable date (Projekt_1.pdf p. 4, 3.1)"
        ) from None
    if pd.isna(parsed_dates).any():
        raise ValueError("missing date (Projekt_1.pdf p. 4, 3.1)")
    dates = parsed_dates.to_numpy(dtype="datetime64[D]")
    if len(np.unique(dates)) != length:
        raise ValueError("duplicate dates (Projekt_1.pdf p. 4, 3.1)")
    if not np.all(dates[1:] > dates[:-1]):
        raise ValueError(
            "dates not strictly increasing (Projekt_1.pdf p. 4, 3.1)"
        )

    try:
        close = frame["close"].to_numpy(dtype=np.float64)
    except (ValueError, TypeError):
        raise ValueError(
            "non-numeric close price (Projekt_1.pdf p. 4, 3.1)"
        ) from None
    if np.isnan(close).any():
        raise ValueError("missing close price (Projekt_1.pdf p. 4, 3.1)")
    if np.any(close <= 0.0):
        raise ValueError("non-positive close price (Projekt_1.pdf p. 4, 3.1)")

    return PriceSeries(
        dates=dates,
        open=frame["open"].to_numpy(dtype=np.float64),
        high=frame["high"].to_numpy(dtype=np.float64),
        low=frame["low"].to_numpy(dtype=np.float64),
        close=close,
        volume=frame["volume"].to_numpy(dtype=np.float64),
        length=length,
    )
