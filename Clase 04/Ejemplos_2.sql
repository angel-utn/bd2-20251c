/*
Listado con: 
nombre de usuario, título del libro leído, fecha de lectura 
y medio de lectura. 
Añadir al listado cualquier medio de lectura que no haya sido utilizado.
*/

SELECT U.NombreUsuario, LE.IDLibro, LI.Titulo, M.Nombre AS "Nombre del Medio"
FROM Usuarios U
INNER JOIN Lecturas LE ON U.IDUsuario = LE.IDUsuario
INNER JOIN Libros LI ON LI.IDLibro = LE.IDLibro
RIGHT JOIN Medios M ON M.IDMedio = LE.IDMedio

/*
  Listar los medios que nunca fueron utilizados
*/

SELECT M.Nombre FROM Medios M
LEFT JOIN Lecturas LE ON LE.IDMedio = M.IDMedio
WHERE LE.IDLectura IS NULL

/*
Listar todos los nombres de usuarios que hayan leído un libro
 de la categoría "Salud". 
No repetir el nombre de usuario.
*/

SELECT DISTINCT U.NombreUsuario 
FROM Usuarios U
INNER JOIN Lecturas LE ON LE.IDUsuario = U.IDUsuario
INNER JOIN Libros LI ON LE.IDLibro = LI.IDLibro
INNER JOIN Categorias C ON LI.IDCategoria = C.IDCategoria
WHERE C.Categoria = 'Salud'

/*
Apellidos, nombres y pseudónimo de los autores que hayan registrado 8
o más como puntaje por al menos un usuario de su misma nacionalidad.
*/

SELECT DISTINCT A.Apellidos, A.Nombres, A.Pseudonimo
FROM Autores A
INNER JOIN Usuarios U ON U.IDPais = A.IDPais
INNER JOIN Puntuaciones P ON P.IDUsuario = U.IDUsuario
WHERE P.Puntaje >= 8
