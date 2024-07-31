CREATE DATABASE PROYECTO_BD;

USE PROYECTO_BD;

/*
Almacena todos los puestos del sistema, incluyendo su nombre y salario.
*/

CREATE TABLE PUESTO
(
	PTO_ID INT NOT NULL AUTO_INCREMENT,
	PTO_NOMBRE VARCHAR(50) NOT NULL,
	PTO_SALARIO DECIMAL(9,2) NOT NULL,
	CONSTRAINT PK_PUESTO PRIMARY KEY (PTO_ID)
);

/*
Almacena todos los puestos del sistema, incluyendo su nombre y salario.
*/

CREATE TABLE PUESTO_HISTORIAL
(
	PTO_ID INT NOT NULL,
	PTO_NOMBRE VARCHAR(50) NOT NULL,
	PTO_SALARIO DECIMAL(9,2) NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);


/*
Almacena los datos de una oficina fisica, como lo son el identificador, nombre, ubicacion y el numero de telefono
*/

CREATE TABLE OFICINA
(
	OFC_ID INT NOT NULL AUTO_INCREMENT,
	OFC_NOMBRE VARCHAR(50) NOT NULL,
	OFC_UBICACION VARCHAR(100) NOT NULL,
	OFC_TELEFONO INT NOT NULL UNIQUE,
	CONSTRAINT PK_OFICINA PRIMARY KEY (OFC_ID)
);

/*
Aparte de almacenar los datos de la tabla OFICINA, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE OFICINA_HISTORIAL
(
	OFC_ID INT NOT NULL,
	OFC_NOMBRE VARCHAR(50) NOT NULL,
	OFC_UBICACION VARCHAR(100) NOT NULL,
	OFC_TELEFONO INT NOT NULL UNIQUE,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de un empleado fisico, como lo son el identificador, nombre,
nacimiento, el puesto (llave foranea con PUESTO), la oficina en la que trabaja (
foranea con OFICINA, el estado (activo o inactivo) y el nombre de usuario)
*/

CREATE TABLE EMPLEADO
(
	EMP_IDENTIFICACION INT NOT NULL,
	EMP_NOMBRE VARCHAR(50) NOT NULL,
	EMP_NACIMIENTO DATE NOT NULL,
	EMP_PUESTO_ID INT NOT NULL,
	EMP_OFC_ID INT NOT NULL,
	EMP_ESTADO BOOL NOT NULL CHECK (EMP_ESTADO in (1, 0)) DEFAULT 1,
	EMP_USUARIO VARCHAR(50) NOT NULL,
	CONSTRAINT PK_EMPLEADO PRIMARY KEY (EMP_IDENTIFICACION),
    CONSTRAINT UNI_USUARIO UNIQUE (EMP_USUARIO),
	CONSTRAINT FK_EMPLEADO_PUESTO FOREIGN KEY (EMP_PUESTO_ID) REFERENCES PUESTO(PTO_ID),
	CONSTRAINT FK_EMPLEADO_OFICINA FOREIGN KEY (EMP_OFC_ID) REFERENCES OFICINA(OFC_ID)
);

/*
Aparte de almacenar los datos de la tabla EMPLEADO, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE EMPLEADO_HISTORIAL
(
	EMP_IDENTIFICACION INT NOT NULL,
	EMP_NOMBRE VARCHAR(50) NOT NULL,
	EMP_NACIMIENTO DATE NOT NULL,
	EMP_PUESTO_ID INT NOT NULL,
	EMP_OFC_ID INT NOT NULL,
	EMP_ESTADO BOOL NOT NULL CHECK (EMP_ESTADO in (1, 0)) DEFAULT 1,
	EMP_USUARIO VARCHAR(50) NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Aparte de almacenar los datos de la tabla EMPLEADO, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE REGISTRO
(
	EMP_IDENTIFICACION INT NOT NULL,
    REG_FECHA DATE NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    CONSTRAINT FK_REGISTRADO_EMPLEADO FOREIGN KEY (EMP_IDENTIFICACION) REFERENCES EMPLEADO(EMP_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla REGISTRO, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE REGISTRO_HISTORIAL
(
	EMP_IDENTIFICACION INT NOT NULL,
    REG_FECHA DATE NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    NOMBRE_USUARIO_MODIFICA VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de la direccion de un empleado como provincia, canton, distrito y otras señas
*/

CREATE TABLE DIRECCION_EMPLEADO
(
	DIR_IDENTIFICACION INT NOT NULL,
    DIR_PROVINCIA VARCHAR(30) NOT NULL,
    DIR_CANTON VARCHAR(30) NOT NULL,
    DIR_DISTRITO VARCHAR(30),
    DIR_OTRAS_SENAS VARCHAR(30),
    CONSTRAINT FK_DIRECCION_EMPLEADO FOREIGN KEY (DIR_IDENTIFICACION) REFERENCES EMPLEADO(EMP_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla DIRECCION_EMPLEADO, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE DIRECCION_EMPLEADO_HISTORIAL
(
	DIR_IDENTIFICACION INT NOT NULL,
    DIR_PROVINCIA VARCHAR(30) NOT NULL,
    DIR_CANTON VARCHAR(30) NOT NULL,
    DIR_DISTRITO VARCHAR(30),
    DIR_OTRAS_SENAS VARCHAR(30),
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos del telefono de un empleado, el identificador, el empleado (llave foranea a la tabla empleado)
y el telefono
*/

CREATE TABLE TELEFONO_EMPLEADO(
	CONT_ID INT AUTO_INCREMENT,
	EMP_IDENTIFICACION INT NOT NULL,
    CONT_TELEFONO VARCHAR(40) NOT NULL,
    CONSTRAINT ID PRIMARY KEY(CONT_ID),
    CONSTRAINT TELEFONO_EMP FOREIGN KEY (EMP_IDENTIFICACION) REFERENCES EMPLEADO(EMP_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla TELEFONO_EMPLEADO, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE TELEFONO_EMPLEADO_HISTORIAL(
	CONT_ID INT,
	EMP_IDENTIFICACION INT NOT NULL,
    CONT_TELEFONO VARCHAR(40) NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos del correo de un empleado, el identificador, el empleado (llave foranea a la tabla empleado)
y el correo
*/

CREATE TABLE CORREO_EMPLEADO
(
	CONT_ID INT AUTO_INCREMENT,
	EMP_IDENTIFICACION INT NOT NULL,
	CONT_CORREO VARCHAR(100) NOT NULL,
    CONSTRAINT ID PRIMARY KEY(CONT_ID),
    CONSTRAINT CORREO_EMP FOREIGN KEY (EMP_IDENTIFICACION) REFERENCES EMPLEADO(EMP_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla CORREO_EMPLEADO, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE CORREO_EMPLEADO_HISTORIAL
(
	CONT_ID INT,
	EMP_IDENTIFICACION INT NOT NULL,
	CONT_CORREO VARCHAR(100) NOT NULL,
    NOMBRE_USUARIO VARCHAR(100),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de un vehiculo como el identificador y el tipo
*/

CREATE TABLE TIPOVEHICULO
(
	ID INT AUTO_INCREMENT,
    TIPO VARCHAR(40),
    PRIMARY KEY(ID)
);

/*
Aparte de almacenar los datos de la tabla TIPO_VEHICULO, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE TIPOVEHICULO_HISTORIAL
(
	ID INT,
    TIPO VARCHAR(40),
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de los vehiculos como el numero interno, la placa, marca,
cantidad disponible, el tipo (llave foranea con TIPO_VEHICULO) y el estado
*/

CREATE TABLE INVENTARIO_VEHICULOS
(
	INV_NUM_INTERNO VARCHAR(60),
    INV_NUM_PLACA VARCHAR(50),
    INV_MARCA VARCHAR(30) NOT NULL,
    INV_STOCK INT DEFAULT 0,
    TIP_ID INT NOT NULL,
    INV_ESTADO_VEHICULO VARCHAR(10),
    CONSTRAINT PK_NUM_INTERNO PRIMARY KEY(INV_NUM_INTERNO),
    CONSTRAINT FK_TIP_INV FOREIGN KEY(TIP_ID) REFERENCES TIPOVEHICULO(ID)
);

/*
Aparte de almacenar los datos de la tabla INVENTARIO_VEHICULOS, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE INVENTARIO_VEHICULOS_HISTORIAL
(
	INV_NUM_INTERNO VARCHAR(60),
    INV_NUM_PLACA VARCHAR(50),
    INV_MARCA VARCHAR(30) NOT NULL,
    INV_STOCK INT DEFAULT 0,
    TIP_ID INT NOT NULL,
    INV_ESTADO_VEHICULO VARCHAR(10),
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de los registros de los vehiculos, como el id del registro, el vehiculo (
llave foranea con INVENTARIO_VEHICULOS), la fecha que se registro y el usuario que lo registro
*/

CREATE TABLE REGISTRO_VEHICULOS
(
	REG_ID INT AUTO_INCREMENT,
    REG_NUM_INTERNO VARCHAR(60) NOT NULL,
    REG_FECHA_REGISTRO DATE NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    CONSTRAINT PK_ID PRIMARY KEY(REG_ID),
    CONSTRAINT FK_REGISTRO_INVENTARIO_VEHICULOS FOREIGN KEY (REG_NUM_INTERNO) REFERENCES INVENTARIO_VEHICULOS(INV_NUM_INTERNO)
);

/*
Aparte de almacenar los datos de la tabla REGISTRO_VEHICULOS, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE REGISTRO_VEHICULOS_HISTORIAL
(
	REG_ID INT,
    REG_NUM_INTERNO VARCHAR(60) NOT NULL,
    REG_FECHA_REGISTRO DATE NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    NOMBRE_USUARIO_MODIFICA VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de las revisiones, como el id de la revision, el vehiculo (
llave foranea con INVENTARIO_VEHICULOS), la fecha de la revision, lo que se hizo en la revision,
y el tipo de mantenimiento
*/

CREATE TABLE REVISION
(
	REV_ID INT AUTO_INCREMENT,
	REV_NUM_INTERNO VARCHAR(60) NOT NULL,
    REV_FECHA_REVISION DATE NOT NULL,
    REV_DESCRIPCION VARCHAR(100),
    REV_TIPO_MANTENIMIENTO VARCHAR(50),
    CONSTRAINT PK_ID PRIMARY KEY(REV_ID),
    CONSTRAINT FK_REVISION_VEHICULO FOREIGN KEY(REV_NUM_INTERNO) REFERENCES REGISTRO_VEHICULOS(REG_NUM_INTERNO)
);

/*
Aparte de almacenar los datos de la tabla REVISION, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE REVISION_HISTORIAL
(
	REV_ID INT,
	REV_NUM_INTERNO VARCHAR(60) NOT NULL,
    REV_FECHA_REVISION DATE NOT NULL,
    REV_DESCRIPCION VARCHAR(100),
    REV_TIPO_MANTENIMIENTO VARCHAR(50),
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de los tipos de envio, como el id del tipo y el nombre o descripcion del
tipo de envio
*/

CREATE TABLE TIPO_ENVIO
(
	ID INT AUTO_INCREMENT,
    TIPO VARCHAR(50) NOT NULL,
    CONSTRAINT ID PRIMARY KEY(ID)
);

/*
Aparte de almacenar los datos de la tabla TIPO_ENVIO, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE TIPO_ENVIO_HISTORIAL
(
	ID INT,
    TIPO VARCHAR(50) NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de un cliente, como el id, el tipo de cliente,
y el estado del mismo
*/

CREATE TABLE CLIENTE
(
	CLI_IDENTIFICACION INT NOT NULL,
    CLI_TIPO VARCHAR(20) CHECK (CLI_TIPO in ('Vip', 'Normal')),
    CLI_ESTADO VARCHAR(20) CHECK (CLI_ESTADO in (1, 0)) DEFAULT 1,
    CONSTRAINT PK_IDENTIFICACION PRIMARY KEY(CLI_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla CLIENTE, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE CLIENTE_HISTORIAL
(
	CLI_IDENTIFICACION INT NOT NULL,
    CLI_TIPO VARCHAR(20) CHECK (CLI_TIPO in ('Vip', 'Normal')),
    CLI_ESTADO VARCHAR(20) CHECK (CLI_ESTADO in (1, 0)) DEFAULT 1,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de la direccion de un cliente, como el id (llave foranea con CLIENTE), la provincia,
el canton, el distrito y otras señas
*/

CREATE TABLE DIRECCION_CLIENTE
(
	DIR_IDENTIFICACION INT NOT NULL,
    DIR_PROVINCIA VARCHAR(30) NOT NULL,
    DIR_CANTON VARCHAR(30) NOT NULL,
    DIR_DISTRITO VARCHAR(30),
    DIR_OTRAS_SENAS VARCHAR(30),
    CONSTRAINT FK_DIRECCION_CLIENTE FOREIGN KEY (DIR_IDENTIFICACION) REFERENCES CLIENTE(CLI_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla CLIENTE, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE DIRECCION_CLIENTE_HISTORIAL
(
	DIR_IDENTIFICACION INT NOT NULL,
    DIR_PROVINCIA VARCHAR(30) NOT NULL,
    DIR_CANTON VARCHAR(30) NOT NULL,
    DIR_DISTRITO VARCHAR(30),
    DIR_OTRAS_SENAS VARCHAR(30),
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos del telefono de un cliente, como el id, id del cliente (llave foranea con CLIENTE),
el numero de telefono 
*/

CREATE TABLE TELEFONO_CLIENTE(
	CONT_ID INT AUTO_INCREMENT,
	CLI_IDENTIFICACION INT NOT NULL,
    CONT_TELEFONO VARCHAR(40) NOT NULL,
    CONSTRAINT ID PRIMARY KEY(CONT_ID),
    CONSTRAINT TELEFONO_CLI FOREIGN KEY (CLI_IDENTIFICACION) REFERENCES CLIENTE(CLI_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla TELEFONO_CLIENTE, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE TELEFONO_CLIENTE_HISTORIAL(
	CONT_ID INT,
	CLI_IDENTIFICACION INT NOT NULL,
    CONT_TELEFONO VARCHAR(40) NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos del correo de un cliente, como el id, id del cliente (llave foranea con CLIENTE),
el correo electronico 
*/

CREATE TABLE CORREO_CLIENTE
(
	CONT_ID INT AUTO_INCREMENT,
	CLI_IDENTIFICACION INT NOT NULL,
	CONT_CORREO VARCHAR(100) NOT NULL,
    CONSTRAINT ID PRIMARY KEY(CONT_ID),
    CONSTRAINT CORREO_CLI FOREIGN KEY (CLI_IDENTIFICACION) REFERENCES CLIENTE(CLI_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla CORREO_CLIENTE, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE CORREO_CLIENTE_HISTORIAL
(
	CONT_ID INT,
	CLI_IDENTIFICACION INT NOT NULL,
	CONT_CORREO VARCHAR(100) NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de un paquete, como el id, descripcion, la oficina donde esta (llave foranea con OFICINA),
el tipo de envio (llave foranea con TIPO_ENVIO), empleado que procesa el pedido (llave foranea con EMPLEADO),
cliente que hace el pedido y el estado del paquete
*/

CREATE TABLE PAQUETE
(
	PAQ_NUM INT NOT NULL,
    PAQ_DESCRIPCION VARCHAR(100),
    OFC_ID INT,
    ID_TIPO_ENVIO INT,
    EMP_IDENTIFICACION INT,
    CLI_ID VARCHAR(50),
    ESTADO_PAQUETE VARCHAR(40),
    PRECIO DECIMAL(10,2),
    CONSTRAINT PK_PAQUETE PRIMARY KEY(PAQ_NUM),
    CONSTRAINT FK_PAQUETE_OFICINA FOREIGN KEY(OFC_ID) REFERENCES OFICINA(OFC_ID),
    CONSTRAINT FK_PAQUETE_ENVIO FOREIGN KEY(ID_TIPO_ENVIO) REFERENCES TIPO_ENVIO(ID),
    CONSTRAINT FK_PAQUETE_EMPLEADO FOREIGN KEY(EMP_IDENTIFICACION) REFERENCES EMPLEADO(EMP_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla PAQUETE, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE PAQUETE_HISTORIAL
(
	PAQ_NUM INT NOT NULL,
    PAQ_DESCRIPCION VARCHAR(100),
    OFC_ID INT,
    ID_TIPO_ENVIO INT,
    EMP_IDENTIFICACION INT,
    CLI_ID VARCHAR(50),
    ESTADO_PAQUETE VARCHAR(40),
    PRECIO DECIMAL(10,2),
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de los registros de los paquete, como el id, el id del paquete (llave foranea con PAQUETE),
fecha que se hizo el registro y el nombre del usuario
*/

CREATE TABLE REGISTRO_PAQUETES
(
	REG_ID INT AUTO_INCREMENT,
	PAQ_NUM INT NOT NULL,
    REG_FECHA DATE NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    CONSTRAINT PK_ID PRIMARY KEY(REG_ID),
    CONSTRAINT FK_REGISTRO_PAQUETE FOREIGN KEY(PAQ_NUM) REFERENCES PAQUETE(PAQ_NUM)
);

/*
Aparte de almacenar los datos de la tabla REGISTRO_PAQUETES, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE REGISTRO_PAQUETES_HISTORIAL
(
	REG_ID INT,
	PAQ_NUM INT NOT NULL,
    REG_FECHA DATE NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    NOMBRE_USUARIO_MODIFICA VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de la factura, como el id, el cliente (llave foranea con CLIENTE), fecha de la factura, 
fecha que se registro la factura, el nombre del registro y el estado
*/

CREATE TABLE FACTURA
(
	FAC_NUM INT NOT NULL,
    CLI_ID INT NOT NULL,
    FAC_FECHA DATE NOT NULL,
    FAC_FECHA_REGISTRO DATE,
    NOMBRE_REGISTRO VARCHAR(50),
    FAC_ESTADO VARCHAR(20) CHECK (FAC_ESTADO IN ('Anulada','Activa')),
    CONSTRAINT PK_NUMFACTURA PRIMARY KEY (FAC_NUM),
    CONSTRAINT FK_FACTURA_CLIENTE FOREIGN KEY (CLI_ID) REFERENCES CLIENTE(CLI_IDENTIFICACION)
);

/*
Aparte de almacenar los datos de la tabla FACTURA, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE FACTURA_HISTORIAL
(
	FAC_NUM INT NOT NULL,
    CLI_ID INT NOT NULL,
    FAC_FECHA DATE NOT NULL,
    FAC_FECHA_REGISTRO DATE,
    NOMBRE_REGISTRO VARCHAR(50),
    NOMBRE_USUARIO_MODIFICA VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los datos de los paquetes de una factura, como el id, el id de la factura (llave foranea con FACTURA)
y el id del paquete (llave foranea con PAQUETE)
*/

CREATE TABLE FACTURA_PAQUETE
(
	ID INT AUTO_INCREMENT,
	FAC_NUM INT NOT NULL,
    PAQ_NUM INT NOT NULL,
    PAQ_CANT INT NOT NULL,
    PAQ_TOTAL DECIMAL(10,2) NOT NUll DEFAULT 0,
    CONSTRAINT PK_ID PRIMARY KEY (ID),
    CONSTRAINT FK_NUMFACTURA FOREIGN KEY(FAC_NUM) REFERENCES FACTURA(FAC_NUM),
    CONSTRAINT FK_NUMPAQUETE FOREIGN KEY(PAQ_NUM) REFERENCES PAQUETE(PAQ_NUM)
);

/*
Aparte de almacenar los datos de la tabla FACTURA_PAQUETE, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE FACTURA_PAQUETE_HISTORIAL
(
	ID INT,
	FAC_NUM INT NOT NULL,
    PAQ_NUM INT NOT NULL,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

/*
Almacena los detalles de una factura, como el id, el numero de factura (llave foranea con FACTURA),
los impuestos, el flete, el impuesto de venta, el total por envio, el total antes del iva y el total
de la factura
*/

CREATE TABLE DETALLE_FACTURA(
	ID INT AUTO_INCREMENT,
	FAC_NUM INT NOT NULL,
    COSTO_IMPUESTOS INT,
    COSTO_FLETE INT,
    COSTO_IV INT,
    TOTAL_POR_ENVIO INT DEFAULT 0,
    TOTAL_ANTES_IVA INT DEFAULT 0,
    TOTAL_FACTURA INT DEFAULT 0,
    CONSTRAINT PK_ID PRIMARY KEY(ID),
    CONSTRAINT FK_DETFACTURA FOREIGN KEY(FAC_NUM) REFERENCES FACTURA(FAC_NUM)
);

/*
Aparte de almacenar los datos de la tabla DETALLE_FACTURA, guarda el nombre del usuario que 
ejecuto la acción, la fecha que se realizó y la acción
*/

CREATE TABLE DETALLE_FACTURA_HISTORIAL
(
	ID INT,
	FAC_NUM INT NOT NULL,
    COSTO_IMPUESTOS INT,
    COSTO_FLETE INT,
    COSTO_IV INT,
    TOTAL_POR_ENVIO INT,
    TOTAL_ANTES_IVA INT,
    TOTAL_FACTURA INT,
    NOMBRE_USUARIO VARCHAR(50),
    FECHA DATE,
    ACCION VARCHAR(50)
);

####################STORED PROCEDURE###################################
/*
Recibe los parametros de nombre y salario y los inserta en la tabla puesto
*/

DELIMITER //
CREATE PROCEDURE INSERTAR_PUESTO(NOMBRE VARCHAR(50), SALARIO DECIMAL(9,2))
BEGIN
	INSERT INTO PUESTO (PTO_NOMBRE, PTO_SALARIO) VALUES (NOMBRE, SALARIO);
END//

/*
Recibe los parametros de nombre, salario y el id de la fila que se desea editar y
remplaza en la fila los valores antiguos por los nuevos en la tabla puesto
*/

CREATE PROCEDURE EDITAR_PUESTO(ID INT, NOMBRE VARCHAR(50), SALARIO DECIMAL(9,2))
BEGIN
	UPDATE PUESTO SET PTO_NOMBRE=NOMBRE, PTO_SALARIO=SALARIO WHERE PTO_ID=ID;
END//

/*
Recibe el parametro del id de la fila que se desea eliminar y elimina la fila de la tabla puesto
*/

CREATE PROCEDURE ELIMINAR_PUESTO(ID INT)
BEGIN
	DELETE FROM PUESTO WHERE PTO_ID=ID;
END//

/*
Muestra todas las filas que contenga la tabla puesto
*/

CREATE PROCEDURE TODOS_PUESTOS()
BEGIN
	SELECT * FROM PUESTO;
END//
DELIMITER ;

/*
Recibe los parametros de nombre, ubicacion y telefono y los inserta en la tabla oficina
*/

DELIMITER //
CREATE PROCEDURE INSERTAR_OFICINA(NOMBRE VARCHAR(50), UBICACION VARCHAR(100), TELEFONO INT)
BEGIN
	INSERT INTO OFICINA (OFC_NOMBRE, OFC_UBICACION, OFC_TELEFONO) VALUES (NOMBRE, UBICACION, TELEFONO);
END//

/*
Recibe los parametros de nombre, ubicacion, telefono y el id de la fila que se desea editar y
remplaza en la fila los valores antiguos por los nuevos en la tabla oficina
*/

CREATE PROCEDURE EDITAR_OFICINA(ID INT, NOMBRE VARCHAR(50), UBICACION VARCHAR(100), TELEFONO INT)
BEGIN
	UPDATE OFICINA SET OFC_NOMBRE=NOMBRE, OFC_UBICACION=UBICACION, OFC_TELEFONO=TELEFONO WHERE OFC_ID=ID;
END//

/*
Recibe el parametro del id de la fila que se desea eliminar y elimina la fila de la tabla oficina
*/

CREATE PROCEDURE ELIMINAR_OFICINA(ID INT)
BEGIN
	DELETE FROM OFICINA WHERE OFC_ID=ID;
END//

/*
Muestra todas las filas que contenga la tabla oficina
*/

CREATE PROCEDURE TODOS_OFICINAS()
BEGIN
	SELECT * FROM OFICINA;
END//
DELIMITER ;

/*
Recibe los parametros de identifacion, nombre, fecha de nacimiento, id del puesto,
nombre de usuario, nombre de usuario de la persona que registro, provincia, canton,
distrito y otras señas y los inserta en la tabla empleado
*/

DELIMITER //
CREATE PROCEDURE INSERTAR_EMPLEADO(ID INT, NOMBRE VARCHAR(50), NAC DATE, PUESTO INT, OFC INT, USUARIO VARCHAR(50), U_REGISTRO VARCHAR(50), PROVINCIA VARCHAR(30), CANTON VARCHAR(30), DISTRITO VARCHAR(30), OTRAS_SENAS VARCHAR(30))
BEGIN
	INSERT INTO EMPLEADO (EMP_IDENTIFICACION, EMP_NOMBRE, EMP_NACIMIENTO, EMP_PUESTO_ID, EMP_OFC_ID, EMP_USUARIO) VALUES (ID, NOMBRE, NAC, PUESTO, OFC, USUARIO);
	INSERT INTO REGISTRO VALUES(ID, CURRENT_DATE(), U_REGISTRO);
	INSERT INTO DIRECCION_EMPLEADO (DIR_IDENTIFICACION, DIR_PROVINCIA, DIR_CANTON, DIR_DISTRITO, DIR_OTRAS_SENAS) VALUES (ID, PROVINCIA, CANTON, DISTRITO, OTRAS_SENAS);
END//

/*
Recibe los parametros de identifacion, nombre, fecha de nacimiento, id del puesto,
nombre de usuario, nombre de usuario de la persona que registro, provincia, canton,
distrito y otras señas y remplaza en la fila los valores antiguos por los nuevos donde
identificacion sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_EMPLEADO(ID INT, NOMBRE VARCHAR(50), NAC DATE, PUESTO INT, OFC INT, USUARIO VARCHAR(50))
BEGIN
	UPDATE EMPLEADO SET EMP_IDENTIFICACION=ID, EMP_NOMBRE=NOMBRE, EMP_NACIMIENTO=NAC, EMP_PUESTO_ID=PUESTO, EMP_OFC_ID=OFC, EMP_USUARIO=USUARIO WHERE EMP_IDENTIFICACION=ID;
END//

/*
Recibe el parametro de identificacion y elimina primeramente de las telefonos donde se
encuentre asociado ese empleado, elimina las asociaciones con la tabla telefono_empleado,
con la tabla correo_empleado, con la tabla registro y por lo ultimo elimina la fila de la
tabla oficina donde identificacion sea igual a la enviada por parametros
*/

CREATE PROCEDURE ELIMINAR_EMPLEADO (ID INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    DELETE FROM TELEFONO_EMPLEADO WHERE TELEFONO_EMPLEADO.CONT_ID IN (SELECT * FROM (SELECT CONT_ID FROM TELEFONO_EMPLEADO WHERE EMP_IDENTIFICACION=ID) AS T);
    DELETE FROM CORREO_EMPLEADO WHERE CORREO_EMPLEADO.CONT_ID IN (SELECT * FROM (SELECT CONT_ID FROM CORREO_EMPLEADO WHERE EMP_IDENTIFICACION=ID) AS T);
    SET SQL_SAFE_UPDATES = 1;
    DELETE FROM DIRECCION_EMPLEADO WHERE DIRECCION_EMPLEADO.DIR_IDENTIFICACION=ID;
    DELETE FROM REGISTRO WHERE REGISTRO.EMP_IDENTIFICACION=ID;
    DELETE FROM EMPLEADO WHERE EMPLEADO.EMP_IDENTIFICACION=ID;
END//

/*
Muestra todas las filas que contenga la tabla empleados
*/

CREATE PROCEDURE TODOS_EMPLEADOS()
BEGIN
	SELECT EMPLEADO.EMP_IDENTIFICACION AS 'IDENTIFICACION', EMPLEADO.EMP_NOMBRE AS 'NOMBRE', EMPLEADO.EMP_NACIMIENTO AS 'FECHA NACIMINENTO', (SELECT PTO_NOMBRE FROM PUESTO WHERE PTO_ID=EMPLEADO.EMP_PUESTO_ID) AS 'PUESTO', (SELECT OFC_NOMBRE FROM OFICINA WHERE OFC_ID=EMPLEADO.EMP_OFC_ID) AS 'OFICINA', EMPLEADO.EMP_USUARIO AS 'USUARIO', DIRECCION_EMPLEADO.DIR_PROVINCIA AS 'DIRECCION', DIRECCION_EMPLEADO.DIR_CANTON AS 'CANTON', DIRECCION_EMPLEADO.DIR_DISTRITO AS 'DISTRITO', DIRECCION_EMPLEADO.DIR_OTRAS_SENAS AS 'OTRAS_SEÑAS' FROM EMPLEADO,DIRECCION_EMPLEADO WHERE EMPLEADO.EMP_IDENTIFICACION = DIRECCION_EMPLEADO.DIR_IDENTIFICACION;
END//

/*
Recibe los parametros de identifacion, fecha de registro y nombre de usuario de la persona
que registró y remplaza en la fila los valores antiguos por los nuevos donde
identificacion sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_REGISTRO(id INT, fecha DATE, URegistro VARCHAR(50))
BEGIN
	UPDATE REGISTRO SET EMP_IDENTIFICACION=id, REG_FECHA=fecha,NOMBRE_USUARIO=URegistro WHERE EMP_IDENTIFICACION=id;
END//

/*
Muestra todas las filas que contenga la tabla registro
*/

CREATE PROCEDURE TODOS_REGISTRO()
BEGIN
	SELECT EMPLEADO.EMP_USUARIO AS "EMPLEADO", REG_FECHA AS "FECHA REGISTRO", NOMBRE_USUARIO AS "NOMBRE DE USUARIO" FROM REGISTRO, EMPLEADO GROUP BY EMPLEADO.EMP_USUARIO;
END//

/*
Recibe los parametros de identifacion, provincia, canton, distrito y otras señas y remplaza en la fila
los valores antiguos por los nuevos donde identificacion sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_DIRECCION_EMPLEADO(ID INT, PROVINCIA VARCHAR(30), CANTON VARCHAR(30), DISTRITO VARCHAR(30), OTRAS_SENAS VARCHAR(30))
BEGIN
	UPDATE DIRECCION_EMPLEADO SET DIR_PROVINCIA=PROVINCIA, DIR_CANTON=CANTON, DIR_DISTRITO=DISTRITO, DIR_OTRAS_SENAS=OTRAS_SENAS WHERE DIR_IDENTIFICACION=ID;
END//

/*
Muestra todas las filas que contenga la tabla direccion_empleado
*/

CREATE PROCEDURE TODOS_DIRECCION_EMPLEADO()
BEGIN
	SELECT * FROM DIRECCION_EMPLEADO;
END//

/*
Muestra la fila de la tabla direccion_empleado donde identificacion sea igual a la que se paso
por parametros
*/

CREATE PROCEDURE DIRECCION_EMPLEADO_POR_ID(id INT)
BEGIN
	SELECT * FROM DIRECCION_EMPLEADO WHERE DIR_IDENTIFICACION = id;
END//

/*
Recibe los parametros de identifacion y correo y los inserta en la tabla correo_empleado
*/

CREATE PROCEDURE INSERTAR_CORREO_EMPLEADO(IDENTIFICACION INT, CORREO VARCHAR(100))
BEGIN
	INSERT INTO CORREO_EMPLEADO(EMP_IDENTIFICACION, CONT_CORREO) VALUES(IDENTIFICACION, CORREO);
END//

/*
Recibe los parametros del id de la fila, identifacion y correo y remplaza en la fila
los valores antiguos por los nuevos donde id de la fila sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_CORREO_EMPLEADO(ID INT, IDENTIFICACION INT, CORREO VARCHAR(100))
BEGIN
	UPDATE CORREO_EMPLEADO SET EMP_IDENTIFICACION=IDENTIFICACION, CONT_CORREO=CORREO WHERE CONT_ID=ID;
END//

/*
Recibe el parametro del id de la fila que se desea eliminar y elimina la fila de la tabla correo_empleado
*/

CREATE PROCEDURE ELIMINAR_CORREO_EMPLEADO(ID INT)
BEGIN
	DELETE FROM CORREO_EMPLEADO WHERE CONT_ID=ID;
END//

/*
Muestra todas las filas que contenga la tabla correo_empleado
*/

CREATE PROCEDURE TODOS_CORREO_EMPLEADO()
BEGIN
	SELECT * FROM CORREO_EMPLEADO;
END//

/*
Recibe los parametros de identifacion y telefono y los inserta en la tabla telefono_empleado
*/

CREATE PROCEDURE INSERTAR_TELEFONO_EMPLEADO(IDENTIFICACION INT, TELEFONO VARCHAR(40))
BEGIN
	INSERT INTO TELEFONO_EMPLEADO (EMP_IDENTIFICACION, CONT_TELEFONO) VALUES(IDENTIFICACION, TELEFONO);
END//

/*
Recibe los parametros del id de la fila, identifacion y telefono y remplaza en la fila
los valores antiguos por los nuevos donde id de fila sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_TELEFONO_EMPLEADO(ID INT, IDENTIFICACION INT, TELEFONO VARCHAR(40))
BEGIN
	UPDATE TELEFONO_EMPLEADO SET EMP_IDENTIFICACION=IDENTIFICACION, CONT_TELEFONO=TELEFONO WHERE CONT_ID=ID;
END//

/*
Recibe el parametro del id de la fila que se desea eliminar y elimina la fila de la tabla telefono_empleado
*/

CREATE PROCEDURE ELIMINAR_TELEFONO_EMPLEADO(ID INT)
BEGIN
	DELETE FROM TELEFONO_EMPLEADO WHERE CONT_ID=ID;
END//

/*
Muestra todas las filas que contenga la tabla telefono_empleado
*/

CREATE PROCEDURE TODOS_TELEFONO_EMPLEADO()
BEGIN
	SELECT * FROM TELEFONO_EMPLEADO;
END//

/*
Muestra la fila de la tabla telefono_empleado donde identificacion sea igual a la que se paso
por parametros
*/

CREATE PROCEDURE OBTENER_TELEFONO_EMPLEADO(IDENTIFICACION INT)
BEGIN
	SELECT EMP_IDENTIFICACION AS Idenficacion, CONT_TELEFONO AS TELEFONO FROM TELEFONO_EMPLEADO WHERE EMP_IDENTIFICACION=IDENTIFICACION;
END//

/*
Muestra la fila de la tabla correo_empleado donde identificacion sea igual a la que se paso
por parametros
*/

CREATE PROCEDURE OBTENER_CORREO_EMPLEADO(IDENTIFICACION INT)
BEGIN
	SELECT EMP_IDENTIFICACION AS Idenficacion, CONT_CORREO AS CORREO FROM CORREO_EMPLEADO WHERE EMP_IDENTIFICACION=IDENTIFICACION;
END//

/*
Recibe el parametro de tipo y lo inserta en la tabla tipo_vehiculo
*/

CREATE PROCEDURE INSERTAR_TIPO_VEHICULO(tipo VARCHAR(40))
BEGIN
	INSERT INTO TIPOVEHICULO(TIPO) VALUES(tipo);
END//

/*
Recibe los parametros del id de la fila y tipo y remplaza en la fila
los valores antiguos por los nuevos donde id de fila sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_TIPO_VEHICULO(id INT, tipo VARCHAR(40))
BEGIN
	UPDATE TIPOVEHICULO SET TIPO = tipo WHERE TIPOVEHICULO.ID=id;
END//

/*
Recibe el parametro del id de la fila que se desea eliminar y elimina la fila de la tabla tipo_vehiculo
*/

CREATE PROCEDURE ELIMINAR_TIPO_VEHICULO(id INT)
BEGIN
	DELETE FROM TIPOVEHICULO WHERE TIPOVEHICULO.ID=id;
END//

/*
Muestra todas las filas que contenga la tabla tipo_vehiculo
*/

CREATE PROCEDURE TODOS_TIPO_VEHICULO()
BEGIN
	SELECT * FROM TIPOVEHICULO;
END//

/*
Recibe el parametro de numero interno, numero de placa, marca, stock, tipo, estado y nombre de usuario de la persona
que registro, inserta numero interno, numero de placa, marca, stock, tipo y estado en la tabla inventario vehiculo,
seguidamente ingresa numero interno, fecha de registro y nombre de usuario de la persona que registro
*/

CREATE PROCEDURE INSERTAR_VEHICULO(num_interno VARCHAR(60), num_placa VARCHAR(50), marca VARCHAR(30), stock INT, tipo INT, estado VARCHAR(10), URegistro VARCHAR(50))
BEGIN
	INSERT INTO INVENTARIO_VEHICULOS VALUES(num_interno, num_placa, marca, stock, tipo, estado);
    INSERT INTO REGISTRO_VEHICULOS (REG_NUM_INTERNO, REG_FECHA_REGISTRO, NOMBRE_USUARIO) VALUES(num_interno, NOW(), URegistro);
END//

/*
Recibe los parametros de numero interno, numero de placa, marca, stock, tipo y estado y remplaza en la fila
los valores antiguos por los nuevos donde numero interno de fila sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_VEHICULO(num_interno VARCHAR(60), num_placa VARCHAR(50), marca VARCHAR(30), stock INT, tipo INT, estado VARCHAR(10))
BEGIN
	UPDATE INVENTARIO_VEHICULOS SET INV_NUM_INTERNO=num_interno, INV_NUM_PLACA=num_placa, INV_MARCA=marca, INV_STOCK=stock, TIP_ID = tipo, INV_ESTADO_VEHICULO = estado WHERE INV_NUM_INTERNO = num_interno;
END//

/*
Recibe el parametro de numero interno de la fila que se desea eliminar, primeramente elimina las referencias
de la tabla registro_vehiculo y por ultimo elimina la fila de la tabla inventario_vehiculo donde numero interno
sea igual al que se paso por parametros
*/

CREATE PROCEDURE ELIMINAR_VEHICULO(num_interno VARCHAR(60))
BEGIN
	DELETE FROM REGISTRO_VEHICULOS WHERE REGISTRO_VEHICULOS.REG_ID = (SELECT * FROM (SELECT REG_ID FROM REGISTRO_VEHICULOS WHERE REG_NUM_INTERNO = num_interno) AS T);
	DELETE FROM INVENTARIO_VEHICULOS WHERE INV_NUM_INTERNO=num_interno;
END//

/*
Muestra todas las filas que contenga la tabla inventario_vehiculos
*/

CREATE PROCEDURE TODOS_VEHICULO()
BEGIN
	SELECT * FROM INVENTARIO_VEHICULOS;
END//

/*
Recibe los parametros de id de registro, numero interno, fecha de registro y nombre de usuario de la persona que regitró
y remplaza en la fila los valores antiguos por los nuevos donde id de registro de fila sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_REGISTRO_VEHICULO(reg_id INT, num_interno VARCHAR(60), fecha DATE, nombre_usuario VARCHAR(40))
BEGIN
	UPDATE REGISTRO_VEHICULOS SET REG_NUM_INTERNO=num_interno, REG_FECHA_REGISTRO=fecha, NOMBRE_USUARIO=nombre_usuario WHERE REGISTRO_VEHICULOS.REG_ID=reg_id;
END //

/*
Muestra todas las filas que contenga la tabla registro_vehiculos
*/

CREATE PROCEDURE TODOS_REGISTRO_VEHICULO()
BEGIN
	SELECT * FROM REGISTRO_VEHICULOS;
END//

/*
Recibe el parametro de numero interno, fecha de revision, descripcion y tipo y los ingresa dentro de la tabla revision
*/

CREATE PROCEDURE INSERTAR_REVISION(num_interno VARCHAR(60), fecha_revision DATE, descripcion VARCHAR(100), tipo VARCHAR(50))
BEGIN
	INSERT INTO REVISION (REV_NUM_INTERNO, REV_FECHA_REVISION, REV_DESCRIPCION, REV_TIPO_MANTENIMIENTO) VALUES(num_interno, fecha_revision, descripcion, tipo);
END //

/*
Recibe los parametros de id de revision, numero interno, fecha de revision, descripcion y tipo y remplaza en la fila los valores
antiguos por los nuevos donde id de revision de fila sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_REVISION(id INT, num_interno VARCHAR(60), fecha_revision DATE, descripcion VARCHAR(100), tipo VARCHAR(50))
BEGIN
	UPDATE REVISION SET REV_NUM_INTERNO = num_interno, REV_FECHA_REVISION = fecha_revision, REV_DESCRIPCION = descripcion, REV_TIPO_MANTENIMIENTO = tipo WHERE REV_ID=id;
END //

/*
Recibe los parametros de id de revision y elimina fila fila donde el id de revision sea igual al que se pasó por parametros
*/

CREATE PROCEDURE ELIMINAR_REVISION(id INT)
BEGIN
	DELETE FROM REVISION WHERE REV_ID=id;
END //

/*
Muestra todas las filas que contenga la tabla revision
*/

CREATE PROCEDURE TODOS_REVISION()
BEGIN
	SELECT * FROM REVISION;
END//

/*
Recibe el parametro de tipo y lo ingresa dentro de la tabla tipo_envio
*/

CREATE PROCEDURE INSERTAR_TIPO_ENVIO(tipo VARCHAR(50))
BEGIN
	INSERT INTO TIPO_ENVIO (TIPO) VALUES(tipo);
END //

/*
Recibe los parametros de id de tipo de envio y tipo y remplaza en la fila los valores antiguos
por los nuevos donde id de tipo de revision de fila sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_TIPO_ENVIO(id INT, tipo VARCHAR(50))
BEGIN
	UPDATE TIPO_ENVIO SET TIPO = tipo WHERE TIPO_ENVIO.ID=id;
END //

/*
Recibe el parametro de id de tipo de envio y elimina fila fila donde el id de tipo de envio sea
igual al que se pasó por parametros
*/

CREATE PROCEDURE ELIMINAR_TIPO_ENVIO(id INT)
BEGIN
	DELETE FROM TIPO_ENVIO WHERE TIPO_ENVIO.ID=id;
END //

/*
Muestra todas las filas que contenga la tabla tipo_envio
*/

CREATE PROCEDURE TODOS_TIPO_ENVIO()
BEGIN
	SELECT * FROM TIPO_ENVIO;
END//

/*
Recibe el parametro de identificacion, tipo, estado, provincia, canton, distrito y otras señas, primeramente ingresa
identificacion, tipo y estado dentro de la tabla cliente y por ultimo ingresa identifacacion, provincia, canton, distrito
y otras señas dentro de la tabla direccion_cliente
*/

CREATE PROCEDURE INSERTAR_CLIENTE(id INT, tipo VARCHAR(20), estado VARCHAR(20), PROVINCIA VARCHAR(30), CANTON VARCHAR(30), DISTRITO VARCHAR(30), OTRAS_SENAS VARCHAR(30))
BEGIN 
	INSERT INTO CLIENTE VALUES (id, tipo, estado);
    INSERT INTO DIRECCION_CLIENTE (DIR_IDENTIFICACION, DIR_PROVINCIA, DIR_CANTON, DIR_DISTRITO, DIR_OTRAS_SENAS) VALUES (ID, PROVINCIA, CANTON, DISTRITO, OTRAS_SENAS);
END //

/*
Recibe los parametros de identificacion, tipo y estado y remplaza en la fila los valores antiguos
por los nuevos donde identificacion sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_CLIENTE(id INT, tipo VARCHAR(20), estado VARCHAR(20))
BEGIN 
	UPDATE CLIENTE SET CLI_IDENTIFICACION = id, CLI_TIPO = tipo, CLI_ESTADO = estado WHERE CLI_IDENTIFICACION = id;
END //

/*
Recibe el parametro de identificacion y elimina primeramente las referencias en la tabla telefono_empleado,
correo_empleado y direccion_cliente y por ultimo la fila donde el id de tipo de envio sea igual al que se pasó
por parametros
*/

CREATE PROCEDURE ELIMINAR_CLIENTE(id INT)
BEGIN 
	SET SQL_SAFE_UPDATES = 0;
	DELETE FROM TELEFONO_EMPLEADO WHERE TELEFONO_EMPLEADO.CONT_ID IN (SELECT * FROM (SELECT CONT_ID FROM TELEFONO_EMPLEADO WHERE EMP_IDENTIFICACION=ID) AS T);
    DELETE FROM CORREO_EMPLEADO WHERE CORREO_EMPLEADO.CONT_ID IN (SELECT * FROM (SELECT CONT_ID FROM CORREO_EMPLEADO WHERE EMP_IDENTIFICACION=ID) AS T);
	SET SQL_SAFE_UPDATES = 1;
    DELETE FROM DIRECCION_CLIENTE WHERE DIRECCION_CLIENTE.DIR_IDENTIFICACION=id;
    DELETE FROM CLIENTE WHERE CLIENTE.CLI_IDENTIFICACION = id;
END //

/*
Recibe los parametros de identifacacion, provincia, canton, distrito y otras señas
y remplaza en la fila los valores antiguos por los nuevos donde identificacion sea igual
a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_DIRECCION_CLIENTE(ID INT, PROVINCIA VARCHAR(30), CANTON VARCHAR(30), DISTRITO VARCHAR(30), OTRAS_SENAS VARCHAR(30))
BEGIN
	UPDATE DIRECCION_CLIENTE SET DIR_PROVINCIA=PROVINCIA, DIR_CANTON=CANTON, DIR_DISTRITO=DISTRITO, DIR_OTRAS_SENAS=OTRAS_SENAS WHERE DIR_IDENTIFICACION=ID;
END//

/*
Muestra todas las filas que contenga la tabla cliente
*/

CREATE PROCEDURE TODOS_CLIENTE()
BEGIN
	SELECT * FROM CLIENTE;
END//

/*
Recibe el parametro de identificacion y correo y lo ingresa dentro de la tabla correo_cliente
*/

CREATE PROCEDURE INSERTAR_CORREO_CLIENTE(IDENTIFICACION INT, CORREO VARCHAR(100))
BEGIN
	INSERT INTO CORREO_CLIENTE(CLI_IDENTIFICACION, CONT_CORREO) VALUES(IDENTIFICACION, CORREO);
END//

/*
Recibe los parametros de id de contacto, identificacion y correo y remplaza en la fila los valores
antiguos por los nuevos donde id de contacto sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_CORREO_CLIENTE(ID INT, IDENTIFICACION INT, CORREO VARCHAR(100))
BEGIN
	UPDATE CORREO_CLIENTE SET CLI_IDENTIFICACION=IDENTIFICACION, CONT_CORREO=CORREO WHERE CONT_ID=ID;
END//

/*
Recibe el parametro de id de contacto y elimina de la tabla correo_cliente donde id sea igual
al que se paso por parametros
*/

CREATE PROCEDURE ELIMINAR_CORREO_CLIENTE(ID INT)
BEGIN
	DELETE FROM CORREO_CLIENTE WHERE CONT_ID=ID;
END//

/*
Muestra todas las filas que contenga la tabla correo_cliente
*/

CREATE PROCEDURE TODOS_CORREO_CLIENTE()
BEGIN
	SELECT * FROM CORREO_CLIENTE;
END//

/*
Recibe el parametro de identificacion y telefono y lo ingresa dentro de la tabla telefono_cliente
*/

CREATE PROCEDURE INSERTAR_TELEFONO_CLIENTE(IDENTIFICACION INT, TELEFONO VARCHAR(40))
BEGIN
	INSERT INTO TELEFONO_CLIENTE (CLI_IDENTIFICACION, CONT_TELEFONO) VALUES(IDENTIFICACION, TELEFONO);
END//

/*
Recibe los parametros de id de contacto, identificacion y telefono y remplaza en la fila los
valores antiguos por los nuevos donde id de contacto sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_TELEFONO_CLIENTE(ID INT, IDENTIFICACION INT, TELEFONO VARCHAR(40))
BEGIN
	UPDATE TELEFONO_CLIENTE SET CLI_IDENTIFICACION=IDENTIFICACION, CONT_TELEFONO=TELEFONO WHERE CONT_ID=ID;
END//

/*
Recibe el parametro de id de contacto y elimina de la tabla telefono_cliente donde id sea igual
al que se paso por parametros
*/

CREATE PROCEDURE ELIMINAR_TELEFONO_CLIENTE(ID INT)
BEGIN
	DELETE FROM TELEFONO_CLIENTE WHERE CONT_ID=ID;
END//


/*
Muestra todas las filas que contenga la tabla telefono_cliente
*/

CREATE PROCEDURE TODOS_TELEFONO_CLIENTE()
BEGIN
	SELECT * FROM TELEFONO_CLIENTE;
END//

/*
Muestra la fila de la tabla telefono_cliente donde identificacion sea igual a la que se paso
por parametros
*/

CREATE PROCEDURE OBTENER_TELEFONO_CLIENTE(IDENTIFICACION INT)
BEGIN
	SELECT CONT_IDENTIFICACION AS Idenficacion, CONT_TELEFONO AS TELEFONO FROM TELEFONO_CLIENTE WHERE CONT_IDENTIFICACION=IDENTIFICACION;
END//

/*
Muestra la fila de la tabla correo_cliente donde identificacion sea igual a la que se paso
por parametros
*/

CREATE PROCEDURE OBTENER_CORREO_CLIENTE(IDENTIFICACION INT)
BEGIN
	SELECT CONT_IDENTIFICACION AS Idenficacion, CONT_CORREO AS CORREO FROM CORREO_CLIENTE WHERE CONT_IDENTIFICACION=id;
END//

/*
Recibe el parametro de numero de paquete, descripcion, numero de oficina, numero de tipo de envio, idenficacion de empleado,
nombre de usuario que registró, idenficacacion del cliente y estado, inserta numero de paquete, descripcion, numero de oficina,
numero de tipo de envio, idenficacion de empleado, idenficacacion del cliente y estado en la tabla inventario vehiculo dentro de
la tabla paquete, seguidamente ingresa numero de paquete, fecha de registro y nombre de usuario de la persona que registro en la
tabla registro_paquete
*/

CREATE PROCEDURE INSERTAR_PAQUETE(num INT, descripcion VARCHAR(100), ofc_id INT, id_tipo_envio INT, empleado_id INT, URegistro VARCHAR(50), cli VARCHAR(50), estado VARCHAR(40), precio DECIMAL(10,2))
BEGIN
	INSERT INTO PAQUETE VALUES(num, descripcion, ofc_id, id_tipo_envio, empleado_id, cli, estado, precio);
    INSERT INTO REGISTRO_PAQUETES (PAQ_NUM, REG_FECHA, NOMBRE_USUARIO) VALUES (num, NOW(), URegistro);
END//

/*
Recibe los parametros de id de registro, numero de paquete, fecha de registro y nombre de usuario de la persona que registro
y remplaza en la fila los valores antiguos por los nuevos donde id de registro sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_REGISTRO_PAQUETE(id INT, num INT, fecha DATE, nombre_usuario VARCHAR(50))
BEGIN
	UPDATE REGISTRO_PAQUETES SET PAQ_NUM = num, REG_FECHA = fecha, NOMBRE_USUARIO = nombre_usuario WHERE REG_ID = id;
END//

/*
Recibe los parametros de numero de paquete, descripcion, numero de oficina, numero de tipo de envio, idenficacion de empleado,
idenficacion de cliente y estado y remplaza en la fila los valores antiguos por los nuevos donde id de paquete sea igual a la que
se paso por parametros
*/

CREATE PROCEDURE EDITAR_PAQUETE(num INT, descripcion VARCHAR(100), ofc_id INT, id_tipo_envio INT, empleado_id INT, cli VARCHAR(50), estado VARCHAR(40), precio DECIMAL(10,2))
BEGIN
	UPDATE PAQUETE SET PAQ_NUM = num, PAQ_DESCRIPCION = descripcion, OFC_ID = ofc_id, ID_TIPO_ENVIO = id_tipo_envio, EMP_IDENTIFICACION = empleado_id, CLI_ID = cli, ESTADO_PAQUETE = estado, Precio=precio WHERE PAQ_NUM=num;
END//

/*
Recibe el parametro de id de contacto y elimina de la tabla telefono_cliente donde id sea igual
al que se paso por parametros
*/

CREATE PROCEDURE ELIMINAR_PAQUETE(num INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	DELETE FROM REGISTRO_PAQUETES WHERE REG_ID IN (SELECT * FROM(SELECT REG_ID FROM REGISTRO_PAQUETES WHERE PAQ_NUM=num) AS T);
	SET SQL_SAFE_UPDATES = 1;
    DELETE FROM PAQUETE WHERE PAQ_NUM = num;
END//

/*
Muestra todas las filas que contenga la tabla paquete
*/

CREATE PROCEDURE TODOS_PAQUETE()
BEGIN
	SELECT * FROM PAQUETE;
END//

/*
Recibe el parametro de numero de factura, identificacion de cliente, fecha de factura, nombre y estado y los inserta dentro
de la tabla factura
*/

CREATE PROCEDURE INSERTAR_FACTURA(num INT, cli_id INT, fecha DATE, nombre VARCHAR(50), estado VARCHAR(20))
BEGIN
	INSERT INTO FACTURA VALUES(num, cli_id, fecha, fecha, nombre, estado);
END//

/*
Recibe los parametros de numero de factura, identificacion de cliente, fecha de factura, nombre de usuario que registró y estado
y remplaza en la fila los valores antiguos por los nuevos donde numero de factura sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_FACTURA(num INT, cli_id INT, fecha DATE, nombre VARCHAR(50), estado VARCHAR(20))
BEGIN
	UPDATE FACTURA SET FAC_NUM = num, CLI_ID = cli_id ,FAC_FECHA = fecha, NOMBRE_REGISTRO = nombre, FAC_ESTADO = estado WHERE FAC_NUM = num;
END//

/*
Recibe el parametro de numero de factura y elimina de la tabla factura donde numero de factura sea igual al que se paso por parametros
*/

CREATE PROCEDURE ELIMINAR_FACTURA(num INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	DELETE FROM FACTURA_PAQUETE WHERE ID IN (SELECT * FROM (SELECT ID FROM FACTURA_PAQUETE WHERE FAC_NUM=num) AS T);
	SET SQL_SAFE_UPDATES = 1;
    DELETE FROM FACTURA WHERE FACTURA.FAC_NUM = num;
END//

/*
Muestra todas las filas que contenga la tabla paquete
*/

CREATE PROCEDURE TODOS_FACTURA()
BEGIN
	SELECT FACTURA.FAC_NUM AS "NUMERO FACTURA", FACTURA.CLI_ID AS "CLIENTE", FACTURA.FAC_FECHA AS "FECHA", FACTURA.NOMBRE_REGISTRO AS "USUARIO QUE REGISTRO", FACTURA.FAC_ESTADO AS "ESTADO", DETALLE_FACTURA.COSTO_IMPUESTOS AS "IMPUESTOS", DETALLE_FACTURA.COSTO_FLETE AS "FLETE", DETALLE_FACTURA.COSTO_IV AS "IV", DETALLE_FACTURA.TOTAL_POR_ENVIO AS "TOTAL ENVIO", DETALLE_FACTURA.TOTAL_ANTES_IVA AS "SIN IV", DETALLE_FACTURA.TOTAL_FACTURA AS "TOTAL FACTURA" FROM FACTURA LEFT JOIN DETALLE_FACTURA ON FACTURA.FAC_NUM=DETALLE_FACTURA.FAC_NUM;
END//

/*
Recibe el parametro de numero de factura y numero de paquete y los inserta dentro de la tabla factura_paquete
*/

CREATE PROCEDURE INSERTAR_PAQUETE_FACTURA(fac_num INT, paq_num INT, paq_cant INT)
BEGIN
	INSERT INTO FACTURA_PAQUETE (FAC_NUM, PAQ_NUM, PAQ_CANT) VALUES(fac_num, paq_num, paq_cant);
END//

/*
Recibe los parametros de id de fila, numero de factura y numero de paquete y remplaza en la fila los valores antiguos
por los nuevos donde numero de fila sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_PAQUETE_FACTURA(id INT, fac_num INT, paq_num INT)
BEGIN
	UPDATE FACTURA_PAQUETE SET FAC_NUM = fac_num, PAQ_NUM = paq_num WHERE FACTURA_PAQUETE.ID=id;
END//

/*
Recibe el parametro de numero de factura y elimina de la tabla factura_paquete donde numero de fila sea igual al que
se paso por parametros
*/

CREATE PROCEDURE ELIMINAR_PAQUETE_FACTURA(id INT)
BEGIN
	DELETE FROM FACTURA_PAQUETE WHERE FACTURA_PAQUETE.ID=id;
END//

/*
Muestra todas las filas que contenga la tabla factura_paquete
*/

CREATE PROCEDURE TODOS_PAQUETE_FACTURA()
BEGIN
	SELECT FACTURA_PAQUETE.FAC_NUM AS FACTURA, PAQ_DESCRIPCION FROM FACTURA_PAQUETE, PAQUETE GROUP BY PAQUETE.PAQ_NUM;
END//

/*
Recibe el parametro de numero de factura, costo de impuestos, costo de flete, costo iva, total de envio, total antes de iva y total de factura
y los inserta dentro de la tabla detalle_factura
*/

CREATE PROCEDURE INSERTAR_DETALLE_FACTURA(fac_num INT, costo_impuestos INT, costo_flete INT, costo_iv INT)
BEGIN
	INSERT INTO DETALLE_FACTURA (FAC_NUM, COSTO_IMPUESTOS, COSTO_FLETE, COSTO_IV) VALUES(fac_num, costo_impuestos, costo_flete, costo_iv);
END//

/*
Recibe los parametros de id de fila, numero de factura, costo de impuestos, costo de flete, costo iva, total de envio, total antes de iva y total de factura
y los inserta dentro de la tabla detalle_factura y remplaza en la fila los valores antiguos
por los nuevos donde numero de fila sea igual a la que se paso por parametros
*/

CREATE PROCEDURE EDITAR_DETALLE_FACTURA(id INT, fac_num INT, costo_impuestos INT, costo_flete INT, costo_iv INT)
BEGIN
	UPDATE DETALLE_FACTURA SET FAC_NUM = fac_num, COSTO_IMPUESTOS = costo_impuestos, COSTO_FLETE = costo_flete, COSTO_IV = costo_iv WHERE DETALLE_FACTURA.ID =id;
END//

/*
Recibe el parametro de id de fila y elimina de la tabla detalle_factura donde numero de fila sea igual al que se paso por parametros
*/

CREATE PROCEDURE ELIMINAR_DETALLE_FACTURA(id INT)
BEGIN
	DELETE FROM DETALLE_FACTURA WHERE DETALLE_FACTURA.ID =id;
END//
DELIMITER ;

#########################TRIGGERS##############################
/*
Se dispara antes de actualizar un registro de la tabla PUESTO. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
PUESTO_HISTORIAL
*/
DELIMITER //
CREATE TRIGGER BU_PUESTO BEFORE UPDATE ON PUESTO FOR EACH ROW
BEGIN
	INSERT INTO PUESTO_HISTORIAL VALUES(OLD.PTO_ID, OLD.PTO_NOMBRE, OLD.PTO_SALARIO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla PUESTO. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
PUESTO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_PUESTO BEFORE DELETE ON PUESTO FOR EACH ROW
BEGIN
	INSERT INTO PUESTO_HISTORIAL VALUES(OLD.PTO_ID, OLD.PTO_NOMBRE, OLD.PTO_SALARIO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla OFICINA. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
OFICINA_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_OFICINA BEFORE UPDATE ON OFICINA FOR EACH ROW
BEGIN
	INSERT INTO OFICINA_HISTORIAL VALUES(OLD.OFC_ID, OLD.OFC_NOMBRE, OLD.OFC_UBICACION, OLD.OFC_TELEFONO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla OFICINA. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
OFICINA_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_OFICINA BEFORE DELETE ON OFICINA FOR EACH ROW
BEGIN
	INSERT INTO OFICINA_HISTORIAL VALUES(OLD.OFC_ID, OLD.OFC_NOMBRE, OLD.OFC_UBICACION, OLD.OFC_TELEFONO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla EMPLEADO. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
EMPLEADO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_EMPLEADO BEFORE UPDATE ON EMPLEADO FOR EACH ROW
BEGIN
	INSERT INTO EMPLEADO_HISTORIAL VALUES(OLD.EMP_IDENTIFICACION, OLD.EMP_NOMBRE, OLD.EMP_NACIMIENTO, OLD.EMP_PUESTO_ID, OLD.EMP_OFC_ID, OLD.EMP_ESTADO, OLD.EMP_USUARIO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla EMPLEADO. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
EMPLEADO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_EMPLEADO BEFORE DELETE ON EMPLEADO FOR EACH ROW
BEGIN
	INSERT INTO EMPLEADO_HISTORIAL VALUES(OLD.EMP_IDENTIFICACION, OLD.EMP_NOMBRE, OLD.EMP_NACIMIENTO, OLD.EMP_PUESTO_ID, OLD.EMP_OFC_ID, OLD.EMP_ESTADO, OLD.EMP_USUARIO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla REGISTRO. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
REGISTRO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_REGISTRO BEFORE UPDATE ON REGISTRO FOR EACH ROW
BEGIN
	INSERT INTO REGISTRO_HISTORIAL VALUES(OLD.EMP_IDENTIFICACION, OLD.REG_FECHA, OLD.NOMBRE_USUARIO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla REGISTRO. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
REGISTRO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_REGISTRO BEFORE DELETE ON REGISTRO FOR EACH ROW
BEGIN
	INSERT INTO REGISTRO_HISTORIAL VALUES(OLD.EMP_IDENTIFICACION, OLD.REG_FECHA, OLD.NOMBRE_USUARIO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla DIRECCION_EMPLEADO. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
DIRECCION_EMPLEADO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_DIRECCION_EMPLEADO BEFORE UPDATE ON DIRECCION_EMPLEADO FOR EACH ROW
BEGIN
	INSERT INTO DIRECCION_EMPLEADO_HISTORIAL VALUES(OLD.DIR_IDENTIFICACION, OLD.DIR_PROVINCIA, OLD.DIR_CANTON, OLD.DIR_DISTRITO, OLD.DIR_OTRAS_SENAS, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla DIRECCION_EMPLEADO. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
DIRECCION_EMPLEADO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_DIRECCION_EMPLEADO BEFORE DELETE ON DIRECCION_EMPLEADO FOR EACH ROW
BEGIN
	INSERT INTO DIRECCION_EMPLEADO_HISTORIAL VALUES(OLD.DIR_IDENTIFICACION, OLD.DIR_PROVINCIA, OLD.DIR_CANTON, OLD.DIR_DISTRITO, OLD.DIR_OTRAS_SENAS, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla TELEFONO_EMPLEADO. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
TELEFONO_EMPLEADO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_TELEFONO_EMPLEADO BEFORE UPDATE ON TELEFONO_EMPLEADO FOR EACH ROW
BEGIN
	INSERT INTO TELEFONO_EMPLEADO_HISTORIAL VALUES(OLD.CONT_ID, OLD.EMP_IDENTIFICACION, OLD.CONT_TELEFONO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla TELEFONO_EMPLEADO. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
TELEFONO_EMPLEADO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_TELEFONO_EMPLEADO BEFORE DELETE ON TELEFONO_EMPLEADO FOR EACH ROW
BEGIN
	INSERT INTO TELEFONO_EMPLEADO_HISTORIAL VALUES(OLD.CONT_ID, OLD.EMP_IDENTIFICACION, OLD.CONT_TELEFONO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla CORREO_EMPLEADO. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
CORREO_EMPLEADO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_CORREO_EMPLEADO BEFORE UPDATE ON CORREO_EMPLEADO FOR EACH ROW
BEGIN
	INSERT INTO CORREO_EMPLEADO_HISTORIAL VALUES(OLD.CONT_ID, OLD.EMP_IDENTIFICACION, OLD.CONT_CORREO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla CORREO_EMPLEADO. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
CORREO_EMPLEADO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_CORREO_EMPLEADO BEFORE DELETE ON CORREO_EMPLEADO FOR EACH ROW
BEGIN
	INSERT INTO CORREO_EMPLEADO_HISTORIAL VALUES(OLD.CONT_ID, OLD.EMP_IDENTIFICACION, OLD.CONT_CORREO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla TIPO_VEHICULO. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
TIPO_VEHICULO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_TIPOVEHICULO BEFORE UPDATE ON TIPOVEHICULO FOR EACH ROW
BEGIN
	INSERT INTO TIPOVEHICULO_HISTORIAL VALUES(OLD.ID, OLD.TIPO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla INVENTARIO_VEHICULOS. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
INVENTARIO_VEHICULOS_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_TIPOVEHICULO BEFORE DELETE ON TIPOVEHICULO FOR EACH ROW
BEGIN
	INSERT INTO TIPOVEHICULO_HISTORIAL VALUES(OLD.ID, OLD.TIPO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla INVENTARIO_VEHICULOS. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
INVENTARIO_VEHICULOS_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_INVENTARIO_VEHICULOS BEFORE UPDATE ON INVENTARIO_VEHICULOS FOR EACH ROW
BEGIN
	INSERT INTO INVENTARIO_VEHICULOS_HISTORIAL VALUES(OLD.INV_NUM_INTERNO, OLD.INV_NUM_PLACA, OLD.INV_MARCA, OLD.INV_STOCK, OLD.TIP_ID, OLD.INV_ESTADO_VEHICULO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla INVENTARIO_VEHICULOS. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
INVENTARIO_VEHICULOS_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_INVENTARIO_VEHICULOS BEFORE DELETE ON INVENTARIO_VEHICULOS FOR EACH ROW
BEGIN
	INSERT INTO INVENTARIO_VEHICULOS_HISTORIAL VALUES(OLD.INV_NUM_INTERNO, OLD.INV_NUM_PLACA, OLD.INV_MARCA, OLD.INV_STOCK, OLD.TIP_ID, OLD.INV_ESTADO_VEHICULO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla REGISTRO_VEHICULOS. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
REGISTRO_VEHICULOS_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_REGISTRO_VEHICULOS BEFORE UPDATE ON REGISTRO_VEHICULOS FOR EACH ROW
BEGIN
	INSERT INTO REGISTRO_VEHICULOS_HISTORIAL VALUES(OLD.REG_ID, OLD.REG_NUM_INTERNO, OLD.REG_FECHA_REGISTRO, OLD.NOMBRE_USUARIO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla REGISTRO_VEHICULOS. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
REGISTRO_VEHICULOS_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_REGISTRO_VEHICULOS BEFORE DELETE ON REGISTRO_VEHICULOS FOR EACH ROW
BEGIN
	INSERT INTO REGISTRO_VEHICULOS_HISTORIAL VALUES(OLD.REG_ID, OLD.REG_NUM_INTERNO, OLD.REG_FECHA_REGISTRO, OLD.NOMBRE_USUARIO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla REVISION. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
REVISION_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_REVISION BEFORE UPDATE ON REVISION FOR EACH ROW
BEGIN
	INSERT INTO REVISION_HISTORIAL VALUES(OLD.REV_ID, OLD.REV_NUM_INTERNO, OLD.REV_FECHA_REVISION, OLD.REV_DESCRIPCION, OLD.REV_TIPO_MANTENIMIENTO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla REVISION. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
REVISION_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_REVISION BEFORE DELETE ON REVISION FOR EACH ROW
BEGIN
	INSERT INTO REVISION_HISTORIAL VALUES(OLD.REV_ID, OLD.REV_NUM_INTERNO, OLD.REV_FECHA_REVISION, OLD.REV_DESCRIPCION, OLD.REV_TIPO_MANTENIMIENTO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla TIPO_ENVIO. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
TIPO_ENVIO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_TIPO_ENVIO BEFORE UPDATE ON TIPO_ENVIO FOR EACH ROW
BEGIN
	INSERT INTO TIPO_ENVIO_HISTORIAL VALUES(OLD.ID, OLD.TIPO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla TIPO_ENVIO. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
TIPO_ENVIO_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_TIPO_ENVIO BEFORE DELETE ON TIPO_ENVIO FOR EACH ROW
BEGIN
	INSERT INTO TIPO_ENVIO_HISTORIAL VALUES(OLD.ID, OLD.TIPO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla CLIENTE. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
CLIENTE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_CLIENTE BEFORE UPDATE ON CLIENTE FOR EACH ROW
BEGIN
	INSERT INTO CLIENTE_HISTORIAL VALUES(OLD.CLI_IDENTIFICACION, OLD.CLI_TIPO, OLD.CLI_ESTADO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla CLIENTE. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
CLIENTE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_CLIENTE BEFORE DELETE ON CLIENTE FOR EACH ROW
BEGIN
	INSERT INTO CLIENTE_HISTORIAL VALUES(OLD.CLI_IDENTIFICACION, OLD.CLI_TIPO, OLD.CLI_ESTADO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla DIRECCION_CLIENTE. 
Almacena los datos anteriores al UPDATE y los inserta en la1 tabla 
DIRECCION_CLIENTE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_DIRECCION_CLIENTE BEFORE UPDATE ON DIRECCION_CLIENTE FOR EACH ROW
BEGIN
	INSERT INTO DIRECCION_CLIENTE_HISTORIAL VALUES(OLD.DIR_IDENTIFICACION, OLD.DIR_PROVINCIA, OLD.DIR_CANTON, OLD.DIR_DISTRITO, OLD.DIR_OTRAS_SENAS, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla DIRECCION_CLIENTE. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
DIRECCION_CLIENTE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_DIRECCION_CLIENTE BEFORE DELETE ON DIRECCION_CLIENTE FOR EACH ROW
BEGIN
	INSERT INTO DIRECCION_CLIENTE_HISTORIAL VALUES(OLD.DIR_IDENTIFICACION, OLD.DIR_PROVINCIA, OLD.DIR_CANTON, OLD.DIR_DISTRITO, OLD.DIR_OTRAS_SENAS, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla TELEFONO_CLIENTE. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
TELEFONO_CLIENTE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_TELEFONO_CLIENTE BEFORE UPDATE ON TELEFONO_CLIENTE FOR EACH ROW
BEGIN
	INSERT INTO TELEFONO_CLIENTE_HISTORIAL VALUES(OLD.CONT_ID, OLD.CLI_IDENTIFICACION, OLD.CONT_TELEFONO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla TELEFONO_CLIENTE. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
TELEFONO_CLIENTE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_TELEFONO_CLIENTE BEFORE DELETE ON TELEFONO_CLIENTE FOR EACH ROW
BEGIN
	INSERT INTO TELEFONO_CLIENTE_HISTORIAL VALUES(OLD.CONT_ID, OLD.CLI_IDENTIFICACION, OLD.CONT_TELEFONO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla CORREO_CLIENTE. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
CORREO_CLIENTE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_CORREO_CLIENTE BEFORE UPDATE ON CORREO_CLIENTE FOR EACH ROW
BEGIN
	INSERT INTO CORREO_CLIENTE_HISTORIAL VALUES(OLD.CONT_ID, OLD.CLI_IDENTIFICACION, OLD.CONT_CORREO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla CORREO_CLIENTE. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
CORREO_CLIENTE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_CORREO_CLIENTE BEFORE DELETE ON CORREO_CLIENTE FOR EACH ROW
BEGIN
	INSERT INTO CORREO_CLIENTE_HISTORIAL VALUES(OLD.CONT_ID, OLD.CLI_IDENTIFICACION, OLD.CONT_CORREO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla PAQUETE. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
PAQUTE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_PAQUETE BEFORE UPDATE ON PAQUETE FOR EACH ROW
BEGIN
	INSERT INTO PAQUETE_HISTORIAL VALUES(OLD.PAQ_NUM, OLD.PAQ_DESCRIPCION, OLD.OFC_ID, OLD.ID_TIPO_ENVIO, OLD.EMP_IDENTIFICACION, OLD.CLI_ID, OLD.ESTADO_PAQUETE, OLD.PRECIO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla PAQUETE. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
PAQUETE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_PAQUETE BEFORE DELETE ON PAQUETE FOR EACH ROW
BEGIN
	INSERT INTO PAQUETE_HISTORIAL VALUES(OLD.PAQ_NUM, OLD.PAQ_DESCRIPCION, OLD.OFC_ID, OLD.ID_TIPO_ENVIO, OLD.EMP_IDENTIFICACION, OLD.CLI_ID, OLD.ESTADO_PAQUETE, OLD.PRECIO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla REGISTRO_PAQUETES. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
REGISTRO_PAQUETES_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_REGISTRO_PAQUETES BEFORE UPDATE ON REGISTRO_PAQUETES FOR EACH ROW
BEGIN
	INSERT INTO REGISTRO_PAQUETES_HISTORIAL VALUES(OLD.REG_ID, OLD.PAQ_NUM, OLD.REG_FECHA, OLD.NOMBRE_USUARIO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla REGISTRO_PAQUETES. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
REGISTRO_PAQUETES_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_REGISTRO_PAQUETES BEFORE DELETE ON REGISTRO_PAQUETES FOR EACH ROW
BEGIN
	INSERT INTO REGISTRO_PAQUETES_HISTORIAL VALUES(OLD.REG_ID, OLD.PAQ_NUM, OLD.REG_FECHA, OLD.NOMBRE_USUARIO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla FACTURA. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
FACTURA_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_FACTURA BEFORE UPDATE ON FACTURA FOR EACH ROW
BEGIN
	INSERT INTO FACTURA_HISTORIAL VALUES(OLD.FAC_NUM, OLD.CLI_ID, OLD.FAC_FECHA, OLD.FAC_FECHA_REGISTRO, OLD.NOMBRE_REGISTRO, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla FACTURA. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
FACTURA_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_FACTURA BEFORE DELETE ON FACTURA FOR EACH ROW
BEGIN
	INSERT INTO FACTURA_HISTORIAL VALUES(OLD.FAC_NUM, OLD.CLI_ID, OLD.FAC_FECHA, OLD.FAC_FECHA_REGISTRO, OLD.NOMBRE_REGISTRO, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla FACTURA_PAQUETE. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
FACTURA_PAQUETE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_FACTURA_PAQUETE BEFORE UPDATE ON FACTURA_PAQUETE FOR EACH ROW
BEGIN
	INSERT INTO FACTURA_PAQUETE_HISTORIAL VALUES(OLD.ID, OLD.FAC_NUM, OLD.PAQ_NUM, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla FACTURA_PAQUETE. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
FACTURA_PAQUETE_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BD_FACTURA_PAQUETE BEFORE DELETE ON FACTURA_PAQUETE FOR EACH ROW
BEGIN
	INSERT INTO FACTURA_PAQUETE_HISTORIAL VALUES(OLD.ID, OLD.FAC_NUM, OLD.PAQ_NUM, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

/*
Se dispara antes de actualizar un registro de la tabla DETALLE_FACTURA. 
Almacena los datos anteriores al UPDATE y los inserta en la tabla 
DETALLE_FACTURA_HISTORIAL
*/

DELIMITER //
CREATE TRIGGER BU_DETALLE_FACTURA BEFORE UPDATE ON DETALLE_FACTURA FOR EACH ROW
BEGIN
	INSERT INTO DETALLE_FACTURA_HISTORIAL VALUES(OLD.ID, OLD.FAC_NUM, OLD.COSTO_IMPUESTOS, OLD.COSTO_FLETE, OLD.COSTO_IV, OLD.TOTAL_POR_ENVIO, OLD.TOTAL_ANTES_IVA, OLD.TOTAL_FACTURA, CURRENT_USER(), NOW(), "EDITADO");
END//
DELIMITER ;

/*
Se dispara antes de eliminar un registro de la tabla DETALLE_FACTURA. 
Almacena los datos anteriores al DELETE y los inserta en la tabla 
DETALLE_FACTURA_HISTORIAL
*/
DELIMITER //
CREATE TRIGGER BD_DETALLE_FACTURA BEFORE DELETE ON DETALLE_FACTURA FOR EACH ROW
BEGIN
	INSERT INTO DETALLE_FACTURA_HISTORIAL VALUES(OLD.ID, OLD.FAC_NUM, OLD.COSTO_IMPUESTOS, OLD.COSTO_FLETE, OLD.COSTO_IV, OLD.TOTAL_POR_ENVIO, OLD.TOTAL_ANTES_IVA, OLD.TOTAL_FACTURA, CURRENT_USER(), NOW(), "ELIMINADO");
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BI_FACTURA_PAQUETE BEFORE INSERT ON FACTURA_PAQUETE FOR EACH ROW
BEGIN
	SET NEW.PAQ_TOTAL=NEW.PAQ_CANT*(SELECT PRECIO FROM PAQUETE WHERE PAQ_NUM=NEW.PAQ_NUM);
END//
DELIMITER;

DELIMITER //
CREATE TRIGGER AI_CALCULAR_ANTES_IVA BEFORE INSERT ON DETALLE_FACTURA FOR EACH ROW
BEGIN
	DECLARE v_TOTAL_ANTES_IVA DECIMAL(10,2);
	DECLARE v_TOTAL_FACTURA DECIMAL(10,2);
	DECLARE V_TOTAL_ENVIO DECIMAL(10,2);

	SET NEW.TOTAL_POR_ENVIO = NEW.COSTO_IV+NEW.COSTO_FLETE;

	SET NEW.TOTAL_ANTES_IVA = (SELECT SUM(PAQ_TOTAL) FROM FACTURA_PAQUETE WHERE FAC_NUM = NEW.FAC_NUM);

	SET NEW.TOTAL_FACTURA = NEW.TOTAL_ANTES_IVA + (NEW.TOTAL_ANTES_IVA * 0.13)+NEW.TOTAL_POR_ENVIO;
END//
DELIMITER ;

##############################################################

CALL INSERTAR_TIPO_VEHICULO('Moto');
CALL INSERTAR_TIPO_VEHICULO('Todo Terreno');
CALL INSERTAR_TIPO_VEHICULO('Sedan');

CALL INSERTAR_PUESTO('VENDEDOR', 800000);
CALL INSERTAR_PUESTO('Tecnico', 900000);
CALL INSERTAR_OFICINA('Ventas', 'CENTRO COMERCIAL CRONOS, SEGUNDO PISO', 22334455);
CALL INSERTAR_OFICINA('Soporte Tecnico', 'Multiplaza del este', 24321231);
CALL INSERTAR_EMPLEADO(123456782, 'Jorge Sandi Calvo', '2002/09/14', 2, 2, 'jsandi16', 'ADMIN', 'Heredia', 'Heredia', '', '');
CALL INSERTAR_EMPLEADO(123456789, 'Andrey Granados Alfaro', '1995/12/15', 1, 1, 'AGRANADOS15', 'ADMIN', 'San Jose', 'San Jose', '', '');
CALL INSERTAR_EMPLEADO(123456783, 'Pedro', '2000-02-12', 1, 2, 'Pedro Antonio', 'ADMIN', 'Cartago', 'Cartago', '', '');
CALL INSERTAR_CORREO_EMPLEADO(123456789, 'AGRANADOS@GMAIL.com');
CALL INSERTAR_CORREO_EMPLEADO(123456789, 'AGRANADOS2@GMAIL.com');
CALL INSERTAR_CORREO_EMPLEADO(123456782, 'jsandi16@gmail.com');
CALL INSERTAR_CORREO_EMPLEADO(123456782, 'jsandi17@gmail.com');
CALL INSERTAR_TELEFONO_EMPLEADO(123456789,  '88990011');
CALL INSERTAR_TELEFONO_EMPLEADO(123456789,  '85324321');
CALL INSERTAR_TELEFONO_EMPLEADO(123456782, '43523321');
CALL INSERTAR_TELEFONO_EMPLEADO(123456782, '43554523');

CALL INSERTAR_CORREO_EMPLEADO(123456783, 'pedro@gmail.com');
CALL INSERTAR_TELEFONO_EMPLEADO(123456783, '42533321');
CALL TODOS_EMPLEADOS();
CALL OBTENER_CORREO_EMPLEADO(123456782);
CALL OBTENER_TELEFONO_EMPLEADO(123456782);

####PRUEBA#####
CALL INSERTAR_PUESTO('SECRETARIO', 10000.50);
CALL EDITAR_PUESTO(3, 'SECRETARIO', 20000.50);
CALL ELIMINAR_PUESTO(3);
CALL TODOS_PUESTOS();
CALL INSERTAR_OFICINA('PRUEBA', 'PRUEBA', 88888888);
CALL EDITAR_OFICINA(3, 'PRUEBA EDIT', 'PRUEBA EDIT', 77777777);
CALL ELIMINAR_OFICINA(3);
CALL TODOS_OFICINAS();
CALL INSERTAR_EMPLEADO(1, 'PRUEBA', '2022-04-04', 1, 1, 'PRUEBA', 'ADMIN', 'SAN JOSE', 'PRUEBA', 'PRUEBA', 'PRUEBA');
CALL EDITAR_EMPLEADO(1, 'PRUEBA EDIT', '2022-05-05', 2, 2, 'PRUEBA EDIT');
CALL ELIMINAR_EMPLEADO (1);
CALL TODOS_EMPLEADOS();
CALL EDITAR_REGISTRO(123456783, "2002-10-10", 'ADMIN 2');
CALL TODOS_REGISTRO();
CALL EDITAR_DIRECCION_EMPLEADO(123456783, 'PRUEBA EDIT', 'PRUEBA', 'PRUEBA EDIT', 'PRUEBA EDIT');
CALL TODOS_DIRECCION_EMPLEADO();
CALL DIRECCION_EMPLEADO_POR_ID(123456782);
CALL INSERTAR_CORREO_EMPLEADO(123456782, 'CORREOPRUEB@GMAIL.COM');
CALL EDITAR_CORREO_EMPLEADO(6, 123456782, 'CORREO');
CALL ELIMINAR_CORREO_EMPLEADO(6);
CALL TODOS_CORREO_EMPLEADO();
CALL INSERTAR_TELEFONO_EMPLEADO(123456782, 'PRUEBA');
CALL EDITAR_TELEFONO_EMPLEADO(6, 123456782, 'PRUEBA EDIT');
CALL ELIMINAR_TELEFONO_EMPLEADO(6);
CALL TODOS_TELEFONO_EMPLEADO();
CALL OBTENER_TELEFONO_EMPLEADO(123456782);
CALL OBTENER_CORREO_EMPLEADO(123456782);
CALL INSERTAR_TIPO_VEHICULO('PRUEBA');
CALL EDITAR_TIPO_VEHICULO(1, 'PRUEBA EDIT');
CALL ELIMINAR_TIPO_VEHICULO(1);
CALL TODOS_TIPO_VEHICULO();
CALL INSERTAR_VEHICULO(1234, 'BCD-123', 'TOYOTA', 100, 2, 'NUEVO', 'ADMIN');
CALL EDITAR_VEHICULO(1234, 'PRUEBA', 'TOYOTA', 99, 2, 'CHOCADO');
CALL ELIMINAR_VEHICULO(1234);
CALL INSERTAR_VEHICULO(1234, 'BCD-123', 'TOYOTA', 100, 2, 'NUEVO', 'ADMIN');
CALL TODOS_VEHICULO();
CALL EDITAR_REGISTRO_VEHICULO(2, 1234, '2022-04-11', 'ADMIN 2');
CALL TODOS_REGISTRO_VEHICULO();
CALL INSERTAR_REVISION(1234, NOW(), 'REVISION GENERAL DEL VEHICULO', 'Mensual');
CALL EDITAR_REVISION(1, 1234, NOW(), 'PRUEBA EDIT', 'Mensual');
CALL ELIMINAR_REVISION(1);
CALL TODOS_REVISION();
CALL INSERTAR_TIPO_ENVIO('Prioritario');
CALL INSERTAR_TIPO_ENVIO('Normal');
CALL INSERTAR_TIPO_ENVIO('Economico');
CALL EDITAR_TIPO_ENVIO(1, 'Terrestre');
CALL ELIMINAR_TIPO_ENVIO(1);
CALL TODOS_TIPO_ENVIO();
CALL INSERTAR_CLIENTE(12345, 'Normal', 1, 'SAN JOSE', 'PRUEBA', 'PRUEBA', 'PRUEBA');
CALL EDITAR_DIRECCION_CLIENTE(12345, 'PRUEBA EDIT', 'PRUEBA', 'PRUEBA EDIT', 'PRUEBA EDIT');
CALL INSERTAR_CORREO_CLIENTE(12345, 'CLIENTE@GMAIL.COM');
CALL EDITAR_CORREO_CLIENTE(1, 12345, 'CLIENTE.COM');
CALL ELIMINAR_CORREO_CLIENTE(1);
CALL INSERTAR_TELEFONO_CLIENTE(12345, 88888888);
CALL EDITAR_TELEFONO_CLIENTE(1, 12345, 77777777);
CALL ELIMINAR_TELEFONO_CLIENTE(1);
CALL EDITAR_CLIENTE(12345, 'Vip', 0);
CALL ELIMINAR_CLIENTE(12345);
CALL INSERTAR_CLIENTE(12345, 'Normal', 1, 'SAN JOSE', 'PRUEBA', 'PRUEBA', 'PRUEBA');
CALL TODOS_CLIENTE();
CALL INSERTAR_TIPO_ENVIO('Aereo');
CALL INSERTAR_PAQUETE(123, 'PAQUETE 1', 1, 2, 123456782, 1234, 'ADMIN', 'En Proceso', 2000);
CALL INSERTAR_PAQUETE(1234, 'PAQUETE 2', 1, 2, 123456782, 1234, 'ADMIN', 'En Proceso', 3000);
CALL EDITAR_REGISTRO_PAQUETE(2, 123, '2006-05-05', 1);
CALL EDITAR_PAQUETE(123, 'PRUEBA EDIT', 1, 2, 123456782, 1234, 'Enviado', 3000);
CALL ELIMINAR_PAQUETE(123);
CALL INSERTAR_PAQUETE(123, 'PAQUETE DE PRUEBA', 1, 2, 123456782, 1234, 'ADMIN', 'En Proceso', 3000);
CALL TODOS_PAQUETE();
CALL INSERTAR_FACTURA(12345, 12345, NOW(), 'ADMIN', 'Activa');
CALL INSERTAR_FACTURA(123456, 12345, NOW(), 'ADMIN', 'Activa');
CALL EDITAR_FACTURA(123456, 12345, '2008-05-05', 'ADMIN 2', 'Anulada');
CALL ELIMINAR_FACTURA(123456);
CALL TODOS_FACTURA();
CALL INSERTAR_PAQUETE_FACTURA(12345, 123, 2);
CALL INSERTAR_PAQUETE_FACTURA(12345, 1234, 3);
CALL EDITAR_PAQUETE_FACTURA(2, 12345, 123);
CALL ELIMINAR_PAQUETE_FACTURA(2);
CALL TODOS_PAQUETE_FACTURA();
CALL INSERTAR_DETALLE_FACTURA(12345, 13, 10000, 11300);
CALL EDITAR_DETALLE_FACTURA(1, 12345, 13, 12000, 13460);
CALL ELIMINAR_DETALLE_FACTURA(1);
####PRUEBA#####