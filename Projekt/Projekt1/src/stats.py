"""Returns and summary statistics, per docs/requirements-code.md A.5."""
from dataclasses import dataclass

import numpy as np

import config
import simulation


@dataclass(frozen=True)
class Summary:
    """The seven summary items of slide F, Projekt_1.pdf p. 7, 4.4."""

    initial_cash: float
    final_equity: float
    profit: float
    portfolio_return_pct: float
    profitable_count: int
    losing_count: int
    win_rate_pct: float | None
    max_loss_pct: float | None
    max_gain_pct: float | None
    open_trade: simulation.Trade | None
    open_qty: float | None
    open_value: float | None


def portfolio_return_pct(initial_cash: float, final_equity: float) -> float:
    """Portfolio return R per formula (6), Projekt_1.pdf p. 5."""
    return 100.0 * (final_equity / initial_cash - 1.0)


def trade_return_pct(buy_price: float, sell_price: float) -> float:
    """Closed-trade return r per formula (7), Projekt_1.pdf p. 5."""
    return 100.0 * (sell_price / buy_price - 1.0)


def trade_returns(
    pairs: list[tuple[simulation.Trade, simulation.Trade]]
) -> list[float]:
    """Return r of every closed trade per formula (7)."""
    return [trade_return_pct(buy.price, sell.price) for buy, sell in pairs]


def summarize(
    result: simulation.SimulationResult,
    start_index: int = config.START_INDEX,
) -> Summary:
    """Summary items 1-7 of slide F, Projekt_1.pdf p. 7, 4.4."""
    initial_cash = float(result.cash[start_index])
    final_equity = float(result.equity[-1])
    returns = trade_returns(simulation.closed_trades(result.trades))
    gains = [r for r in returns if r >= 0.0]
    losses = [-r for r in returns if r < 0.0]
    open_trade = simulation.open_position(result.trades)
    return Summary(
        initial_cash=initial_cash,
        final_equity=final_equity,
        profit=final_equity - initial_cash,
        portfolio_return_pct=portfolio_return_pct(
            initial_cash, final_equity
        ),
        profitable_count=len(gains),
        losing_count=len(losses),
        win_rate_pct=100.0 * len(gains) / len(returns) if returns else None,
        max_loss_pct=max(losses) if losses else None,
        max_gain_pct=max(gains) if gains else None,
        open_trade=open_trade,
        open_qty=(
            float(result.position_qty[-1]) if open_trade else None
        ),
        open_value=(
            float(result.equity[-1]) if open_trade else None
        ),
    )


def considered_signals(
    signals: np.ndarray,
    result: simulation.SimulationResult,
    start_index: int = config.START_INDEX,
) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    """Signals from sample 101 and whether executed, Projekt_1.pdf p. 6, E1."""
    indices = np.flatnonzero(signals)
    indices = indices[indices > start_index]
    executed_indices = {trade.signal_index for trade in result.trades}
    executed = np.array(
        [int(j) in executed_indices for j in indices], dtype=bool
    )
    return indices, signals[indices], executed


def time_in_market_pct(
    position_qty: np.ndarray, start_index: int = config.START_INDEX
) -> float:
    """Share of sessions 101...L-1 with an open position, in percent."""
    return 100.0 * float(np.mean(position_qty[start_index + 1 :] > 0.0))


def mean_holding_sessions(
    pairs: list[tuple[simulation.Trade, simulation.Trade]],
    profitable: bool,
) -> float | None:
    """Mean sessions held by profitable (r >= 0) or losing closed trades."""
    held = [
        sell.execution_index - buy.execution_index
        for buy, sell in pairs
        if (trade_return_pct(buy.price, sell.price) >= 0.0) == profitable
    ]
    return sum(held) / len(held) if held else None


def mean_return_pct(
    pairs: list[tuple[simulation.Trade, simulation.Trade]],
    profitable: bool,
) -> float | None:
    """Mean r per formula (7) of profitable (r >= 0) or losing trades."""
    chosen = [
        r for r in trade_returns(pairs) if (r >= 0.0) == profitable
    ]
    return sum(chosen) / len(chosen) if chosen else None
