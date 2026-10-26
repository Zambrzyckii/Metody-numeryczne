function [p, c, z_history, k_escape] = lab2_z3()
% LAB2_Z3 Historia wybranej orbity.
% Wejście: brak. Parametry wybierane wewnątrz funkcji.
% Wyjście:
%   p         - skalarna struktura: c_re, c_im - części c,
%               N - maksymalna liczba kroków.
%   c         - parametr zespolony, skalar double.
%   z_history - wiersz kolejnych wartości orbity, począwszy od z_0 = 0.
%               Przy ucieczce ma k_escape + 1 elementów.
%               Bez ucieczki do limitu ma p.N + 1 elementów.
%   k_escape  - czas ucieczki albo 0, gdy nie wykryto ucieczki do p.N.
% Typy: pola p są rzeczywistymi skalarami double.
% Wszystkie wyniki liczbowe są pełne, skończone i typu double.
% c i z_history mogą być zespolone. k_escape jest rzeczywistym skalarem.
% Liczba wykonanych kroków wynika z numel(z_history) - 1.
% Do zaliczenia wybierz punkt z zadania 2: 10 < k_escape <= p.N.
% Wykres: jedna figura, osobne panele orbity i modułu.
%
% Kod startowy: uzupełnij miejsca oznaczone UZUPEŁNIJ.
% Zastąp puste [] obliczeniami. Zachowaj nagłówek funkcji.
% Rysowanie jest pomijane, dopóki potrzebne tablice są puste.

%===============================================================================
%% 1. Punkt wybrany z wykresu czasów ucieczki w zadaniu 2.
% Wybierz indeks j, dla którego k_escape(j) > 10.
% Przepisz dokładne x(j), b i N z tamtego doświadczenia do pól poniżej.
% Początkowe c_re = 2 i c_im = 2 są poza zakresem. Zmień obie wartości.
% Gdy nie ma takiego punktu, zmień b lub N i ponów zadanie 2.
p = struct();
% UZUPEŁNIJ: część rzeczywista wybranego punktu, od -2 do 1.
p.c_re = 2;
% UZUPEŁNIJ: część urojona tego samego punktu, od -1.5 do 1.5.
p.c_im = 2;
% Całkowity limit iteracji: od 11 do 200.
p.N = 100;

%% 2. Parametr zespolony i miejsce na historię.
% UZUPEŁNIJ: połącz p.c_re i p.c_im w jeden skalar zespolony.
% https://www.mathworks.com/help/matlab/ref/complex.html
c = [];
% Kod startowy przydziela pamięć przed pętlą. Indeks 1 przechowuje z_0.
% https://www.mathworks.com/help/matlab/ref/zeros.html
z = 0;
z_history = zeros(1, p.N + 1);
z_history(1) = z;
% Zero oznacza brak wykrytej ucieczki.
k_escape = 0;

%% 3. Historia jednej orbity.
% UZUPEŁNIJ wnętrze pętli. Rozwiń własną rekurencję z zadań 1 i 2.
for k = 1:p.N
    % Oblicz nowe z i zapisz je w historii.
    % Dopiero wtedy sprawdź przekroczenie promienia 2.
    % Zapisz czas ucieczki i zakończ pętlę przez break.
    % https://www.mathworks.com/help/matlab/ref/break.html
    % Moduł równy 2 nie spełnia kryterium wykrycia ucieczki.
end

%===============================================================================

%% Opcjonalny wydruk punktu do pracy lokalnej.
% format long g pokazuje do 15 cyfr znaczących double.
% print_point = 1 wypisuje obie części c z %.17g. W MG pozostaw 0.
% To do 17 cyfr znaczących, nie miejsc po przecinku, bez końcowych zer.
% Pozwala odtworzyć double po skopiowaniu, bez zwiększania precyzji obliczeń.
% https://www.mathworks.com/help/matlab/ref/format.html
% https://www.mathworks.com/help/matlab/ref/fprintf.html
print_point = 0;
if print_point == 1
    if isnumeric(c) && isscalar(c)
        fprintf('Punkt c:\n');
        fprintf('p.c_re = %.17g;\n', real(c));
        fprintf('p.c_im = %.17g;\n', imag(c));
    else
        warning('LAB2:PointToPrint', ...
            'Najpierw oblicz skalar c.');
    end
end

%% 4. Skrócenie historii w kodzie startowym. Nie wymaga uzupełniania.
% Zachowujemy k_escape + 1 wartości: z_0 i kroki do ucieczki włącznie.
% Bez ucieczki pozostaje cały bufor N + 1 obliczonych wartości.
if k_escape > 0
    z_history = z_history(1:(k_escape + 1));
end

%% 5. Wizualizacja w kodzie startowym. Nie wymaga uzupełniania.
if ~isempty(c) && ~isempty(z_history)
    % Dla dociekliwych: numery kroków i moduły służą tylko do rysowania.
    % Liczba kroków jest o jeden mniejsza od liczby zapisanych wartości.
    % https://www.mathworks.com/help/matlab/ref/double.numel.html
    % https://www.mathworks.com/help/matlab/ref/double.colon.html
    iterations = 0:(numel(z_history) - 1);
    % https://www.mathworks.com/help/matlab/ref/double.abs.html
    abs_history = abs(z_history);
    fig = figure('Name', 'Historia wybranej orbity', ...
        'Color', 'w', 'WindowStyle', 'normal');
    % Okno 1600 x 800 wymaga ekranu >= 1700 x 950. Inaczej domyślne.
    screen_units = get(groot, 'Units');
    set(groot, 'Units', 'pixels');
    screen_size = get(groot, 'ScreenSize');
    set(groot, 'Units', screen_units);
    if all(screen_size(3:4) >= [1700 950])
        set(fig, 'Units', 'pixels', 'Position', [50 50 1600 800]);
    end
    % Zachowaj czytelne podpisy również przy ciemnym motywie MATLAB-a.
    if isprop(fig, 'Theme')
        fig.Theme = 'light';
    end
    % Lewy panel pokazuje położenia kolejnych wartości z_k.
    subplot(1, 2, 1);
    plot(real(z_history), imag(z_history), 'o-', 'LineWidth', 1.2);
    axis equal;
    grid on;
    xlabel('Re(z_k)');
    ylabel('Im(z_k)');
    title(sprintf('Orbita dla c = %.3g %+.3gi', p.c_re, p.c_im));

    % Prawy panel pokazuje moduły w kolejnych krokach i poziom odniesienia.
    subplot(1, 2, 2);
    plot(iterations, abs_history, 'o-', 'LineWidth', 1.2);
    hold on;
    plot([0 p.N], [2 2], 'r--', 'LineWidth', 1.2);
    hold off;
    grid on;
    xlim([0 p.N]);
    xlabel('Numer iteracji k');
    ylabel('|z_k|');
    legend('|z_k|', 'Poziom 2', 'Location', 'best');
    if k_escape > 0
        title(sprintf('Czas ucieczki: %d', k_escape));
    else
        title(sprintf('Brak ucieczki do N = %d', p.N));
    end
end

%% Zapis wykresu do sprawozdania.
% Zapisz PNG lokalnie do sprawozdania: odkomentuj save_png = 1.
% W MG pozostaw 0. Plik w bieżącym katalogu zostanie nadpisany.
% https://www.mathworks.com/help/matlab/ref/exportgraphics.html
save_png = 0;
% save_png = 1;
if save_png == 1
    % Zapisz całą figurę z oboma panelami utworzoną w tym wywołaniu.
    % https://www.mathworks.com/help/matlab/ref/exist.html
    % https://www.mathworks.com/help/matlab/ref/isgraphics.html
    if exist('fig', 'var') && isgraphics(fig, 'figure') && ...
            ~isempty(findall(fig, 'Type', 'line'))
        exportgraphics(fig, 'lab2_zadanie3.png', 'Resolution', 200);
    else
        warning('LAB2:NoFigure', ...
            'Najpierw uzupełnij obliczenia i utwórz wykres.');
    end
end

end
