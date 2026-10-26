function [p, x, c, z, k_escape, active] = lab2_z2()
% LAB2_Z2 Czasy ucieczki dla punktów odcinka.
% Wejście: brak. Parametry wybierane wewnątrz funkcji.
% Wyjście:
%   p        - struktura: x_min = -2, x_max = 1 - granice wymagane w MG,
%              b - skalar wspólnej części urojonej, nx - liczba punktów,
%              N - limit iteracji.
%   x        - równomierne współrzędne od p.x_min do p.x_max.
%   c        - punkty zespolone o części urojonej p.b.
%   z        - wartości zamrożone przy ucieczce albo z_N.
%   k_escape - czas ucieczki od 1 do p.N albo 0.
%   active   - maska logiczna punktów bez wykrytej ucieczki.
%              Po obliczeniach: true dokładnie tam, gdzie k_escape == 0.
% Typy: p jest skalarną strukturą z rzeczywistymi skalarami double.
% Wszystkie pozostałe wyniki: pełne wiersze [1, p.nx].
% active ma typ logical. Inne wektory mają typ double.
% c i z mogą być zespolone. Pozostałe wektory są rzeczywiste.
% Zero oznacza brak ucieczki do limitu, nie czas ucieczki równy 0.
% Wykres: jedna figura, czasy ucieczki i osobne oznaczenia zer.
%
% Kod startowy: uzupełnij miejsca oznaczone UZUPEŁNIJ.
% Zastąp [] obliczeniami. Zachowaj nagłówek i wybierz p.b, p.nx oraz p.N.

%===============================================================================
%% 1. Parametry doświadczenia.
p = struct();
% W MG zachowaj p.x_min = -2 i p.x_max = 1. Zmieniaj granice tylko lokalnie.
p.x_min = -2;
p.x_max = 1;
p.b = 0.1;       % Część urojona: od -1.5 do 1.5.
p.nx = 301;       % Całkowita liczba punktów: od 50 do 400.
p.N = 100;       % Całkowity limit iteracji: od 10 do 200.

%% 2. Punkty i stan początkowy.
% UZUPEŁNIJ: przenieś własne przygotowanie x i c z zadania 1.
% https://www.mathworks.com/help/matlab/ref/double.linspace.html
% https://www.mathworks.com/help/matlab/ref/complex.html
x = [];
c = [];
% UZUPEŁNIJ: przygotuj wartości początkowe orbit i k_escape dla całej linii.
% https://www.mathworks.com/help/matlab/ref/zeros.html
% https://www.mathworks.com/help/matlab/ref/double.size.html
z = [];
k_escape = [];
% UZUPEŁNIJ: utwórz maskę logiczną wskazującą początkowo wszystkie punkty.
% active ma ten sam rozmiar co c. Możesz skorzystać z true i size.
% https://www.mathworks.com/help/matlab/ref/true.html
% https://www.mathworks.com/help/matlab/ref/double.size.html
active = [];

%% 3. Czasy ucieczki dla wielu orbit.
% UZUPEŁNIJ wnętrze pętli, rozwijając własną iterację z zadania 1.
% z(active) wybiera elementy wskazane przez true w masce active.
% Użyj tego zapisu po lewej stronie przypisania, aby zmienić tylko te elementy.
for k = 1:p.N
    % Aktualizuj tylko aktywne orbity, z ich własnymi parametrami c.
    % Wśród nich rozpoznaj nowe ucieczki i zapisz ich czas ucieczki.
    % Wyłącz te punkty z dalszych zmian, zachowując wartości z i k_escape.
    % Możesz zakończyć pętlę wcześniej, gdy nie ma aktywnych punktów.
    % https://www.mathworks.com/help/matlab/ref/break.html
end
%===============================================================================

%% Opcjonalny wydruk punktu do pracy lokalnej.
% format long g pokazuje do 15 cyfr znaczących double.
% Ustaw print_point = 1, aby wypisać obie współrzędne przez %.17g.
% To do 17 cyfr znaczących, bez końcowych zer, a nie 17 miejsc po przecinku.
% Zapis pozwala odtworzyć tę samą wartość double. Nie zwiększa jej precyzji.
% W MG pozostaw print_point = 0.
% https://www.mathworks.com/help/matlab/ref/format.html
% https://www.mathworks.com/help/matlab/ref/fprintf.html
% Wybierz point_index od 1 do numel(c).
% Do zadania 3 wymagane jest k_escape(point_index) > 10.
point_index = 1;
print_point = 0;
if print_point == 1
    % Sprawdź, czy wskazany element c istnieje.
    if isnumeric(c) && isvector(c) && isscalar(point_index) && ...
            isreal(point_index) && point_index == fix(point_index) && ...
            point_index >= 1 && point_index <= numel(c)
        fprintf('Punkt c(%d):\n', point_index);
        fprintf('p.c_re = %.17g;\n', real(c(point_index)));
        fprintf('p.c_im = %.17g;\n', imag(c(point_index)));
    else
        warning('LAB2:PointToPrint', ...
            'Najpierw oblicz c i wybierz poprawny indeks point_index.');
    end
end

%% 4. Wykres w kodzie startowym. Nie zmieniaj tej części.
% POCZĄTEK BLOKU WYKRESU DO ZABLOKOWANIA W MATLAB GRADER.
% Rysuj po przygotowaniu x, k_escape i końcowej maski active.
if ~isempty(x) && ~isempty(k_escape) && islogical(active) && ...
        isequal(size(x), size(k_escape), size(active))
    % Dla dociekliwych: te kopie służą tylko wykresowi, nie zmieniają wyników.
    % no_escape jest lokalną kopią końcowej maski active.
    no_escape = active;
    % k_plot zachowuje czasy ucieczki. NaN tworzy przerwy w linii.
    k_plot = k_escape;
    k_plot(no_escape) = NaN;
    % no_escape_plot: kółka na poziomie 0 dla active == true.
    % NaN ukrywa pozostałe kółka.
    no_escape_plot = zeros(size(x));
    no_escape_plot(~no_escape) = NaN;
    % https://www.mathworks.com/help/matlab/ref/plot.html
    % https://www.mathworks.com/help/matlab/ref/nan.html
    fig = figure('Name', 'Czasy ucieczki na linii punktów', ...
        'Color', 'w', 'WindowStyle', 'normal');
    % Okno 1600 x 800 wymaga ekranu >= 1700 x 950. Inaczej domyślne.
    screen_units = get(groot, 'Units');
    set(groot, 'Units', 'pixels');
    screen_size = get(groot, 'ScreenSize');
    set(groot, 'Units', screen_units);
    if all(screen_size(3:4) >= [1700 950])
        set(fig, 'Units', 'pixels', 'Position', [50 50 1600 800]);
    end
    % Jasne tło i czytelne podpisy także przy ciemnym motywie MATLAB-a.
    if isprop(fig, 'Theme')
        fig.Theme = 'light';
    end
    % Pokaż czasy ucieczki, a na poziomie 0 brak ucieczki do limitu.
    plot(x, k_plot, '.-', 'LineWidth', 1);
    hold on;
    plot(x, no_escape_plot, 'ko', 'MarkerSize', 3);
    hold off;
    grid on;
    xlim([p.x_min p.x_max]);
    ylim([-1 p.N + 1]);
    xlabel('Re(c)');
    ylabel('Czas ucieczki');
    legend('Czas ucieczki', ...
        sprintf('0: brak ucieczki do N = %d', p.N), 'Location', 'best');
    title(sprintf('Im(c) = %.3g, nx = %d, N = %d', p.b, p.nx, p.N));
end
% KONIEC BLOKU WYKRESU DO ZABLOKOWANIA W MATLAB GRADER.

%% Zapis wykresu do sprawozdania.
% Zapisz PNG lokalnie do sprawozdania: odkomentuj save_png = 1.
% W MG pozostaw 0. Plik w bieżącym katalogu zostanie nadpisany.
% https://www.mathworks.com/help/matlab/ref/exportgraphics.html
save_png = 0;
% save_png = 1;
if save_png == 1
    % Zapisuj wyłącznie figurę utworzoną w tym wywołaniu funkcji.
    % https://www.mathworks.com/help/matlab/ref/exist.html
    % https://www.mathworks.com/help/matlab/ref/isgraphics.html
    if exist('fig', 'var') && isgraphics(fig, 'figure') && ...
            ~isempty(findall(fig, 'Type', 'line'))
        exportgraphics(fig, 'lab2_zadanie2.png', 'Resolution', 200);
    else
        warning('LAB2:NoFigure', ...
            'Najpierw uzupełnij obliczenia i utwórz wykres.');
    end
end

end
