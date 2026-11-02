"""Charts A1-E2, docs/requirements-charts.md and presentation-style.md 3.6."""
from pathlib import Path

import matplotlib.dates as mdates
import numpy as np
from matplotlib.axes import Axes
from matplotlib.figure import Figure
from matplotlib.lines import Line2D

import config
import data
import simulation
import stats
import style
from export import format_date

MARKER_SIZE = 6
LEGEND_ANCHOR = (1.01, 1.0)


def _macd_label() -> str:
    """MACD(N1,N2,N3) text from config."""
    n_fast, n_slow, n_signal = config.MACD_PARAMS
    return f"MACD({n_fast},{n_slow},{n_signal})"


def new_figure(size_mm: tuple[float, float]) -> Figure:
    """Figure at the exact final size in millimetres."""
    width, height = size_mm
    return Figure(figsize=(width / 25.4, height / 25.4), layout="constrained")


def date_axis(ax: Axes, first: np.datetime64, last: np.datetime64) -> None:
    """Date ticks as numbers only, independent of the locale."""
    ax.set_xlim(first, last)
    if (last - first).astype(int) > 366:
        ax.xaxis.set_major_locator(mdates.MonthLocator(bymonth=(1, 7)))
        ax.xaxis.set_major_formatter(mdates.DateFormatter("%m.%Y"))
    else:
        ax.xaxis.set_major_locator(
            mdates.AutoDateLocator(minticks=3, maxticks=5)
        )
        ax.xaxis.set_major_formatter(mdates.DateFormatter("%d.%m.%Y"))


def marker_style(side: str, executed: bool = True) -> dict:
    """Buy up-triangle and sell down-triangle, hollow when not executed."""
    color = style.BUY if side == "buy" else style.SELL
    return {
        "linestyle": "none",
        "marker": "^" if side == "buy" else "v",
        "markersize": MARKER_SIZE,
        "color": color,
        "markerfacecolor": color if executed else "white",
        "markeredgewidth": 1.2,
        "clip_on": False,
    }


def _title(chart_id: str, text: str) -> str:
    """Title with the chart ID and the instrument name."""
    return f"{chart_id} · {config.INSTRUMENT_NAME} - {text}"


def _price_label() -> str:
    """Price axis label with the unit."""
    return f"Cena [{config.INSTRUMENT_UNIT}]"


def _legend_right(ax: Axes, handles: list | None = None) -> None:
    """Vertical legend outside the plot, aligned with the top edge."""
    ax.legend(
        handles=handles,
        loc="upper left",
        bbox_to_anchor=LEGEND_ANCHOR,
        borderaxespad=0.0,
        labelspacing=0.25,
    )


def _legend_below(fig: Figure, ax: Axes, extra: list[Axes], ncol: int) -> None:
    """One figure legend below the plot for lines of several axes."""
    handles, labels = [], []
    for each in [ax, *extra]:
        axis_handles, axis_labels = each.get_legend_handles_labels()
        handles += axis_handles
        labels += axis_labels
    fig.legend(handles, labels, loc="outside lower center", ncol=ncol)


def chart_a1(prices: data.PriceSeries) -> Figure:
    """A1 input data, Projekt_1.pdf p. 6, 4.2."""
    dates = prices.dates
    fig = new_figure(style.FULL_SIZE_MM)
    ax = fig.subplots()
    ax.axvspan(
        dates[0],
        dates[config.START_INDEX],
        facecolor=style.GRID,
        edgecolor="none",
        label=f"Próbki 0-{config.START_INDEX} (sygnały nieużywane)",
    )
    ax.plot(dates, prices.close, color=style.PRIMARY, label="Cena zamknięcia")
    ax.set_title(
        _title(
            "A1",
            f"cena zamknięcia, {format_date(dates[0])}"
            f" - {format_date(dates[-1])}",
        )
    )
    ax.set_ylabel(_price_label())
    ax.set_xlabel("Data")
    date_axis(ax, dates[0], dates[-1])
    style.decimal_comma(ax.yaxis)
    _legend_below(fig, ax, [], 2)
    return fig


def _plot_price_and_macd(
    ax: Axes,
    dates: np.ndarray,
    close: np.ndarray,
    macd: np.ndarray,
    signal: np.ndarray,
) -> Axes:
    """Light price on the left axis, MACD and SIGNAL on the right axis."""
    ax.plot(
        dates,
        close,
        color=style.PRICE,
        linewidth=1.2,
        label="Cena zamknięcia (lewa oś)",
    )
    ax.set_ylabel(_price_label())
    ax.set_xlabel("Data")
    style.decimal_comma(ax.yaxis)

    ax_right = ax.twinx()
    ax_right.plot(
        dates, macd, color=style.PRIMARY, label="MACD (prawa oś)"
    )
    ax_right.plot(
        dates,
        signal,
        color=style.SIGNAL_LINE,
        linestyle="--",
        label="SIGNAL (prawa oś)",
    )
    ax_right.set_ylabel(
        f"MACD, SIGNAL [{config.INSTRUMENT_UNIT}]", color=style.PRIMARY
    )
    ax_right.tick_params(axis="y", colors=style.PRIMARY)
    ax_right.spines["right"].set_visible(True)
    ax_right.spines["right"].set_color(style.PRIMARY)
    ax_right.grid(False)
    style.decimal_comma(ax_right.yaxis)
    return ax_right


def chart_b1(
    prices: data.PriceSeries, macd: np.ndarray, signal: np.ndarray
) -> Figure:
    """B1 price and indicator, Projekt_1.pdf p. 6, 4.2."""
    dates = prices.dates
    fig = new_figure(style.FULL_SIZE_MM)
    ax = fig.subplots()
    ax_right = _plot_price_and_macd(ax, dates, prices.close, macd, signal)
    ax.set_title(
        _title("B1", f"cena zamknięcia i {_macd_label()}")
    )
    date_axis(ax, dates[0], dates[-1])
    _legend_below(fig, ax, [ax_right], 3)
    return fig


def plot_c1(
    ax: Axes,
    dates: np.ndarray,
    macd: np.ndarray,
    signal: np.ndarray,
    signals: np.ndarray,
    result: simulation.SimulationResult,
) -> None:
    """C1 MACD, SIGNAL and signals from sample 101, Projekt_1.pdf p. 6."""
    first = config.START_INDEX
    ax.plot(dates[first:], macd[first:], color=style.PRIMARY, label="MACD")
    ax.plot(
        dates[first:],
        signal[first:],
        color=style.SIGNAL_LINE,
        linestyle="--",
        label="SIGNAL",
    )
    indices, sides, _ = stats.considered_signals(signals, result)
    for value, side, label in (
        (1, "buy", "Sygnał kupna"),
        (-1, "sell", "Sygnał sprzedaży"),
    ):
        idx = indices[sides == value]
        ax.plot(dates[idx], macd[idx], label=label, **marker_style(side))
    ax.set_title(_title("C1", f"{_macd_label()} i sygnały"))
    ax.set_ylabel(f"MACD, SIGNAL\n[{config.INSTRUMENT_UNIT}]")
    style.decimal_comma(ax.yaxis)
    _legend_right(ax)


def plot_c2(ax: Axes, dates: np.ndarray, hist: np.ndarray) -> None:
    """C2 histogram H with the zero level, Projekt_1.pdf p. 6."""
    first = config.START_INDEX
    x = dates[first:]
    h = hist[first:]
    width = 1.5
    ax.bar(
        x[h > 0],
        h[h > 0],
        width=width,
        linewidth=0,
        color=style.BUY_LIGHT,
        label="H > 0",
    )
    ax.bar(
        x[h < 0],
        h[h < 0],
        width=width,
        linewidth=0,
        color=style.SELL_LIGHT,
        label="H < 0",
    )
    ax.axhline(0.0, color=style.MUTED, linewidth=0.8)
    ax.set_title(_title("C2", "histogram H"))
    ax.set_ylabel(f"H [{config.INSTRUMENT_UNIT}]")
    style.decimal_comma(ax.yaxis)
    _legend_right(ax)


def chart_c1_c2(
    prices: data.PriceSeries,
    macd: np.ndarray,
    signal: np.ndarray,
    hist: np.ndarray,
    signals: np.ndarray,
    result: simulation.SimulationResult,
) -> Figure:
    """C1 and C2 stacked on one shared time axis, Projekt_1.pdf p. 6."""
    dates = prices.dates
    fig = new_figure(style.PAIR_SIZE_MM)
    ax_top, ax_bottom = fig.subplots(2, 1, sharex=True)
    plot_c1(ax_top, dates, macd, signal, signals, result)
    plot_c2(ax_bottom, dates, hist)
    ax_bottom.set_xlabel("Data")
    date_axis(ax_bottom, dates[config.START_INDEX], dates[-1])
    return fig


def chart_d1(
    prices: data.PriceSeries,
    macd: np.ndarray,
    signal: np.ndarray,
    buy: simulation.Trade,
    sell: simulation.Trade,
) -> Figure:
    """D1 zoom of B1 around one closed trade, Projekt_1.pdf p. 6, 4.2."""
    first = max(buy.signal_index - config.D1_MARGIN, 0)
    last = min(sell.execution_index + config.D1_MARGIN, prices.length - 1)
    window = slice(first, last + 1)
    dates = prices.dates
    fig = new_figure(style.FULL_SIZE_MM)
    ax = fig.subplots()
    ax_right = _plot_price_and_macd(
        ax, dates[window], prices.close[window], macd[window], signal[window]
    )
    for trade, side, word in (
        (buy, "buy", "kupna"),
        (sell, "sell", "sprzedaży"),
    ):
        marker = marker_style(side)
        ax.axvline(
            dates[trade.signal_index],
            color=marker["color"],
            linestyle=":",
            linewidth=1.0,
        )
        ax.plot(
            [dates[trade.signal_index]],
            [prices.close[trade.signal_index]],
            label=f"Sygnał {word} (sesja przecięcia)",
            **marker_style(side, executed=False),
        )
        ax.plot(
            [dates[trade.execution_index]],
            [trade.price],
            label=f"Wykonanie {word} (następna sesja)",
            **marker,
        )
    ax.set_title(
        _title("D1", f"wybrana transakcja, cena i {_macd_label()}")
    )
    date_axis(ax, dates[first], dates[last])
    _legend_below(fig, ax, [ax_right], 2)
    return fig


def plot_e1(
    ax: Axes,
    prices: data.PriceSeries,
    signals: np.ndarray,
    result: simulation.SimulationResult,
) -> None:
    """E1 price with executed and skipped signals, Projekt_1.pdf p. 6."""
    first = config.START_INDEX
    dates = prices.dates
    (price_line,) = ax.plot(
        dates[first:],
        prices.close[first:],
        color=style.PRICE,
        linewidth=1.2,
        label="Cena zamknięcia",
    )
    indices, sides, is_executed = stats.considered_signals(signals, result)
    handles = [price_line]
    for value, side, noun, done_word, skipped_word in (
        (1, "buy", "Kupno", "wykonane", "niewykonane"),
        (-1, "sell", "Sprzedaż", "wykonana", "niewykonana"),
    ):
        chosen_side = sides == value
        for chosen, executed, word in (
            (indices[chosen_side & is_executed], True, done_word),
            (indices[chosen_side & ~is_executed], False, skipped_word),
        ):
            marker = marker_style(side, executed=executed)
            if len(chosen):
                ax.plot(dates[chosen], prices.close[chosen], **marker)
            handles.append(
                Line2D([], [], label=f"{noun} {word}", **marker)
            )
    ax.set_title(_title("E1", "cena i sygnały"))
    ax.set_ylabel(_price_label())
    style.decimal_comma(ax.yaxis)
    _legend_right(ax, handles)


def plot_e2(
    ax: Axes,
    prices: data.PriceSeries,
    result: simulation.SimulationResult,
) -> None:
    """E2 portfolio value V_i from sample 100, Projekt_1.pdf p. 6."""
    first = config.START_INDEX
    dates = prices.dates
    ax.plot(
        dates[first:],
        simulation.INITIAL_UNITS * prices.close[first:],
        color=style.MUTED,
        linestyle="--",
        linewidth=1.0,
        label="Referencja (kup i trzymaj)",
    )
    ax.plot(
        dates[first:],
        result.equity[first:],
        color=style.PRIMARY,
        label="Wartość portfela",
    )
    ax.set_title(_title("E2", "wartość portfela"))
    ax.set_ylabel(f"Wartość portfela\n[{config.INSTRUMENT_UNIT}]")
    style.decimal_comma(ax.yaxis)
    _legend_right(ax)


def chart_e1_e2(
    prices: data.PriceSeries,
    signals: np.ndarray,
    result: simulation.SimulationResult,
) -> Figure:
    """E1 and E2 stacked on one shared time axis, Projekt_1.pdf p. 6."""
    dates = prices.dates
    fig = new_figure(style.PAIR_SIZE_MM)
    ax_top, ax_bottom = fig.subplots(2, 1, sharex=True)
    plot_e1(ax_top, prices, signals, result)
    plot_e2(ax_bottom, prices, result)
    ax_bottom.set_xlabel("Data")
    date_axis(ax_bottom, dates[config.START_INDEX], dates[-1])
    return fig


def save(fig: Figure, name: str, charts_dir: Path = config.CHARTS_DIR) -> Path:
    """Save a vector PDF with reproducible metadata, brief 3.6."""
    charts_dir.mkdir(parents=True, exist_ok=True)
    path = charts_dir / f"{name}.pdf"
    fig.savefig(path, format="pdf", metadata={"CreationDate": None})
    return path
