function result = lab4_z3()
% Uzupełnij obliczenia i wykresy w funkcji impedance_secant, która wyznacza
% przybliżenie miejsca zerowego funkcji impedance_difference metodą siecznych.
%
% Funkcja lab4_z3 zapisuje wyniki funkcji impedance_secant w strukturze
% result. Przenieś cały model impedance_difference z zadania 1.
%
% result: struktura z wynikami obliczeń.
% Wyniki liczbowe: double, wektory wierszowe lub kolumnowe.
% result.xvec: wektor kolejnych przybliżeń miejsca zerowego [Hz].
% result.xdif: wartości bezwzględne różnic kolejnych przybliżeń [Hz],
% o długości iterations-1. Mały krok nie gwarantuje małego błędu
% bezwzględnego przybliżenia.
% result.xsolution: ostatnie przybliżenie miejsca zerowego, skalar [Hz].
% result.ysolution: wartość funkcji różnicy w xsolution, skalar [Ohm].
% ysolution jest residuum i zachowuje znak. abs(ysolution) to jego moduł.
% Błąd bezwzględny przybliżenia x to |x-x_*|, gdzie x_* jest dokładnym zerem.
% result.iterations: skalar równy liczbie elementów xvec.
%
% xvec zaczyna się od x2. Wektor nie zawiera punktów startowych x0 i x1.

save_png = 0; % Ustaw lokalnie 1, aby zapisać całą istniejącą figurę.
[xvec, xdif, xsolution, ysolution, iterations] = impedance_secant();
result = struct('xvec', xvec, 'xdif', xdif, ...
    'xsolution', xsolution, 'ysolution', ysolution, ...
    'iterations', iterations);
fig = get(groot, 'CurrentFigure');
if save_png == 1 && ~isempty(fig)
    exportgraphics(fig, 'zadanie3.png', 'Resolution', 150);
end
end

function [xvec, xdif, xsolution, ysolution, iterations] = ...
    impedance_secant()
% Wyznacza przybliżenie miejsca zerowego funkcji impedance_difference metodą
% siecznych.
% xvec - wektor z kolejnymi przybliżeniami miejsca zerowego,
%   xvec(1)=x2, gdzie x2 jest pierwszym przybliżeniem metody siecznych.
%   Punkty startowe x0 i x1 nie należą do xvec.
% xdif - wielkości kroków, nie oszacowania błędu bezwzględnego,
%   xdif(i) = abs(xvec(i+1)-xvec(i)),
% xsolution - wyznaczone przybliżenie miejsca zerowego,
% ysolution - wartość funkcji impedance_difference wyznaczona
%   dla f=xsolution,
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution.

a = 2; % pierwszy punkt startowy metody siecznych
b = 12; % drugi punkt startowy metody siecznych
ytolerance = 1e-8; % tolerancja modułu residuum w jednostkach Ohm.
% Mały moduł residuum nie gwarantuje małego błędu przybliżenia.
max_iterations = 1000; % maksymalna liczba iteracji metody siecznych

x0 = a;
x1 = b;
f0 = impedance_difference(x0);
f1 = impedance_difference(x1);

xvec = [];
xdif = [];
xsolution = Inf;
ysolution = Inf;
iterations = max_iterations;

% Zakończ przy pierwszym przybliżeniu, dla którego moduł bieżącej
% wartości funkcji jest mniejszy od ytolerance.
% Zgłoś error po limicie lub stagnacji bez spełnienia tolerancji.
% Stagnacja: nowe przybliżenie jest równe poprzedniemu.
% Przed krokiem sprawdź, czy mianownik wzoru siecznych jest zerowy.
for ii=1:max_iterations
    % x2 = ...
    % xvec(ii,1) = x2;
    % f2 = ...
    % if ...
    % else
    %     Zaktualizuj oba punkty i ich wartości funkcji.
    % end
end


% Przygotowanie figury jest dostarczone. Uzupełnij tylko miejsca PLOT.
% Możesz zmieniać podpisy i dodawać oznaczenia bez zasłaniania danych.
figure('WindowStyle','normal');
subplot(2,1,1);
% PLOT_GORNY: narysuj xvec w skali liniowej, iteracje od 1.
xlabel('Numer iteracji');
ylabel('Przybliżenie częstotliwości [Hz]');
title('Sieczne: kolejne przybliżenia');
subplot(2,1,2);
% PLOT_DOLNY: narysuj xdif przez semilogy, numery różnic od 1.
xlabel('Numer różnicy');
ylabel('Wielkość kroku [Hz]');
title('Sieczne: różnice kolejnych przybliżeń');
% Koniec dostarczonego przygotowania figury.



end

function impedance_delta = impedance_difference(f)
% Skopiuj całą funkcję impedance_difference z zadania 1,
% razem z jej parametrami i obsługą niedodatniego argumentu.
error('lab4:Incomplete', ...
    'Uzupełnij obliczenia w impedance_difference.');
end
