Use EjemploTriggersyTransaccionesDB;

-- Ejemplos de Procedimientos Almacenados
------------------------------------------
Go
-- Crear un nuevo tipo de cuenta
Create Or Alter procedure SP_CrearTipoCuenta(
  @ID varchar(2),
  @NombreCuenta varchar(50)
)
As 
Begin

  If Trim(@NombreCuenta) = '' Begin
    Raiserror('Nombre de cuenta no puede ser vacío', 16, 1);
    Return;
  End

  Insert into TiposCuenta (IDTipoCuenta, Nombre)
  Values (@ID, @NombreCuenta);

  Print 'Insertado correctamente el tipo de cuenta'

End

Exec SP_CrearTipoCuenta 'X', '';

---
Go
Create Or Alter Procedure SP_ConsultarMovimientosxIDCuenta(
  @IDCuenta int
)
As
Begin
  Select C.IDCliente, C.IDTipoCuenta, C.LimiteDescubierto, C.Saldo, Cli.Apellidos, Cli.Nombres from Cuentas C
  Inner Join Clientes Cli ON Cli.IDCliente = C.IDCliente
  Where IDCuenta = @IDCuenta;
End

Exec SP_ConsultarMovimientosxIDCuenta 1;