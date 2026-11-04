function result = lab3_z5()
% Porównanie LU, Jacobiego i Gaussa-Seidla na tych samych układach.
% Dostarczono dane, trzy powtórzenia, mediany, zapis wyników i wykresy.
% Uzupełnij sześć funkcji generatora i metod na końcu pliku.
% result.elapsed i result.res_norm: rozmiar x metoda x powtórzenie.
% Kolejność metod: LU, Jacobi, Gauss-Seidel. Czasy są w sekundach.
% result.runs przechowuje dane i wyniki każdego pomiaru.
% Czas LU obejmuje rozkład i podstawienia, czas iteracji tylko rdzeń.
% Budowa sieci i wyodrębnianie macierzy iteracji są poza pomiarem.
    save_png = 0; % Ustaw lokalnie 1, aby zapisać całą figurę.
    result.dimensions = [1200 1800 2400 3000];
    result.repeats = 3;
    result.tol = 1e-8;
    result.max_iter = 500;
    m = numel(result.dimensions);
    result.elapsed = zeros(m,3,result.repeats);
    result.res_norm = zeros(m,3,result.repeats);
    result.iterations = zeros(m,3,result.repeats);
    result.runs = cell(m,3,result.repeats);
    for i = 1:m
        N = result.dimensions(i);
        % Sieć i układ powstają przed uruchomieniem zegarów.
        Edges = build_network(N);
        [~, A, b] = generate_matrix(Edges);
        x0 = ones(N,1)/N;
        for repeat = 1:result.repeats
            [elapsed,x] = measure_direct(A,b);
            history = [];
            iterations = 0;
            result = store_run(result,i,1,repeat,A,b,x0, ...
                elapsed,x,history,iterations);
            [elapsed,x,history,iterations] = ...
                measure_jacobi(A,b,x0,result.tol,result.max_iter);
            result = store_run(result,i,2,repeat,A,b,x0, ...
                elapsed,x,history,iterations);
            [elapsed,x,history,iterations] = ...
                measure_gauss_seidel(A,b,x0,result.tol,result.max_iter);
            result = store_run(result,i,3,repeat,A,b,x0, ...
                elapsed,x,history,iterations);
        end
    end
    result.median_time = median(result.elapsed,3);
    result.median_res_norm = median(result.res_norm,3);
    result.median_iterations = median(result.iterations,3);
    draw_result(result,save_png);
end

function [elapsed,x,res_history,iterations] = ...
        measure_jacobi(A,b,x0,tol,max_iter)
% Wzorzec pomiaru: macierze przygotuj przed uruchomieniem zegara.
% Własną metodę Jacobiego wpisz w jacobi_core na końcu pliku.
% Zegar obejmuje tylko wywołanie rdzenia iteracyjnego.
    [D,L,U] = prepare_data(A);
    T = L+U;
    timer = tic;
    [x,res_history,iterations] = jacobi_core(D,T,b,x0,tol,max_iter);
    elapsed = toc(timer);
end

function [D,L,U] = prepare_data(A)
% A = D+L+U. L i U są ściśle trójkątne, D jest diagonalna.
% To części macierzy A, nie czynniki jej rozkładu LU.
    n = size(A,1);
    D = spdiags(diag(A),0,n,n);
    L = tril(A,-1);
    U = triu(A,1);
end

function result = store_run(result,i,method,repeat,A,b,x0, ...
        elapsed,x,history,iterations)
% Dostarczony zapis wyników. Wykonuje się po zatrzymaniu zegara.
    result.elapsed(i,method,repeat) = elapsed;
    result.res_norm(i,method,repeat) = norm(A*x-b,2);
    result.iterations(i,method,repeat) = iterations;
    result.runs{i,method,repeat} = struct('A',A,'b',b,'x0',x0, ...
        'tol',result.tol,'max_iter',result.max_iter,'x',x, ...
        'res_history',history,'iterations',iterations);
end

function ready = plot_ready(result)
% Rysowanie wymaga macierzy median o prawidłowych rozmiarach.
ready = false;
if ~isa(result.dimensions, 'double') || ~isreal(result.dimensions) || ...
        isempty(result.dimensions) || ...
        ~isequal(size(result.dimensions), [1 numel(result.dimensions)]) || ...
        any(~isfinite(result.dimensions))
    return
end
shape = [numel(result.dimensions) 3];
for name = {'median_time', 'median_res_norm'}
    value = result.(name{1});
    if ~isa(value, 'double') || ~isreal(value) || ...
            ~isequal(size(value), shape)
        return
    end
end
ready = true;
end

function draw_result(result, save_png)
% Dostarczony wykres nie zmienia surowych pomiarów w result.
    if ~plot_ready(result)
        return
    end
    fig = figure('WindowStyle', 'normal');
    if isprop(fig, 'Theme')
        set(fig, 'Theme', 'light');
    end
    screen = get(0, 'ScreenSize');
    if screen(3) >= 1700 && screen(4) >= 950
        set(fig, 'Position', [50 50 1600 800]);
    end
    ax = subplot(2, 1, 1);
    bars = bar(result.dimensions, result.median_time, 'grouped');
    set(ax, 'Tag', 'lab3_z5_time');
    set(bars(1), 'Tag', 'LU');
    set(bars(2), 'Tag', 'Jacobi');
    set(bars(3), 'Tag', 'GaussSeidel');
    xlabel('Liczba równań N');
    ylabel('Mediana czasu solvera [s]');
    title('Czas obliczeń bez budowy macierzy');
    legend('LU', 'Jacobi', 'Gauss-Seidel', 'Location', 'best');
    grid on
    ax = subplot(2, 1, 2);
    % Dla danego N wszystkie metody korzystają z tego samego b.
    relative_norm = result.median_res_norm;
    for i = 1:numel(result.dimensions)
        b = result.runs{i,1,1}.b;
        relative_norm(i,:) = relative_norm(i,:)/norm(b,2);
    end
    % Zero zastępujemy realmin tylko na potrzeby logarytmu na wykresie.
    values = log10(max(relative_norm, realmin));
    values(~isfinite(relative_norm)) = NaN;
    bars = bar(result.dimensions, values, 'grouped');
    set(ax, 'Tag', 'lab3_z5_residual');
    set(bars(1), 'Tag', 'LU');
    set(bars(2), 'Tag', 'Jacobi');
    set(bars(3), 'Tag', 'GaussSeidel');
    xlabel('Liczba równań N');
    ylabel('log10(mediana(||r||_2 / ||b||_2))');
    title('Względna norma residuum po zakończeniu obliczeń');
    legend('LU', 'Jacobi', 'Gauss-Seidel', 'Location', 'best');
    grid on
    if save_png == 1
        exportgraphics(fig, 'lab3_zadanie5.png');
    end
end

function Edges = build_network(N)
% BUILD_NETWORK Tworzy odtwarzalną sieć do porównywania metod.
% N     - całkowita liczba węzłów, N >= 4.
% Edges - pełna macierz double 2 x (3*N), źródła nad celami.
% Każdy węzeł ma trzy różne wyjścia do innych węzłów.
% Cykl przez wszystkie węzły zapewnia wejścia i silną spójność.
% Dwa dodatkowe wyjścia pochodzą z lokalnego strumienia mt19937ar.
% Ziarno wynosi 20261024. Funkcja nie zmienia globalnego stanu rng.
% Reguła K=25-N dotyczy wyłącznie małej sieci w zadaniu 1.

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

% Dopuszczalne przesunięcia to 2:N-1. Pierwszy wybór ma N-2 możliwości.
% Drugi wybór pomija pierwszą pozycję, bez ponawiania losowania.
first = randi(stream, N - 2, 1, N);
second = randi(stream, N - 3, 1, N);
second = second + (second >= first);
first_target = mod(source + first, N) + 1;
second_target = mod(source + second, N) + 1;
Edges = [source, source, source; ...
    cycle_target, first_target, second_target];
end

% Poniżej znajdują się wszystkie funkcje do uzupełnienia.

function [B, A, b] = generate_matrix(Edges)
% Buduje układ PageRank z połączeń źródło -> cel.
% Edges: pełna macierz double 2 x K, źródła nad celami.
% B: sparse double N x N, B(i,j)=1 dla odnośnika j -> i.
% A: sparse double N x N, A=I-d*H. H ma znormalizowane kolumny B.
% b: pełna kolumna double N x 1, b=(1-d)/N * ones(N,1).
% Wstaw własne obliczenia generate_matrix z zadania 1.
% Użyj sparse, spdiags i speye. Zachowaj rzadkość dla dużych N.
% Budowa macierzy odbywa się poza pomiarem czasu metod.

d = 0.85;
N = max(max(Edges));

%===============================================================================
% UZUPEŁNIJ: wyznacz kolejno B, A oraz b.
    error('lab3:MissingImplementation', ...
        'Uzupełnij funkcję generate_matrix na końcu pliku.');
%===============================================================================
end

function [elapsed,x] = measure_direct(A,b)
% A: rzadka macierz kwadratowa. b,x: pełne wektory kolumnowe.
% elapsed: czas przygotowania rozkładu LU i obliczenia x [s].
% Użyj lu z czterema wynikami, PAQ=LU, i wywołaj direct_core.
% Uruchom tic przed lu, a toc po direct_core. Nie buduj tutaj sieci.
%===============================================================================
% UZUPEŁNIJ: napisz measure_direct.
    error('lab3:MissingImplementation', ...
        'Uzupełnij funkcję measure_direct na końcu pliku.');
%===============================================================================
end

function x = direct_core(L,U,P,Q,b)
% L,U: czynniki LU. P,Q: permutacje, P*A*Q=L*U.
% Rozwiąż dwa układy trójkątne i przywróć kolejność niewiadomych.
% Zwróć pełną kolumnę x. Ta funkcja nie mierzy czasu.
%===============================================================================
% UZUPEŁNIJ: napisz direct_core.
    error('lab3:MissingImplementation', ...
        'Uzupełnij funkcję direct_core na końcu pliku.');
%===============================================================================
end

function [x,res_history,iterations] = ...
        jacobi_core(D,T,b,x0,tol,max_iter)
% Oblicz residuum z części macierzy, bez odtwarzania A.
% D: rzadka macierz diagonalna, T=L+U. Norma dotyczy A=D+T.
% Wszystkie nowe składowe korzystają z poprzedniego x.
% Stop: norm(A*x-b,2) <= tol*norm(b,2) albo limit max_iter.
% res_history(1) zawiera normę dla x0, przed pierwszą aktualizacją.
% Po k aktualizacjach historia jest kolumną z k+1 normami.
% Zwróć x, res_history oraz iterations=k.
% Możesz dostosować własny kod z zadania 3. Nie mierz tutaj czasu.
%===============================================================================
% UZUPEŁNIJ: napisz jacobi_core.
    error('lab3:MissingImplementation', ...
        'Uzupełnij funkcję jacobi_core na końcu pliku.');
%===============================================================================
end

function [elapsed,x,res_history,iterations] = ...
        measure_gauss_seidel(A,b,x0,tol,max_iter)
% Zmierz wywołanie rdzenia, analogicznie do measure_jacobi.
% Przed tic wywołaj prepare_data i zbuduj M=D+L.
% U jest ściśle górnotrójkątna.
% Wywołaj gauss_seidel_core. Zwróć czas [s] i trzy wyniki iteratora.
%===============================================================================
% UZUPEŁNIJ: napisz measure_gauss_seidel.
    error('lab3:MissingImplementation', ...
        'Uzupełnij funkcję measure_gauss_seidel na końcu pliku.');
%===============================================================================
end

function [x,res_history,iterations] = ...
        gauss_seidel_core(M,U,b,x0,tol,max_iter)
% Oblicz residuum z części macierzy, bez odtwarzania A.
% M=D+L, A=M+U. Rozwiązuj M*x_new=b-U*x_old bez macierzy odwrotnej.
% Stop: norm(A*x-b,2) <= tol*norm(b,2) albo limit max_iter.
% res_history(1) zawiera normę dla x0, przed pierwszą aktualizacją.
% Po k aktualizacjach historia jest kolumną z k+1 normami.
% Zwróć x, res_history oraz iterations=k.
% Możesz dostosować własny kod z zadania 4. Nie mierz tutaj czasu.
%===============================================================================
% UZUPEŁNIJ: napisz gauss_seidel_core.
    error('lab3:MissingImplementation', ...
        'Uzupełnij funkcję gauss_seidel_core na końcu pliku.');
%===============================================================================
end

