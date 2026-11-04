function result = lab3_z6()
% LAB3_Z6 Granice przydatności metod na danych filtru mikrofalowego.
% Funkcja i lokalne solvery znajdują się w jednym pliku.
% Umieść niezmieniony filtr_dielektryczny.mat obok tego pliku funkcji.
% Funkcja wykonuje eksperyment i rysuje jedną figurę.
% result.n: liczba równań, tol = 1e-8, max_iter = 500.
% direct.x: rozwiązanie A\b, direct.res_norm: norma euklidesowa residuum.
% jacobi i gauss_seidel mają pola x, res_history i iterations.
% Historia: k aktualizacji daje k+1 norm, pierwsza jest dla x0.
% res_history jest kolumną norm od kroku 0 do zwróconego przybliżenia x.
% iterations: liczba aktualizacji, równa numel(res_history)-1.
% Zachowaj pełny wynik solvera, także Inf/NaN.
% x jest pełną kolumną n x 1. Wyniki liczbowe mają typ double.

    % Ustaw lokalnie 1, aby zapisać całą figurę.
    save_png = 0;
    data_file = 'filtr_dielektryczny.mat';
    if ~isfile(data_file)
        data_file = fullfile(fileparts(mfilename('fullpath')), data_file);
    end
    if ~isfile(data_file)
        error('lab3:MissingData', ...
            ['Nie znaleziono filtr_dielektryczny.mat. Pobierz dane zadania ' ...
            'i umieść plik obok lab3_z6.m.']);
    end
    data = load(data_file, 'A', 'b');
    A = data.A;
    b = data.b;
    result.n = size(A, 1);
    result.tol = 1e-8;
    result.max_iter = 500;
    x0 = ones(result.n, 1);

    % Dostarczone rozwiązanie bezpośrednie jest punktem odniesienia.
    % Zachowaj dane filtru, format sparse macierzy A i pełną kolumnę b.
    result.direct.x = A\b;
    result.direct.res_norm = [];
    empty_run = struct('x', [], 'res_history', [], ...
        'iterations', []);
    result.jacobi = empty_run;
    result.gauss_seidel = empty_run;

%===============================================================================
% UZUPEŁNIJ: norma residuum i wywołania metod.
% Tutaj oceń wynik bezpośredni i uruchom własne metody iteracyjne.

    % Oblicz result.direct.res_norm z A, b i result.direct.x.
    % Nie wpisuj przewidywanej normy jako stałej.

    % Wywołaj lokalne solvery z zadań 3 i 4 dla tych samych A, b, x0
    % oraz tolerancji i limitu z result. Zapisz x, res_history i iterations
    % w result.jacobi oraz result.gauss_seidel.
    % Przypisz wyniki w kolejności: x, res_history, iterations.
    % Nie zmieniaj historii zwróconych przez solvery.
    % Sam wzrost normy nie zatrzymuje iteracji.

% Koniec części do napisania. Dalszy kod sam rysuje wyniki obliczeń.
%===============================================================================
    draw_filter(result, save_png);
end

function [ready,message] = plot_ready(result)
% Wskazuje brakujące dane potrzebne do narysowania wykresu.
ready = false;
[direct,message] = plot_field(result,'direct','direct');
if ~isempty(message), return, end
[value,message] = plot_field(direct,'res_norm','direct.res_norm');
if ~isempty(message), return, end
message = plot_value_issue(value,[1 1],'direct.res_norm');
if ~isempty(message)
    message = [message ' Oblicz norm(A*result.direct.x-b,2).'];
    return
end
for name = {'jacobi','gauss_seidel'}
    key = name{1};
    [run,message] = plot_field(result,key,key);
    if ~isempty(message), return, end
    [history,message] = plot_field(run,'res_history',[key '.res_history']);
    if ~isempty(message), return, end
    message = plot_value_issue(history,[max(1,numel(history)) 1], ...
        [key '.res_history']);
    if ~isempty(message)
        message = [message ' Zapisz normę dla x0 i po każdym kroku.'];
        return
    end
    [count,message] = plot_field(run,'iterations',[key '.iterations']);
    if ~isempty(message), return, end
    message = plot_value_issue(count,[1 1],[key '.iterations']);
    if ~isempty(message)
        return
    end
    if ~isfinite(run.iterations) || ...
            run.iterations ~= numel(history)-1
        message = sprintf(['%s.iterations: z historii wynika %d, ' ...
            'otrzymano %.17g.'],key,numel(history)-1,run.iterations);
        return
    end
end
ready = true;
end

function [value,message] = plot_field(result,key,name)
% Wskazuje nazwę brakującego pola wyników.
value = [];
message = '';
if ~isstruct(result) || ~isscalar(result)
    message = sprintf('%s: zachowaj pojedynczą strukturę wyników.',name);
elseif ~isfield(result,key)
    message = sprintf('%s: brakuje pola. Zapisz wynik pod tą nazwą.',name);
else
    value = result.(key);
end
end

function message = plot_value_issue(value,shape,name)
% Nie zmieniamy danych obliczeń tylko po to, by narysować wykres.
message = '';
if isempty(value)
    message = sprintf('%s: wynik jest pusty. Uzupełnij obliczenia.',name);
elseif ~isa(value,'double') || ~isreal(value)
    message = sprintf('%s: oczekiwano rzeczywistej tablicy double.',name);
elseif ~isequal(size(value),shape)
    message = sprintf('%s: nieprawidłowy rozmiar.',name);
end
if ~isempty(message)
    message = sprintf('%s Oczekiwany rozmiar: %s, otrzymany: %s.', ...
        message,mat2str(shape),mat2str(size(value)));
end
end

function draw_filter(result, save_png)
% Grafika nie zmienia historii. Pomija wartości bez skończonego logarytmu.
    [ready,message] = plot_ready(result);
    if ~ready
        fprintf('%s\n',message);
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
    ax = subplot(1, 2, 1);
    draw_history(result.jacobi, result.direct, 'Jacobi');
    set(ax, 'Tag', 'lab3_z6_jacobi');
    ax = subplot(1, 2, 2);
    draw_history(result.gauss_seidel, result.direct, 'Gauss-Seidel');
    set(ax, 'Tag', 'lab3_z6_gauss_seidel');
    if save_png == 1
        exportgraphics(fig, 'lab3_zadanie6.png');
    end
end

function draw_history(run, direct, method_name)
    k = (0:run.iterations)';
    values = run.res_history;
    values(~isfinite(values) | values <= 0) = NaN;
    semilogy(k, values, 'LineWidth', 1.4, 'Tag', 'residual_history');
    hold on
    if isfinite(direct.res_norm) && direct.res_norm > 0
        semilogy([0 max(1, run.iterations)], ...
            [direct.res_norm direct.res_norm], '--', 'LineWidth', 1.2, ...
            'Tag', 'direct_residual');
        legend(method_name, 'Rozwiązanie przez A\b', ...
            'Location', 'best', 'Interpreter', 'none');
    else
        legend(method_name, 'Location', 'best');
    end
    hold off
    xlabel('Numer iteracji k');
    ylabel('Norma residuum');
    title({method_name; sprintf('k=%d, końcowa norma: %.3g', ...
        run.iterations, run.res_history(end))});
    grid on
end

% Wstaw poniżej własne solvery z zadań 3 i 4.

function [x, res_history, iterations] = ...
        solve_jacobi(A, b, x0, tol, max_iter)
%===============================================================================
% UZUPEŁNIJ: wstaw solver z zadania 3, bez budowy danych i wykresów.
% Historia: od x0 do ostatniego x, także końcowe NaN/Inf.
% iterations = numel(res_history)-1.
    x = [];
    res_history = [];
    iterations = [];
%===============================================================================
end

function [x, res_history, iterations] = ...
        solve_gauss_seidel(A, b, x0, tol, max_iter)
%===============================================================================
% UZUPEŁNIJ: wstaw solver z zadania 4, bez budowy danych i wykresów.
% Historia: od x0 do ostatniego x, także końcowe NaN/Inf.
% iterations = numel(res_history)-1.
    x = [];
    res_history = [];
    iterations = [];
%===============================================================================
end
