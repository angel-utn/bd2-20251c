-- Contar la cantidad de libros
Select Count(*) As CantLibros From Libros;

-- Contar la cantidad de autores con pseudónimo
Select Count(*) As CantAutoresPseudonimo
From Autores Where Pseudonimo is not null;

Select Count(Pseudonimo) As CantAutoresPsedonimo_2 From Autores;

-- El promedio de páginas de los libros
Select Avg(Cast(Paginas As Decimal(10, 2))) From Libros;

Select Avg(Paginas * 1.0) From Libros;

-- Por cada categoría de libro, el nombre de la categoría y la cantidad de libros que hay

Select Cat.Categoria, Count(Cat.IDCategoria) As CantLibros
From Categorias Cat
Inner Join Libros Lib On Cat.IDCategoria = Lib.IDCategoria
Group By Cat.Categoria;

-- Por cada categoría de libro, el nombre de la categoría, la cantidad de libros que hay,
-- y el promedio de páginas
Select Cat.Categoria, 
Count(Cat.IDCategoria) As CantLibros,
Avg(Lib.Paginas) As PromedioPaginas
From Categorias Cat
Inner Join Libros Lib On Cat.IDCategoria = Lib.IDCategoria
Group By Cat.Categoria;

-- Por cada usuario, la cantidad de libros que leyó y la cantidad de veces que leyó libros.
Select 
U.NombreUsuario,
count(distinct IDLibro) as CantLibrosDistintos,
count(IDLibro) as CantSesionesLectura
From Usuarios U
Inner Join Lecturas L ON U.IDUsuario = L.IDUsuario
Group By U.NombreUsuario;

-- Por cada usuario, la cantidad de libros que leyó y la cantidad de veces que leyó libros
-- entre los años 2015 y 2018
Select 
U.NombreUsuario,
count(distinct IDLibro) as CantLibrosDistintos,
count(IDLibro) as CantSesionesLectura
From Usuarios U
Inner Join Lecturas L ON U.IDUsuario = L.IDUsuario
Where Year(L.FechaHora) Between 2015 AND 2018
Group By U.NombreUsuario;

-- Por cada usuario, la cantidad de libros que leyó y la cantidad de veces que leyó libros.
-- Sólo aquellos usuarios que leyeron más de 8 libros distintos.
Select 
U.NombreUsuario,
count(distinct IDLibro) as CantLibrosDistintos,
count(IDLibro) as CantSesionesLectura
From Usuarios U
Inner Join Lecturas L ON U.IDUsuario = L.IDUsuario
Group By U.NombreUsuario
Having count(distinct IDLibro) > 8;

-- Por cada usuario, la cantidad de libros que leyó y la cantidad de veces que leyó libros
-- entre los años 2015 y 2018.
-- Sólo aquellos usuarios que leyeron más de 8 libros distintos.
Select 
U.NombreUsuario,
count(distinct IDLibro) as CantLibrosDistintos,
count(IDLibro) as CantSesionesLectura
From Usuarios U
Inner Join Lecturas L ON U.IDUsuario = L.IDUsuario
Where Year(L.FechaHora) Between 2015 AND 2018
Group By U.NombreUsuario
Having Count(Distinct IDLibro) > 8;
