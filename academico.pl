% academico.pl
% Autor: Kevin Briceño
% Carnet: 15-11661

% dicta(Profesor, Materia)
dicta(leonardo, ci3661).
dicta(maria,    ci3725).
dicta(pedro,    ci2691).

% cursa(Estudiante, Materia)
cursa(ana,   ci3661).
cursa(ana,   ci3725).
cursa(juan,  ci3661).
cursa(elena, ci2691).
cursa(elena, ci3725).

% nota(Estudiante, Materia, Nota)
nota(ana,   ci3661, 88).
nota(ana,   ci3725, 70).
nota(juan,  ci3661, 40).        % juan reprobó ci3661
nota(elena, ci2691, 51).
% elena no tiene nota en ci3725 (la está cursando)


% Predicado: profesor_de(Prof, Est).
% Verdadero si Prof le da (o le dio) clases a Est en al menos una materia.
profesor_de(Prof, Est) :-
    dicta(Prof, Mat),
    cursa(Est, Mat).

% Predicado: aprobado(Est, Mat).
% Verdadero si Est cursó Mat y obtuvo nota >= 50.
aprobado(Est, Mat) :-
    cursa(Est, Mat),
    nota(Est, Mat, Nota),
    Nota >= 50.

% Predicado: aplazado(Est).
% Verdadero si Est ha obtenido menos de 50 en al menos una materia (tiene nota registrada < 50).
aplazado(Est) :-
    nota(Est, Mat, Nota),
    Nota < 50.

% Predicado: cursando_sin_nota(Est, Mat).
% Verdadero si Est cursa Mat pero no tiene nota registrada para esa materia.
cursando_sin_nota(Est, Mat) :-
    cursa(Est, Mat),
    not(nota(Est, Mat, _)).
