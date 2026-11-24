function result = lab4_z7()
% Uzupełnij fzero_results wynikami dwóch prób wykonanych samodzielnie
% poza tym plikiem. Sprawdź, czy fzero wyznacza przybliżenie miejsca
% zerowego tangensa dla punktów startowych 1.4 oraz 2.8.
% Argument, wartość funkcji i exitflag przenieś z tej samej próby.
% Zachowaj precyzję wydruku do 17 cyfr znaczących. Nie przeliczaj
% wartości funkcji z zaokrąglonego argumentu.
%
% Funkcja lab4_z7 zapisuje wyniki i oceny obu prób w strukturze result.
% result.x1, result.x2: skalary double, argumenty dla startu 1.4 i 2.8.
% result.y1, result.y2: skalary double, zwrócone wartości funkcji.
% result.exitflag1, result.exitflag2: skalary double, flagi obu prób.
% result.conclusion1, result.conclusion2: skalary string, oceny wyników.
%
% Każda próba jest oceniana osobno. Nieuzupełnione pola drugiej próby
% nie odbierają zaliczenia poprawnej pierwszej próby i odwrotnie.
% Zakaz fzero i tan w całym pliku jest warunkiem obu kryteriów.

[x1, y1, x2, y2, exitflag1, exitflag2, conclusion1, conclusion2] = ...
    fzero_results();
result = struct('x1', x1, 'y1', y1, 'x2', x2, 'y2', y2, ...
    'exitflag1', exitflag1, 'exitflag2', exitflag2, ...
    'conclusion1', conclusion1, 'conclusion2', conclusion2);
end

% Funkcje lokalne.
function [x1, y1, x2, y2, exitflag1, exitflag2, ...
    conclusion1, conclusion2] = fzero_results()
% UWAGA: w tej funkcji nie należy wywoływać funkcji fzero, tan.
% x1 - argument zwrócony przez fzero dla punktu startowego 1.4.
% x2 - argument zwrócony przez fzero dla punktu startowego 2.8.
% y1 - wartość funkcji zwrócona jako drugi wynik tego samego
% wywołania fzero co x1.
% y2 - wartość funkcji zwrócona jako drugi wynik tego samego
% wywołania fzero co x2.
% exitflag1, exitflag2 - kody zakończenia obu prób, skalary double.
% conclusion1, conclusion2 - oceny wyników po polsku, skalary string.
% Dozwolone napisy (wybierz osobno na podstawie każdej próby):
% "Wyznaczono przybliżenie miejsca zerowego."
% "Nie wyznaczono przybliżenia miejsca zerowego."
% "Wyznaczono dokładne miejsce zerowe bez błędu numerycznego."
% Użyj podwójnych cudzysłowów: tworzą string, nie char.
% Zachowaj polskie znaki, wielkość liter, spacje w zdaniu i kropkę.
% Test pomija tylko białe znaki na brzegach napisu.
% Przygotuj ustne uzasadnienie wyboru. Plik TXT nie jest wymagany.

x1 = [];
x2 = [];
y1 = [];
y2 = [];
exitflag1 = [];
exitflag2 = [];
conclusion1 = "";
conclusion2 = "";

end
