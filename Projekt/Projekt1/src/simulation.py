"""Portfolio simulation, per docs/requirements-code.md A.3, A.4 and B.3."""
from dataclasses import dataclass

import numpy as np

import config

INITIAL_UNITS = 1000.0


@dataclass(frozen=True)
class Trade:
    """One executed transaction, docs/requirements-code.md B.3."""

    signal_index: int
    execution_index: int
    side: str
    price: float


@dataclass(frozen=True)
class SimulationResult:
    """Portfolio vectors and executed trades, Projekt_1.pdf p. 5, 3.3."""

    cash: np.ndarray
    position_qty: np.ndarray
    equity: np.ndarray
    trades: list[Trade]


def _check_state(i: int, cash_i: float, qty_i: float) -> None:
    """Invariants C >= 0 and Q >= 0, docs/requirements-code.md B.3."""
    if cash_i < 0.0 or qty_i < 0.0:
        raise ValueError(f"negative cash or position at i={i}")


def _check_equity(
    equity: np.ndarray,
    cash: np.ndarray,
    position_qty: np.ndarray,
    close: np.ndarray,
    start_index: int,
) -> None:
    """Invariant V_i = C_i + Q_i*x_i per formula (5), Projekt_1.pdf p. 4."""
    i = slice(start_index, None)
    expected = cash[i] + position_qty[i] * close[i]
    if not np.array_equal(equity[i], expected):
        raise ValueError("equity violates formula (5)")


def simulate(
    close: np.ndarray,
    signals: np.ndarray,
    start_index: int = config.START_INDEX,
    delay: int = config.DELAY,
) -> SimulationResult:
    """Five-step simulation algorithm, Projekt_1.pdf p. 5, 3.3."""
    length = len(close)
    cash = np.full(length, np.nan)
    position_qty = np.full(length, np.nan)
    equity = np.full(length, np.nan)

    cash[start_index] = INITIAL_UNITS * close[start_index]
    position_qty[start_index] = 0.0
    equity[start_index] = cash[start_index]
    trades: list[Trade] = []

    for i in range(start_index + 1, length):
        cash[i] = cash[i - 1]
        position_qty[i] = position_qty[i - 1]
        j = i - delay
        if j >= start_index + 1:
            if signals[j] == 1 and cash[i - 1] > 0.0:
                position_qty[i] = cash[i - 1] / close[i]
                cash[i] = 0.0
                trades.append(Trade(j, i, "buy", float(close[i])))
            elif signals[j] == -1 and position_qty[i - 1] > 0.0:
                if trades and trades[-1].side == "sell":
                    raise ValueError(f"sell without a position at i={i}")
                cash[i] = position_qty[i - 1] * close[i]
                position_qty[i] = 0.0
                trades.append(Trade(j, i, "sell", float(close[i])))
        equity[i] = cash[i] + position_qty[i] * close[i]
        _check_state(i, cash[i], position_qty[i])

    _check_equity(equity, cash, position_qty, close, start_index)
    return SimulationResult(cash, position_qty, equity, trades)


def closed_trades(trades: list[Trade]) -> list[tuple[Trade, Trade]]:
    """Buy-sell pairs of closed trades, Projekt_1.pdf p. 5, step 5."""
    pairs = []
    pending_buy = None
    for trade in trades:
        if trade.side == "buy":
            pending_buy = trade
        else:
            if pending_buy is None:
                raise ValueError("sell without a position in trade list")
            pairs.append((pending_buy, trade))
            pending_buy = None
    return pairs


def open_position(trades: list[Trade]) -> Trade | None:
    """Unmatched final buy, open at the end, docs A.5."""
    if trades and trades[-1].side == "buy":
        return trades[-1]
    return None
