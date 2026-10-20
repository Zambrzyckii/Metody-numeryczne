"""MACD indicator computation, per docs/requirements-code.md A.2 and B.3."""
import numpy as np


def ema(values: np.ndarray, n: int) -> np.ndarray:
    """EMA per formula (1), Projekt_1.pdf p. 1."""
    alpha = 2.0 / (n + 1)
    result = np.empty_like(values, dtype=np.float64)
    result[0] = values[0]
    for i in range(1, len(values)):
        result[i] = alpha * values[i] + (1.0 - alpha) * result[i - 1]
    return result


def compute_macd(
    close: np.ndarray, params: tuple[int, int, int]
) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    """MACD, SIGNAL and histogram per formulas (2)-(4), Projekt_1.pdf p. 2."""
    n_fast, n_slow, n_signal = params
    macd = ema(close, n_fast) - ema(close, n_slow)
    signal = ema(macd, n_signal)
    hist = macd - signal
    return macd, signal, hist


def detect_signals(hist: np.ndarray) -> np.ndarray:
    """Buy/sell signals from the sign change of H, Projekt_1.pdf p. 2."""
    signals = np.zeros(len(hist), dtype=np.int8)
    buy = (hist[:-1] <= 0.0) & (hist[1:] > 0.0)
    sell = (hist[:-1] >= 0.0) & (hist[1:] < 0.0)
    signals[1:][buy] = 1
    signals[1:][sell] = -1
    return signals
