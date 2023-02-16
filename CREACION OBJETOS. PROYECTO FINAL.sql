
DROP SCHEMA if exists proyecto;
CREATE SCHEMA IF NOT EXISTS proyecto;

USE proyecto;

DROP TABLE if exists cliente;
CREATE TABLE if not exists cliente ( 
    id_cliente int not null primary key,
    id_producto varchar(20),
    nivel_educacion varchar(20),
    estado_civil varchar(20),
    ingresos numeric
);

DROP TABLE if exists compra;
CREATE TABLE if not exists compra ( 
    id_compra int auto_increment not null primary key,
    id_cliente int not null,
    id_producto varchar (20)
);

DROP TABLE if exists producto;
CREATE TABLE if not exists producto ( 
    id_producto varchar(20) not null primary key,
    id_cliente int not null,
    precio numeric
);

DROP TABLE if exists periodo;
CREATE TABLE if not exists periodo ( 
    id_periodo int auto_increment not null primary key,
    id_compra int not null,
    dia_ultima_compra date,
    dia_primera_compra date    
);

  
DROP TABLE if exists quejas;
CREATE TABLE if not exists quejas ( 
    id_queja int auto_increment not null primary key,
    existe_queja boolean,
    id_producto varchar(20) not null ,
    id_cliente int not null
);

DROP TABLE if exists supermercado;
CREATE TABLE if not exists supermercado ( 
    id_sucursal VARCHAR (20) not null primary key,
    id_cliente int not null,
    id_producto varchar(20) not null,
    compra_sitio_web boolean,
    compra_tienda boolean
);

DROP TABLE if exists campaña;
CREATE TABLE if not exists campaña ( 
    id_campaña int not null primary key auto_increment,
	id_producto varchar(20) not null
);

ALTER TABLE cliente
ADD CONSTRAINT FK_id_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE compra
ADD CONSTRAINT FK_id_cliente
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

ALTER TABLE compra
ADD CONSTRAINT FK_id_producto_compra
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE producto
ADD CONSTRAINT FK_id_cliente_producto
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

ALTER TABLE periodo
ADD CONSTRAINT FK_id_compra_periodo
FOREIGN KEY (id_compra) REFERENCES compra(id_compra);

ALTER TABLE quejas
ADD CONSTRAINT FK_id_producto_quejas
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE quejas
ADD CONSTRAINT FK_id_cliente_quejas
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

ALTER TABLE supermercado
ADD CONSTRAINT FK_id_cliente_supermercado
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

ALTER TABLE supermercado
ADD CONSTRAINT FK_id_producto_supermercado
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE campaña
ADD CONSTRAINT FK_id_producto_campaña
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

-- CREACIÓN DE VISTAS

-- 1. Indica los productos con un precio de venta por arriba del promedio
CREATE OR REPLACE VIEW vs_preciopromedio AS
SELECT id_producto, precio
FROM producto
WHERE precio > (select AVG(precio) FROM producto)
;
    
-- 2. Cantidad de días transcurridos entre la primera y la última compra 
CREATE OR REPLACE VIEW vs_dias_transcurridos AS 
SELECT id_periodo, (SELECT DATEDIFF (dia_ultima_compra,dia_primera_compra)) AS cant_dias 
FROM periodo
;

-- 3. Contabiliza el total de compras en la web y en la tienda física
CREATE OR REPLACE VIEW vs_cantidadcompras AS
SELECT (SELECT count(compra_sitio_web)) AS compra_web , (SELECT count(compra_tienda)) AS compra_tienda
FROM supermercado
;

-- 4. Cantidad de clientes de cada nivel de educación
CREATE OR REPLACE VIEW vs_niveleducacion AS
SELECT nivel_educacion AS nivel,
COUNT(nivel_educacion) AS total
FROM cliente
GROUP BY nivel_educacion
;

-- CREACION DE FUNCIONES

-- 1.Calcula el precio del producto con IVA

DELIMITER $$

DROP FUNCTION IF EXISTS iva_precio;
CREATE FUNCTION  iva_precio ( precio DECIMAL(11,2) , IVA DECIMAL (2,2) )
RETURNS DECIMAL(11,2)
DETERMINISTIC
	BEGIN
		DECLARE result DECIMAL (11,2);
        SET result = precio * 0.21;
        RETURN result;
	END
$$

-- 2. Formula para generar direcciones de email para comunicaciones internas con cada sucursal

DELIMITER $$

DROP FUNCTION IF EXISTS mail_sucursal;
CREATE FUNCTION mail_sucursal ( id_sucursal VARCHAR(20), mail VARCHAR(20))
RETURNS VARCHAR (20)
DETERMINISTIC
	BEGIN
		DECLARE result VARCHAR (20);
        SET result = (SELECT CONCAT(id_sucursal, '@supermecadocoder.com') FROM supermercado);
		RETURN result;
	END
$$

-- PROCEDIMIENTOS ALMACENADOS

-- 1. permite identificar si existe una queja y la relaciona con el producto y al código de sucursal al que pertenece

DELIMITER $$
DROP PROCEDURE IF EXISTS queja_sucursal;
CREATE PROCEDURE queja_sucursal ()
	BEGIN
		SELECT quejas.existe_queja, quejas.id_producto, supermercado.id_sucursal
        FROM quejas
        INNER JOIN supermercado ON
        quejas.id_producto = supermercado.id_producto
        WHERE quejas.existe_queja = '1';
	END  
$$

-- 2. identifica a los peridos con mayor fidelización de clientes, es decir en donde existió menor cantidad de dias entre la primera y la última compra

DELIMITER $$
DROP PROCEDURE IF EXISTS fidelizacion;
CREATE PROCEDURE fidelizacion ()
	BEGIN
		SELECT id_periodo, (SELECT DATEDIFF (dia_ultima_compra,dia_primera_compra)) 
        AS dias_transcurridos 
		FROM periodo
        ORDER BY dias_transcurridos;
	END
$$
        