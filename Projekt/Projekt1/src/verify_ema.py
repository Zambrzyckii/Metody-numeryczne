"""Independent EMA check against pandas, docs/requirements-code.md B.3."""
import sys

import pandas as pd

import config
import data
from macd import ema

TOLERANCE = 1e-9


def main() -> int:
    """Check ema() against pandas ewm, docs/requirements-code.md B.8."""
    close = data.load_prices(config.DATA_FILE).close
    series = pd.Series(close)
    failed = False
    for n in config.MACD_PARAMS:
        reference = series.ewm(span=n, adjust=False).mean().to_numpy()
        max_diff = float(abs(ema(close, n) - reference).max())
        status = "OK" if max_diff <= TOLERANCE else "FAIL"
        print(f"N={n}: max abs diff = {max_diff:.3e} {status}")
        failed = failed or max_diff > TOLERANCE
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
