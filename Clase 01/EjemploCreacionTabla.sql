Create Database CLASE1_2025_1C
Go
Use Clase1_2025_1C
Go
Create Table Areas(
    IDArea tinyint not null primary key,
    Nombre varchar(50) not null,
    Presupuesto money not null check (Presupuesto > 0),
    Mail varchar(200) null
)
