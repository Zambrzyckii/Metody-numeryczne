"""Experiment charts X1-X4, Projekt_1.pdf p. 7-8, 4.5 and 5.2."""
import numpy as np
from matplotlib import ticker
from matplotlib.figure import Figure
from matplotlib.legend_handler import HandlerTuple
from matplotlib.lines import Line2D

import config
import data
import rsi
import style
from charts import date_axis, marker_style, new_figure, save
from export import format_date

HIST_RANGE_PCT = (-30.0, 50.0)
HIST_STEP_PCT = 2.5
DELTA_RANGE_PP = (-70.0, 35.0)
BAR_WIDTH = 0.8


def _num(value: float, decimals: int = 2) -> str:
    """Decimal comma, no-break space and U+2212, as the tick labels."""
    text = f"{abs(value):.{decimals}f}"
    whole, _, fraction = text.partition(".")
    if len(whole) >= 5:
        whole = f"{int(whole):,}".replace(",", "\u00a0")
    result = f"{whole},{fraction}" if fraction else whole
    if value < 0 and float(text) != 0.0:
        result = "−" + result
    return result


def _note(label: str) -> Line2D:
    """Legend entry without a symbol, for a note that has no mark."""
    return Line2D([], [], linestyle="none", label=label)


def _figure_legend(
    fig: Figure, handles: list, ncol: int, labels: list[str] | None = None
) -> None:
    """One figure legend below the plot, as in charts.py."""
    fig.legend(
        handles=handles,
        labels=labels,
        loc="outside lower center",
        ncol=ncol,
        handler_map={tuple: HandlerTuple(ndivide=None)},
    )


def chart_x1(numbers: dict) -> Figure:
    """X1 return change per instrument, Projekt_1.pdf p. 8, 5.2."""
    agg = numbers["aggregates"]
    tolerance = numbers["same_tolerance_pp"]
    delta = np.sort([r["delta_pp"] for r in numbers["instruments"]])
    position = np.arange(len(delta))
    fig = new_figure(style.FULL_SIZE_MM)
    ax = fig.subplots()
    handles = []
    for mask, color, label in (
        (
            delta > tolerance,
            style.BUY_LIGHT,
            f"R wzrosło (n = {agg['helped_count']})",
        ),
        (
            delta < -tolerance,
            style.SELL_LIGHT,
            f"R spadło (n = {agg['hurt_count']})",
        ),
    ):
        handles.append(
            ax.bar(
                position[mask],
                delta[mask],
                width=BAR_WIDTH,
                linewidth=0,
                color=color,
                label=label,
            )
        )
    ax.axhline(0.0, color=style.TEXT, linewidth=0.6)
    for key, word, line_style, color in (
        ("mean_delta_pp", "Średnia", "--", style.PRIMARY),
        ("median_delta_pp", "Mediana", ":", style.MUTED),
    ):
        handles.append(
            ax.axhline(
                agg[key],
                color=color,
                linestyle=line_style,
                label=f"{word} = {_num(agg[key])} pp",
            )
        )
    handles.append(_note(f"Bez zmiany (n = {agg['same_count']}), brak słupka"))
    low, high = DELTA_RANGE_PP
    ax.set_ylim(low, high)
    outside = [value for value in delta if value < low or value > high]
    if outside:
        ax.text(
            0.05,
            0.03,
            "Poza zakresem osi: "
            + ", ".join(f"{_num(value)} pp" for value in outside),
            transform=ax.transAxes,
            color=style.MUTED,
        )
    ax.set_xlim(-1, len(delta))
    ax.set_xticks([])
    ax.grid(False, axis="x")
    ax.set_title(
        f"X1 · {agg['count']} spółek Nasdaq"
        " - zmiana stopy zwrotu po filtrze RSI"
    )
    ax.set_xlabel(
        f"Spółki posortowane według zmiany R (n = {agg['count']})"
    )
    ax.set_ylabel("Zmiana R [pp]")
    style.decimal_comma(ax.yaxis)
    _figure_legend(fig, handles, 3)
    return fig


def chart_x2(numbers: dict) -> Figure:
    """X2 returns of all and of blocked trades, Projekt_1.pdf p. 8, 5.2."""
    agg = numbers["aggregates"]
    low, high = HIST_RANGE_PCT
    edges = np.arange(low, high + HIST_STEP_PCT / 2, HIST_STEP_PCT)
    samples = (
        (
            "Wszystkie transakcje algorytmu podstawowego",
            [
                x
                for r in numbers["instruments"]
                for x in r["basic_trade_returns"]
            ],
            agg["basic_closed_count"],
            agg["basic_losing_share_pct"],
            style.PRIMARY,
        ),
        (
            "Transakcje zablokowane przez filtr RSI",
            [
                t["return_pct"]
                for r in numbers["instruments"]
                for t in r["blocked_trades"]
            ],
            agg["blocked_count"],
            agg["blocked_losing_share_pct"],
            style.SIGNAL_LINE,
        ),
    )
    fig = new_figure(style.FULL_SIZE_MM)
    ax = fig.subplots()
    for name, values, count, losing_share, color in samples:
        counts, _ = np.histogram(np.clip(values, low, high), bins=edges)
        ax.stairs(
            100.0 * counts / len(values),
            edges,
            color=color,
            label=(
                f"{name} (n = {count}, stratnych"
                f" {_num(losing_share)} %)"
            ),
        )
    ax.axvline(
        0.0, color=style.MUTED, linestyle="--", linewidth=1.0, label="r = 0"
    )
    ax.set_xlim(low, high)
    ax.set_title(
        f"X2 · {agg['count']} spółek Nasdaq"
        " - stopa zwrotu transakcji zablokowanych i wszystkich"
    )
    ax.set_xlabel(
        "Stopa zwrotu transakcji r [%], wartości spoza zakresu"
        " w skrajnych przedziałach"
    )
    ax.set_ylabel("Udział transakcji [%]")
    style.decimal_comma(ax.xaxis)
    style.decimal_comma(ax.yaxis)
    handles, _ = ax.get_legend_handles_labels()
    _figure_legend(fig, handles, 1)
    return fig


def _example_figure(chart_id: str, example: dict, numbers: dict) -> Figure:
    """Price and RSI around a trade blocked by the filter, p. 8, 5.2."""
    period = numbers["rsi_period"]
    threshold = numbers["rsi_threshold"]
    prices = data.load_prices(
        config.EXPERIMENT_DATA_DIR / f"{example['ticker']}.csv"
    )
    rsi_values = rsi.rsi(prices.close, period)
    first = max(example["buy_signal_index"] - config.D1_MARGIN, 0)
    last = min(
        example["sell_execution_index"] + config.D1_MARGIN, prices.length - 1
    )
    window = slice(first, last + 1)
    dates = prices.dates
    signal = example["buy_signal_index"]
    buy = example["buy_execution_index"]
    sell = example["sell_execution_index"]

    fig = new_figure(style.PAIR_SIZE_MM)
    ax_price, ax_rsi = fig.subplots(2, 1, sharex=True)
    (price_line,) = ax_price.plot(
        dates[window],
        prices.close[window],
        color=style.PRICE,
        linewidth=1.2,
        label="Cena zamknięcia",
    )
    signal_style = marker_style("buy", executed=False)
    signal_label = "Sygnał kupna pominięty przez alg. zmodyfikowany"
    signal_handle = Line2D([], [], label=signal_label, **signal_style)
    ax_price.plot([dates[signal]], [prices.close[signal]], **signal_style)
    buy_style = marker_style("buy")
    ax_price.plot([dates[buy]], [example["buy_price"]], **buy_style)
    buy_label = (
        f"Kupno {format_date(dates[buy])}, wykonane przez alg. podstawowy"
    )
    sell_signal = example["sell_signal_index"]
    sell_signal_style = marker_style("sell", executed=False)
    sell_style = marker_style("sell")
    ax_price.plot(
        [dates[sell_signal]], [prices.close[sell_signal]], **sell_signal_style
    )
    ax_price.plot([dates[sell]], [example["sell_price"]], **sell_style)
    signal_day = format_date(dates[sell_signal])
    if dates[sell_signal].astype("datetime64[Y]") == dates[sell].astype(
        "datetime64[Y]"
    ):
        signal_day = signal_day[:5]
    sell_label = (
        f"Sprzedaż: sygnał {signal_day}, wykonanie"
        f" {format_date(dates[sell])}, r = {_num(example['return_pct'])} %"
    )
    buy_handle = Line2D([], [], label=buy_label, **buy_style)
    sell_handle = (
        Line2D([], [], **sell_signal_style),
        Line2D([], [], **sell_style),
    )
    ax_price.set_title(
        f"{chart_id} · {example['ticker']} - cena zamknięcia, kupno"
        f" zablokowane przy RSI {_num(example['rsi_at_signal'])}"
    )
    ax_price.margins(y=0.15)
    ax_price.yaxis.set_major_locator(ticker.MaxNLocator(nbins=4))
    ax_price.set_ylabel("Cena [USD]")
    style.decimal_comma(ax_price.yaxis)

    (rsi_line,) = ax_rsi.plot(
        dates[window],
        rsi_values[window],
        color=style.SIGNAL_LINE,
        label=f"RSI({period})",
    )
    threshold_line = ax_rsi.axhline(
        threshold,
        color=style.SELL,
        linestyle="--",
        linewidth=1.0,
        label=f"Próg {_num(threshold, 0)}",
    )
    ax_rsi.plot([dates[signal]], [rsi_values[signal]], **signal_style)
    ax_rsi.set_title(f"RSI({period}) i próg {_num(threshold, 0)}")
    ax_rsi.yaxis.set_major_locator(ticker.MaxNLocator(nbins=4))
    ax_rsi.set_ylabel("RSI [pkt]")
    ax_rsi.set_xlabel("Data")
    style.decimal_comma(ax_rsi.yaxis)
    date_axis(ax_rsi, dates[first], dates[last])
    labeled = [price_line, rsi_line, threshold_line, signal_handle, buy_handle]
    _figure_legend(
        fig,
        [*labeled, sell_handle],
        2,
        [handle.get_label() for handle in labeled] + [sell_label],
    )
    return fig


def chart_x3(numbers: dict) -> Figure:
    """X3 example where the filter helped, Projekt_1.pdf p. 8, 5.2."""
    return _example_figure("X3", numbers["help_example"], numbers)


def chart_x4(numbers: dict) -> Figure:
    """X4 example where the filter hurt, Projekt_1.pdf p. 8, 5.2."""
    return _example_figure("X4", numbers["hurt_example"], numbers)


def write_all(numbers: dict) -> list[str]:
    """Save X1-X4 to charts/, Projekt_1.pdf p. 7-8, 4.5 and 5.2."""
    style.apply()
    builders = {
        "X1": chart_x1,
        "X2": chart_x2,
        "X3": chart_x3,
        "X4": chart_x4,
    }
    for name, build in builders.items():
        save(build(numbers), name)
    return [f"charts/{name}.pdf" for name in builders]
