
/*********************************************************/
/*Dominios*/
CREATE DOMAIN dom_rif_cliente
    AS char(10);

CREATE DOMAIN dom_cedula
    AS char(10);

CREATE DOMAIN dom_direccion
    AS varchar(255);

CREATE DOMAIN dom_telefono
    AS char(11)
    CHECK (value not like '%[^0-9]%');

CREATE DOMAIN dom_fecha
    AS timestamp(0);

CREATE DOMAIN dom_num_factura
    AS char(15);

CREATE DOMAIN dom_codigo
    AS char(10);

CREATE DOMAIN dom_cantidad
    AS int
    CHECK (value >= 0);

CREATE DOMAIN dom_precio
    AS dec(15,2)
    CHECK (value >= 0);                  

CREATE DOMAIN dom_descripcion
    AS varchar(100);

/*********************************************************/
/*Tablas*/
CREATE TABLE clientes(
    rif_cliente dom_rif_cliente PRIMARY KEY,
    cedula dom_cedula UNIQUE NOT NULL,
    nombre varchar(80) NOT NULL, 
    direccion dom_direccion NOT NULL,
    telefono dom_telefono,
    fecha_nac dom_fecha NOT NULL,
    status_c char CHECK (status_c IN ('A', 'S', 'M')) NOT NULL,
    fecha_in dom_fecha NOT NULL,
    fecha_out dom_fecha CHECK (fecha_out > fecha_in)
);

CREATE TABLE facturas(
    num_factura dom_num_factura PRIMARY KEY,
    rif_cliente dom_rif_cliente NOT NULL,
    fecha_emision dom_fecha NOT NULL,
    tipo_pago char CHECK (tipo_pago IN ('E', 'T')) NOT NULL, 
    tipo_moneda char CHECK (tipo_moneda IN ('B','D', 'P')) NOT NULL
);

CREATE TABLE facturas_detalles(
    num_factura dom_num_factura,
    cod_articulo dom_codigo,
    cantidad dom_cantidad NOT NULL,
    precio dom_precio NOT NULL,
    PRIMARY KEY(num_factura, cod_articulo)
);

CREATE TABLE articulos(
    cod_articulo dom_codigo PRIMARY KEY,
    descripcion dom_descripcion NOT NULL,
    cod_linea dom_codigo NOT NULL, 
    precio dom_precio NOT NULL,
    existencia int NOT NULL CHECK (existencia >= 0), 
    maximo int NOT NULL CHECK (maximo >= minimo), 
    minimo int NOT NULL CHECK (minimo >= 0 AND minimo <= maximo), 
    status_a char CHECK (status_a IN ('A', 'D', 'R')) NOT NULL
);


CREATE TABLE articulos_compras(
    cod_proveedor dom_codigo,
    cod_articulo dom_codigo ,
    fec_compra dom_fecha,
    cantidad dom_cantidad NOT NULL,
    precio dom_precio NOT NULL,
    PRIMARY KEY(cod_proveedor, cod_articulo, fec_compra)
);

CREATE TABLE lineas(
  cod_linea dom_codigo PRIMARY KEY,
  descripcion dom_descripcion UNIQUE NOT NULL
);

CREATE TABLE proveedores(
    cod_proveedor dom_codigo PRIMARY KEY,
    razon_soc varchar(50) UNIQUE NOT NULL,
    direccion dom_direccion NOT NULL, 
    telefono dom_telefono,
    status_p char CHECK (status_p IN ('A', 'S', 'E')) NOT NULL
);

/*********************************************************/
/*Claves Foráneas*/
ALTER TABLE facturas
    ADD FOREIGN KEY (rif_cliente)
    REFERENCES clientes (rif_cliente)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE facturas_detalles
    ADD FOREIGN KEY (num_factura)
    REFERENCES facturas (num_factura)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE facturas_detalles
    ADD FOREIGN KEY (cod_articulo)
    REFERENCES articulos (cod_articulo)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;


ALTER TABLE articulos
    ADD FOREIGN KEY (cod_linea)
    REFERENCES lineas (cod_linea)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;
    
ALTER TABLE articulos_compras
    ADD FOREIGN KEY (cod_articulo)
    REFERENCES articulos (cod_articulo)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;
    
ALTER TABLE articulos_compras
    ADD FOREIGN KEY (cod_proveedor)
    REFERENCES proveedores (cod_proveedor)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

/*********************************************************/
/*Modificaciones*/
/*1*/
CREATE INDEX ON articulos (cod_linea);   

/*2*/
ALTER TABLE facturas
    ALTER COLUMN tipo_moneda TYPE VARCHAR(9);

ALTER TABLE facturas
    DROP CONSTRAINT facturas_tipo_moneda_check;
    
UPDATE facturas SET tipo_moneda = 'Bolívares' WHERE tipo_moneda = 'B';
UPDATE facturas SET tipo_moneda = 'Divisas' WHERE tipo_moneda = 'D';
UPDATE facturas SET tipo_moneda = 'Petro' WHERE tipo_moneda = 'P';

ALTER TABLE facturas
    ADD CONSTRAINT facturas_tipo_moneda_check CHECK (tipo_moneda IN ('Bolívares', 'Divisas', 'Petro'));

/*3*/
ALTER TABLE articulos
    ADD COLUMN fecha_out dom_fecha;    

/*4*/
ALTER TABLE clientes
    DROP COLUMN fecha_nac;
ALTER TABLE clientes
    ADD COLUMN email varchar(100) DEFAULT '' NOT NULL;

/*5*/
CREATE INDEX ON facturas (rif_cliente);