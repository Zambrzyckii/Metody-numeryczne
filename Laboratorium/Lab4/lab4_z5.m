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

% Przenieś własną bisekcję i rysowanie z zadania 2 do funkcji poniżej.
% Dostosuj model, przedział oraz podpisy i jednostki, bez zmiany metody.
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
% argumentu zgodnie z instrukcją.

% Przygotowanie figury jest dostarczone. Uzupełnij tylko miejsca PLOT.
% Możesz zmieniać podpisy i dodawać oznaczenia bez zasłaniania danych.
figure('WindowStyle','normal');
subplot(2,1,1);
% PLOT_GORNY: narysuj xvec w skali liniowej, iteracje od 1.
xlabel('Numer iteracji');
ylabel('Przybliżenie czasu [s]');
title('Bisekcja: kolejne przybliżenia');
subplot(2,1,2);
% PLOT_DOLNY: oblicz i narysuj
%   a) szerokości kolejnych przedziałów (różnica b_history - a_history),
%   b) teoretyczne zmniejszanie przedziału poszukiwań miejsca zerowego.
% Użyj semilogy i numerów podziałów od 0. Narysuj obie serie.
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
% Skopiuj całą funkcję velocity_difference z zadania 4,
% razem z jej parametrami i obsługą niedodatniego argumentu.
error('lab4:Incomplete','Uzupełnij model prędkości.');
end
