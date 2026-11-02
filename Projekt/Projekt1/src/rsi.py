"""RSI indicator and buy-signal filter, experiment of Projekt_1.pdf 5.1.

RS = A / B with A, B recursive averages of gains and losses,
A_i = alpha * G_i + (1 - alpha) * A_{i-1}, alpha = 1/n. The smoothing is
the project's own choice, analogous to formula (1), Projekt_1.pdf p. 1.
RSI is 100 where B = 0.
"""
import numpy as np


def rsi(close: np.ndarray, n: int) -> np.ndarray:
    """RSI per Murphy [1, rozdz. 10], docs/requirements-code.md B.4."""
    alpha = 1.0 / n
    delta = np.zeros(len(close), dtype=np.float64)
    delta[1:] = close[1:] - close[:-1]
    gain = np.maximum(delta, 0.0)
    loss = np.maximum(-delta, 0.0)
    avg_gain = np.empty_like(gain)
    avg_loss = np.empty_like(loss)
    avg_gain[0] = gain[0]
    avg_loss[0] = loss[0]
    for i in range(1, len(close)):
        avg_gain[i] = alpha * gain[i] + (1.0 - alpha) * avg_gain[i - 1]
        avg_loss[i] = alpha * loss[i] + (1.0 - alpha) * avg_loss[i - 1]
    result = np.full(len(close), 100.0)
    positive = avg_loss > 0.0
    result[positive] = 100.0 - 100.0 / (
        1.0 + avg_gain[positive] / avg_loss[positive]
    )
    return result


def filter_buy_signals(
    signals: np.ndarray, rsi_values: np.ndarray, threshold: float
) -> np.ndarray:
    """Drop buys with RSI >= threshold, Projekt_1.pdf p. 7, 5.1."""
    filtered = signals.copy()
    filtered[(signals == 1) & (rsi_values >= threshold)] = 0
    return filtered
