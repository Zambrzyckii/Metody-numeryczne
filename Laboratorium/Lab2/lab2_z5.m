function [p, x, y, X, Y, C, F, K, B] = lab2_z5()
% LAB2_Z5 Interaktywna wizualizacja zbioru Mandelbrota.
% Wejście: brak. Parametry obu paneli są zdefiniowane poniżej.
% p - tablica dwóch struktur. p(1) opisuje lewy, p(2) prawy panel.
% Pola: x_min, x_max, y_min, y_max, nx, ny i N.
% Zwrócone p(2) zawiera granice po dopasowaniu proporcji okna.
% x, y, X, Y, C, F, K, B - osobne tablice komórkowe 1 x 2.
% Indeks {1} wskazuje wynik lewego panelu, a {2} prawego panelu.
% Znaczenie każdego wyniku podaje calculate_mandelbrot_fractal poniżej.
% Przykład: K{2} zawiera macierz czasów ucieczki prawego panelu.
% Zmieniasz sześć wskazanych parametrów i uzupełniasz obliczenia.
% Pozostała część kodu startowego nie wymaga uzupełniania.

%% Gęstość siatki obu obrazów.
% Zachowaj scale = 4: 961 punktów na osi x i 801 na osi y.
scale = 4;

%% Parametry pierwszego obrazu: cały zbiór w ustalonym oknie.
% Wartość stała: -2. Nie zmieniaj.
p(1).x_min = -2;
% Wartość stała: 1. Nie zmieniaj.
p(1).x_max = 1;
% Wartość stała: -1.5. Nie zmieniaj.
p(1).y_min = -1.5;
% Wartość stała: 1.5. Nie zmieniaj.
p(1).y_max = 1.5;
% Siatka zadania: 240*scale + 1 punktów. Nie zmieniaj wzoru.
p(1).nx = 240*scale + 1;
% Siatka zadania: 200*scale + 1 punktów. Nie zmieniaj wzoru.
p(1).ny = 200*scale + 1;
%===============================================================================
% MOŻESZ ZMIENIĆ: liczba całkowita od 20 do 300.
p(1).N = 80;

%% Parametry drugiego obrazu: wybierz mniejszy fragment brzegu.
% Zastąp cztery [] granicami wybranego obszaru.
% Pole po dopasowaniu proporcji: dodatnie i mniejsze od 1e-10.
% Kod startowy symetrycznie poszerzy krótszy bok do proporcji 1:1.
% Wymagany udział zer w K: od 10% do 90%, z końcami włącznie.
% ZMIEŃ: co najmniej -2 i mniej niż p(2).x_max.
p(2).x_min = -0.08564456432056454;
% ZMIEŃ: więcej niż p(2).x_min i co najwyżej 1.
p(2).x_max = -0.085643681798233437;
% ZMIEŃ: co najmniej -1.5 i mniej niż p(2).y_max.
p(2).y_min = 0.8753943460402398;
% ZMIEŃ: więcej niż p(2).y_min i co najwyżej 1.5.
p(2).y_max = 0.87539522856257102;
% Siatka zadania: 240*scale + 1 punktów. Nie zmieniaj wzoru.
p(2).nx = 240*scale + 1;
% Siatka zadania: 200*scale + 1 punktów. Nie zmieniaj wzoru.
p(2).ny = 200*scale + 1;
% MOŻESZ ZMIENIĆ: liczba całkowita od 20 do 300.
p(2).N = 80;
%===============================================================================

%% POCZĄTEK BLOKU KODU STARTOWEGO DO ZABLOKOWANIA W MATLAB GRADER.
% Tablice 1 x 2 przechowują osobno wyniki lewego i prawego panelu.
% Nawiasy {} udostępniają zawartość komórki, np. K{2} to prawy wynik.
% https://www.mathworks.com/help/matlab/ref/cell.html
x = cell(1, 2);
y = cell(1, 2);
X = cell(1, 2);
Y = cell(1, 2);
C = cell(1, 2);
F = cell(1, 2);
K = cell(1, 2);
B = cell(1, 2);

fig = figure('Name', 'Interaktywna wizualizacja zbioru Mandelbrota', ...
    'Color', 'w', 'WindowStyle', 'normal', ...
    'MenuBar', 'none', 'ToolBar', 'none');
% Okno 1600 x 800 wymaga ekranu >= 1700 x 950. Inaczej domyślne.
screen_units = get(groot, 'Units');
set(groot, 'Units', 'pixels');
screen_size = get(groot, 'ScreenSize');
set(groot, 'Units', screen_units);
if all(screen_size(3:4) >= [1700 950])
    set(fig, 'Units', 'pixels', 'Position', [50 50 1600 800]);
end
if isprop(fig, 'Theme')
    fig.Theme = 'light';
end

% Pierwsze wywołanie: obliczenia całego okna, wyniki w komórkach {1}.
[x{1}, y{1}, X{1}, Y{1}, C{1}, F{1}, K{1}, B{1}] = ...
    calculate_mandelbrot_fractal(p(1).x_min, p(1).x_max, ...
    p(1).y_min, p(1).y_max, p(1).nx, p(1).ny, p(1).N);
plot_mandelbrot_fractal(1, p(1), x{1}, y{1}, K{1});

% Choć jedna pusta granica pomija prawy panel, zachowując lewy.
if isempty(p(2).x_min) || isempty(p(2).x_max) || ...
        isempty(p(2).y_min) || isempty(p(2).y_max)
    show_mandelbrot_message(2, ...
        ['Uzupełnij cztery granice prawego okna. ' ...
        'Puste [] oznacza, że obszar nie został jeszcze wybrany.']);
else
    % Drugie wywołanie: wybrany fragment, wyniki w komórkach {2}.
    % Błąd prawego panelu nie odbiera wyników poprawnego lewego panelu.
    try
        % Zachowaj środek i rozszerz krótszy bok jak w lewym oknie.
        p(2) = normalize_mandelbrot_window(p(2), p(1));
        [x{2}, y{2}, X{2}, Y{2}, C{2}, F{2}, K{2}, B{2}] = ...
            calculate_mandelbrot_fractal(p(2).x_min, p(2).x_max, ...
            p(2).y_min, p(2).y_max, p(2).nx, p(2).ny, p(2).N);
        plot_mandelbrot_fractal(2, p(2), x{2}, y{2}, K{2});
    catch ME
        fprintf('Panel 2: nie można ukończyć obrazu: %s\n', ME.message);
        show_mandelbrot_message(2, ME.message);
    end
end
% KONIEC BLOKU KODU STARTOWEGO DO ZABLOKOWANIA W MATLAB GRADER.

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
        exportgraphics(fig, 'lab2_zadanie5.png', 'Resolution', 200);
    else
        warning('LAB2:NoFigure', ...
            'Najpierw uzupełnij obliczenia i utwórz wykres.');
    end
end

%% Automatyczny podgląd interaktywny poprawnych wykresów 2D.
% Zoom działa dla paneli z danymi do rysowania. Ustaw 0, aby go wyłączyć.
% Przeciągnij prostokąt lewym przyciskiem, aby przeliczyć wybrany obszar.
% Oddal ×2, prawy klik lub Shift + klik podwaja oba wymiary,
% najwyżej do obszaru początkowego. Kółko zmienia skalę dwukrotnie.
% Widok początkowy lub dwuklik przywraca początkowy obszar panelu.
% Granice z tytułu lub okna poleceń przepisz do p(2) i uruchom kod ponownie.
% Zoom nie zmienia zwróconych wyników ani p. Przy save_png = 1 odświeża PNG.
interactive_zoom = 1;
if interactive_zoom == 1
    configure_mandelbrot_zoom(fig, p, save_png);
end

end

function [x, y, X, Y, C, F, K, B] = calculate_mandelbrot_fractal( ...
    x_min, x_max, y_min, y_max, nx, ny, N)
% CALCULATE_MANDELBROT_FRACTAL Oblicza dane wykresu 2D czasów ucieczki.
% Funkcja nie rysuje i nie wybiera parametrów powiększenia.
% Wejścia: granice prostokąta, liczby punktów na osiach i limit iteracji.
% x, y - wiersze współrzędnych, rozmiary [1,nx] oraz [1,ny].
% X, Y - macierze współrzędnych. X(r,j)=x(j), Y(r,j)=y(r).
% C    - macierz parametrów zespolonych X + 1i*Y.
% F    - wartości orbit przy pierwszej ucieczce albo po N krokach.
% K    - czasy ucieczki. Zero: brak wykrytej ucieczki do limitu N.
% B    - maska logical, true dokładnie tam, gdzie K jest równe zero.
% Macierze mają rozmiar [ny,nx]. Wiersz odpowiada y, kolumna x.
% Pełne tablice liczbowe mają typ double i skończone wartości.
% C i F mogą być zespolone. Pozostałe tablice liczbowe są rzeczywiste.
% Start: z_0=0. Wykrycie ucieczki: moduł > 2, nie >= 2.
% Nie aktualizujemy orbity po zapisaniu jej czasu ucieczki.

%===============================================================================
%% UZUPEŁNIJ: przygotuj siatkę jak w zadaniu 4.
% linspace uwzględnia końce przedziału, meshgrid łączy wszystkie pary.
% https://www.mathworks.com/help/matlab/ref/double.linspace.html
% https://www.mathworks.com/help/matlab/ref/meshgrid.html
% https://www.mathworks.com/help/matlab/ref/complex.html
x = linspace(x_min, x_max, nx);
y = linspace(y_min, y_max, ny);
[X, Y] = meshgrid(x, y);
C = complex(X, Y);

%% UZUPEŁNIJ: przenieś algorytm czasu ucieczki z zadania 2 na macierze.
% 1. Przygotuj początkowe wartości F, czasy K i maskę aktywności B.
% 2. Aktualizuj tylko aktywne orbity, używając stałych parametrów C.
% 3. Przy pierwszym przekroczeniu modułu 2 zapisz numer kroku w K.
% 4. Wyłącz te punkty w B, zachowując ich wartości F z chwili ucieczki.
% 5. Zakończ po N krokach lub wcześniej, jeśli nie ma aktywnych punktów.
% Pamiętaj o potęgowaniu elementowym .^ i indeksowaniu maską logiczną.
% https://www.mathworks.com/help/matlab/ref/zeros.html
% https://www.mathworks.com/help/matlab/ref/true.html
% https://www.mathworks.com/help/matlab/ref/double.size.html
% https://www.mathworks.com/help/matlab/ref/double.power.html
F = zeros(size(C));
K = zeros(size(C));
B = true(size(C));

for k = 1:N
    F(B) = F(B).^2 + C(B);
    escaped = B & (abs(F) > 2);
    K(escaped) = k;
    B(escaped) = false;
end
%===============================================================================
end

% ======================================================================
% FUNKCJE WIZUALIZACJI Z KODU STARTOWEGO. NIE WYMAGAJĄ UZUPEŁNIANIA.
% Możesz przeanalizować ten blok, lecz jego znajomość nie jest wymagana.
% Pytania dotyczą obliczeń: siatki, iteracji i czasu ucieczki.
% W MATLAB Grader rysowanie i obsługa myszy pozostają zablokowane.
% ======================================================================

function p = normalize_mandelbrot_window(p, base)
% NORMALIZE_MANDELBROT_WINDOW Zachowuje proporcje i środek wybranego okna.
% Poszerz krótszy bok. Nie zmniejszaj pola ani nie przesuwaj środka.
% Zwrócone p opisuje rzeczywisty obszar późniejszych obliczeń i wykresu.
limits = {p.x_min, p.x_max, p.y_min, p.y_max};
valid = cellfun(@(v) isa(v, 'double') && isscalar(v) && ...
    isreal(v) && isfinite(v), limits);
if ~all(valid) || p.x_min >= p.x_max || p.y_min >= p.y_max
    error('LAB2:WindowBounds', ...
        'Podaj cztery liczbowe granice z x_min < x_max i y_min < y_max.');
end
width = p.x_max - p.x_min;
height = p.y_max - p.y_min;
ratio = (base.x_max-base.x_min)/(base.y_max-base.y_min);
% Pomijaj różnicę wynikającą tylko z zaokrągleń zapisu granic w double.
tolerance = 2*(eps(max(abs([p.x_min p.x_max]))) + ...
    ratio*eps(max(abs([p.y_min p.y_max]))));
if width - ratio*height > tolerance
    padding = (width/ratio - height)/2;
    p.y_min = p.y_min - padding;
    p.y_max = p.y_max + padding;
elseif ratio*height - width > tolerance
    padding = (ratio*height - width)/2;
    p.x_min = p.x_min - padding;
    p.x_max = p.x_max + padding;
end
if p.x_min < base.x_min || p.x_max > base.x_max || ...
        p.y_min < base.y_min || p.y_max > base.y_max
    error('LAB2:WindowBounds', ...
        ['Po dopasowaniu proporcji okno wychodzi poza obszar początkowy. ' ...
        'Wybierz mniejszy obszar lub zmień jego położenie.']);
end
end

function plot_mandelbrot_fractal(panel, p, x, y, K)
% PLOT_MANDELBROT_FRACTAL Rysuje wykres 2D czasów ucieczki.
% panel - pozycja 1 lub 2 w układzie 1 x 2 bieżącej figury.
% p - parametry jednego okna. x, y - jego współrzędne, K - czasy ucieczki.
% Funkcja nie zmienia danych. Puste wyniki zastępuje komunikatem.
% Prawy obraz wymaga odpowiedniego pola i udziału zer.
% Pełną poprawność danych sprawdza test zadania.
ax = get_mandelbrot_axes(panel);
ax.Tag = sprintf('MandelbrotPanel%d', panel);
axis(ax, 'off');
message = '';
if ~valid_mandelbrot_map(p, x, y, K)
    message = 'Uzupełnij wyniki funkcji obliczeniowej.';
elseif panel == 2
    % Te dwa warunki realizują etapy zadania, a nie pełną walidację.
    area = (p.x_max - p.x_min) * (p.y_max - p.y_min);
    zero_count = nnz(K == 0);
    if area >= 1e-10
        message = ['Obszar drugiego wykresu jest zbyt duży. ' ...
            'Wybierz mniejszy fragment: pole mniejsze od 1e-10.'];
    elseif zero_count < ceil(0.1*numel(K)) || ...
            zero_count > floor(0.9*numel(K))
        message = sprintf(['Zera zajmują %.1f%% siatki. ' ...
            'Wybierz fragment brzegu z udziałem 10-90%%.'], ...
            100*zero_count/numel(K));
    end
end
if ~isempty(message)
    show_mandelbrot_message(panel, message);
    return;
end

% Kolory pokazują czasy ucieczki. Każdy panel ma własną skalę od 0 do N.
% https://www.mathworks.com/help/matlab/ref/imagesc.html
imagesc(ax, x, y, K, [0 p.N]);
% imagesc resetuje własności osi. Znacznik nadaj dopiero po rysowaniu.
ax.Tag = sprintf('MandelbrotPanel%d', panel);
disableDefaultInteractivity(ax);
ax.Toolbar = [];
% Oś urojona rośnie ku górze. Jednostki obu osi mają równą długość.
% https://www.mathworks.com/help/matlab/ref/axis.html
axis(ax, 'xy');
axis(ax, 'equal');
xlim(ax, [p.x_min p.x_max]);
ylim(ax, [p.y_min p.y_max]);
% Pierwszy kolor to czerń dla K = 0. Pozostałe odpowiadają czasom ucieczki.
% https://www.mathworks.com/help/matlab/ref/colormap.html
colormap(ax, [0 0 0; parula(p.N)]);
color_bar = colorbar(ax);
color_bar.Label.String = 'Czas ucieczki (0: brak do limitu)';
xlabel(ax, 'Re(c)');
ylabel(ax, 'Im(c)');
update_mandelbrot_title(ax, panel, p, K);
end

function show_mandelbrot_message(panel, message)
% SHOW_MANDELBROT_MESSAGE Wyświetla wskazówkę zamiast brakującego obrazu.
ax = get_mandelbrot_axes(panel);
ax.Tag = sprintf('MandelbrotPanel%d', panel);
cla(ax);
axis(ax, 'off');
text(ax, 0.5, 0.5, strrep(message, '. ', newline), ...
    'Units', 'normalized', 'HorizontalAlignment', 'center', ...
    'Interpreter', 'none');
fprintf('Panel %d: %s\n', panel, message);
end

function update_mandelbrot_title(ax, panel, p, K)
% UPDATE_MANDELBROT_TITLE Opisuje parametry aktualnego wykresu 2D.
% Format %.17g podaje do 17 cyfr znaczących, pozwalając odtworzyć double.
area = (p.x_max - p.x_min) * (p.y_max - p.y_min);
title(ax, {sprintf('Panel %d: N = %d, zera %.1f%%', ...
    panel, p.N, 100*nnz(K == 0)/numel(K)), ...
    sprintf('x: [%.17g, %.17g]', p.x_min, p.x_max), ...
    sprintf('y: [%.17g, %.17g]', p.y_min, p.y_max), ...
    sprintf('Pole obszaru: %.17g', area)}, ...
    'FontSize', 10, 'Interpreter', 'none');
end

function ax = get_mandelbrot_axes(panel)
% GET_MANDELBROT_AXES Tworzy osie raz, z miejscem na tytuł i przyciski.
% Jednostki normalized skalują układ razem z oknem, także w R2023b.
fig = gcf;
tag = sprintf('MandelbrotPanel%d', panel);
ax = findobj(fig, 'Type', 'axes', 'Tag', tag);
if isempty(ax)
    ax = axes('Parent', fig, 'Units', 'normalized', ...
        'Position', [0.07+0.49*(panel-1) 0.18 0.36 0.63], 'Tag', tag);
end
end

function configure_mandelbrot_zoom(fig, p, save_png)
% CONFIGURE_MANDELBROT_ZOOM Własna nawigacja bez historii trybu zoom MATLAB-a.
% Granice początkowe są stałe, niezależne od rozmiaru okna i danych obrazu.
if ~isgraphics(fig, 'figure')
    return;
end
has_map = false;
for panel = 1:numel(p)
    ax = findobj(fig, 'Type', 'axes', ...
        'Tag', sprintf('MandelbrotPanel%d', panel));
    if ~isscalar(ax) || ~isscalar(findobj(ax, 'Type', 'image'))
        continue;
    end
    state = struct('parameters', p(panel), 'current', p(panel), ...
        'panel', panel, 'save_png', save_png, ...
        'aspect_ratio', diff(ax.XLim)/diff(ax.YLim));
    state.change_view = @(xl, yl) redraw_mandelbrot_zoom(ax, xl, yl);
    setappdata(ax, 'MandelbrotZoom', state);
    has_map = true;
    % Przyciski odnoszą się do konkretnych osi, nie do bieżącej osi gca.
    left = 0.10 + 0.49*(panel-1);
    uicontrol(fig, 'Style', 'pushbutton', 'Units', 'normalized', ...
        'Position', [left 0.03 0.13 0.045], 'String', 'Oddal ×2', ...
        'Tag', sprintf('MandelbrotOut%d', panel), ...
        'Callback', @(~, ~) scale_mandelbrot_view(ax, 2), ...
        'Interruptible', 'off', 'BusyAction', 'cancel');
    uicontrol(fig, 'Style', 'pushbutton', 'Units', 'normalized', ...
        'Position', [left+0.14 0.03 0.15 0.045], ...
        'String', 'Widok początkowy', ...
        'Tag', sprintf('MandelbrotReset%d', panel), ...
        'Callback', @(~, ~) reset_mandelbrot_view(ax), ...
        'Interruptible', 'off', 'BusyAction', 'cancel');
end
if ~has_map
    return;
end
% Zdarzenia używają współrzędnych osi odczytanych po zmianie rozmiaru.
% Nie włączaj standardowego zoom ani pan: przejmują callbacki figury.
% https://www.mathworks.com/help/matlab/ref/matlab.ui.figure.html
fig.WindowButtonDownFcn = @(source, ~) select_mandelbrot_window(source);
% Callback ruchu zapewnia bieżącą wartość ax.CurrentPoint także dla kółka.
fig.WindowButtonMotionFcn = @(~, ~) [];
fig.WindowScrollWheelFcn = @(source, event) ...
    scroll_mandelbrot_view(source, event);
fig.Interruptible = 'off';
fig.BusyAction = 'cancel';
end

function select_mandelbrot_window(fig)
% SELECT_MANDELBROT_WINDOW Lewy przycisk zaznacza, prawy oddala dwukrotnie.
% Shift + klik także oddala. Dwuklik przywraca obszar początkowy.
if isappdata(fig, 'MandelbrotBusy')
    return;
end
clicked = fig.CurrentObject;
ax = ancestor(clicked, 'axes');
if isempty(ax) || ~isappdata(ax, 'MandelbrotZoom')
    return;
end
point = ax.CurrentPoint(1, 1:2);
if point(1) < ax.XLim(1) || point(1) > ax.XLim(2) || ...
        point(2) < ax.YLim(1) || point(2) > ax.YLim(2)
    return;
end
switch fig.SelectionType
    case {'alt', 'extend'}
        scale_mandelbrot_view(ax, 2);
    case 'open'
        reset_mandelbrot_view(ax);
    case 'normal'
        % rbbox śledzi przeciągnięcie w aktualnej geometrii figury.
        % Nie wymaga Image Processing Toolbox ani przeliczania pikseli.
        % https://www.mathworks.com/help/matlab/ref/rbbox.html
        old_position = fig.Position;
        rbbox;
        if ~isgraphics(ax) || ~isequal(fig.Position, old_position)
            return;
        end
        last = ax.CurrentPoint(1, 1:2);
        xl = sort([point(1), last(1)]);
        yl = sort([point(2), last(2)]);
        % Zaznaczenie pozostaje w aktualnym obrazie. Klik bez ruchu pomijamy.
        xl = max(ax.XLim(1), min(ax.XLim(2), xl));
        yl = max(ax.YLim(1), min(ax.YLim(2), yl));
        if diff(xl) <= 1e-4*diff(ax.XLim) || ...
                diff(yl) <= 1e-4*diff(ax.YLim)
            return;
        end
        state = getappdata(ax, 'MandelbrotZoom');
        state.change_view(xl, yl);
end
end

function scroll_mandelbrot_view(fig, event)
% SCROLL_MANDELBROT_VIEW Jeden ruch kółka zmienia rozmiar obszaru dwa razy.
if event.VerticalScrollCount == 0 || isappdata(fig, 'MandelbrotBusy')
    return;
end
axes_list = findobj(fig, 'Type', 'axes');
for j = 1:numel(axes_list)
    ax = axes_list(j);
    if ~isappdata(ax, 'MandelbrotZoom')
        continue;
    end
    point = ax.CurrentPoint(1, 1:2);
    if point(1) >= ax.XLim(1) && point(1) <= ax.XLim(2) && ...
            point(2) >= ax.YLim(1) && point(2) <= ax.YLim(2)
        scale_mandelbrot_view(ax, 2^sign(event.VerticalScrollCount));
        return;
    end
end
end

function scale_mandelbrot_view(ax, factor)
% SCALE_MANDELBROT_VIEW Skaluje obie długości, zachowując środek i proporcje.
% factor = 2 oznacza dwa razy szerszy i wyższy obszar, czyli cztery razy
% większe pole. Przy brzegu przesuwamy okno w obrębie obszaru początkowego.
xl = mean(ax.XLim) + [-0.5 0.5]*diff(ax.XLim)*factor;
yl = mean(ax.YLim) + [-0.5 0.5]*diff(ax.YLim)*factor;
state = getappdata(ax, 'MandelbrotZoom');
state.change_view(xl, yl);
end

function reset_mandelbrot_view(ax)
% RESET_MANDELBROT_VIEW Przywraca dokładnie początkowe granice tego panelu.
state = getappdata(ax, 'MandelbrotZoom');
p = state.parameters;
state.change_view([p.x_min p.x_max], [p.y_min p.y_max]);
end

function redraw_mandelbrot_zoom(ax, x_limits, y_limits)
% REDRAW_MANDELBROT_ZOOM Najpierw przelicza dane, potem zmienia obraz.
% Błąd obliczeń pozostawia poprzedni obraz, zakresy i tytuł bez zmian.
if ~isgraphics(ax, 'axes') || ~isappdata(ax, 'MandelbrotZoom')
    return;
end
fig = ancestor(ax, 'figure');
if isappdata(fig, 'MandelbrotBusy')
    return;
end
state = getappdata(ax, 'MandelbrotZoom');
p = fit_mandelbrot_window(state.parameters, x_limits, y_limits, ...
    state.aspect_ratio);
if isequal([p.x_min p.x_max p.y_min p.y_max], [ax.XLim ax.YLim])
    return;
end
setappdata(fig, 'MandelbrotBusy', true);
cleanup = onCleanup(@() finish_mandelbrot_navigation(fig));
image_handle = findobj(ax, 'Type', 'image');
try
    % Bez arbitralnej granicy długości boków: węzły muszą być rozróżnialne.
    x_grid = linspace(p.x_min, p.x_max, p.nx);
    y_grid = linspace(p.y_min, p.y_max, p.ny);
    if any(diff(x_grid) <= 0) || any(diff(y_grid) <= 0)
        error('LAB2:ZoomPrecision', ...
            ['Dalsze powiększenie zlewa punkty siatki w arytmetyce ' ...
            'double. Zachowano poprzedni widok.']);
    end
    [x, y, ~, ~, ~, ~, K, ~] = calculate_mandelbrot_fractal( ...
        p.x_min, p.x_max, p.y_min, p.y_max, p.nx, p.ny, p.N);
    if ~valid_mandelbrot_map(p, x, y, K)
        error('LAB2:ZoomData', 'Niepoprawne dane nowego obrazu.');
    end
catch ME
    warning('LAB2:ZoomFailed', 'Nie przeliczono widoku: %s', ME.message);
    return;
end
if ~isgraphics(ax) || ~isscalar(image_handle) || ~isgraphics(image_handle)
    return;
end
% Uchwyt obrazu pozostaje stały, także po maksymalizacji i pomniejszeniu.
set(image_handle, 'XData', [x(1), x(end)], ...
    'YData', [y(1), y(end)], 'CData', K);
ax.XLim = [p.x_min p.x_max];
ax.YLim = [p.y_min p.y_max];
state.current = p;
setappdata(ax, 'MandelbrotZoom', state);
update_mandelbrot_title(ax, state.panel, p, K);
fprintf('Panel %d:\n', state.panel);
fprintf('x_min = %.17g\nx_max = %.17g\n', p.x_min, p.x_max);
fprintf('y_min = %.17g\ny_max = %.17g\n', p.y_min, p.y_max);
if state.save_png == 1
    exportgraphics(fig, 'lab2_zadanie5.png', 'Resolution', 200);
end
end

function finish_mandelbrot_navigation(fig)
% FINISH_MANDELBROT_NAVIGATION Zwalnia blokadę również po błędzie obliczeń.
if isgraphics(fig) && isappdata(fig, 'MandelbrotBusy')
    rmappdata(fig, 'MandelbrotBusy');
end
end

function valid = valid_mandelbrot_map(p, x, y, K)
% VALID_MANDELBROT_MAP Sprawdza tylko dane potrzebne do bezpiecznej grafiki.
% Matematyczną poprawność algorytmu ocenia test zadania, nie wizualizacja.
valid = isnumeric(x) && isreal(x) && isequal(size(x), [1 p.nx]) && ...
    isnumeric(y) && isreal(y) && isequal(size(y), [1 p.ny]) && ...
    all(isfinite(x)) && all(isfinite(y)) && ...
    numel(x) > 1 && numel(y) > 1 && all(diff(x) > 0) && all(diff(y) > 0) && ...
    isnumeric(K) && isreal(K) && isequal(size(K), [p.ny p.nx]) && ...
    all(isfinite(K(:)));
end

function p = fit_mandelbrot_window(p, x_limits, y_limits, aspect_ratio)
% FIT_MANDELBROT_WINDOW Zachowuje proporcje i granice obszaru początkowego.
% Najpierw symetrycznie rozszerza krótszy wymiar zaznaczenia. Jeśli wynik
% dotyka brzegu, przesuwa prostokąt, zachowując jego rozmiar i proporcje.
% Gdy okno osiąga pełny rozmiar, przywraca dokładne granice początkowe.
base_width = p.x_max - p.x_min;
base_height = p.y_max - p.y_min;
width = max(diff(x_limits), aspect_ratio*diff(y_limits));
if width >= base_width*(1-32*eps)
    return;
end
height = width/aspect_ratio;
center_x = max(p.x_min+width/2, min(p.x_max-width/2, mean(x_limits)));
center_y = max(p.y_min+height/2, min(p.y_max-height/2, mean(y_limits)));
% Pełny rozmiar drugiego wymiaru także oznacza widok początkowy.
if height >= base_height*(1-32*eps)
    return;
end
p.x_min = center_x-width/2;
p.x_max = center_x+width/2;
p.y_min = center_y-height/2;
p.y_max = center_y+height/2;
end
