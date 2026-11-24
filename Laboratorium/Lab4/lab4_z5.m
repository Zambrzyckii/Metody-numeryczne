function result = lab4_z5()
% Uzupełnij obliczenia i wykresy w funkcji velocity_bisection, która
% wyznacza przybliżenie miejsca zerowego velocity_difference metodą bisekcji.
% Przenieś własną bisekcję i rysowanie z zadania 2 oraz cały model
% velocity_difference z zadania 4. Zmień model i jednostki, nie metodę.
%
% Funkcja lab4_z5 zapisuje wyniki velocity_bisection w strukturze result.
% Wyniki liczbowe: double, wektory wierszowe lub kolumnowe.
% result.xvec: wektor kolejnych przybliżeń czasu osiągnięcia celu [s].
% result.xdif: wartości bezwzględne różnic kolejnych przybliżeń [s],
% o długości iterations-1.
% result.xsolution: ostatnie przybliżenie czasu, skalar [s].
% result.ysolution: wartość funkcji różnicy w xsolution, skalar [m/s].
% ysolution jest residuum i zachowuje znak. abs(ysolution) to jego moduł.
% Błąd bezwzględny przybliżenia x to |x-x_*|, gdzie x_* jest dokładnym zerem.
% error_bound to oszacowanie błędu środka przedziału zawierającego zero.
% Gwarancja dotyczy arytmetyki dokładnej. Zaokrąglenia oceń osobno.
% result.iterations: skalar równy liczbie elementów xvec.
% result.a_history, result.b_history: odpowiednio lewe i prawe końce przedziałów
% [s].
% result.fa_history: wartości funkcji na lewych końcach [m/s].
% result.fb_history: wartości funkcji na prawych końcach [m/s].
%
% Każdy z czterech wektorów ma iterations elementów.
% Pierwszy element opisuje stan początkowy.
% Kolejne wartości zapisujemy po podziale, bez nowego wpisu po sukcesie.
% Stan po k podziałach ma indeks k+1. Środek to xvec(k+1).
% Aby zapisać całą figurę do sprawozdania, ustaw lokalnie save_png=1.

save_png = 0;
[xvec, xdif, xsolution, ysolution, iterations, ...
    a_history, b_history, fa_history, fb_history] = ...
    velocity_bisection();
result = struct('xvec', xvec, 'xdif', xdif, ...
    'xsolution', xsolution, 'ysolution', ysolution, ...
    'iterations', iterations, ...
    'a_history', a_history, 'b_history', b_history, ...
    'fa_history', fa_history, 'fb_history', fb_history);
fig = get(groot, 'CurrentFigure');
if save_png == 1 && ~isempty(fig)
    exportgraphics(fig, 'zadanie5.png', 'Resolution', 150);
end
end

% Funkcje lokalne.
function [xvec, xdif, xsolution, ysolution, iterations, ...
    a_history, b_history, fa_history, fb_history] = ...
    velocity_bisection()
% Wyznacza przybliżenie miejsca zerowego funkcji velocity_difference metodą
% bisekcji.
% Wyniki funkcji lokalnej zbiera funkcja główna.
% xvec: wektor kolejnych przybliżeń argumentu [s].
% xdif: abs(diff(xvec)), wektor o jeden element krótszy [s].
% xsolution: ostatnie przybliżenie argumentu, skalar [s].
% ysolution: wartość funkcji różnicy w xsolution, skalar [m/s].
% iterations: skalar równy liczbie elementów xvec.
% Wyniki liczbowe: double, wektory wierszowe lub kolumnowe.
% a_history, b_history: odpowiednio lewe i prawe końce przedziałów [s].
% fa_history: wartości funkcji na lewych końcach [m/s].
% fb_history: wartości funkcji na prawych końcach [m/s].
% Każdy z czterech wektorów ma iterations elementów.
% Pierwszy element opisuje stan początkowy.
% Następne stany zapisujemy po podziale, bez wpisu po sukcesie.
% Stan po k podziałach ma indeks k+1. Środek to xvec(k+1). Wartości fa/fb są
% aktualne.

a = 2; % lewa granica przedziału poszukiwań miejsca zerowego
b = 45; % prawa granica przedziału poszukiwań miejsca zerowego
ytolerance = 1e-8; % tolerancja modułu residuum w jednostkach m/s.
% Mały moduł residuum nie gwarantuje małego błędu przybliżenia.
max_iterations = 1000; % maksymalna liczba iteracji wykonana przez alg. bisekcji

fa = velocity_difference(a);
fb = velocity_difference(b);

% Wektory zapisują stan początkowy i stany po wykonanych podziałach.
% a_history, b_history: odpowiednio lewe i prawe końce przedziałów.
% fa_history: wartości funkcji na lewych końcach [m/s].
% fb_history: wartości funkcji na prawych końcach [m/s].
a_history = [];
b_history = [];
fa_history = [];
fb_history = [];
xvec = [];
xdif = [];
xsolution = Inf;
ysolution = Inf;
iterations = max_iterations;

% Zakończ przy pierwszym przybliżeniu, dla którego moduł bieżącej
% wartości funkcji jest mniejszy od ytolerance.
% Zgłoś error po limicie lub stagnacji bez spełnienia tolerancji.
% Stagnacja: obliczony środek jest równy końcowi przedziału.
% Zapisz początkowe końce i wartości funkcji w pierwszych
% elementach czterech wektorów.
a_history(1,1) = a;
b_history(1,1) = b;
fa_history(1,1) = fa;
fb_history(1,1) = fb;

for ii=1:max_iterations
    c = (a + b)/2;
    xvec(ii,1) = c;
    fc = velocity_difference(c);
    if abs(fc) < ytolerance
        xsolution = c;
        ysolution = fc;
        iterations = ii;
        break
    end
    if c == a || c == b
        error('lab4:stagnation', ...
            'Bisekcja: stagnacja przed spełnieniem tolerancji residuum.');
    end
    if fa*fc < 0
        b = c;
        fb = fc;
    else
        a = c;
        fa = fc;
    end
    a_history(ii+1,1) = a;
    b_history(ii+1,1) = b;
    fa_history(ii+1,1) = fa;
    fb_history(ii+1,1) = fb;
    if ii == max_iterations
        error('lab4:iterationLimit', ...
            'Bisekcja: limit iteracji bez spełnienia tolerancji residuum.');
    end
end
xdif = abs(diff(xvec));

% Oblicz lokalne error_bound i zinterpretuj je w jednostkach
% argumentu zgodnie z instrukcją.
error_bound = (b_history(end) - a_history(end))/2;

% Przygotowanie figury jest dostarczone. Uzupełnij tylko miejsca PLOT.
% Możesz zmieniać podpisy i dodawać oznaczenia bez zasłaniania danych.
figure('WindowStyle','normal');
subplot(2,1,1);
plot(1:iterations, xvec, 'o-');
xlabel('Numer iteracji');
ylabel('Przybliżenie czasu [s]');
title('Bisekcja: kolejne przybliżenia');
subplot(2,1,2);
interval_widths = b_history - a_history;
division_numbers = 0:iterations-1;
semilogy(division_numbers, interval_widths, 'o-');
hold on;
semilogy(division_numbers, interval_widths(1)./2.^division_numbers, 's--');
xlabel('Liczba podziałów');
ylabel('Szerokość przedziału [s]');
title('Bisekcja: zmniejszanie szerokości przedziału');
if numel(findobj(gca,'Type','line')) >= 2
    legend('Z zapisanych końców przedziału', ...
        'Ze wzoru teoretycznego');
end
% Koniec dostarczonego przygotowania figury.

end

function velocity_delta = velocity_difference (t)
u = 2200; % prędkość wylotowa gazów [m/s]
m0 = 180000; % masa początkowa [kg]
q = 3000; % szybkość zużywania paliwa [kg/s]
g = 1.622; % przyspieszenie grawitacyjne [m/s^2]
velocity_goal = 850; % prędkość docelowa [m/s]
if t <= 0
    error('lab4:nonpositiveTime', ...
        'Czas musi być dodatni.');
end
velocity = u*log(m0/(m0 - q*t)) - g*t;
velocity_delta = velocity - velocity_goal;
end
