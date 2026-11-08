function result = lab3_z2()
% LAB3_Z2 LU, struktura macierzy i rozwiązanie PageRank.
% result: Edges, N, B, A, b oraz x, L, U, P, Q, res_norm.

% Wybierz całkowite N od 1000 do 2000.
N = 1500;
save_png = 0; % Ustaw lokalnie 1, aby zapisać wykres.
Edges = build_network(N);
[B, A, b] = generate_matrix(Edges);
result = struct();
result.Edges = Edges;
result.N = N;
result.B = B;
result.A = A;
result.b = b;
result.x = [];
result.L = [];
result.U = [];
result.P = [];
result.Q = [];
result.res_norm = [];
% Rozwiązywanie układu wymaga kompletnych macierzy B, A i b.
if ~matrices_ready(B, A, b, N)
    return
end
[result.x, result.L, result.U, result.P, result.Q, result.res_norm] = ...
    solve_direct(A, b);
% Wykres powstaje po uzyskaniu wyników o wymaganych rozmiarach.
if plot_ready(result)
    plot_direct(result, save_png);
end
end

function [x, L, U, P, Q, res_norm] = solve_direct(A, b)
% SOLVE_DIRECT Rozwiązuje A*x=b przez LU z dwiema permutacjami.
% A        - rzeczywista, nieosobliwa macierz double N x N, sparse.
% b        - rzeczywisty wektor kolumnowy double N x 1.
% x        - wektor rozwiązania N x 1 w pierwotnej kolejności niewiadomych.
% L, U     - rzeczywiste macierze sparse double N x N, P*A*Q=L*U.
%            L jest dolnotrójkątna z jedynkami na przekątnej.
%            U jest górnotrójkątna.
% P, Q     - macierze permutacji sparse double N x N, wierszy i kolumn.
% res_norm - norma euklidesowa residuum A*x-b.
% A i b mają skończone wartości. Zakładamy poprawne dane wejściowe.
% Wyniki x i res_norm są rzeczywiste i mają typ double.
% Funkcja nie generuje danych, nie mierzy czasu i nie tworzy wykresu.

% Użyj lu z czterema wynikami i zachowaj format sparse.
% Zastosuj permutacje i rozwiąż dwa układy trójkątne według PDF-u.
% Operator \ stosuj tylko do tych układów, nie do całego A*x=b.
% Nie wyznaczaj macierzy odwrotnej. Zwróć też normę 2 residuum A*x-b.
%===============================================================================
% UZUPEŁNIJ: rozwiąż układ przez LU i oceń residuum.
[L, U, P, Q] = lu(A);
y = L \ (P * b);
z = U \ y;
x = Q * z;
res_norm = norm(A * x - b);
%===============================================================================
end

function [B, A, b] = generate_matrix(Edges)
% GENERATE_MATRIX Buduje układ PageRank z połączeń źródło -> cel.
% Edges: double 2 x K, źródła nad celami, numery węzłów 1:N.
% Dane są poprawne: bez pętli i powtórzeń, każdy węzeł ma wejście i wyjście.
% B: sparse double N x N, B(i,j)=1 dla odnośnika j -> i.
% H: B po normalizacji kolumn stopniami wyjściowymi.
% A: sparse double N x N, A = I - d*H.
% b: pełna kolumna double N x 1, b = (1-d)/N * ones(N,1).
% Wstaw obliczenia z generate_matrix z zadania 1, bez funkcji rysujących.
% Użyj sparse, spdiags i speye. Zachowaj rzadkość obliczeń pośrednich.
% Generator ma obsługiwać także duże sieci, bez ograniczeń N i K z zadania 1.

% Parametry modelu.
d = 0.85;
N = max(max(Edges));

%===============================================================================
% UZUPEŁNIJ: wyznacz kolejno B, A oraz b.
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
deg = full(sum(B, 1));
D = spdiags(1 ./ deg(:), 0, N, N);
H = B * D;
A = speye(N) - d * H;
b = (1 - d) / N * ones(N, 1);
%===============================================================================
end

function Edges = build_network(N)
% BUILD_NETWORK Tworzy odtwarzalną sieć do porównywania metod.
% N     - całkowita liczba węzłów, N >= 4.
% Edges - pełna macierz double 2 x (3*N), źródła nad celami.
% Cykl zapewnia silną spójność, dwa dodatkowe wyjścia są losowane.
% Każdy węzeł ma trzy różne wyjścia. Reguła K=25-N tutaj nie obowiązuje.
% Lokalny mt19937ar z ziarnem 20261024 nie zmienia globalnego rng.

if ~isscalar(N)
    error('lab3:InvalidNetworkSize', ...
        ['N: liczba węzłów musi być skalarem. ' ...
        'Oczekiwany rozmiar: [1 1], otrzymany: %s.'], ...
        mat2str(size(N)));
end
if ~isnumeric(N) || ~isreal(N) || ~isfinite(N) || ...
        N < 4 || N ~= floor(N)
    error('lab3:InvalidNetworkSize', ...
        'N musi być skończoną liczbą całkowitą nie mniejszą niż 4.');
end
N = double(N);
stream = RandStream('mt19937ar', 'Seed', 20261024);
source = 1:N;
cycle_target = mod(source, N) + 1;

% Losujemy dwa różne przesunięcia z 2:N-1, bez ponawiania losowania.
first = randi(stream, N - 2, 1, N);
second = randi(stream, N - 3, 1, N);
second = second + (second >= first);
first_target = mod(source + first, N) + 1;
second_target = mod(source + second, N) + 1;
Edges = [source, source, source; ...
    cycle_target, first_target, second_target];
end

function plot_direct(result, save_png)
% Zestaw strukturę układu z wypełnieniem L oraz wartościami rozwiązania.
fig = prepare_figure();
layout = tiledlayout(fig, 2, 2, ...
    'TileSpacing', 'compact', 'Padding', 'compact');
ax = nexttile(layout);
spy(result.A, 'k');
set(ax, 'Tag', 'lab3_z2_matrix');
title(ax, 'Struktura macierzy A');
ax = nexttile(layout);
spy(result.L, 'k');
set(ax, 'Tag', 'lab3_z2_factor');
title(ax, 'Struktura czynnika L');
ax = nexttile(layout, [1, 2]);
bar(ax, 1:result.N, result.x);
set(ax, 'Tag', 'lab3_z2_solution');
xlabel(ax, 'Numer węzła');
ylabel(ax, 'Wartość rozwiązania');
grid(ax, 'on');
title(ax, sprintf('LU: N=%d, norma residuum = %.3e', ...
    result.N, result.res_norm));
style_figure(fig);
if save_png == 1
    exportgraphics(fig, 'lab3_zadanie2.png', 'Resolution', 150);
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

function ready = plot_ready(result)
% Sprawdza tylko dane wymagane do rysowania.
ready = isa(result.x,'double') && isreal(result.x) && ...
    isequal(size(result.x),[result.N 1]) && all(isfinite(result.x)) && ...
    isa(result.L,'double') && isreal(result.L) && ...
    isequal(size(result.L),[result.N result.N]) && ...
    isa(result.res_norm,'double') && isreal(result.res_norm) && ...
    isscalar(result.res_norm) && isfinite(result.res_norm);
end

