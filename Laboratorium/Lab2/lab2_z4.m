function [p, x, y, X, Y, C, z3] = lab2_z4()
% LAB2_Z4 Wartości z_3 dla punktów siatki prostokątnej.
% Wejście: brak. Parametry wybierane wewnątrz funkcji.
% Wyjście:
%   p  - skalarna struktura: x_min, x_max, y_min, y_max
%          określają okno, nx i ny - liczby punktów na osiach.
%   x  - wiersz współrzędnych poziomych [1, p.nx].
%   y  - wiersz współrzędnych pionowych [1, p.ny].
%   X  - współrzędne poziome, macierz [p.ny, p.nx].
%   Y  - współrzędne pionowe, macierz [p.ny, p.nx].
%   C  - parametry X + 1i*Y, macierz [p.ny, p.nx].
%   z3 - wartości z_3 dla wszystkich C, macierz [p.ny, p.nx].
%          Każda orbita zaczyna się od z_0 = 0 i wykonuje trzy kroki.
% Typy: pola p są rzeczywistymi skalarami double.
% Pozostałe wyniki są pełnymi, skończonymi tablicami double.
% C i z3 mogą być zespolone. Pozostałe tablice są rzeczywiste.
% Wiersz macierzy odpowiada y, a kolumna odpowiada x.
% Nie zatrzymuj orbit po przekroczeniu modułu 2.
% Wykres 2D: abs(z3) we współrzędnych punktów c, w jednej figurze.
%
% Kod startowy: uzupełnij miejsca oznaczone UZUPEŁNIJ.
% Zastąp puste [] obliczeniami. Zachowaj nagłówek funkcji.
% Rysowanie jest pomijane, dopóki potrzebne tablice są puste.

%===============================================================================
%% 1. Parametry doświadczenia.
% To zadanie możesz wykonać niezależnie od iteracji z zadań 2 i 3.
p = struct();
p.x_min = -2;    % -2 <= x_min < x_max <= 1.
p.x_max = 1;
p.y_min = -1.5;  % -1.5 <= y_min < y_max <= 1.5.
p.y_max = 1.5;
p.nx = 151;     % Całkowita liczba kolumn: od 5 do 300.
p.ny = 101;     % Całkowita liczba wierszy: od 5 do 300.

%% 2. Współrzędne i siatka.
% UZUPEŁNIJ: przygotuj wiersze współrzędnych x i y przez linspace.
% https://www.mathworks.com/help/matlab/ref/double.linspace.html
x = [];
y = [];
% UZUPEŁNIJ: zastąp dwa poniższe przypisania wywołaniem meshgrid.
% Liczba wierszy macierzy ma wynosić p.ny, a liczba kolumn p.nx.
% https://www.mathworks.com/help/matlab/ref/meshgrid.html
X = [];
Y = [];

%% 3. Parametry zespolone i trzeci krok rekurencji.
% UZUPEŁNIJ: zbuduj C z części rzeczywistej X i części urojonej Y.
% https://www.mathworks.com/help/matlab/ref/complex.html
C = [];
% UZUPEŁNIJ: dla każdego elementu C wyznacz z_3, zaczynając od z_0 = 0.
% Wykonaj dokładnie trzy kroki, również gdy moduł wcześniej przekroczy 2.
% Użyj potęgowania element po elemencie: .^ zamiast potęgowania macierzy ^.
% Możesz skorzystać z zeros i size do przygotowania wartości początkowych.
% https://www.mathworks.com/help/matlab/ref/zeros.html
% https://www.mathworks.com/help/matlab/ref/double.size.html
% https://www.mathworks.com/help/matlab/ref/double.power.html
z3 = [];

% Możesz zmienić jet(64) (Jet, 64 kolory), np. na:
% parula(64) - Parula, 64 kolory,
% https://www.mathworks.com/help/matlab/ref/parula.html
% turbo(128) - Turbo, 128 kolorów,
% https://www.mathworks.com/help/matlab/ref/turbo.html
% hot(32) - Hot, 32 kolory.
% https://www.mathworks.com/help/matlab/ref/hot.html
% Liczba kolorów nie zmienia siatki ani obliczonych wartości z3.
% https://www.mathworks.com/help/matlab/ref/jet.html
plot_colormap = jet(64);
%===============================================================================

%% 4. Wykres 2D modułów w kodzie startowym. Nie wymaga uzupełniania.
% Rysujemy abs(z3), zachowując zespolone wartości zwracanego z3.
if ~isempty(x) && ~isempty(y) && ~isempty(z3)
    fig = figure('Name', 'Moduły po trzech krokach rekurencji', ...
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
    % Kolumnom przypisz współrzędne x, a wierszom współrzędne y.
    % https://www.mathworks.com/help/matlab/ref/imagesc.html
    % https://www.mathworks.com/help/matlab/ref/double.abs.html
    imagesc(x, y, abs(z3));
    % Ustaw kierunek osi y oraz jednakową długość jednostki na obu osiach.
    % https://www.mathworks.com/help/matlab/ref/axis.html
    axis xy;
    axis equal;
    % Pokaż dokładnie wybrane okno parametrów zespolonych c.
    % https://www.mathworks.com/help/matlab/ref/xlim.html
    % https://www.mathworks.com/help/matlab/ref/ylim.html
    xlim([p.x_min p.x_max]);
    ylim([p.y_min p.y_max]);
    % Zastosuj paletę wybraną w edytowanym bloku kodu.
    % https://www.mathworks.com/help/matlab/ref/colormap.html
    colormap(plot_colormap);
    color_bar = colorbar;
    color_bar.Label.String = '|z_3|';
    xlabel('Re(c)');
    ylabel('Im(c)');
    title(sprintf('Moduł z_3: nx = %d, ny = %d', p.nx, p.ny));
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
            ~isempty(findall(fig, 'Type', 'image'))
        exportgraphics(fig, 'lab2_zadanie4.png', 'Resolution', 200);
    else
        warning('LAB2:NoFigure', ...
            'Najpierw uzupełnij obliczenia i utwórz wykres.');
    end
end

end
