"""Basic-part entry point, docs/requirements-code.md B.2 and B.5."""
import sys

import numpy as np

import charts
import config
import data
import export
import macd
import simulation
import stats
import style


def select_d1_trade(
    pairs: list[tuple[simulation.Trade, simulation.Trade]]
) -> tuple[simulation.Trade, simulation.Trade]:
    """Trade with the largest r (earliest on ties), Projekt_1.pdf p. 6, D1."""
    best = pairs[0]
    for pair in pairs[1:]:
        if stats.trade_return_pct(
            pair[0].price, pair[1].price
        ) > stats.trade_return_pct(best[0].price, best[1].price):
            best = pair
    return best


def build_numbers(
    prices: data.PriceSeries,
    signals: np.ndarray,
    result: simulation.SimulationResult,
    summary: stats.Summary,
) -> dict:
    """JSON payload with every unrounded number, docs B.5 and A.5."""
    pairs = simulation.closed_trades(result.trades)
    if not pairs:
        raise ValueError(
            "no closed trade in the data (Projekt_1.pdf p. 5, 3.4)"
        )
    buy, sell = select_d1_trade(pairs)
    _, _, executed_flags = stats.considered_signals(signals, result)
    signal_count = len(executed_flags)
    executed_count = int(executed_flags.sum())
    start = config.START_INDEX
    return {
        "initial_cash": summary.initial_cash,
        "final_equity": summary.final_equity,
        "profit": summary.profit,
        "portfolio_return_pct": summary.portfolio_return_pct,
        "closed_count": len(pairs),
        "profitable_count": summary.profitable_count,
        "losing_count": summary.losing_count,
        "win_rate_pct": summary.win_rate_pct,
        "max_loss_pct": summary.max_loss_pct,
        "max_gain_pct": summary.max_gain_pct,
        "open_qty": summary.open_qty,
        "open_value": summary.open_value,
        "open_trade": (
            {
                "signal_index": summary.open_trade.signal_index,
                "execution_index": summary.open_trade.execution_index,
                "price": summary.open_trade.price,
            }
            if summary.open_trade
            else None
        ),
        "sample_count": len(result.cash),
        "execution_count": len(result.trades),
        "data_start_date": str(prices.dates[0]),
        "data_end_date": str(prices.dates[-1]),
        "buy_hold_return_pct": stats.portfolio_return_pct(
            simulation.INITIAL_UNITS * prices.close[start],
            simulation.INITIAL_UNITS * prices.close[-1],
        ),
        "signal_count": signal_count,
        "executed_signal_count": executed_count,
        "skipped_signal_count": signal_count - executed_count,
        "time_in_market_pct": stats.time_in_market_pct(result.position_qty),
        "mean_win_sessions": stats.mean_holding_sessions(pairs, True),
        "mean_loss_sessions": stats.mean_holding_sessions(pairs, False),
        "mean_win_pct": stats.mean_return_pct(pairs, True),
        "mean_loss_pct": stats.mean_return_pct(pairs, False),
        "d1_trade": {
            "buy_signal_index": buy.signal_index,
            "buy_signal_date": str(prices.dates[buy.signal_index]),
            "buy_execution_index": buy.execution_index,
            "buy_execution_date": str(prices.dates[buy.execution_index]),
            "buy_price": buy.price,
            "sell_signal_index": sell.signal_index,
            "sell_signal_date": str(prices.dates[sell.signal_index]),
            "sell_execution_index": sell.execution_index,
            "sell_execution_date": str(prices.dates[sell.execution_index]),
            "sell_price": sell.price,
            "return_pct": stats.trade_return_pct(buy.price, sell.price),
            "sessions": sell.execution_index - buy.execution_index,
        },
        "closed_trades": [
            {
                "buy_signal_index": buy.signal_index,
                "buy_execution_index": buy.execution_index,
                "buy_price": buy.price,
                "sell_signal_index": sell.signal_index,
                "sell_execution_index": sell.execution_index,
                "sell_price": sell.price,
                "return_pct": stats.trade_return_pct(
                    buy.price, sell.price
                ),
            }
            for buy, sell in pairs
        ],
    }


def _date_text(iso_date: str) -> str:
    """ISO date as DD.MM.YYYY for the slides."""
    return export.format_date(np.datetime64(iso_date))


def build_macros(numbers: dict) -> dict[str, str]:
    """LaTeX macros for slides D, E and F, docs/requirements-code.md B.5."""
    trade = numbers["d1_trade"]
    return {
        "InitialCapital": export.format_number(numbers["initial_cash"]),
        "FinalEquity": export.format_number(numbers["final_equity"]),
        "ProfitAmount": export.format_number(numbers["profit"]),
        "ReturnPct": export.format_number(numbers["portfolio_return_pct"]),
        "ClosedCount": export.format_number(numbers["closed_count"], 0),
        "ProfitableCount": export.format_number(
            numbers["profitable_count"], 0
        ),
        "LosingCount": export.format_number(numbers["losing_count"], 0),
        "WinRatePct": export.format_optional(numbers["win_rate_pct"]),
        "MaxLossPct": export.format_optional(numbers["max_loss_pct"]),
        "MaxGainPct": export.format_optional(numbers["max_gain_pct"]),
        "OpenQty": export.format_optional(numbers["open_qty"]),
        "OpenValue": export.format_optional(numbers["open_value"]),
        "SampleCount": export.format_number(numbers["sample_count"], 0),
        "DataStartDate": _date_text(numbers["data_start_date"]),
        "DataEndDate": _date_text(numbers["data_end_date"]),
        "TradeBuySignalDate": _date_text(trade["buy_signal_date"]),
        "TradeBuyDate": _date_text(trade["buy_execution_date"]),
        "TradeBuyPrice": export.format_number(trade["buy_price"]),
        "TradeSellSignalDate": _date_text(trade["sell_signal_date"]),
        "TradeSellDate": _date_text(trade["sell_execution_date"]),
        "TradeSellPrice": export.format_number(trade["sell_price"]),
        "TradeReturnPct": export.format_number(trade["return_pct"]),
        "TradeSessions": export.format_number(trade["sessions"], 0),
        "SignalCount": export.format_number(numbers["signal_count"], 0),
        "ExecutedSignalCount": export.format_number(
            numbers["executed_signal_count"], 0
        ),
        "SkippedSignalCount": export.format_number(
            numbers["skipped_signal_count"], 0
        ),
        "BuyHoldReturnPct": export.format_number(
            numbers["buy_hold_return_pct"]
        ),
        "TimeInMarketPct": export.format_number(
            numbers["time_in_market_pct"]
        ),
        "MeanWinSessions": export.format_optional(
            numbers["mean_win_sessions"], 1
        ),
        "MeanLossSessions": export.format_optional(
            numbers["mean_loss_sessions"], 1
        ),
        "MeanWinPct": export.format_optional(numbers["mean_win_pct"]),
        "MeanLossPct": export.format_optional(numbers["mean_loss_pct"]),
    }


def write_charts(
    prices: data.PriceSeries,
    macd_line: np.ndarray,
    signal_line: np.ndarray,
    hist: np.ndarray,
    signals: np.ndarray,
    result: simulation.SimulationResult,
) -> list[str]:
    """Save charts A1-E2 as vector PDFs, docs/requirements-charts.md."""
    style.apply()
    buy, sell = select_d1_trade(simulation.closed_trades(result.trades))
    figures = {
        "A1": charts.chart_a1(prices),
        "B1": charts.chart_b1(prices, macd_line, signal_line),
        "C1_C2": charts.chart_c1_c2(
            prices, macd_line, signal_line, hist, signals, result
        ),
        "D1": charts.chart_d1(prices, macd_line, signal_line, buy, sell),
        "E1_E2": charts.chart_e1_e2(prices, signals, result),
    }
    return [str(charts.save(fig, name)) for name, fig in figures.items()]


def main() -> int:
    """Run the basic part end to end, docs/requirements-code.md B.2."""
    prices = data.load_prices(config.DATA_FILE)
    macd_line, signal_line, hist = macd.compute_macd(
        prices.close, config.MACD_PARAMS
    )
    signals = macd.detect_signals(hist)
    result = simulation.simulate(prices.close, signals)
    summary = stats.summarize(result)
    numbers = build_numbers(prices, signals, result, summary)
    macros = build_macros(numbers)
    export.write_results("basic", numbers, macros)
    chart_files = write_charts(
        prices, macd_line, signal_line, hist, signals, result
    )

    print(f"initial cash C_100: {summary.initial_cash}")
    print(f"final equity V_(L-1): {summary.final_equity}")
    print(f"portfolio return R: {summary.portfolio_return_pct} %")
    print(
        f"closed trades: {numbers['closed_count']}"
        f" ({summary.profitable_count} profitable,"
        f" {summary.losing_count} losing)"
    )
    print(f"open position at the end: {summary.open_trade is not None}")
    print("written: results/basic.json, results/basic.tex")
    for chart_file in chart_files:
        print(f"written: {chart_file}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
