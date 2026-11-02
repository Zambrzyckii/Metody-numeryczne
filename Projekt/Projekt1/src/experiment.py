"""Experiment entry point, RSI filter on MACD, Projekt_1.pdf p. 7-8, 5."""
import math
import sys
from pathlib import Path

import numpy as np

import config
import data
import export
import macd
import rsi
import simulation
import stats

RSI_PERIOD = 14
RSI_OVERBOUGHT = 70.0
SAME_TOLERANCE_PP = 1e-9
IDENTITY_REL_TOL = 1e-9
EXAMPLE_RULE = (
    "Instruments with exactly one blocked closed trade. Help is the largest"
    " delta_pp, hurt the smallest, ties by ticker."
)


def list_csv_files(directory: Path) -> list[Path]:
    """Sorted CSV files of the shared dataset, Projekt_1.pdf p. 8, 5.2."""
    files = sorted(directory.glob("*.csv")) if directory.is_dir() else []
    if not files:
        raise ValueError(
            f"no CSV files in '{directory}', set MN_DATA_DIR to the"
            " directory with the shared dataset (Projekt_1.pdf p. 8, 5.2)"
        )
    return files


def _algorithm_record(
    result: simulation.SimulationResult,
    pairs: list[tuple[simulation.Trade, simulation.Trade]],
) -> dict:
    """Per-instrument metrics of one algorithm, Projekt_1.pdf p. 5, 3.4."""
    summary = stats.summarize(result)
    return {
        "return_pct": summary.portfolio_return_pct,
        "closed_count": len(pairs),
        "profitable_count": summary.profitable_count,
        "losing_count": summary.losing_count,
        "win_rate_pct": summary.win_rate_pct,
        "max_loss_pct": summary.max_loss_pct,
        "max_gain_pct": summary.max_gain_pct,
        "open_position": summary.open_trade is not None,
    }


def _blocked_trade(
    ticker: str,
    prices: data.PriceSeries,
    rsi_values: np.ndarray,
    buy: simulation.Trade,
    sell: simulation.Trade,
) -> dict:
    """Closed basic trade whose buy signal the filter dropped."""
    return {
        "ticker": ticker,
        "buy_signal_index": buy.signal_index,
        "buy_signal_date": str(prices.dates[buy.signal_index]),
        "rsi_at_signal": float(rsi_values[buy.signal_index]),
        "buy_execution_index": buy.execution_index,
        "buy_execution_date": str(prices.dates[buy.execution_index]),
        "buy_price": buy.price,
        "sell_signal_index": sell.signal_index,
        "sell_execution_index": sell.execution_index,
        "sell_execution_date": str(prices.dates[sell.execution_index]),
        "sell_price": sell.price,
        "return_pct": stats.trade_return_pct(buy.price, sell.price),
    }


def analyze_instrument(ticker: str, prices: data.PriceSeries) -> dict:
    """Basic and RSI-filtered run on one price vector, p. 8, 5.2."""
    close = prices.close
    _, _, hist = macd.compute_macd(close, config.MACD_PARAMS)
    signals = macd.detect_signals(hist)
    rsi_values = rsi.rsi(close, RSI_PERIOD)
    filtered = rsi.filter_buy_signals(signals, rsi_values, RSI_OVERBOUGHT)
    dropped = (signals == 1) & (filtered == 0)

    basic = simulation.simulate(close, signals)
    modified = simulation.simulate(close, filtered)
    basic_pairs = simulation.closed_trades(basic.trades)
    modified_pairs = simulation.closed_trades(modified.trades)

    kept = [p for p in basic_pairs if not dropped[p[0].signal_index]]
    blocked = [p for p in basic_pairs if dropped[p[0].signal_index]]
    blocked_executed = sum(
        1
        for t in basic.trades
        if t.side == "buy" and dropped[t.signal_index]
    )
    basic_record = _algorithm_record(basic, basic_pairs)
    modified_record = _algorithm_record(modified, modified_pairs)
    start = config.START_INDEX
    return {
        "ticker": ticker,
        "basic": basic_record,
        "modified": modified_record,
        "delta_pp": modified_record["return_pct"]
        - basic_record["return_pct"],
        "buy_and_hold_pct": 100.0 * (close[-1] / close[start] - 1.0),
        "dropped_buy_signals": int(dropped[start + 1:].sum()),
        "blocked_executed_buys": blocked_executed,
        "blocked_closed_count": len(blocked),
        "basic_trade_returns": stats.trade_returns(basic_pairs),
        "identity_holds": kept == modified_pairs
        and blocked_executed == len(blocked),
        "blocked_trades": [
            _blocked_trade(ticker, prices, rsi_values, buy, sell)
            for buy, sell in blocked
        ],
    }


def _mean_or_none(values: list[float]) -> float | None:
    return float(np.mean(values)) if values else None


def _share_pct(profitable: int, closed: int) -> float | None:
    return 100.0 * profitable / closed if closed else None


def aggregate(records: list[dict]) -> dict:
    """Global result over all instruments, Projekt_1.pdf p. 8, 5.2."""
    basic = np.array([r["basic"]["return_pct"] for r in records])
    modified = np.array([r["modified"]["return_pct"] for r in records])
    delta = np.array([r["delta_pp"] for r in records])
    hold = np.array([r["buy_and_hold_pct"] for r in records])
    blocked = [t for r in records for t in r["blocked_trades"]]
    blocked_r = [t["return_pct"] for t in blocked]
    all_r = [x for r in records for x in r["basic_trade_returns"]]
    numbers = {
        "count": len(records),
        "mean_basic_pct": float(basic.mean()),
        "median_basic_pct": float(np.median(basic)),
        "mean_modified_pct": float(modified.mean()),
        "median_modified_pct": float(np.median(modified)),
        "mean_delta_pp": float(delta.mean()),
        "median_delta_pp": float(np.median(delta)),
        "mean_hold_pct": float(hold.mean()),
        "median_hold_pct": float(np.median(hold)),
        "helped_count": int((delta > SAME_TOLERANCE_PP).sum()),
        "hurt_count": int((delta < -SAME_TOLERANCE_PP).sum()),
        "same_count": int((np.abs(delta) <= SAME_TOLERANCE_PP).sum()),
        "dropped_signal_count": sum(
            r["dropped_buy_signals"] for r in records
        ),
        "blocked_executed_count": sum(
            r["blocked_executed_buys"] for r in records
        ),
        "blocked_count": len(blocked),
        "blocked_losing_count": sum(1 for x in blocked_r if x < 0.0),
        "blocked_profitable_count": sum(1 for x in blocked_r if x >= 0.0),
        "single_blocked_count": sum(
            1 for r in records if r["blocked_closed_count"] == 1
        ),
        "blocked_mean_pct": _mean_or_none(blocked_r),
        "all_trades_mean_pct": _mean_or_none(all_r),
        "identity_failure_count": sum(
            1 for r in records if not r["identity_holds"]
        ),
    }
    for name in ("basic", "modified"):
        closed = sum(r[name]["closed_count"] for r in records)
        profitable = sum(r[name]["profitable_count"] for r in records)
        losses = [
            r[name]["max_loss_pct"]
            for r in records
            if r[name]["max_loss_pct"] is not None
        ]
        numbers[f"{name}_closed_count"] = closed
        numbers[f"{name}_profitable_count"] = profitable
        numbers[f"{name}_losing_count"] = sum(
            r[name]["losing_count"] for r in records
        )
        numbers[f"{name}_win_rate_pct"] = _share_pct(
            profitable, closed
        )
        numbers[f"{name}_mean_max_loss_pct"] = _mean_or_none(losses)
    numbers["changed_count"] = (
        numbers["helped_count"] + numbers["hurt_count"]
    )
    numbers["blocked_losing_share_pct"] = _share_pct(
        numbers["blocked_losing_count"], numbers["blocked_count"]
    )
    numbers["basic_losing_share_pct"] = _share_pct(
        numbers["basic_losing_count"], numbers["basic_closed_count"]
    )
    return numbers


def _single_trade_example(record: dict) -> dict:
    """Example from an instrument with one blocked trade, p. 8, 5.2."""
    trade = record["blocked_trades"][0]
    basic_factor = 1.0 + record["basic"]["return_pct"] / 100.0
    trade_factor = 1.0 + trade["return_pct"] / 100.0
    expected_pct = 100.0 * (basic_factor / trade_factor - 1.0)
    modified_pct = record["modified"]["return_pct"]
    if not math.isclose(
        1.0 + expected_pct / 100.0,
        1.0 + modified_pct / 100.0,
        rel_tol=IDENTITY_REL_TOL,
    ):
        raise ValueError(
            f"single blocked trade identity fails for {record['ticker']}"
        )
    return {
        **trade,
        "basic_return_pct": record["basic"]["return_pct"],
        "modified_return_pct": modified_pct,
        "delta_pp": record["delta_pp"],
        "identity_expected_modified_pct": expected_pct,
        "identity_residual_pp": expected_pct - modified_pct,
    }


def pick_examples(records: list[dict]) -> tuple[dict, dict]:
    """Help and hurt example, Projekt_1.pdf p. 8, 5.2."""
    candidates = [
        r
        for r in records
        if r["blocked_closed_count"] == 1
        and r["blocked_executed_buys"] == 1
    ]
    if not candidates:
        raise ValueError("no instrument with exactly one blocked trade")
    helped = min(candidates, key=lambda r: (-r["delta_pp"], r["ticker"]))
    hurt = min(candidates, key=lambda r: (r["delta_pp"], r["ticker"]))
    return _single_trade_example(helped), _single_trade_example(hurt)


def _pl_date(iso_date: str) -> str:
    year, month, day = iso_date.split("-")
    return f"{day}.{month}.{year}"


def _latex_text(text: str) -> str:
    return text.replace("_", "\\_")


def _example_macros(prefix: str, example: dict) -> dict[str, str]:
    """Macros of one local example, docs/requirements-code.md B.5."""
    return {
        f"{prefix}Ticker": _latex_text(example["ticker"]),
        f"{prefix}SignalDate": _pl_date(example["buy_signal_date"]),
        f"{prefix}Rsi": export.format_number(example["rsi_at_signal"]),
        f"{prefix}BuyDate": _pl_date(example["buy_execution_date"]),
        f"{prefix}BuyPrice": export.format_number(example["buy_price"]),
        f"{prefix}SellDate": _pl_date(example["sell_execution_date"]),
        f"{prefix}SellPrice": export.format_number(
            example["sell_price"]
        ),
        f"{prefix}ReturnPct": export.format_number(
            example["return_pct"]
        ),
        f"{prefix}BasicPct": export.format_number(
            example["basic_return_pct"]
        ),
        f"{prefix}ModifiedPct": export.format_number(
            example["modified_return_pct"]
        ),
        f"{prefix}DeltaPp": export.format_number(example["delta_pp"]),
    }


def build_macros(numbers: dict) -> dict[str, str]:
    """LaTeX macros of the experiment, docs/requirements-code.md B.5."""
    agg = numbers["aggregates"]
    integers = {
        "Count": "count",
        "HelpedCount": "helped_count",
        "HurtCount": "hurt_count",
        "SameCount": "same_count",
        "BasicClosedCount": "basic_closed_count",
        "ModifiedClosedCount": "modified_closed_count",
        "BasicProfitableCount": "basic_profitable_count",
        "ModifiedProfitableCount": "modified_profitable_count",
        "BasicLosingCount": "basic_losing_count",
        "ModifiedLosingCount": "modified_losing_count",
        "DroppedSignalCount": "dropped_signal_count",
        "BlockedExecutedCount": "blocked_executed_count",
        "BlockedCount": "blocked_count",
        "BlockedLosingCount": "blocked_losing_count",
        "BlockedProfitableCount": "blocked_profitable_count",
        "IdentityFailureCount": "identity_failure_count",
        "SingleBlockedCount": "single_blocked_count",
        "ChangedCount": "changed_count",
    }
    decimals = {
        "MeanBasicPct": "mean_basic_pct",
        "MedianBasicPct": "median_basic_pct",
        "MeanModifiedPct": "mean_modified_pct",
        "MedianModifiedPct": "median_modified_pct",
        "MeanDeltaPp": "mean_delta_pp",
        "MedianDeltaPp": "median_delta_pp",
        "MeanHoldPct": "mean_hold_pct",
        "MedianHoldPct": "median_hold_pct",
        "BasicWinRatePct": "basic_win_rate_pct",
        "ModifiedWinRatePct": "modified_win_rate_pct",
        "BasicMeanMaxLossPct": "basic_mean_max_loss_pct",
        "ModifiedMeanMaxLossPct": "modified_mean_max_loss_pct",
        "BlockedLosingSharePct": "blocked_losing_share_pct",
        "BasicLosingSharePct": "basic_losing_share_pct",
        "BlockedMeanPct": "blocked_mean_pct",
        "AllTradesMeanPct": "all_trades_mean_pct",
    }
    macros = {
        "RsiPeriod": export.format_number(numbers["rsi_period"], 0),
        "RsiThreshold": export.format_number(numbers["rsi_threshold"], 0),
    }
    for name, key in integers.items():
        macros[name] = export.format_number(agg[key], 0)
    for name, key in decimals.items():
        macros[name] = export.format_optional(agg[key])
    macros.update(_example_macros("Help", numbers["help_example"]))
    macros.update(_example_macros("Hurt", numbers["hurt_example"]))
    return {f"Exp{name}": text for name, text in macros.items()}


def main() -> int:
    """Run the experiment end to end, Projekt_1.pdf p. 7-8, 5."""
    records = []
    for path in list_csv_files(config.EXPERIMENT_DATA_DIR):
        prices = data.load_prices(path)
        records.append(analyze_instrument(path.stem, prices))
    help_example, hurt_example = pick_examples(records)
    numbers = {
        "rsi_period": RSI_PERIOD,
        "rsi_threshold": RSI_OVERBOUGHT,
        "same_tolerance_pp": SAME_TOLERANCE_PP,
        "example_rule": EXAMPLE_RULE,
        "aggregates": aggregate(records),
        "help_example": help_example,
        "hurt_example": hurt_example,
        "instruments": records,
    }
    export.write_results("experiment", numbers, build_macros(numbers))

    agg = numbers["aggregates"]
    print(f"instruments: {agg['count']}")
    print(
        f"delta R mean: {agg['mean_delta_pp']:.2f} pp,"
        f" median: {agg['median_delta_pp']:.2f} pp"
    )
    print(
        f"helped: {agg['helped_count']}, hurt: {agg['hurt_count']},"
        f" same: {agg['same_count']}"
    )
    print(
        f"blocked trades: {agg['blocked_count']}"
        f" ({agg['blocked_losing_count']} losing,"
        f" {agg['blocked_profitable_count']} profitable)"
    )
    print(f"identity failures: {agg['identity_failure_count']}")
    print("written: results/experiment.json, results/experiment.tex")
    return 0


if __name__ == "__main__":
    sys.exit(main())
