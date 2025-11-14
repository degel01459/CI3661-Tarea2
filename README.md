# CI3661-Tarea2

Practica de Prolog

## Tarea 2 — Laboratorio de Lenguajes de Programación I

**Alumno:** Kevin Briceño  
**Carnet:** 15-11661

### Estructura del Proyecto

El proyecto consta de dos módulos independientes implementados en SWI-Prolog:

CI3661-Tarea2/
├── academico.pl        # Solución al Problema 2 (Base de datos académica)
├── prelaciones.pl      # Solución al Problema 1 (Árbol de prelaciones)
├── Tarea_2_Laboratorio_de_Lenguajes_de_Programación.pdf
└── README.md           # Documentación del proyecto

### Resumen General del Problema

Ambos problemas se basan en el siguiente conjunto de asignaturas: ma1111, ci2525, ci2691, ci3661, ci3641, ci3725, ci3825.

#### Problema 1:  Árbol de prelaciones

Este módulo establece y consulta el grafo de dependencias de asignaturas, basado en las siguientes cadenas de prelación:

1. ma1111->ci2525->ci2691->ci3661
2. ma1111->ci2525->ci2691->ci3641->ci3725->ci3825

##### prelacion_directa

Determina si existe una dependencia inmediata entre dos asignaturas.
Se implementa directamente mediante Hechos de la forma prela(A, B), donde A es prelación directa de B.

##### prelacion_total

Determina si existe un camino de dependencia directo o indirecto desde una asignatura A hasta una asignatura B.

Se define recursivamente a partir de prelacion_directa.

Nota: Se utiliza el argumento Visited para evitar ciclos infinitos en el backtracking al recorrer las aristas del grafo.

#### Problema 2:  Base de datos académica

Este módulo utiliza hechos para modelar la información de profesores, estudiantes, cursos y sus calificaciones. Se emplean reglas para inferir el estatus académico de los estudiantes.

profesor_de(Prof, Est):
Infiere si un profesor Prof imparte clases a un estudiante Est.
Se resuelve mediante un join lógico que verifica la existencia de una materia Mat tal que dicta(Prof, Mat) y cursa(Est, Mat).

aprobado(Est, Mat):
Verdadero si el estudiante Est ha obtenido una Nota registrada para la materia Mat y dicha Nota es mayor o igual a 50.

aplazado(Est):
Verdadero si existe al menos una materia para la cual el estudiante Est tiene una Nota registrada estrictamente menor a 50.

cursando_sin_nota(Est, Mat):
Verdadero si existe un hecho cursa(Est, Mat) y se verifica que no existe un hecho nota(Est, Mat, _) (es decir, no hay nota registrada).

El operador preferido para la negación por fallo es \+ en la mayoría de los dialectos modernos de Prolog incluyendo SWI-Prolog, ya que not a menudo se reserva para otros contextos o es considerado obsoleto.

##### Uso de Operadores de Negación

1. En prelacion_total (\+) para garantizar que el motor no pueda probar que un nodo fue visitado, lo que previene el ciclado infinito.

2. En cursando_sin_nota (not) para adherirse a una instrucción específica, aunque \+ es el estándar moderno en SWI-Prolog. Ambos cumplen el rol de Negación por Fallo, que es inferir la falsedad de un predicado por la imposibilidad de demostrar su verdad en la base de conocimientos.

#### Instrucciones de Ejecución

##### Requisitos

- SWI-Prolog (versión recomendada: 9.0 o superior)

##### Correr el Código

Para correr y probar las reglas implementadas, se requiere el intérprete SWI-Prolog:

1. Abrir la terminal e iniciar el intérprete:

```bash
swipl
```

2. Cargar el archivo deseado utilizando la sintaxis de consulta (sin la extensión .pl):

```Prolog
?- [prelaciones]. o ?- [academico].
```

3. Una vez cargado, realice las consultas necesarias. Para salir del intérprete, use halt.

```Prolog
?- halt.
```

##### Ejemplos de uso

```Prolog
?- [prelaciones].
true.

?- prelacion_directa(ci2691, ci3661).
true.

?- prelacion_total(ci2525, ci3661).
true.

?- prelacion_total(ma1111, ci3825).
true.

?- prelacion_total(ci3661, ci3725).
false.

?- halt.    % para salir de Prolog

?- [academico].
true.

?- profesor_de(leonardo, ana).
true.

?- aprobado(ana, ci3661).
true.

?- aprobado(elena, ci3725).
false.      % porque no tiene nota registrada

?- aplazado(juan).
true.

?- cursando_sin_nota(elena, ci3725).
true.

?- halt.    % para salir de Prolog
```
