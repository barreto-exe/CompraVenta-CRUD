--2
SELECT
	rif_cliente,
	nombre,
	direccion,
	fecha_in 
FROM
	clientes 
WHERE
	EXTRACT ( YEAR FROM fecha_in ) = EXTRACT ( YEAR FROM CURRENT_DATE ) - 1 
	AND fecha_out IS NOT NULL 
ORDER BY
	fecha_in,
	nombre ASC;

--3
SELECT DISTINCT
	rif_cliente,
	cedula,
	nombre 
FROM
	clientes 
WHERE
	rif_cliente IN ( SELECT rif_cliente FROM facturas WHERE fecha_emision BETWEEN '2016-01-01' :: DATE AND '2019-01-01' :: DATE ) 
ORDER BY
	cedula DESC;

--4
SELECT
	cod_linea,
	descripcion,
	( SELECT COUNT ( * ) FROM articulos A WHERE A.cod_linea = l.cod_linea ) AS cantidad_articulos,
	( SELECT AVG ( precio ) FROM articulos A WHERE A.cod_linea = l.cod_linea ) AS precio_promedio 
FROM
	lineas l 
ORDER BY
	cantidad_articulos DESC;

--5
SELECT DISTINCT
	num_factura,
	rif_cliente,
	fecha_emision 
FROM
	facturas 
WHERE
	num_factura IN (
	SELECT
		num_factura 
	FROM
		facturas_detalles 
	WHERE
		cod_articulo IN ( SELECT cod_articulo FROM articulos WHERE cod_linea = ( SELECT cod_linea FROM lineas WHERE descripcion = 'Articulos de papeleria' ) ) 
		AND EXTRACT ( YEAR FROM fecha_emision ) = EXTRACT ( YEAR FROM CURRENT_DATE ) - 1 
	) 
ORDER BY
	rif_cliente,
	num_factura;

--6
SELECT
	cod_articulo,
	descripcion,
	(
	SELECT SUM
		( precio ) 
	FROM
		facturas_detalles f 
	WHERE
		cod_articulo = A.cod_articulo 
		AND EXTRACT ( YEAR FROM ( SELECT ( fecha_emision ) FROM facturas WHERE f.num_factura = num_factura ) ) = EXTRACT ( YEAR FROM CURRENT_DATE ) - 1 
	) AS total_ventas 
FROM
	articulos A 
GROUP BY
	cod_articulo 
HAVING
	(
	SELECT SUM
		( precio ) 
	FROM
		facturas_detalles f 
	WHERE
		cod_articulo = A.cod_articulo 
		AND EXTRACT ( YEAR FROM ( SELECT ( fecha_emision ) FROM facturas WHERE f.num_factura = num_factura ) ) = EXTRACT ( YEAR FROM CURRENT_DATE ) - 1 
	) > 5000000 
ORDER BY
	total_ventas;

--7
SELECT DISTINCT
	a_c.cod_proveedor,
	P.razon_soc,
	P.direccion,
	P.telefono,
	P.status_p,
	a_c.cod_articulo,
	A.descripcion,
	a_c.cantidad,
	( a_c.precio / a_c.cantidad ) AS precio_minimo,
	a_c.fec_compra 
FROM
	articulos_compras a_c,
	articulos A,
	proveedores P 
WHERE
	a_c.cod_articulo = 'A0054' 
	AND ( SELECT MIN ( precio / cantidad ) FROM articulos_compras WHERE cod_articulo = a_c.cod_articulo ) = a_c.precio / a_c.cantidad 
	AND A.cod_articulo = a_c.cod_articulo 
	AND P.cod_proveedor = a_c.cod_proveedor;

--8
UPDATE articulos A 
SET status_a = 'D' 
WHERE
	existencia = 0 
	AND ( SELECT MAX ( fecha_emision ) FROM facturas
	WHERE num_factura IN ( SELECT ( num_factura ) FROM facturas_detalles
	WHERE A.cod_articulo = cod_articulo ) ) < CURRENT_DATE - '1 YEAR' :: INTERVAL;

--9
CREATE TABLE IF NOT EXISTS historico_proveedores(
	id SERIAL PRIMARY KEY,
    cod_proveedor dom_codigo NOT NULL,
    razon_soc varchar(50) NOT NULL,
    direccion dom_direccion NOT NULL, 
    telefono dom_telefono
);

CREATE OR REPLACE FUNCTION respaldar_prov ( ) RETURNS TRIGGER AS $historico$ BEGIN
	INSERT INTO historico_proveedores ( cod_proveedor, razon_soc, direccion, telefono )
	VALUES
		( OLD.cod_proveedor, OLD.razon_soc, OLD.direccion, OLD.telefono );
	DELETE 
	FROM
		articulos_compras 
	WHERE
		cod_proveedor = OLD.cod_proveedor;
	RETURN OLD;
	
END;
$historico$ LANGUAGE plpgsql;

CREATE TRIGGER historico
	BEFORE DELETE
	ON proveedores
	FOR EACH ROW
	EXECUTE PROCEDURE respaldar_prov();


DELETE 
FROM
	proveedores 
WHERE
	cod_proveedor IN ( SELECT ( cod_proveedor ) FROM proveedores WHERE status_p = 'E' );