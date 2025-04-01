Create Database Libreria_Semana03
Collate Latin1_General_CI_AI
Go
Use Libreria_Semana03
Go
-- Representa la categoria de los libros: Terror, Ficcion, Distopia, etc.
Create Table Categorias(
    IDCategoria int not null primary key identity (1, 1),
    Categoria varchar(50) not null
)
Go
Create Table Paises(
    IDPais varchar(3) not null primary key,
    Pais varchar(100) not null
)
Go
Create Table Ciudades(
    IDCiudad bigint primary key not null identity(1, 1),
    IDPais varchar(3) not null foreign key references Paises(IDPais),
    Ciudad varchar(100) not null
)
Go
Create Table Autores(
    IDAutor int not null primary key identity (1, 1),
    IDPais varchar(3) null foreign key references Paises(IDPais),
    Apellidos varchar(100) null,
    Nombres varchar(100) null,
    Pseudonimo varchar(100) null,
    AñoNacimiento smallint null
)
Go
Create Table Libros(
    IDLibro bigint primary key not null,
    IDCategoria int not null foreign key references Categorias(IDCategoria),
    Titulo varchar(100) not null,
    Descripcion varchar(2048) null,
    AñoPublicacion smallint null,
    Paginas smallint not null check (Paginas >= 1)
)
Go
-- Representa la participación de un autor en un libro
Create Table AutoresLibro(
    IDAutor int not null foreign key references Autores(IDAutor),
    IDLibro bigint not null foreign key references Libros(IDLibro),
    Primary Key (IdAutor, IDLibro)
)
Go
Create Table Usuarios(
    IDUsuario bigint not null primary key identity (1, 1),
    IDPais varchar(3) not null foreign key references Paises(IDPais),
    NombreUsuario varchar(20) not null unique,
    Mail varchar(250) not null,
    FechaInscripcion date not null default(getdate())
)
Go
-- Representa un medio de lectura: Libro papel, Ebook, Tablet, Audiolibro, etc.
Create Table Medios(
    IDMedio tinyint not null primary key identity(1, 1),
    Nombre varchar(50) not null
)
Go
-- Representa una sesión de lectura de un usuario de un libro.
Create Table Lecturas(
    IDLectura bigint not null primary key identity (1, 1),
    IDUsuario bigint not null foreign key references Usuarios(IDUsuario),
    IDLibro bigint not null foreign key references Libros(IDLibro),
    IDMedio tinyint not null foreign key references Medios(IDMedio),
    FechaHora date not null default(getdate()),
    TiempoEnMinutos smallint not null check(TiempoEnMinutos >= 1)
)
Go
-- Representa la puntuación que le da un usuario a un libro.
Create Table Puntuaciones(
    IDUsuario bigint not null foreign key references Usuarios(IDUsuario),
    IDLibro bigint not null foreign key references Libros(IDLibro),
    Puntaje tinyint not null check (Puntaje Between 1 And 10),
    Primary Key (IDUsuario, IDLibro)
)