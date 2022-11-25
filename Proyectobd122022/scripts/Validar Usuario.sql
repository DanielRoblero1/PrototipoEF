set @validacion = 0;
call bdexamenfinal.getValidarUsuario('dan', '123', @validacion);
select @validacion;
