USE Libreria;

/* Listado de apellidos y nombres de autores con el nombre de su país de origen. */
--SELECT * FROM Autores;
SELECT A.Apellidos, A.Nombres, P.Pais FROM Autores A INNER JOIN Paises P ON A.IDPais = P.IDPais
ORDER BY P.Pais;

/* Listado con: título, año publicación, páginas y categorías de libros. */
SELECT L.Titulo, L.AñoPublicacion, L.Paginas, C.Categoria  
FROM Libros L INNER JOIN Categorias C ON L.IDCategoria = C.IDCategoria;

/* Listado que tenga los siguientes datos de libros: título, cantidad de páginas y, además, nombres,
apellidos y seudónimos de sus autores. */

SELECT
L.Titulo, L.Paginas AS 'Cantidad de páginas', A.Nombres, A.Apellidos, A.Pseudonimo
FROM Libros L
INNER JOIN AutoresLibro AL ON L.IDLibro = AL.IDLibro
INNER JOIN Autores A ON AL.IDAutor = A.IDAutor

/* Listado con: nombre de usuario, nombre de su país, título del libro, fecha y hora de lectura,
nombre del medio de lectura y duración en minutos.
Ordenado por nombre de usuario, título de libro y fecha y hora de lectura de forma ascendente. */

SELECT
--U.IDUsuario,
U.NombreUsuario AS 'Nombre de usuario',
P.Pais AS 'Pais del usuario',
LI.Titulo,
LE.FechaHora AS 'Fecha y hora de lectura',
M.Nombre AS 'Medio de lectura',
LE.TiempoEnMinutos AS 'Duración en minutos'
FROM Usuarios U
INNER JOIN Paises P ON U.IDPais = P.IDPais
INNER JOIN Lecturas LE ON U.IDUsuario = LE.IDUsuario
INNER JOIN Libros LI ON LE.IDLibro = LI.IDLibro
INNER JOIN Medios M ON LE.IDMedio = M.IDMedio
--WHERE U.IDUsuario = 4
--WHERE ('Fecha y hora de lectura') = '2013-04-14'
--WHERE LE.FechaHora = '2013-04-14'
--ORDER BY U.IDUsuario ASC, 'Nombre de usuario' ASC,  LI.Titulo ASC, 5 ASC;
ORDER BY 'Nombre de usuario' ASC,  LI.Titulo ASC, 4 ASC;

/* Listado con: apellidos y nombres de los autores, títulos y años de publicación de los libros.
Si hay autores sin libros asociados mostrarlos igual en el listado. */
SELECT A.Apellidos, A.Nombres,
--AL.IDAutor, AL.IDLibro,
L.Titulo, L.AñoPublicacion
FROM Autores A
LEFT JOIN AutoresLibro AL ON A.IDAutor = AL.IDAutor
LEFT JOIN Libros L ON AL.IDLibro = L.IDLibro
