USE proyectobd122022;
ALTER TABLE tbl_bitacora
  ADD bitip varchar(25) not null;
ALTER TABLE tbl_bitacora
  ADD bitnombrepc varchar(60) not null;
ALTER TABLE tbl_bitacora
  MODIFY bitfecha varchar(30) not null;
ALTER TABLE tbl_usuario
  CHANGE tipo usutipo VARCHAR(15);

  