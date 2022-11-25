DELIMITER $$
USE `proyectobd122022`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getValidarUsuario`(IN usuario VARCHAR(20), IN contra VARCHAR(20), OUT validacion BOOLEAN)
BEGIN 
	SELECT if(COUNT(*)>0, TRUE, FALSE)
	INTO validacion
	FROM proyectobd122022.tbl_usuarios 
	WHERE usunombre=usuario AND usucontrasena=contra;
END$$
DELIMITER ;
