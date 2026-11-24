function result = lab4_z2()
% Uzupełnij obliczenia i wykresy w funkcji impedance_bisection, która wyznacza
% przybliżenie miejsca zerowego funkcji impedance_difference metodą bisekcji.
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

% Zakończ przy pierwszym przybliżeniu, dla którego moduł bieżącej
% wartości funkcji jest mniejszy od ytolerance.
% Zgłoś error po limicie lub stagnacji bez spełnienia tolerancji.
% Stagnacja: obliczony środek jest równy końcowi przedziału.
for ii=1:max_iterations
    % c = ...
    % xvec(ii,1) = c;
    % fc = ...
    % if ...
    % else
    %     Wybierz połowę i dopisz aktualne końce oraz wartości funkcji.
    % end
end

% Oblicz lokalne error_bound i zinterpretuj je w jednostkach
% argumentu funkcji zgodnie z instrukcją.

% Przygotowanie figury jest dostarczone. Uzupełnij tylko miejsca PLOT.
% Możesz zmieniać podpisy i dodawać oznaczenia bez zasłaniania danych.
figure('WindowStyle','normal');
subplot(2,1,1);
% PLOT_GORNY: narysuj xvec w skali liniowej, iteracje od 1.
xlabel('Numer iteracji');
ylabel('Przybliżenie częstotliwości [Hz]');
title('Bisekcja: kolejne przybliżenia');
subplot(2,1,2);
% PLOT_DOLNY: oblicz i narysuj
%   a) szerokości kolejnych przedziałów (różnica b_history - a_history)
%   b) teoretyczne zmniejszanie się przedziału poszukiwań miejsca zerowego
% Użyj semilogy i numerów podziałów od 0. Narysuj obie serie.
xlabel('Liczba podziałów');
ylabel('Szerokość przedziału [Hz]');
title('Bisekcja: zmniejszanie szerokości przedziału');
if numel(findobj(gca,'Type','line')) >= 2
    legend('Z zapisanych końców przedziału', ...
        'Ze wzoru teoretycznego');
end

end

function impedance_delta = impedance_difference (f)
% Skopiuj kod funkcji impedance_difference z zadania 1.
error('lab4:Incomplete', ...
    'Uzupełnij obliczenia w impedance_difference.');
end
