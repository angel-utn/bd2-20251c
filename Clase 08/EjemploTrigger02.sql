Use EjemploTriggersyTransaccionesDB;
Go
-- Cuando se intente borrar físicamente una cuenta, no borrarla y en su lugar
-- realizar una baja lógica de la misma.

Create Or Alter Trigger TR_BorrarCuenta ON Cuentas
Instead Of Delete
As
Begin
  
  Declare @IDCuenta int;
  Declare @Saldo money;

  Select @IDCuenta = IDCuenta, @Saldo = Saldo from deleted;

  if @Saldo <> 0 Begin
    Raiserror('No se puede dar de baja una cuenta con saldo distinto a cero', 16, 1);
    Return;
  End
  
  Update Cuentas set FechaBaja = getdate() 
  Where 
  IDCuenta = @IDCuenta And 
  FechaBaja IS NULL And
  Saldo = 0;

End

Select * From cuentas;

Delete From Cuentas Where IDCuenta = 7;

