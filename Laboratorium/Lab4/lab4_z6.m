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
% PLOT_GORNY: narysuj kolejne przybliżenia z xvec obu metod w skali liniowej.
xlabel('Numer iteracji');
ylabel('Przybliżenie czasu [s]');
title('Czas osiągnięcia 850 m/s: przybliżenia');
if numel(findobj(gca,'Type','line')) >= 2
    legend('Bisekcja','Sieczne');
end
subplot(2,1,2);
% PLOT_DOLNY: oblicz moduły residuów obu metod i narysuj przez semilogy.
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
% Wklej własną funkcję z zadania 5. Usuń jej część rysującą.
a = 2; % początek przedziału lub pierwszy punkt [s]
b = 45; % koniec przedziału lub drugi punkt [s]
ytolerance = 1e-8; % tolerancja modułu residuum [m/s]
max_iterations = 1000; % limit iteracji
% Wstaw własny algorytm, zachowaj te dane i usuń poniższą blokadę.
error('lab4:Incomplete','Uzupełnij bisekcję z zadania 5.');
end

function [xvec,xdif,xsolution,ysolution,iterations] = velocity_secant()
% Przenieś własną metodę z zadania 3 i dostosuj do modelu rakiety.
% Wywołuj velocity_difference. Punkty startowe: 2 i 45 sekund.
% Zachowaj próg modułu residuum 1e-8 m/s i limit 1000 iteracji.
% Zachowaj obsługę stagnacji, zerowego mianownika i limitu.
% Usuń osobne rysowanie.
a = 2; % początek przedziału lub pierwszy punkt [s]
b = 45; % koniec przedziału lub drugi punkt [s]
ytolerance = 1e-8; % tolerancja modułu residuum [m/s]
max_iterations = 1000; % limit iteracji
% Wstaw własny algorytm, zachowaj te dane i usuń poniższą blokadę.
error('lab4:Incomplete','Uzupełnij metodę siecznych.');
end

function velocity_delta = velocity_difference(t)
% Skopiuj całą funkcję velocity_difference z zadania 4,
% razem z jej parametrami i obsługą niedodatniego argumentu.
error('lab4:Incomplete','Uzupełnij model prędkości.');
end
