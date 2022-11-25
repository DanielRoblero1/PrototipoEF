DELIMITER $$
USE `bdExamenFinal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getValidarUsuario`(IN usuario VARCHAR(20), IN contra VARCHAR(20), OUT validacion BOOLEAN)
BEGIN 
	SELECT if(COUNT(*)>0, TRUE, FALSE)
	INTO validacion
	FROM bdExamenFinal.tbl_usuario
	WHERE usunombre=usuario AND usucontrasena=contra;
END$$
DELIMITER ;