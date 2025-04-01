Use Libreria_Semana03;

-- Listado de todas las columnas de la tabla de libros.
Select * From Libros;

-- Listado de todos los libros. Indicando IDLibro, Titulo, CantidadDePaginas
Select IDLibro, Titulo, Paginas From Libros;

-- Listado de Apellidos y Nombres y Pseudónimo de los Autores
Select A.Apellidos, A.Nombres, A.Pseudonimo As Apodo From Autores As A;

/* Alias en tablas */
Select A.Apellidos, A.Nombres, A.Pseudonimo As Apodo From Autores As A;

/* Obtener los libros cuya categoría sea 1, 3 o 5 */
SELECT * FROM Libros
WHERE IDCategoria = 1 OR IDCategoria = 3 OR IDCategoria = 5;

SELECT * FROM Libros WHERE IDCategoria IN (1, 3, 5);

/* Listar los usuarios cuyo país no sea "AR" ni "BR" */
SELECT * FROM Usuarios WHERE IDPais NOT IN ('AR', 'BR');

-- SELECT * FROM Usuarios where idpais != 'AR' AND idpais != 'BR'

/* Listar los usuarios cuyo país sea "AR" o "BR" */
SELECT * FROM Usuarios WHERE IDPais IN ('AR', 'BR');

/* Mostrar los libros publicados entre 2000 y 2010 */

SELECT * FROM Libros WHERE AñoPublicacion >= 2000 AND AñoPublicacion <= 2010;
SELECT * FROM Libros WHERE AñoPublicacion BETWEEN 2000 AND 2010;

/* Listar las lecturas realizadas entre 1/1/2022 y 1/5/2022 */
SELECT * FROM Lecturas WHERE FechaHora BETWEEN '2022-01-01' AND '2022-05-01'
ORDER BY FechaHora ASC, TiempoEnMinutos ASC;

/* Listar las lecturas con una duración que no esté entre 10 y 60 minutos */
SELECT * FROM Lecturas WHERE TiempoEnMinutos NOT BETWEEN 10 AND 60;

/* Obtener los usuarios cuyo nombre de usuario comience con "A" */
SELECT * FROM Usuarios WHERE NombreUsuario LIKE 'A%';

/* Obtener los usuarios cuyo nombre de usuario incluya "A" */
SELECT * FROM Usuarios WHERE NombreUsuario LIKE '%A%';

/* ¿Qué nos devuelve esto? NombreUsuario like '%A_A%' */
SELECT * FROM Usuarios WHERE NombreUsuario like '%A_A%';

/* Obtener los nombres de usuarios que no sean Ana (NombreUsuario <> 'Ana') */
SELECT * FROM Usuarios WHERE NombreUsuario NOT LIKE '%A_A%'; -- incorrecto, pues excluye por ejemplo 'Ada'
SELECT * FROM Usuarios WHERE NombreUsuario NOT LIKE 'ANA';
SELECT * FROM Usuarios WHERE NombreUsuario <> 'ANA';
SELECT * FROM Usuarios WHERE NombreUsuario LIKE 'A[^nN]A';

/* Obtener los títulos de los libros que comiencen con 'The' */
SELECT Titulo FROM Libros WHERE Titulo LIKE 'The%';

/* Obtener los títulos de los libros que comiencen con vocal y continúen con cualquier carácter o texto */
SELECT Titulo FROM Libros WHERE Titulo LIKE '[aeiou]%';

/* Obtener los títulos de los libros que comiencen con vocal,
continúen con uno de estos caracteres: lpf y finalicen con cualquier carácter o texto */
SELECT Titulo FROM Libros WHERE Titulo LIKE '[aeiou][lpf]%';

/* Obtener los títulos de los libros que comiencen con vocal,
continúen con un carácter en el rango entre b y m, y finalicen con cualquier carácter o texto */
SELECT Titulo FROM Libros WHERE Titulo LIKE '[aeiou][b-m]%';

/* Mostrar los autores cuyo pseudónimo no esté registrado */
SELECT * FROM Autores WHERE Pseudonimo = NULL; -- incorrecto, NULL no puede comparar con operadores relacionales
SELECT * FROM Autores WHERE Pseudonimo IS NULL; -- correcto

/* Mostrar los autores cuyo pseudónimo esté registrado */
SELECT * FROM Autores WHERE Pseudonimo IS NOT NULL;

/* Listar los libros cuya descripción no ha sido ingresada */
SELECT * FROM Libros WHERE Descripcion IS NULL;

/*
'' NO ES NULL, ES CADENA VACÍA
' ' NO ES NULL, ES UN ESPACIO (1 CARÁCTER)
*/

/* Listar los libros cuya descripción está vacía */
SELECT * FROM Libros WHERE Descripcion = '';

/* Obtener los 3 libros con título más largo */
SELECT TOP 3 Titulo, LEN(Titulo) AS Longitud FROM Libros ORDER BY Longitud DESC;
SELECT TOP 3 Titulo, LEN(Titulo) AS Longitud FROM Libros ORDER BY LEN(Titulo) DESC;
SELECT TOP 3 Titulo, LEN(Titulo) AS Longitud FROM Libros ORDER BY 2 DESC;

/* ¿Y los 4 libros con título más largo? */
SELECT TOP 4 WITH TIES Titulo, LEN(Titulo) AS Longitud FROM Libros ORDER BY 2 DESC;

/* Obtener la lista de países distintos donde hay usuarios registrados */
SELECT IDPais FROM Usuarios; -- incorrecto, IDs repetidos
SELECT DISTINCT(IDPais) FROM Usuarios; -- correcto