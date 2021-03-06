create database heladeria;

use heladeria;

CREATE TABLE producto(
	idproducto int auto_increment NOT NULL PRIMARY KEY,
	idcategoria int NOT NULL,
	codigo varchar(50) NULL,
	nombre varchar(100) NOT NULL,
	precio_venta decimal(11, 2) NOT NULL,
	stock int NOT NULL,
	descripcion varchar(256) NULL,
	condicion bit (1) DEFAULT NULL
) ;

CREATE TABLE categoria(
	idcategoria int auto_increment NOT NULL PRIMARY KEY,
	nombre varchar(50) NOT NULL,
	descripcion varchar(256) NULL,
	condicion bit (1) DEFAULT NULL
);

CREATE TABLE detalle_ingreso(
	iddetalle_ingreso int auto_increment NOT NULL PRIMARY KEY,
	idingreso int NOT NULL,
	idproducto int NOT NULL,
	cantidad int NOT NULL,
	precio decimal(11, 2) NOT NULL
) ;

CREATE TABLE detalle_venta(
	iddetalle_venta int auto_increment NOT NULL PRIMARY KEY,
	idventa int NOT NULL,
	idproducto int NOT NULL,
	cantidad int NOT NULL,
	precio decimal(11, 2) NOT NULL,
	descuento decimal(11, 2) NOT NULL
) ;

CREATE TABLE ingreso(
	idingreso int auto_increment NOT NULL PRIMARY KEY,
	idproveedor int NOT NULL,
	idusuario int NOT NULL,
	tipo_comprobante varchar(20) NOT NULL,
	serie_comprobante varchar(7) NULL,
	num_comprobante varchar(10) NOT NULL,
	fecha_hora datetime NOT NULL,
	impuesto decimal(4, 2) NOT NULL,
	total decimal(11, 2) NOT NULL,
	estado varchar(20) NOT NULL
) ;

CREATE TABLE persona(
	idpersona int auto_increment NOT NULL PRIMARY KEY,
	tipo_persona varchar(20) NOT NULL,
	nombre varchar(100) NOT NULL,
	tipo_documento varchar(20) NULL,
	num_documento varchar(20) NULL,
	direccion varchar(70) NULL,
	telefono varchar(20) NULL,
	email varchar(50) NULL
);

CREATE TABLE rol(
	idrol int auto_increment NOT NULL PRIMARY KEY,
	nombre varchar(30) NOT NULL,
	descripcion varchar(100) NULL,
	condicion bit (1) DEFAULT NULL
) ;

CREATE TABLE usuario(
	idusuario int auto_increment NOT NULL PRIMARY KEY,
	idrol int NOT NULL,
	nombre varchar(100) NOT NULL,
	tipo_documento varchar(20) NULL,
	num_documento varchar(20) NULL,
	direccion varchar(70) NULL,
	telefono varchar(20) NULL,
	email varchar(50) NOT NULL,
	password_hash varbinary(130),
	password_salt varbinary(258),
	condicion bit (1) DEFAULT NULL
);

CREATE TABLE venta(
	idventa int auto_increment NOT NULL PRIMARY KEY,
	idcliente int NOT NULL,
	idusuario int NOT NULL,
	tipo_comprobante varchar(20) NOT NULL,
	serie_comprobante varchar(7) NULL,
	num_comprobante varchar(10) NOT NULL,
	fecha_hora datetime NOT NULL,
	impuesto decimal(4, 2) NOT NULL,
	total decimal(11, 2) NOT NULL,
	estado varchar(20) NOT NULL
) ;

ALTER TABLE producto ADD FOREIGN KEY(idcategoria)
REFERENCES categoria (idcategoria);

ALTER TABLE detalle_ingreso ADD FOREIGN KEY(idproducto)
REFERENCES producto (idproducto);

ALTER TABLE detalle_ingreso   ADD FOREIGN KEY(idingreso)
REFERENCES ingreso (idingreso)
ON DELETE CASCADE;

ALTER TABLE detalle_venta    ADD FOREIGN KEY(idproducto)
REFERENCES  producto (idproducto);

ALTER TABLE detalle_venta    ADD FOREIGN KEY(idventa)
REFERENCES  venta (idventa)
ON DELETE CASCADE;

ALTER TABLE ingreso    ADD FOREIGN KEY(idproveedor)
REFERENCES  persona (idpersona);

ALTER TABLE ingreso    ADD FOREIGN KEY(idusuario)
REFERENCES  usuario (idusuario);

ALTER TABLE usuario    ADD FOREIGN KEY(idrol)
REFERENCES  rol (idrol);

ALTER TABLE venta   ADD FOREIGN KEY(idcliente)
REFERENCES  persona (idpersona);

ALTER TABLE venta   ADD FOREIGN KEY(idusuario)
REFERENCES  usuario (idusuario);

INSERT  categoria (idcategoria, nombre, descripcion, condicion) VALUES (1, N'Helados', N'Todas las variedades de helados', 1);
INSERT  categoria (idcategoria, nombre, descripcion, condicion) VALUES (2, N'Bebidas', N'Gaseosas y agua de mesa/mineral', 1);

INSERT  producto (idproducto, idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion) VALUES (1, 1, N'0342', N'Zambito', CAST(1.20 AS Decimal(11, 2)), 10, N'-', 1);
INSERT  producto (idproducto, idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion) VALUES (2, 2, N'0547', N'Coca Cola', CAST(1.50 AS Decimal(11, 2)), 16, N'(500ml)', 1);
INSERT  producto (idproducto, idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion) VALUES (3, 1, N'0467', N'Turbo', CAST(0.70 AS Decimal(11, 2)), 48, N'', 1);
INSERT  producto (idproducto, idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion) VALUES (4, 1, N'0345', N'Trika', CAST(1.50 AS Decimal(11, 2)), 20, N'', 1);

INSERT  persona (idpersona, tipo_persona, nombre, tipo_documento, num_documento, direccion, telefono, email) VALUES (1, N'Cliente', N'Laura ramirez', N'DNI', N'45786936', N'', N'', N'');
INSERT  persona (idpersona, tipo_persona, nombre, tipo_documento, num_documento, direccion, telefono, email) VALUES (2, N'Proveedor', N'Mayra', N'DNI', N'89306527', N'fgfg', N'46546654', N'mayra@gmail.com');
INSERT  persona (idpersona, tipo_persona, nombre, tipo_documento, num_documento, direccion, telefono, email) VALUES (3, N'Cliente', N'Silvia Gonzáles', N'DNI', N'78469812', N'Lima', N'945723751', N'v@mail.com');
INSERT  persona (idpersona, tipo_persona, nombre, tipo_documento, num_documento, direccion, telefono, email) VALUES (4, N'Cliente', N'Jair Caramuti', N'DNI', N'45672398', N'Lima', N'945628651', N'j@mail.com');
INSERT  persona (idpersona, tipo_persona, nombre, tipo_documento, num_documento, direccion, telefono, email) VALUES (5, N'Cliente', N'Vinz Lopez', N'DNI', N'70917341', N'comas', N'923451773', N'l@mail.com');

INSERT  rol (idrol, nombre, descripcion, condicion) VALUES (1, N'Administrador', N'Administrador del Sistema', 1);
INSERT  rol (idrol, nombre, descripcion, condicion) VALUES (2, N'Almacenero', N'Almacenero del Sistema', 1);
INSERT  rol (idrol, nombre, descripcion, condicion) VALUES (3, N'Vendedor', N'Vendedor del Sistema', 1);

INSERT  usuario (idusuario, idrol, nombre, tipo_documento, num_documento, direccion, telefono, email, password_hash, password_salt, condicion) VALUES (1, 1, N'Daniel Ardiles', N'DNI', N'47715777', N'Zarumilla 113 - Lima', N'931742904', N'ardiles@gmail.com', 0xDD7731CF8729C9428A4E724F61D1F5927E45EE0D736690476AD47CABE1DE3E8927C470E19D23FC88FB61937C6BD1C014F487425FA42D86612EC502DE7D89423F, 0xE68F8D12D91766BBDD19F4FE1E33118E4C57B548C7F1B8E40A2916CDA53E67FB1ABE9EA2ACD4B7330E28994DB576F909E47518BE94856DBD645ECF4A1C39454BCD33C1213EFCAB2FED73A25DF8529E8A0AFDC30E94F802FEB66C6752132D78A7061288C3AF67E5D08AB94E3E652DA945A1BD8773F013A35D48304F39DD84C8D9, 1);
INSERT  usuario (idusuario, idrol, nombre, tipo_documento, num_documento, direccion, telefono, email, password_hash, password_salt, condicion) VALUES (2, 3, N'Vincenzo Lopez Caballero', N'DNI', N'47856932', N'Lima', N'985632147', N'vinz@gmail.com', 0x37D7137257A47E88DE639F382F37E98DFE65B581C00996421B2D66B57E37781D08874987E6A0BEE9DD28E00E35E1A1E0BB3E224D33E88C836F2C3E48CA2B6B18, 0x1CB3A0CA6373ED75061ACB2116760018FD319B8B0A070A2AC3CA5A72F1F3772300C05D33D1FC7D3AF76F69F11D6EC0B2E11E7D8D62D629B1746EB973E945B03EB6BC04220F7D645B786BBACD82CCDCCFFD9508B05D101EA0379DEFAACB8D2053377FEAEDC0A020354587AF0EF1E7D75F9538953E038CC8E54BB71F89D421118D, 1);
INSERT  usuario (idusuario, idrol, nombre, tipo_documento, num_documento, direccion, telefono, email, password_hash, password_salt, condicion) VALUES (3, 2, N'Jair Matos Caramuti', N'DNI', N'96321452', N'Lima', N'9632587412', N'matos@gmail.com', 0xE0066FE0685EAB27E5F6B0E3510703D0CE28D1E34F2D5C2B4FB6F8FF4E7B697E5E07E5B2FEA15F1E7887E2EEFF97FF4F1D077F67219C1BFF052C2BB7405BF3F3, 0x84FE80EF9241ECBEE7A416DBBF90504F94541BEE4FB128E118033AFA8273D0D88C26FBC8C372321027421318AE0193CBA8545CFD92E2E80A394C22400852D4593E99244FB8C11B8DB981AF7537420E32E809263786B5A8E0A0A9ECE18D5C895DAC275EFB823468CF5D6C696EF7F787DCE93135CD6253B0B4F44DA48E48A2D217, 1);
INSERT  usuario (idusuario, idrol, nombre, tipo_documento, num_documento, direccion, telefono, email, password_hash, password_salt, condicion) VALUES (4, 1, N'Diego Moscaiza', N'DNI', N'72364276', N'Pons 12 - Callao', N'940935731', N'dmoscaiza@gmail.com', 0xDD7731CF8729C9428A4E724F61D1F5927E45EE0D736690476AD47CABE1DE3E8927C470E19D23FC88FB61937C6BD1C014F487425FA42D86612EC502DE7D89423F, 0xE68F8D12D91766BBDD19F4FE1E33118E4C57B548C7F1B8E40A2916CDA53E67FB1ABE9EA2ACD4B7330E28994DB576F909E47518BE94856DBD645ECF4A1C39454BCD33C1213EFCAB2FED73A25DF8529E8A0AFDC30E94F802FEB66C6752132D78A7061288C3AF67E5D08AB94E3E652DA945A1BD8773F013A35D48304F39DD84C8D9, 1);

INSERT  venta (idventa, idcliente, idusuario, tipo_comprobante, serie_comprobante, num_comprobante, fecha_hora, impuesto, total, estado) VALUES (1, 1, 1, N'FACTURA', N'66798', N'6579', CAST(N'2020-12-10T01:32:24.187' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(1.20 AS Decimal(11, 2)), N'Aceptado');

INSERT  detalle_venta (iddetalle_venta, idventa, idproducto, cantidad, precio, descuento) VALUES (1, 1, 2, 1, CAST(1.20 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)));





