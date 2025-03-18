 Create Database Clase01
 Go
 Use Clase01
 Go
Create Table Areas(
	IDArea smallint not null primary key identity (1, 1),
	Nombre varchar(50) not null,
	Mail varchar(255) not null
)
Go
Create Table Proyectos(
	IDProyecto int not null primary key,
	Nombre varchar(100) not null
)
Go
Create TAble Empleados(
	IDEmpleado int not null primary key,
	Apellidos varchar(100) not null,
	Nombres varchar(100) not null,
	Salario money check (Salario >= 0),
	FechaContratacion date not null,
	IDArea smallint null foreign key references Areas(IDArea)
)
Go
Create Table EmpleadosProyecto(
	IDEmpleado int not null foreign key references Empleados(IDEmpleado),
	IDProyecto int not null foreign key references Proyectos(IDProyecto),
	primary key (IDEmpleado, IDProyecto)
)
Go
Create TAble PresupuestosAreas(
	Año tinyint not null,
	IDArea smallint not null foreign key references Areas(IDArea),
	Presupuesto money not null check (Presupuesto >= 0),
	primary key (Año, IDArea)
)
