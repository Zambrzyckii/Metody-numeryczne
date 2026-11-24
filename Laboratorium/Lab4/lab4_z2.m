function result = lab4_z2()
% Uzupełnij obliczenia i wykresy w funkcji impedance_bisection, która wyznacza
% przybliżenie miejsca zerowego funkcji impedance_difference metodą bisekcji.
%
% Funkcja lab4_z2 zapisuje wyniki funkcji impedance_bisection w strukturze
% result.
%
% result: struktura z wynikami obliczeń.
% Wyniki liczbowe: double, wektory wierszowe lub kolumnowe.
%
% result.xvec: wektor kolejnych przybliżeń miejsca zerowego [Hz].
% result.xdif: wektor wartości bezwzględnych różnic kolejnych przybliżeń
% miejsca zerowego [Hz], o długości iterations-1.
% result.xsolution: ostatnie przybliżenie miejsca zerowego, skalar [Hz].
% result.ysolution: wartość funkcji różnicy w xsolution, skalar [Ohm].
% ysolution jest residuum i zachowuje znak. abs(ysolution) to jego moduł.
% Błąd bezwzględny przybliżenia x to |x-x_*|, gdzie x_* jest dokładnym zerem.
% error_bound to oszacowanie błędu środka przedziału zawierającego zero.
% Gwarancja dotyczy arytmetyki dokładnej. Zaokrąglenia oceń osobno.
% result.iterations: skalar równy liczbie elementów xvec.
% result.a_history, result.b_history: odpowiednio lewe i prawe końce przedziałów
% [Hz].
% result.fa_history: wartości funkcji na lewych końcach [Ohm].
% result.fb_history: wartości funkcji na prawych końcach [Ohm].
%
% Każdy z czterech wektorów ma iterations elementów.
% Pierwszy element opisuje stan początkowy.
% Kolejne wartości zapisujemy w wektorach po podziale.
% Stan po k podziałach ma indeks k+1. Środek to xvec(k+1).

save_png = 0; % Ustaw lokalnie 1, aby zapisać całą istniejącą figurę.
[xvec, xdif, xsolution, ysolution, iterations, ...
    a_history, b_history, fa_history, fb_history] = ...
    impedance_bisection();
result = struct('xvec', xvec, 'xdif', xdif, ...
    'xsolution', xsolution, 'ysolution', ysolution, ...
    'iterations', iterations, ...
    'a_history', a_history, 'b_history', b_history, ...
    'fa_history', fa_history, 'fb_history', fb_history);
fig = get(groot, 'CurrentFigure');
if save_png == 1 && ~isempty(fig)
    exportgraphics(fig, 'zadanie2.png', 'Resolution', 150);
end
end

function [xvec, xdif, xsolution, ysolution, iterations, ...
    a_history, b_history, fa_history, fb_history] = ...
    impedance_bisection()
% Wyznacza przybliżenie miejsca zerowego funkcji impedance_difference metodą
% bisekcji.
% xvec - wektor z kolejnymi przybliżeniami miejsca zerowego,
%   gdzie xvec(1)=(a+b)/2,
% xdif - wektor wartości bezwzględnych różnic kolejnych przybliżeń,
%   xdif(i)=abs(xvec(i+1)-xvec(i)),
% xsolution - wyznaczone przybliżenie miejsca zerowego,
% ysolution - wartość funkcji impedance_difference wyznaczona
%   dla f=xsolution,
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution.

a = 2; % lewa granica przedziału poszukiwań miejsca zerowego
b = 12; % prawa granica przedziału poszukiwań miejsca zerowego
% tolerancja wartości funkcji w przybliżonym miejscu zerowym.
ytolerance = 1e-8; % tolerancja modułu residuum w jednostkach Ohm.
% Mały moduł residuum nie gwarantuje małego błędu przybliżenia.
max_iterations = 1000; % maksymalna liczba iteracji wykonana przez alg. bisekcji

fa = impedance_difference(a);
fb = impedance_difference(b);

% Wektory zapisują stan początkowy i stany po wykonanych podziałach.
% a_history, b_history: odpowiednio lewe i prawe końce przedziałów.
% fa_history: wartości funkcji na lewych końcach [Ohm].
% fb_history: wartości funkcji na prawych końcach [Ohm].
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

% Zakończ przy pierwszym przybliżeniu, dla którego moduł bieżącej
% wartości funkcji jest mniejszy od ytolerance.
% Zgłoś error po limicie lub stagnacji bez spełnienia tolerancji.
% Stagnacja: obliczony środek jest równy końcowi przedziału.
for ii=1:max_iterations
    c = (a + b)/2;
    xvec(ii,1) = c;
    fc = impedance_difference(c);
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
% argumentu funkcji zgodnie z instrukcją.
error_bound = (b_history(end) - a_history(end))/2;

% Przygotowanie figury jest dostarczone. Uzupełnij tylko miejsca PLOT.
% Możesz zmieniać podpisy i dodawać oznaczenia bez zasłaniania danych.
figure('WindowStyle','normal');
subplot(2,1,1);
plot(1:iterations, xvec, 'o-');
xlabel('Numer iteracji');
ylabel('Przybliżenie częstotliwości [Hz]');
title('Bisekcja: kolejne przybliżenia');
subplot(2,1,2);
interval_widths = b_history - a_history;
division_numbers = 0:iterations-1;
semilogy(division_numbers, interval_widths, 'o-');
hold on;
semilogy(division_numbers, interval_widths(1)./2.^division_numbers, 's--');
xlabel('Liczba podziałów');
ylabel('Szerokość przedziału [Hz]');
title('Bisekcja: zmniejszanie szerokości przedziału');
if numel(findobj(gca,'Type','line')) >= 2
    legend('Z zapisanych końców przedziału', ...
        'Ze wzoru teoretycznego');
end

end

function impedance_delta = impedance_difference (f)
R = 680; % rezystancja [Ohm]
L = 2.5; % indukcyjność [H]
C = 4.7e-5; % pojemność [F]
M = 100; % docelowy moduł impedancji [Ohm]
if f <= 0
    error('lab4:nonpositiveFrequency', ...
        'Częstotliwość musi być dodatnia.');
end
omega = 2*pi*f;
impedance_module = 1/sqrt(1/R^2 + (omega*C - 1/(omega*L))^2);
impedance_delta = impedance_module - M;
end
