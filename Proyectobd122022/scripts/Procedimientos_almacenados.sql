---- TRIGERS PARA VENTAS ----

DELIMITER //
CREATE TRIGGER log_tbl_clientes after insert on tbl_clientes
FOR EACH ROW BEGIN
	INSERT INTO tbl_bitacoraventas (bitventas) VALUES ('SE CREO UN REGISTRO EN MANTENIMIENTO CLIENTES');
END//


DELIMITER //
CREATE TRIGGER delete_tbl_clientes after DELETE on tbl_clientes
FOR EACH ROW BEGIN
	INSERT INTO tbl_bitacoraventas (bitventas) VALUES ('SE BORRO UN REGISTRO EN MANTENIMIENTO CLIENTES');
END//

---- PROCESO ----

DELIMITER //
CREATE PROCEDURE cliente_buscado(IN letra CHAR)
BEGIN
SELECT *
FROM tbl_clientes
WHERE clinombre LIKE concat(letra,'%');
END //
DELIMITER ;

CALL cliente_buscado('d');