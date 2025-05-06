Use EjemploTriggersyTransaccionesDB;
Go
-- Al modificar el tipo de cuenta de una cuenta. Si se modifica de una
-- cuenta corriente a una caja de ahorro:
-- Verificar que la cuenta corriente no tenga saldo negativo para realizar el proceso

Create Trigger TR_ModificarTipoCuenta ON Cuentas
After Update
As Begin

  Declare @TipoCuentaAnterior char(2)
  Declare @TipoCuentaActual char(2)
  Declare @Saldo money

  Select @TipoCuentaAnterior = IDTipoCuenta From deleted;
  Select @TipoCuentaActual = IDTipoCuenta from inserted;
  Select @Saldo = Saldo From deleted;

  Begin Transaction;

  IF @TipoCuentaAnterior = 'CC' And @TipoCuentaActual = 'CA' And @Saldo < 0 Begin
    Rollback Transaction;
    RAISERROR('No se puede optar por Caja de Ahorro si registra deuda', 16, 1)
    Return;
  End

  Commit Transaction;

End


select * from Cuentas;

Update Cuentas Set IDTipoCuenta = 'CA' Where IDCuenta = 7;