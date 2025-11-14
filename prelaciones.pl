% prelaciones.pl
% Autor: Kevin Briceño
% Carnet: 15-11661

prela(ci2691, ci3661). % ci2691 prela a ci3661
prela(ci2525, ci2691).
prela(ci2691, ci3641).
prela(ci3641, ci3725).
prela(ci3725, ci3825). % ci3725 prela a ci3825
prela(ma1111, ci2525).

% Predicado: prelacion_directa(A, B).
% Verdadero si A es prelación directa de B (A es prerequisito inmediato de B).
prelacion_directa(A, B) :-
    prela(A, B).

% Predicado: prelacion_total(A, B).
% Verdadero si A es prelación (directa o indirecta) de B.
% Implementación con acumulador para evitar ciclos.
prelacion_total(A, B) :-
    prelacion_total(A, B, []).

% Caso base: A es prelacion directa de B
prelacion_total(A, B, _) :-
    prela(A, B).

% Caso recursivo: existe C tal que A prela C y C prelacion_total B,
% evitando volver a visitar nodos ya visitados
prelacion_total(A, B, Visited) :-
    prela(A, C),
    \+ member(C, Visited),      % no hemos visitado C aún
    prelacion_total(C, B, [C|Visited]).
