"""Basic-part entry point, docs/requirements-code.md B.2 and B.5."""
import sys

import config
import data
import export
import macd
import simulation
import stats


def build_numbers(
    result: simulation.SimulationResult, summary: stats.Summary
) -> dict:
    """JSON payload with every unrounded number, docs B.5 and A.5."""
    pairs = simulation.closed_trades(result.trades)
    if not pairs:
        raise ValueError(
            "no closed trade in the data (Projekt_1.pdf p. 5, 3.4)"
        )
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


def build_macros(numbers: dict) -> dict[str, str]:
    """LaTeX macros for slide F, docs/requirements-code.md B.5."""
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
    }


def main() -> int:
    """Run the basic part end to end, docs/requirements-code.md B.2."""
    prices = data.load_prices(config.DATA_FILE)
    _, _, hist = macd.compute_macd(prices.close, config.MACD_PARAMS)
    signals = macd.detect_signals(hist)
    result = simulation.simulate(prices.close, signals)
    summary = stats.summarize(result)
    numbers = build_numbers(result, summary)
    macros = build_macros(numbers)
    export.write_results("basic", numbers, macros)

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
    return 0


if __name__ == "__main__":
    sys.exit(main())
