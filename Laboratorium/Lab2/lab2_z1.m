function [b, x, c, z1, z2, z5] = lab2_z1()
% LAB2_Z1 Wybrane wyrazy orbit dla punktów odcinka.
% Wejście: brak. Parametry określasz wewnątrz funkcji.
% Wyjście:
%   b  - wybrana część urojona, rzeczywisty skalar double z [-1.5, 1.5].
%   x  - nx równomiernych współrzędnych od -2 do 1, z końcami włącznie.
%   c  - parametry zespolone x + 1i*b, niezmienne podczas obliczeń.
%   z1 - wartości orbit po pierwszym kroku.
%   z2 - wartości orbit po drugim kroku.
%   z5 - wartości orbit po piątym kroku.
% x, c, z1, z2 i z5 są osobnymi wektorami double o rozmiarze [1, nx].
% nx jest liczbą punktów od 200 do 1000, początkowo 200. nx = numel(x).
% x jest rzeczywisty. c, z1, z2 i z5 mogą być zespolone.
% Wyniki rekurencji zachowujemy bez obcinania wartości.
% Wykres: jedna figura, trzy krzywe |z1|, |z2| i |z5| względem x.
% Granice x, nx, z0 i plot_limit są lokalne, nie są wynikami funkcji.
%
% UZUPEŁNIJ oznacza miejsce na obliczenia. [] oznacza brak wyniku.
% Zastąp puste przypisania obliczeniami, zachowując nagłówek funkcji.

%===============================================================================
%% Parametry doświadczenia.
% W MG zachowaj xmin = -2 i xmax = 1. Zmieniaj granice tylko lokalnie.
xmin = -2;
xmax = 1;
% Liczba punktów: całkowita od 200 do 1000.
nx = 200;
% UZUPEŁNIJ: wybierz rzeczywiste b z przedziału [-1.5, 1.5].
% Początkowe 2 jest poza zakresem i trzeba je zmienić.
b = 2;
% Dodatnia, skończona granica widoku. Nie zmienia wyników obliczeń.
plot_limit = 10;

%% Punkty i stan początkowy.
% UZUPEŁNIJ: utwórz nx równomiernych współrzędnych od xmin do xmax.
% Możesz skorzystać z linspace, które uwzględnia oba końce przedziału.
% https://www.mathworks.com/help/matlab/ref/double.linspace.html
x = [];
% UZUPEŁNIJ: połącz części rzeczywiste x ze wspólną częścią urojoną b.
% Użyj jednostki urojonej 1i albo funkcji complex.
% https://www.mathworks.com/help/matlab/ref/complex.html
c = [];
% UZUPEŁNIJ: przygotuj wartości początkowe dla wszystkich punktów c.
% Pomocne są zeros oraz size do zachowania rozmiaru wektora.
% https://www.mathworks.com/help/matlab/ref/zeros.html
% https://www.mathworks.com/help/matlab/ref/double.size.html
z0 = [];

%% Wartości dla wymaganych numerów kroków.
% UZUPEŁNIJ: oblicz z1 zgodnie z rekurencją podaną w opisie.
% Operator .^ wykonuje potęgowanie każdego elementu wektora osobno.
% https://www.mathworks.com/help/matlab/ref/double.power.html
z1 = [];
% UZUPEŁNIJ: wyznacz z2 na podstawie poprzedniego kroku i tego samego c.
% Możesz ponownie użyć operatorów .^ oraz +.
z2 = [];
% UZUPEŁNIJ: wyznacz z5, uwzględniając również trzeci i czwarty krok.
% Możesz zachować wyniki pośrednie w zmiennych z3 i z4.
z5 = [];
%===============================================================================

%% Wykres modułów wyników z kodu startowego.
% Rysowanie rozpoczyna się po uzupełnieniu potrzebnych wyników.
if ~isempty(x) && ~isempty(z1) && ~isempty(z2) && ~isempty(z5)
    fig = figure('Name', 'Kroki 1, 2 i 5 iteracji Mandelbrota', ...
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
    % abs oblicza moduły bez modyfikowania zespolonych wyników.
    % https://www.mathworks.com/help/matlab/ref/double.abs.html
    % https://www.mathworks.com/help/matlab/ref/plot.html
    plot(x, abs(z1), '-', 'LineWidth', 1.4, 'DisplayName', 'k = 1');
    hold on;
    plot(x, abs(z2), '--', 'LineWidth', 1.4, 'DisplayName', 'k = 2');
    plot(x, abs(z5), ':', 'LineWidth', 1.4, 'DisplayName', 'k = 5');
    hold off;
    grid on;
    % Zmiana zakresu widoku nie obcina danych przekazanych do plot.
    % https://www.mathworks.com/help/matlab/ref/axis.html
    axis([xmin xmax 0 plot_limit]);
    xlabel('Re(c)');
    ylabel('|z_k|');
    legend('show', 'Location', 'best');
    title(sprintf('b = %.3g, nx = %d, próg wykresu = %.3g', ...
        b, nx, plot_limit));
end

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
        exportgraphics(fig, 'lab2_zadanie1.png', 'Resolution', 200);
    else
        warning('LAB2:NoFigure', ...
            'Najpierw uzupełnij obliczenia i utwórz wykres.');
    end
end

end
