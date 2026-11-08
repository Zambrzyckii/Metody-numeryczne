function result = lab3_z4()
% LAB3_Z4 PageRank metodą Gaussa-Seidla i historia residuum.
% result: Edges, N, B, A, b oraz x, res_history, iterations.

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
result.x0 = ones(N, 1) / N;
result.tol = 1e-8;
result.max_iter = 500;
result.x = [];
result.res_history = [];
result.iterations = [];
% Rozwiązywanie układu wymaga kompletnych macierzy B, A i b.
if ~matrices_ready(B, A, b, N)
    return
end
[result.x, result.res_history, result.iterations] = ...
    solve_gauss_seidel(A, b, result.x0, result.tol, ...
        result.max_iter);
% Wykres powstaje po uzyskaniu wyników o wymaganych rozmiarach.
if plot_ready(result)
    draw_history(result, save_png);
end
end

function [x, res_history, iterations] = ...
        solve_gauss_seidel(A, b, x0, tol, max_iter)
% SOLVE_GAUSS_SEIDEL Rozwiązuje A*x=b metodą Gaussa-Seidla.
% A          - rzeczywista macierz double N x N, full/sparse.
%              Przekątna jest niezerowa. Dane wejściowe są skończone.
% b, x0      - rzeczywiste wektory kolumnowe double N x 1.
% tol        - skończona, nieujemna tolerancja względna double.
% max_iter   - skończona, nieujemna całkowita liczba aktualizacji.
% x          - ostatni wektor kolumnowy double N x 1, także po NaN/Inf.
% res_history- kolumna double norm residuum od x0, długość iterations+1.
% iterations - liczba wykonanych aktualizacji x, od 0 do max_iter.
% Stop: norm(A*x-b,2) <= tol*norm(b,2) albo limit max_iter.
% Funkcja nie generuje danych ani wykresów.

%===============================================================================
% UZUPEŁNIJ: napisz metodę Gaussa-Seidla.
% Możesz wykorzystać zapis historii i warunek stopu z zadania 3.
% Wydziel D,L,U w A=D+L+U: diagonalną i ściśle trójkątne części.
% Zachowaj rzadkość. Nie twórz macierzy odwrotnej.
%
% Rozwiązuj układ trójkątny z D+L przez \ albo aktualizuj składowe x.
% W drugim wariancie rozróżnij składowe już zmienione i jeszcze stare.
% Zapisz normę dla x0 oraz po każdym pełnym kroku.
% Zakończ po osiągnięciu progu albo wykonaniu max_iter aktualizacji.
% Sam wzrost normy nie zatrzymuje iteracji. NaN/Inf nie wymagają obsługi.
%
% Zwróć ostatnie x i tylko obliczone normy w kolumnie res_history.
% Historia: k aktualizacji daje k+1 norm, pierwsza jest dla x0.
% res_history(k+1) odpowiada k aktualizacjom. iterations to ich liczba,
% czyli liczba zapisanych norm minus jedna. Skróć niewykorzystany bufor.
M = tril(A);                % D + L
U = triu(A, 1);             % A = M + U

normb = norm(b, 2);
x = x0;
res_history = zeros(max_iter + 1, 1);   % bufor, na końcu zostanie skrócony
res_history(1) = norm(A*x - b, 2);      % norma dla x0, przed pierwszą aktualizacją
iterations = 0;

% Stop: norm <= tol*norm(b) albo limit max_iter. Warunek jest zapisany jako
% ~(norma <= próg), żeby NaN w historii nie kończył iteracji przed limitem.
while iterations < max_iter && ~(res_history(iterations + 1) <= tol*normb)
    x = M \ (b - U*x);                  % x(k+1) = (D+L)^-1 (b - U x(k))
    iterations = iterations + 1;
    res_history(iterations + 1) = norm(A*x - b, 2);
end
res_history = res_history(1:iterations + 1);
%===============================================================================
end

function [B, A, b] = generate_matrix(Edges)
% GENERATE_MATRIX Buduje układ PageRank z połączeń źródło -> cel.
% Edges: pełna macierz double 2 x K, źródła nad celami.
% N wynika z największego numeru węzła. Dane są poprawne i bez pętli.
% Każdy węzeł ma wejście i wyjście, krawędzie nie powtarzają się.
% B: sparse double N x N, B(i,j)=1 dla odnośnika j -> i.
% A: sparse double N x N, A = I - d*H.
% b: pełna kolumna double N x 1, b = (1-d)/N * ones(N,1).
% H powstaje z B przez normalizację kolumn stopniami wyjściowymi.
%
% Wstaw obliczenia z generate_matrix z zadania 1, bez funkcji rysujących.
% Użyj sparse, spdiags i speye. Zachowaj rzadkość również dla dużych N.

% Parametry modelu.
d = 0.85;
N = max(max(Edges));

%===============================================================================
% UZUPEŁNIJ: wyznacz kolejno B, A oraz b.
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);   % B(i,j)=1 dla j -> i
deg = full(sum(B, 1));                          % stopnie wyjściowe (kolumny)
D = spdiags(1 ./ deg(:), 0, N, N);              % skalowanie kolumn
H = B * D;
A = speye(N) - d * H;
b = (1 - d) / N * ones(N, 1);
%===============================================================================
end

% Część dostarczona: sieć, kontrola danych i wizualizacja.
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

function draw_history(result, save_png)
% Dostarczona wizualizacja pokazuje normę residuum od kroku zerowego.
fig = figure('Name', 'PageRank: Gauss-Seidel', 'WindowStyle', 'normal', ...
    'Color', 'w');
screen = get(groot, 'ScreenSize');
if screen(3) >= 1700 && screen(4) >= 950
    set(fig, 'Position', [50, 50, 1600, 800]);
end
ax = axes('Parent', fig);
semilogy(ax, 0:result.iterations, result.res_history, '-o', ...
    'LineWidth', 1.2, 'MarkerSize', 3, 'Tag', 'res_history');
set(ax, 'Tag', 'lab3_z4_history', 'Color', 'w', ...
    'XColor', 'k', 'YColor', 'k', 'GridColor', [0.15, 0.15, 0.15]);
grid on
xlabel('Liczba wykonanych iteracji', 'Color', 'k');
ylabel('Norma residuum ||Ax-b||_2', 'Color', 'k');
title(sprintf('Gauss-Seidel: N = %d, iteracje = %d', ...
    result.N, result.iterations), 'Color', 'k');
% Zero, NaN i Inf pozostają w wyniku, choć nie są widoczne w skali log.
if save_png
    exportgraphics(fig, 'lab3_zadanie4.png', 'Resolution', 150);
end
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
% Sprawdza rozmiary danych wykresu. Historia może kończyć się NaN/Inf.
ready = isa(result.iterations,'double') && isreal(result.iterations) && ...
    isscalar(result.iterations) && isfinite(result.iterations) && ...
    result.iterations >= 0 && result.iterations == fix(result.iterations) ...
    && isa(result.res_history,'double') && isreal(result.res_history) && ...
    isequal(size(result.res_history),[result.iterations+1 1]);
end

