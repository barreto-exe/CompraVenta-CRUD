/*
 Navicat Premium Data Transfer

 Source Server         : Local
 Source Server Type    : PostgreSQL
 Source Server Version : 130003
 Source Host           : localhost:5432
 Source Catalog        : compraventasdb
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 130003
 File Encoding         : 65001

 Date: 29/05/2021 01:02:49
*/


-- ----------------------------
-- Table structure for articulos
-- ----------------------------
DROP TABLE IF EXISTS "public"."articulos";
CREATE TABLE "public"."articulos" (
  "cod_articulo" "public"."dom_codigo" COLLATE "pg_catalog"."default" NOT NULL,
  "descripcion" "public"."dom_descripcion" COLLATE "pg_catalog"."default" NOT NULL,
  "cod_linea" "public"."dom_codigo" COLLATE "pg_catalog"."default" NOT NULL,
  "precio" "public"."dom_precio" NOT NULL,
  "existencia" int4 NOT NULL,
  "maximo" int4 NOT NULL,
  "minimo" int4 NOT NULL,
  "status_a" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "fecha_out" "public"."dom_fecha"
)
;

-- ----------------------------
-- Table structure for articulos_compras
-- ----------------------------
DROP TABLE IF EXISTS "public"."articulos_compras";
CREATE TABLE "public"."articulos_compras" (
  "cod_proveedor" "public"."dom_codigo" COLLATE "pg_catalog"."default" NOT NULL,
  "cod_articulo" "public"."dom_codigo" COLLATE "pg_catalog"."default" NOT NULL,
  "fec_compra" "public"."dom_fecha" NOT NULL,
  "cantidad" "public"."dom_cantidad" NOT NULL,
  "precio" "public"."dom_precio" NOT NULL
)
;

-- ----------------------------
-- Table structure for clientes
-- ----------------------------
DROP TABLE IF EXISTS "public"."clientes";
CREATE TABLE "public"."clientes" (
  "rif_cliente" "public"."dom_rif_cliente" COLLATE "pg_catalog"."default" NOT NULL,
  "cedula" "public"."dom_cedula" COLLATE "pg_catalog"."default" NOT NULL,
  "nombre" varchar(80) COLLATE "pg_catalog"."default" NOT NULL,
  "direccion" "public"."dom_direccion" COLLATE "pg_catalog"."default" NOT NULL,
  "telefono" "public"."dom_telefono" COLLATE "pg_catalog"."default",
  "status_c" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "fecha_in" "public"."dom_fecha" NOT NULL,
  "fecha_out" "public"."dom_fecha",
  "email" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying
)
;

-- ----------------------------
-- Table structure for facturas
-- ----------------------------
DROP TABLE IF EXISTS "public"."facturas";
CREATE TABLE "public"."facturas" (
  "num_factura" "public"."dom_num_factura" COLLATE "pg_catalog"."default" NOT NULL,
  "rif_cliente" "public"."dom_rif_cliente" COLLATE "pg_catalog"."default" NOT NULL,
  "fecha_emision" "public"."dom_fecha" NOT NULL,
  "tipo_pago" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "tipo_moneda" varchar(9) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for facturas_detalles
-- ----------------------------
DROP TABLE IF EXISTS "public"."facturas_detalles";
CREATE TABLE "public"."facturas_detalles" (
  "num_factura" "public"."dom_num_factura" COLLATE "pg_catalog"."default" NOT NULL,
  "cod_articulo" "public"."dom_codigo" COLLATE "pg_catalog"."default" NOT NULL,
  "cantidad" "public"."dom_cantidad" NOT NULL,
  "precio" "public"."dom_precio" NOT NULL
)
;

-- ----------------------------
-- Table structure for lineas
-- ----------------------------
DROP TABLE IF EXISTS "public"."lineas";
CREATE TABLE "public"."lineas" (
  "cod_linea" "public"."dom_codigo" COLLATE "pg_catalog"."default" NOT NULL,
  "descripcion" "public"."dom_descripcion" COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for proveedores
-- ----------------------------
DROP TABLE IF EXISTS "public"."proveedores";
CREATE TABLE "public"."proveedores" (
  "cod_proveedor" "public"."dom_codigo" COLLATE "pg_catalog"."default" NOT NULL,
  "razon_soc" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "direccion" "public"."dom_direccion" COLLATE "pg_catalog"."default" NOT NULL,
  "telefono" "public"."dom_telefono" COLLATE "pg_catalog"."default",
  "status_p" char(1) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Indexes structure for table articulos
-- ----------------------------
CREATE INDEX "articulos_cod_articulo_idx" ON "public"."articulos" USING btree (
  "cod_articulo" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table articulos
-- ----------------------------
ALTER TABLE "public"."articulos" 
  ADD CONSTRAINT "articulos_status_a_check" 
  CHECK (status_a = ANY (ARRAY['A'::bpchar, 'D'::bpchar, 'R'::bpchar]));
ALTER TABLE "public"."articulos" 
  ADD CONSTRAINT "articulos_check" 
  CHECK (minimo <= maximo);

-- ----------------------------
-- Primary Key structure for table articulos
-- ----------------------------
ALTER TABLE "public"."articulos" 
  ADD CONSTRAINT "articulos_pkey" 
  PRIMARY KEY ("cod_articulo");

-- ----------------------------
-- Indexes structure for table articulos_compras
-- ----------------------------
CREATE INDEX "articulos_compras_cod_articulo_cod_proveedor_idx" 
ON "public"."articulos_compras" USING btree (
  "cod_articulo" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST,
  "cod_proveedor" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table articulos_compras
-- ----------------------------
ALTER TABLE "public"."articulos_compras" 
  ADD CONSTRAINT "articulos_compras_pkey" 
  PRIMARY KEY ("cod_proveedor", "cod_articulo", "fec_compra");

-- ----------------------------
-- Indexes structure for table clientes
-- ----------------------------
CREATE INDEX "clientes_nombre_idx" 
ON "public"."clientes" USING btree (
  "nombre" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table clientes
-- ----------------------------
ALTER TABLE "public"."clientes" 
  ADD CONSTRAINT "clientes_cedula_key" 
  UNIQUE ("cedula");

-- ----------------------------
-- Checks structure for table clientes
-- ----------------------------
ALTER TABLE "public"."clientes" 
  ADD CONSTRAINT "clientes_status_c_check" 
  CHECK (status_c = ANY (ARRAY['A'::bpchar, 'S'::bpchar, 'M'::bpchar]));
ALTER TABLE "public"."clientes" 
  ADD CONSTRAINT "clientes_check" 
  CHECK (fecha_out::timestamp without time zone > fecha_in::timestamp without time zone);

-- ----------------------------
-- Primary Key structure for table clientes
-- ----------------------------
ALTER TABLE "public"."clientes" 
  ADD CONSTRAINT "clientes_pkey" 
  PRIMARY KEY ("rif_cliente");

-- ----------------------------
-- Checks structure for table facturas
-- ----------------------------
ALTER TABLE "public"."facturas" 
  ADD CONSTRAINT "facturas_tipo_pago_check" 
  CHECK (tipo_pago = ANY (ARRAY['E'::bpchar, 'T'::bpchar]));
ALTER TABLE "public"."facturas" 
  ADD CONSTRAINT "facturas_tipo_moneda_check" 
  CHECK (tipo_moneda::text = ANY (ARRAY['Bolívares'::character varying, 'Divisas'::character varying, 'Petro'::character varying]::text[]));

-- ----------------------------
-- Primary Key structure for table facturas
-- ----------------------------
ALTER TABLE "public"."facturas" 
  ADD CONSTRAINT "facturas_pkey" 
  PRIMARY KEY ("num_factura");

-- ----------------------------
-- Primary Key structure for table facturas_detalles
-- ----------------------------
ALTER TABLE "public"."facturas_detalles" 
  ADD CONSTRAINT "facturas_detalles_pkey" 
  PRIMARY KEY ("num_factura", "cod_articulo");

-- ----------------------------
-- Uniques structure for table lineas
-- ----------------------------
ALTER TABLE "public"."lineas" 
  ADD CONSTRAINT "lineas_descripcion_key" 
  UNIQUE ("descripcion");

-- ----------------------------
-- Primary Key structure for table lineas
-- ----------------------------
ALTER TABLE "public"."lineas" 
  ADD CONSTRAINT "lineas_pkey" 
  PRIMARY KEY ("cod_linea");

-- ----------------------------
-- Uniques structure for table proveedores
-- ----------------------------
ALTER TABLE "public"."proveedores" 
  ADD CONSTRAINT "proveedores_razon_soc_key" 
  UNIQUE ("razon_soc");

-- ----------------------------
-- Checks structure for table proveedores
-- ----------------------------
ALTER TABLE "public"."proveedores" 
  ADD CONSTRAINT "proveedores_status_p_check" 
  CHECK (status_p = ANY (ARRAY['A'::bpchar, 'S'::bpchar, 'E'::bpchar]));

-- ----------------------------
-- Primary Key structure for table proveedores
-- ----------------------------
ALTER TABLE "public"."proveedores" 
  ADD CONSTRAINT "proveedores_pkey" 
  PRIMARY KEY ("cod_proveedor");

-- ----------------------------
-- Foreign Keys structure for table articulos
-- ----------------------------
ALTER TABLE "public"."articulos" 
  ADD CONSTRAINT "articulos_cod_linea_fkey" 
  FOREIGN KEY ("cod_linea") 
  REFERENCES "public"."lineas" ("cod_linea") 
  ON DELETE RESTRICT 
  ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table articulos_compras
-- ----------------------------
ALTER TABLE "public"."articulos_compras" 
  ADD CONSTRAINT "articulos_compras_cod_articulo_fkey" 
  FOREIGN KEY ("cod_articulo") 
  REFERENCES "public"."articulos" ("cod_articulo") 
  ON DELETE RESTRICT 
  ON UPDATE CASCADE;
ALTER TABLE "public"."articulos_compras" 
  ADD CONSTRAINT "articulos_compras_cod_proveedor_fkey" 
  FOREIGN KEY ("cod_proveedor") 
  REFERENCES "public"."proveedores" ("cod_proveedor") 
  ON DELETE RESTRICT 
  ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table facturas
-- ----------------------------
ALTER TABLE "public"."facturas" 
  ADD CONSTRAINT "facturas_rif_cliente_fkey" 
  FOREIGN KEY ("rif_cliente") 
  REFERENCES "public"."clientes" ("rif_cliente") 
  ON DELETE RESTRICT 
  ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table facturas_detalles
-- ----------------------------
ALTER TABLE "public"."facturas_detalles" 
  ADD CONSTRAINT "facturas_detalles_cod_articulo_fkey" 
  FOREIGN KEY ("cod_articulo") 
  REFERENCES "public"."articulos" ("cod_articulo") 
  ON DELETE RESTRICT 
  ON UPDATE CASCADE;
ALTER TABLE "public"."facturas_detalles" 
  ADD CONSTRAINT "facturas_detalles_num_factura_fkey" 
  FOREIGN KEY ("num_factura") 
  REFERENCES "public"."facturas" ("num_factura") 
  ON DELETE RESTRICT 
  ON UPDATE CASCADE;
