Use EjemploTriggersyTransaccionesDB;
Go
-- Cuando se intente borrar físicamente una cuenta, no borrarla y en su lugar
-- seleccionar los datos de la cuenta que se pretendía borrar.

-- Tipo de trigger:
  -- Instead of

-- Tabla:
  -- Cuentas

-- Acción que lo dispara:
  -- Delete

-- Explicación breve del código del trigger:
  -- Selección de los datos que se iban a borrar

Create Trigger TR_BorrarCuenta ON Cuentas
Instead Of Delete
As
Begin
  Select * From deleted;
End


Select * From cuentas;

Delete From Cuentas Where IDCuenta = 5;