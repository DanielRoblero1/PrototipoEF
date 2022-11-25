CREATE SCHEMA IF NOT EXISTS `bdExamenFinal` DEFAULT CHARACTER SET utf8 ;
USE `bdExamenFinal` ;

CREATE TABLE IF NOT EXISTS tbl_usuario (
	usuid INT NOT NULL AUTO_INCREMENT,
	usunombre VARCHAR(45) NOT NULL,
	usucontrasena VARCHAR(25) NOT NULL,
	usuestatus VARCHAR(1) NOT NULL,
	usunombrereal VARCHAR(60),
	usucorreoe VARCHAR(60),
	usutelefono VARCHAR(25),
	usudireccion VARCHAR(80),
    usutipo VARCHAR(15),
	PRIMARY KEY (usuid) )
ENGINE = InnoDB CHARACTER SET = latin1;

CREATE TABLE tbl_bodegas
(
	bodcodigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bodnombre VARCHAR(60),
    bodestatus VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_lineas
(
	lincodigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    linnombre VARCHAR(60),
    linestatus VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_marcas
(
	marcodigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    marnombre VARCHAR(60),
    marestatus VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_productos
(
	prodcodigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    prodnombre VARCHAR(60),
    lincodigo INT NOT NULL,
    marcodigo INT NOT NULL,
    prodexistencia FLOAT(10,2),
    prodestatus VARCHAR(1),
    FOREIGN KEY (lincodigo) REFERENCES tbl_lineas(lincodigo),
    FOREIGN KEY (marcodigo) REFERENCES tbl_marcas(marcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbL_existencias
(
	bodcodigo INT NOT NULL,
    prodcodigo INT NOT NULL,
    exisaldo FLOAT(10,2),
    PRIMARY KEY (bodcodigo, prodcodigo),
	FOREIGN KEY (bodcodigo) REFERENCES tbl_bodegas(bodcodigo),
    FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_vendedores
(
	vedcodigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    vednombre VARCHAR(60),
    veddireccion VARCHAR(60),
    vedtelefono VARCHAR(50),
    vednit VARCHAR(20),
    vedestatus VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_clientes
(
	clicodigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    clinombre VARCHAR(60),
    clidireccion VARCHAR(60),
    clinit VARCHAR(20),
    clitelefono VARCHAR(50),
    cliestatus VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_vendedoresclientes
(
	vedcodigo INT NOT NULL,
    clicodigo INT NOT NULL,
    PRIMARY KEY (vedcodigo, clicodigo),
    FOREIGN KEY (vedcodigo) REFERENCES tbl_vendedores(vedcodigo),
	FOREIGN KEY (clicodigo) REFERENCES tbl_clientes(clicodigo)    
) ENGINE=INNODB DEFAULT CHARSET=latin1;    
CREATE TABLE tbl_proveedores
(
	procodigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pronombre VARCHAR(60),
    prodireccion VARCHAR(60),
    protelefono VARCHAR(50),
    pronit VARCHAR(50),
    proestatus VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_sucursales
(
	succodigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sucnombre VARCHAR(60),
    sucestatus VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_compras_encabezado
(
	coedocumento VARCHAR(10),
    procodigo INT NOT NULL,
    coefecha DATE,
	coetotal FLOAT(10,2),
    coeestatus VARCHAR(1),
    PRIMARY KEY (coedocumento),
    FOREIGN KEY (procodigo) REFERENCES tbl_proveedores(procodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_compras_detalle
(
    coedocumento VARCHAR(10),
    codorden INT NOT NULL,
    prodcodigo INT NOT NULL,
    codcantidad FLOAT(10,2),
    codcosto FLOAT(10,2),
	bodcodigo INT NOT NULL,
    PRIMARY KEY (coedocumento, codorden, prodcodigo),
    FOREIGN KEY (coedocumento) REFERENCES tbl_compras_encabezado(coedocumento),
	FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo),    
    FOREIGN KEY (bodcodigo) REFERENCES tbl_bodegas(bodcodigo)    
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_ventas_encabezado
(
	veedocumento VARCHAR(10),
    clicodigo INT NOT NULL,
    veefecha VARCHAR(15),
	veetotal FLOAT(10,2),
    veeestatus VARCHAR(1),
    PRIMARY KEY (veedocumento),
    FOREIGN KEY (clicodigo) REFERENCES tbl_clientes(clicodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE tbl_ventas_detalle
(
	veedocumento VARCHAR(10),
    vedorden INT NOT NULL,
    prodcodigo INT NOT NULL,
    vedcantidad FLOAT(10,2),
    vedcosto FLOAT(10,2),
    vedprecio FLOAT(10,2),
	bodcodigo INT NOT NULL,
    PRIMARY KEY (veedocumento, vedorden, prodcodigo),
    FOREIGN KEY (veedocumento) REFERENCES tbl_ventas_encabezado(veedocumento),
	FOREIGN KEY (bodcodigo) REFERENCES tbl_bodegas(bodcodigo),
	FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)    

) ENGINE=INNODB DEFAULT CHARSET=latin1;

-------------------- ARE VENTAS-------------------------- 
CREATE TABLE deudas_ventas_encabezado(
	dve_documento VARCHAR(10),
	clicodigo INT,			
    veedocumento VARCHAR(10),  
    dve_estatus VARCHAR(1),
    PRIMARY KEY (dve_documento, clicodigo, veedocumento),
    FOREIGN KEY (clicodigo) REFERENCES tbl_clientes(clicodigo),
    FOREIGN KEY (veedocumento) REFERENCES tbl_ventas_encabezado(veedocumento)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE deudas_ventas_detalle(
	dve_documento VARCHAR(10),
    prodcodigo INT,
    total_ventaenca FLOAT(10,2),
    dve_saldo_documento FLOAT (10,2),
    deudaventa FLOAT(10,2),
    PRIMARY KEY (dve_documento, prodcodigo),
    FOREIGN KEY (dve_documento) REFERENCES deudas_ventas_encabezado(dve_documento),
    FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE cotizacion_ventas_encabezado(
	cve_documento VARCHAR(10),
    clicodigo INT,
    cve_fecha DATE,
    cve_total FLOAT(10,2),
    cve_estatus VARCHAR(1),
    PRIMARY KEY (cve_documento, clicodigo),
    FOREIGN KEY (clicodigo) REFERENCES tbl_clientes(clicodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE cotizacion_ventas_detalle(
	cve_documento VARCHAR(10),
    cvd_orden INT NOT NULL,
    prodcodigo INT,
    cve_cantidad_producto INT (5),
    cve_costo_producto FLOAT (10,2),
    PRIMARY KEY (cve_documento, prodcodigo),
    FOREIGN KEY (cve_documento) REFERENCES cotizacion_ventas_encabezado(cve_documento),
    FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE pedidos_ventas_encabezado(
	pve_documento VARCHAR(10),
    clicodigo INT,
    pve_fecha DATE,
    PRIMARY KEY (pve_documento, clicodigo),
    FOREIGN KEY (clicodigo) REFERENCES tbl_clientes(clicodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE pedidos_ventas_detalle(
	pve_documento VARCHAR(10),
	prodcodigo INT,
    pve_cantidad_producto INT (5),
    pve_total_producto FLOAT (10,2),
    PRIMARY KEY (pve_documento, prodcodigo),
    FOREIGN KEY (pve_documento) REFERENCES pedidos_ventas_encabezado(pve_documento),
    FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1; 
 
 -------------------- AREA COMPRAS -------------------------- 
CREATE TABLE deudas_compras_encabezado(
	dce_documento VARCHAR(10),
	procodigo INT,			
    coedocumento VARCHAR(10),  
    dce_estatus VARCHAR(1),
    PRIMARY KEY (dce_documento, procodigo, coedocumento),
    FOREIGN KEY (procodigo) REFERENCES tbl_proveedores(procodigo),
    FOREIGN KEY (coedocumento) REFERENCES tbl_compras_encabezado(coedocumento)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE deudas_compras_detalle(
	dce_documento VARCHAR(10),
    prodcodigo INT,
    total_compras FLOAT(10,2),
    dce_saldo_documento FLOAT (10,2),
    deudacompra FLOAT(10,2),
    PRIMARY KEY (dce_documento, prodcodigo),
    FOREIGN KEY (dce_documento) REFERENCES deudas_compras_encabezado(dce_documento),
    FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE cotizacion_compras_encabezado(
	cce_documento VARCHAR(10),
    procodigo INT,
    cce_fecha DATE,
    PRIMARY KEY (cce_documento, procodigo),
    FOREIGN KEY (procodigo) REFERENCES tbl_proveedores(procodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE cotizacion_compras_detalle(
	cce_documento VARCHAR(10),
    prodcodigo INT,
    cce_cantidad_producto INT (5),
    cce_total_producto FLOAT (10,2),
    PRIMARY KEY (cce_documento, prodcodigo),
    FOREIGN KEY (cce_documento) REFERENCES cotizacion_compras_encabezado(cce_documento),
    FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE pedidos_compras_encabezado(
	pce_documento VARCHAR(10),
    procodigo INT,
    pce_fecha VARCHAR(10),
    pce_total INT (10),
    pce_estatus VARCHAR(1),
    PRIMARY KEY (pce_documento, procodigo),
    FOREIGN KEY (procodigo) REFERENCES tbl_proveedores(procodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE pedidos_compras_detalle(
	pce_documento VARCHAR(10),
	pcd_orden INT NOT NULL,
    prodcodigo INT,
    pcd_cantidad_producto INT (5),
    pcd_costo_producto INT (10),
    PRIMARY KEY (pce_documento, prodcodigo),
    FOREIGN KEY (pce_documento) REFERENCES pedidos_compras_encabezado(pce_documento),
    FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

 -------------------- AREA DEVOLUCION -------------------------- 

CREATE TABLE tbl_ventasdevolucion_encabezado
(
	idvendev VARCHAR(10),
    pve_documento VARCHAR(10),
    clicodigo INT,
    Fechavendev DATE,
    PRIMARY KEY (idvendev, pve_documento, clicodigo),
    FOREIGN KEY (pve_documento) REFERENCES pedidos_ventas_encabezado(pve_documento),
	FOREIGN KEY (clicodigo) REFERENCES tbl_clientes(clicodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE tbl_ventasdevolucion_detalle
(
	idvendev VARCHAR(10),
    prodcodigo INT,
    ventdevde_cantidad FLOAT (10,2),
    ventdevde_total FLOAT (10,2),
    PRIMARY KEY (idvendev, prodcodigo),
    FOREIGN KEY (idvendev) REFERENCES tbl_ventasdevolucion_encabezado(idvendev),
	FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE tbl_comprasdevolucion_encabezado
(
	idcomdev VARCHAR(10),
    pce_documento VARCHAR(10),
    procodigo INT,
    Fechavendev DATE,
    PRIMARY KEY (idcomdev, pce_documento, procodigo),
    FOREIGN KEY (pce_documento) REFERENCES pedidos_compras_encabezado(pce_documento),
	FOREIGN KEY (procodigo) REFERENCES tbl_proveedores(procodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE tbl_comprasdevolucion_detalle
(
	idcomdev VARCHAR(10),
    prodcodigo INT,
    ventdevde_cantidad FLOAT (10,2),
    ventdevde_total FLOAT (10,2),
    PRIMARY KEY (idcomdev, prodcodigo),
    FOREIGN KEY (idcomdev) REFERENCES tbl_comprasdevolucion_encabezado(idcomdev),
	FOREIGN KEY (prodcodigo) REFERENCES tbl_productos(prodcodigo)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

-- TABLA PARA TRIGGER --
CREATE TABLE tbl_bitacoraventas
(
	bitventas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bitventas_accion VARCHAR(55),
    bitventas_fecha DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB DEFAULT CHARSET=latin1;
    