function result = lab4_z1()
% Uzupełnij kod funkcji impedance_difference, która wyznacza różnicę pomiędzy
% modułem impedancji dla częstotliwości f a wartością docelową M=100 Ohm
% (wzór (1.2) z instrukcji).
%
% Funkcja lab4_z1 zwraca rezultaty działania funkcji impedance_difference
% dla trzech testowych scenariuszy: a) f=12 Hz, b) f=0 Hz, c) f=-12 Hz.
%
% result: struktura z wynikami.
% f: skalar double, częstotliwość [Hz].
% impedance_delta: skalar double, |Z(f)|-100 [Ohm].
% error_raised: logical 1 x 2, błędy dla argumentów 0 i -12.
% Funkcja główna wywołuje tę samą funkcję lokalną dla trzech argumentów.
% result.f - częstotliwość 12 Hz,
% result.impedance_delta - wartość modelu dla result.f,
% result.error_raised - zgłoszenie błędów dla 0 oraz -12 (logical 1 x 2).
% Uzupełnij tylko funkcję lokalną impedance_difference.

result = struct();
result.f = 12;
result.impedance_delta = impedance_difference(result.f);
result.error_raised = false(1, 2);
invalid_f = [0, -12];
for index = 1:numel(invalid_f)
    try
        impedance_difference(invalid_f(index));
    catch
        result.error_raised(index) = true;
    end
end
end

function impedance_delta = impedance_difference(f)
% Parametry obwodu są dostarczone. Zaimplementuj model z zadania 1.
R = 680; % rezystancja [Ohm]
L = 2.5; % indukcyjność [H]
C = 4.7e-5; % pojemność [F]
M = 100; % docelowy moduł impedancji [Ohm]
% Zaimplementuj wzór i błąd dla f<=0. Usuń poniższą blokadę.
error('lab4:Incomplete', ...
    'Uzupełnij obliczenia w impedance_difference.');
end
