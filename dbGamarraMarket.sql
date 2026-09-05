/* Crear base de datos dbGamarraMarket */
DROP DATABASE IF EXISTS dbGamarraMarket;
CREATE DATABASE dbGamarraMarket
DEFAULT CHARACTER SET utf8;

USE dbGamarraMarket;

/* Crear la tabla CLIENTE */
CREATE TABLE CLIENTE
(
    id int,
    tipo_documento char(3),
    numero_documento char(9),
    nombres varchar(60),
    apellidos varchar(90),
    email varchar(80),
    celular char(9),
    fecha_nacimiento date,
    activo bool,
    CONSTRAINT cliente_pk PRIMARY KEY (id)
);

/* Crear la tabla VENDEDOR */
CREATE TABLE VENDEDOR
(
    id int,
    tipo_documento char(3),
    numero_documento char(15),
    nombres varchar(60),
    apellidos varchar(90),
    salario decimal(8,2),
    celular char(9),
    email varchar(80),
    activo bool,
    CONSTRAINT vendedor_pk PRIMARY KEY (id)
);

/* Crear la tabla VENTA */
CREATE TABLE VENTA
(
    id int,
    fecha_hora timestamp,
    activo bool,
    cliente_id int,
    vendedor_id int,
    CONSTRAINT venta_pk PRIMARY KEY (id)
);

/* Crear la tabla PRENDA */
CREATE TABLE PRENDA
(
    id int,
    descripcion varchar(90),
    marca varchar(90),
    cantidad int,
    talla varchar(10),
    precio decimal(8,2),
    activo bool,
    CONSTRAINT prenda_pk PRIMARY KEY (id)
);

/* Crear la tabla VENTA_DETALLE */
CREATE TABLE VENTA_DETALLE
(
    id int,
    cantidad int,
    venta_id int,
    prenda_id int,
    CONSTRAINT venta_detalle_pk PRIMARY KEY (id)
);

/* Listar tablas existentes en la base de datos en uso */
SHOW TABLES;

/* Listar estructura de cada tabla */
SHOW COLUMNS IN CLIENTE;
SHOW COLUMNS IN VENDEDOR;
SHOW COLUMNS IN VENTA;
SHOW COLUMNS IN PRENDA;
SHOW COLUMNS IN VENTA_DETALLE;

/* Crear relación VENTA_CLIENTE */
ALTER TABLE VENTA
    ADD CONSTRAINT venta_cliente FOREIGN KEY (cliente_id)
    REFERENCES CLIENTE (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/* Crear relación VENTA_VENDEDOR */
ALTER TABLE VENTA
    ADD CONSTRAINT venta_vendedor FOREIGN KEY (vendedor_id)
    REFERENCES VENDEDOR (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/* Crear relación VENTA_DETALLE_VENTA */
ALTER TABLE VENTA_DETALLE
    ADD CONSTRAINT venta_detalle_venta FOREIGN KEY (venta_id)
    REFERENCES VENTA (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/* Crear relación VENTA_DETALLE_PRENDA */
ALTER TABLE VENTA_DETALLE
    ADD CONSTRAINT venta_detalle_prenda FOREIGN KEY (prenda_id)
    REFERENCES PRENDA (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/* Listar relaciones de tablas de la base de datos activa */
SELECT
    i.constraint_name, k.table_name, k.column_name,
    k.referenced_table_name, k.referenced_column_name
FROM
    information_schema.TABLE_CONSTRAINTS i
LEFT JOIN information_schema.KEY_COLUMN_USAGE k
ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY'
AND i.TABLE_SCHEMA = DATABASE();
