function result = lab3_z1()
% LAB3_Z1 Sieć stron, macierze PageRank i wykres.
% result: Edges, N, B, A, b, r. Wszystkie funkcje są w tym pliku.
% Ustaw 1 lokalnie, aby zapisać wykres do PNG.
save_png = 0;
[Edges, B, A, b, r] = pagerank();
result = struct();
result.Edges = Edges;
result.N = max(Edges(:));
result.B = B;
result.A = A;
result.b = b;
result.r = r;
if ~isempty(r) && all(isfinite(r))
    plot_network(B, r, save_png);
end
end

function [Edges, B, A, b, r] = pagerank()
% PAGERANK Definiuje sieć i oblicza jej ranking.
% Edges: pełna double 2 x K, źródła nad celami krawędzi.
% B, A: rzadkie double N x N. b, r: pełne kolumny double N x 1.
% Wybierz N=8..12 i K=25-N różnych krawędzi, bez pętli własnych.
% Każdy węzeł 1:N ma mieć co najmniej jedno wejście i jedno wyjście.
%===============================================================================
% UZUPEŁNIJ: zdefiniuj sieć. N = max(max(Edges)).
Edges = [1 2 3 4 5 6 7 8 9 10 1 2 3 4 5; 2 3 4 5 6 7 8 9 10 1 5 6 7 8 9];
%===============================================================================
% Dostarczone wywołania generatora i rozwiązania A*r=b.
validate_network(Edges);
[B, A, b] = generate_matrix(Edges);
% Rozwiązywanie układu wymaga kompletnych macierzy B, A i b.
r = [];
if ~matrices_ready(B, A, b, max(max(Edges)))
    return
end
% Operator \ rozwiązuje tutaj równanie metodą bezpośrednią.
r = A \ b;
end

function [B, A, b] = generate_matrix(Edges)
% GENERATE_MATRIX Buduje układ PageRank z poprawnej sieci Edges.
% Edges: double 2 x K, źródła nad celami. Numery węzłów: 1:N.
% B: sparse N x N, B(i,j)=1 dla odnośnika j -> i.
% A: sparse N x N, A = I-d*H. Kolumny H sumują się do 1.
% b: pełna kolumna N x 1, b = (1-d)/N * ones(N,1).
% Funkcja ma też obsługiwać duże sieci z kolejnych zadań.
%
% Zbuduj B przez sparse. Wyznacz stopnie wyjściowe i przeskaluj
% kolumny B przez spdiags. Z otrzymanej H zbuduj A oraz b.
% Użyj speye i zachowaj sparse w obliczeniach macierzowych.

% Parametry dostarczone.
d = 0.85;
N = max(max(Edges));

%===============================================================================
% UZUPEŁNIJ: wyznacz kolejno B, A oraz b.
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
deg = full(sum(B, 1));
D = spdiags(1 ./ deg(:), 0, N, N);
H = B * D;
A = speye(N) - 0.85 * H;
b = (1 - 0.85) / N * ones(N, 1);
%===============================================================================
end

function ready = matrices_ready(B, A, b, N)
% Sprawdza format i rozmiary macierzy przed rozwiązaniem układu.
ready = false;
values = {B, A, b};
shapes = {[N N], [N N], [N 1]};
for index = 1:3
    value = values{index};
    if ~isa(value, 'double') || ~isreal(value) || ...
            ~isequal(size(value), shapes{index}) || ...
            issparse(value) ~= (index < 3) || any(~isfinite(value(:)))
        return
    end
end
ready = true;
end

function validate_network(Edges)
% Sprawdza reguły budowy sieci przed utworzeniem macierzy.
if ~ismatrix(Edges) || size(Edges, 1) ~= 2 || isempty(Edges)
    error('lab3:InvalidEdges', ...
        ['Edges: błędny rozmiar. ' ...
        'Oczekiwany rozmiar: [2 K], otrzymany: %s. ' ...
        'Wpisz źródła w pierwszym wierszu, a cele w drugim. ' ...
        'Wybierz N=8..12 i K=25-N.'], mat2str(size(Edges)));
end
if ~isa(Edges, 'double') || ~isreal(Edges) || issparse(Edges) || ...
        any(~isfinite(Edges(:))) || any(Edges(:) < 1) || ...
        any(Edges(:) ~= floor(Edges(:)))
    error('lab3:InvalidEdges', ...
        'Edges musi być pełną macierzą double 2 x K z numerami węzłów.');
end
N = max(Edges(:));
if N < 8 || N > 12
    error('lab3:InvalidSmallNetwork', ...
        'Wybierz od 8 do 12 węzłów oraz dokładnie 25-N krawędzi.');
end
if size(Edges, 2) ~= 25 - N
    error('lab3:InvalidSmallNetwork', ...
        ['Edges: dla N=%d liczba krawędzi wynosi K=25-N=%d. ' ...
        'Oczekiwany rozmiar: %s, otrzymany: %s.'], ...
        N, 25-N, mat2str([2 25-N]), mat2str(size(Edges)));
end
if any(Edges(1, :) == Edges(2, :)) || ...
        size(unique(Edges.', 'rows'), 1) ~= size(Edges, 2)
    error('lab3:InvalidEdges', ...
        'Usuń pętle własne i powtórzenia tych samych krawędzi.');
end
if numel(unique(Edges(1, :))) ~= N || ...
        numel(unique(Edges(2, :))) ~= N
    error('lab3:InvalidEdges', ...
        'Każdy węzeł 1:N musi mieć co najmniej jedno wejście i wyjście.');
end
end

function plot_network(B, r, save_png)
% Dostarczony wykres: macierz, graf i ranking.
N = size(B, 1);
fig = prepare_figure();
layout = tiledlayout(fig, 2, 2, ...
    'TileSpacing', 'compact', 'Padding', 'compact');
ax_matrix = nexttile(layout);
spy(B, 'k');
set(ax_matrix, 'Tag', 'lab3_z1_matrix');
title(ax_matrix, 'Struktura macierzy B');
xlabel(ax_matrix, 'Węzeł źródłowy (kolumna)');
ylabel(ax_matrix, 'Węzeł docelowy (wiersz)');
ax_graph = nexttile(layout);
G = digraph(B.');
plot(ax_graph, G, 'Layout', 'circle', 'MarkerSize', 7, 'ArrowSize', 10);
set(ax_graph, 'Tag', 'lab3_z1_graph');
title(ax_graph, 'Graf skierowany');
axis(ax_graph, 'off');
ax_rank = nexttile(layout, [1, 2]);
bar(ax_rank, 1:N, r);
set(ax_rank, 'Tag', 'lab3_z1_rank');
xlabel(ax_rank, 'Numer węzła');
ylabel(ax_rank, 'PageRank');
title(ax_rank, 'Wartości rankingu');
grid(ax_rank, 'on');
sgtitle(layout, sprintf('N = %d, K = %d, d = 0.85', N, nnz(B)));
style_figure(fig);
if save_png == 1
    exportgraphics(fig, 'lab3_zadanie1.png', 'Resolution', 300);
end
end

function fig = prepare_figure()
fig = figure('Color', 'w', 'WindowStyle', 'normal');
if isprop(fig, 'Theme')
    set(fig, 'Theme', 'light');
end
screen_size = get(groot, 'ScreenSize');
if screen_size(3) >= 1700 && screen_size(4) >= 950
    set(fig, 'Position', [50, 50, 1600, 800]);
end
end

function style_figure(fig)
% Jawne kolory zapewniają czytelność także w eksporcie PNG.
axes_list = findall(fig, 'Type', 'axes');
for ax = axes_list.'
    set(ax, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', ...
        'GridColor', [0.3 0.3 0.3]);
end
set(findall(fig, 'Type', 'text'), 'Color', 'k');
end
