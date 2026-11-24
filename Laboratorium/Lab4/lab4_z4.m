function result = lab4_z4()
% Uzupełnij kod funkcji velocity_difference, która wyznacza różnicę
% pomiędzy prędkością rakiety w chwili t a wartością docelową 850 m/s.
% Funkcję różnicy określa wzór (4.2) z instrukcji.
% Model posłuży w zadaniach 5 i 6 do wyznaczenia czasu osiągnięcia celu.
%
% Funkcja lab4_z4 zwraca rezultaty działania velocity_difference dla
% czterech scenariuszy: t=25 s, t=12 s oraz niedodatnich 0 s i -12 s.
% Funkcja główna obsługuje wyjątki. Uzupełnij tylko funkcję lokalną.
%
% result: struktura z wynikami.
% result.t, result.check_t: skalary double, czasy 25 s i 12 s.
% result.velocity_delta: skalar double, v(result.t)-850 [m/s].
% result.check_velocity_delta: skalar double, v(result.check_t)-850 [m/s].
% result.error_raised: logical 1 x 2, błędy dla argumentów 0 i -12.
% Przykłady 25 s i 12 s należą do dziedziny modelu.
% Wzór dopuszcza t=0. Jego odrzucenie jest wymaganiem zadania.

result.t = 25;
result.velocity_delta = velocity_difference(result.t);
result.check_t = 12;
result.check_velocity_delta = velocity_difference(result.check_t);
result.error_raised = false(1, 2);
invalid_t = [0, -12];
for index = 1:numel(invalid_t)
    try
        velocity_difference(invalid_t(index));
    catch
        result.error_raised(index) = true;
    end
end
end

% Funkcje lokalne.
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
