function result = lab4_z6()
% Porównaj własne implementacje bisekcji i siecznych dla modelu rakiety.
% Przenieś velocity_bisection z zadania 5 i metodę siecznych z zadania 3
% do velocity_secant. Usuń ich osobne wykresy. Skopiuj cały model
% velocity_difference z zadania 4 i uzupełnij plot_comparison.
%
% Funkcja lab4_z6 wywołuje obie metody, wyświetla zestawienie wyników
% i uruchamia wspólne rysowanie. Te wywołania są dostarczone.
% result.bisection i result.secant: struktury wyników odpowiednich metod.
% W każdej strukturze znajdują się pola:
% xvec: wektor kolejnych przybliżeń czasu [s],
% xdif: wartości bezwzględne różnic kolejnych przybliżeń [s],
%   o długości iterations-1,
% xsolution: ostatnie przybliżenie czasu, skalar [s],
% ysolution: wartość velocity_difference(xsolution), skalar [m/s],
% ysolution jest residuum i zachowuje znak. abs(ysolution) to jego moduł.
% Błąd bezwzględny przybliżenia x to |x-x_*|, gdzie x_* jest dokładnym zerem.
% error_bound to oszacowanie błędu środka przedziału zawierającego zero.
% Gwarancja dotyczy arytmetyki dokładnej. Zaokrąglenia oceń osobno.
% iterations: skalar równy liczbie elementów xvec.
% Przykładowo result.secant.xvec zawiera kolejne przybliżenia metody siecznych,
% bez jej dwóch punktów startowych.
%
% result.bisection zawiera wektory po iterations elementów:
% a_history i b_history: odpowiednio lewe i prawe końce [s],
% fa_history i fb_history: wartości funkcji na tych końcach [m/s].
% Pierwsze elementy wektorów opisują stan przed pierwszym podziałem.
% Kolejne wpisy powstają po podziale, z aktualnymi wartościami funkcji.
% Stan po k podziałach ma indeks k+1, bez nowego wpisu po sukcesie.
% Środek tego przedziału to result.bisection.xvec(k+1).
% Wszystkie liczby: double. Wektory wierszowe lub kolumnowe.
% Aby zapisać figurę do sprawozdania, ustaw lokalnie save_png=1.

save_png = 0;
result = compare_methods();
display_comparison(result);
plot_comparison(result);
fig = get(groot,'CurrentFigure');
if save_png == 1 && ~isempty(fig)
    exportgraphics(fig,'zadanie6.png','Resolution',150);
end
end

% Funkcje lokalne.
function result = compare_methods()
[xvec, xdif, xsolution, ysolution, iterations, ...
    a_history, b_history, fa_history, fb_history] = ...
    velocity_bisection();
result.bisection = struct('xvec', xvec, 'xdif', xdif, ...
    'xsolution', xsolution, 'ysolution', ysolution, ...
    'iterations', iterations, ...
    'a_history', a_history, 'b_history', b_history, ...
    'fa_history', fa_history, 'fb_history', fb_history);
[xvec, xdif, xsolution, ysolution, iterations] = velocity_secant();
result.secant = struct('xvec', xvec, 'xdif', xdif, ...
    'xsolution', xsolution, 'ysolution', ysolution, ...
    'iterations', iterations);
end

function display_comparison(result)
% Ten blok wyświetla dane. Interpretację przeprowadź samodzielnie.
fprintf('Metoda       t [s]              |F(t)| [m/s]     Iteracje\n');
for name = {'bisection','secant'}
    data = result.(name{1});
    fprintf('%-10s %18.12f %18.10e %8d\n', name{1}, ...
        data.xsolution, abs(data.ysolution), data.iterations);
end
bound = (result.bisection.b_history(end) - ...
    result.bisection.a_history(end))/2;
fprintf('Bisekcja: oszacowanie błędu czasu = %.10e s\n', bound);
end

function plot_comparison(result)
% Wykorzystaj własne polecenia rysowania i dostosuj dane do porównania.
% Przygotowanie figury jest dostarczone. Uzupełnij tylko miejsca PLOT.
% Każda metoda ma własne numery iteracji. Nie dopełniaj krótszego wektora.
% Residua oblicz dla wszystkich xvec funkcją velocity_difference.
% Na osi logarytmicznej zero nie ma położenia. Zachowaj je w danych,
% a brak punktu wyjaśnij własną adnotacją, jeśli taka sytuacja wystąpi.
figure('WindowStyle','normal');
subplot(2,1,1);
plot(1:result.bisection.iterations, result.bisection.xvec, 'o-');
hold on;
plot(1:result.secant.iterations, result.secant.xvec, 's-');
xlabel('Numer iteracji');
ylabel('Przybliżenie czasu [s]');
title('Czas osiągnięcia 850 m/s: przybliżenia');
if numel(findobj(gca,'Type','line')) >= 2
    legend('Bisekcja','Sieczne');
end
subplot(2,1,2);
bisection_residuals = abs(arrayfun(@velocity_difference, ...
    result.bisection.xvec));
secant_residuals = abs(arrayfun(@velocity_difference, ...
    result.secant.xvec));
semilogy(1:result.bisection.iterations, bisection_residuals, 'o-');
hold on;
semilogy(1:result.secant.iterations, secant_residuals, 's-');
hold on;
yline(1e-8,'--','Tolerancja residuum', ...
    'LabelHorizontalAlignment','left');
xlabel('Numer iteracji');
ylabel('|F(t)| [m/s]');
title('Spełnienie równania prędkości');
if numel(findobj(gca,'Type','line')) >= 2
    legend('Bisekcja','Sieczne','Tolerancja residuum');
end
% Koniec dostarczonego przygotowania figury.
end

function [xvec, xdif, xsolution, ysolution, iterations, ...
    a_history, b_history, fa_history, fb_history] = ...
    velocity_bisection()
a = 2; % początek przedziału lub pierwszy punkt [s]
b = 45; % koniec przedziału lub drugi punkt [s]
ytolerance = 1e-8; % tolerancja modułu residuum [m/s]
max_iterations = 1000; % limit iteracji

fa = velocity_difference(a);
fb = velocity_difference(b);

a_history = [];
b_history = [];
fa_history = [];
fb_history = [];
xvec = [];
xdif = [];
xsolution = Inf;
ysolution = Inf;
iterations = max_iterations;

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
end

function [xvec,xdif,xsolution,ysolution,iterations] = velocity_secant()
a = 2; % początek przedziału lub pierwszy punkt [s]
b = 45; % koniec przedziału lub drugi punkt [s]
ytolerance = 1e-8; % tolerancja modułu residuum [m/s]
max_iterations = 1000; % limit iteracji

x0 = a;
x1 = b;
f0 = velocity_difference(x0);
f1 = velocity_difference(x1);

xvec = [];
xdif = [];
xsolution = Inf;
ysolution = Inf;
iterations = max_iterations;

for ii=1:max_iterations
    denominator = f1 - f0;
    if denominator == 0
        error('lab4:zeroDenominator', ...
            'Sieczne: zerowy mianownik wzoru siecznych.');
    end
    x2 = x1 - f1*(x1 - x0)/denominator;
    xvec(ii,1) = x2;
    f2 = velocity_difference(x2);
    if abs(f2) < ytolerance
        xsolution = x2;
        ysolution = f2;
        iterations = ii;
        break
    end
    if x2 == x1
        error('lab4:stagnation', ...
            'Sieczne: stagnacja przed spełnieniem tolerancji residuum.');
    end
    x0 = x1;
    f0 = f1;
    x1 = x2;
    f1 = f2;
    if ii == max_iterations
        error('lab4:iterationLimit', ...
            'Sieczne: limit iteracji bez spełnienia tolerancji residuum.');
    end
end
xdif = abs(diff(xvec));
end

function velocity_delta = velocity_difference(t)
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
