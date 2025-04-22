Use Libreria;

-----------------------------
-- Subconsultas escalares
-----------------------------

-- Los libros que tienen más páginas que el promedio de páginas
Select L.Titulo, L.Paginas From Libros L
Where L.Paginas > 
(Select Avg(Paginas * 1.0) From Libros);

-- Resuelto con una variable (NO ES SUBCONSULTAS)
Declare @PaginasPromedio Decimal(10, 4);
Set @PaginasPromedio = (Select Avg(Paginas * 1.0) From Libros);
Select L.Titulo, L.Paginas From Libros L
Where L.Paginas > @PaginasPromedio;

-- Los libros que tienen más páginas que cualquier libro de categoría 'Historia'. Debe tener más páginas que el libro de 'Historia' con más páginas.
Select * From Libros L
Where L.Paginas > (
  Select Max(Lib.Paginas)
  From Libros Lib
  Inner Join Categorias Cat ON Lib.IDCategoria = Cat.IDCategoria
  Where Cat.Categoria = 'Historia'
);

-- Por cada usuario, listar nombre de usuario y la cantidad de libros leídos en el año 2020 y la cantidad de libros leídos en el 2021.

-- NOMBREUSUARIO    LIBROS2020    LIBROS2021
-- ANGEL            10            11
-- LAURA            11            20

Select 
U.NombreUsuario,
(
  Select Count(distinct IDLibro) From Lecturas L
  Where Year(L.FechaHora) = 2020 And L.IDUsuario = U.IDUsuario
) As CantLibros2020,
(
  Select Count(distinct IDLibro) From Lecturas L
  Where Year(L.FechaHora) = 2021 And L.IDUsuario = U.IDUsuario
) As CantLibros2021
From Usuarios U;

-----------------------------
-- Subconsultas de Columnas
-----------------------------

-- Los libros que no fueron leídos en el año 2023 por usuarios de Argentina.
Select * From Libros
Where IDLibro Not In (
  Select distinct Lib.IDLibro
  from Libros Lib
  Inner Join Lecturas Lec On Lec.IdLibro = Lib.IdLibro
  Inner Join Usuarios U ON U.IDUsuario = Lec.IDUsuario
  Inner Join Paises P ON P.IDPais = U.IDPais
  Where P.Pais = 'Argentina' And Year(Lec.FechaHora) = 2023
);

-- Conjunto universo    Conjunto Libros 2023 ARG        Complemento
-- +--------------+     -- +---------------------+     -- +---------------------+
-- +    Libros    +  -  -- +    Libros2023ARG    +  =  -- +    LibrosNO2023ARG  +
-- +--------------+     -- +---------------------+     -- +---------------------+

-- Es el conjunto de Libros del 2023 leídos por Argentinos (me sirve)
-- Los IDLibro, títulos de los libros que fueron leídos por usuarios de Argentina en 2023.
Select distinct Lib.IDLibro, Lib.Titulo
from Libros Lib
Inner Join Lecturas Lec On Lec.IdLibro = Lib.IdLibro
Inner Join Usuarios U ON U.IDUsuario = Lec.IDUsuario
Inner Join Paises P ON P.IDPais = U.IDPais
Where P.Pais = 'Argentina' And Year(Lec.FechaHora) = 2023

-- Los libros que tienen más páginas que cualquier libro de categoría 'Historia'. Debe tener más páginas que el libro de 'Historia' con más páginas.
Select * From Libros L
Where L.Paginas > ALL (
  Select Lib.Paginas
  From Libros Lib
  Inner Join Categorias Cat ON Lib.IDCategoria = Cat.IDCategoria
  Where Cat.Categoria = 'Historia'
);

-- Los libros que tienen más páginas que algún libro de categoría 'Historia'. Debe tener más páginas que el libro de 'Historia' con menos páginas.
Select * From Libros L
Where L.Paginas > ANY (
  Select Lib.Paginas
  From Libros Lib
  Inner Join Categorias Cat ON Lib.IDCategoria = Cat.IDCategoria
  Where Cat.Categoria = 'Historia'
);

----------------------------------
-- Subconsultas de Varias Columnas
----------------------------------

-- Los usuarios que hayan leído más libros en el 2021 que en el 2020 pero que hayan leído libros en ambos años.

Select * From 
(
    Select 
    U.NombreUsuario,
    (
      Select Count(distinct IDLibro) From Lecturas L
      Where Year(L.FechaHora) = 2020 And L.IDUsuario = U.IDUsuario
    ) As CantLibros2020,
    (
      Select Count(distinct IDLibro) From Lecturas L
      Where Year(L.FechaHora) = 2021 And L.IDUsuario = U.IDUsuario
    ) As CantLibros2021
    From Usuarios U
) As EstadisticaLecturas
Where 
EstadisticaLecturas.CantLibros2021 > EstadisticaLecturas.CantLibros2020
And EstadisticaLecturas.CantLibros2021 > 0
And EstadisticaLecturas.CantLibros2020 > 0;


-- Variante SQL Server
With Lecturas20202021 As (
  Select 
    U.NombreUsuario,
    (
      Select Count(distinct IDLibro) From Lecturas L
      Where Year(L.FechaHora) = 2020 And L.IDUsuario = U.IDUsuario
    ) As CantLibros2020,
    (
      Select Count(distinct IDLibro) From Lecturas L
      Where Year(L.FechaHora) = 2021 And L.IDUsuario = U.IDUsuario
    ) As CantLibros2021
    From Usuarios U
)

Select * From Lecturas20202021
Where 
Lecturas20202021.CantLibros2021 > Lecturas20202021.CantLibros2020
And Lecturas20202021.CantLibros2021 > 0
And Lecturas20202021.CantLibros2020 > 0;

