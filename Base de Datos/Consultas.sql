--2
SELECT
	rif_cliente,
	nombre,
	direccion,
	fecha_in 
FROM
	clientes 
WHERE
	fecha_in > '2020-01-01' :: DATE 
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
	rif_cliente IN ( SELECT rif_cliente FROM facturas WHERE fecha_emision BETWEEN '2011-01-01' :: DATE AND '2020-01-01' :: DATE ) 
ORDER BY
	cedula DESC;

--4
SELECT cod_linea, descripcion,
(SELECT COUNT (*) FROM articulos o WHERE o.cod_linea = l.cod_linea) AS cantidad_articulos,
(SELECT AVG (precio) FROM articulos o WHERE o.cod_linea = l.cod_linea) AS precio_promedio
FROM lineas l
ORDER BY cantidad_articulos DESC;

--5
SELECT DISTINCT num_factura, rif_cliente, fecha_emision
FROM facturas
WHERE num_factura IN (SELECT num_factura FROM facturas_detalles WHERE cod_articulo IN (SELECT cod_articulo FROM articulos WHERE cod_linea = (SELECT cod_linea FROM lineas WHERE descripcion = 'Articulos de papeleria')) AND fecha_emision  BETWEEN '2020-01-01'::DATE AND '2021-01-01'::DATE)
ORDER BY rif_cliente, num_factura;

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
		cod_articulo = x.cod_articulo 
		AND ( SELECT ( fecha_emision ) FROM facturas WHERE f.num_factura = num_factura ) BETWEEN '2011-01-01' :: DATE 
		AND '2020-01-01' :: DATE 
	) AS total_ventas 
FROM
	articulos x 
GROUP BY
	cod_articulo 
HAVING
	(
	SELECT SUM
		( precio ) 
	FROM
		facturas_detalles f 
	WHERE
		cod_articulo = x.cod_articulo 
		AND ( SELECT ( fecha_emision ) FROM facturas WHERE f.num_factura = num_factura ) BETWEEN '2011-01-01' :: DATE 
		AND '2020-01-01' :: DATE 
	) > 5000000 
ORDER BY
	total_ventas

--7
SELECT
	cod_proveedor,
	( SELECT ( razon_soc ) FROM proveedores WHERE cod_proveedor = x.cod_proveedor ) AS razon_social,
	( SELECT ( direccion ) FROM proveedores WHERE cod_proveedor = x.cod_proveedor ) AS direccion,
	( SELECT ( telefono ) FROM proveedores WHERE cod_proveedor = x.cod_proveedor ) AS telefono,
	( SELECT ( status_p ) FROM proveedores WHERE cod_proveedor = x.cod_proveedor ) AS status,
	cod_articulo,
	( SELECT ( descripcion ) FROM articulos WHERE cod_articulo = x.cod_articulo ) AS nombre_articulo,
	(precio / cantidad) AS precio_minimo 
FROM
	articulos_compras x 
WHERE
	cod_articulo = 'A0054' 
	AND ( SELECT MIN ( precio / cantidad ) FROM articulos_compras WHERE cod_articulo = x.cod_articulo ) = precio / cantidad;


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
	AND P.cod_proveedor = a_c.cod_proveedor

--8
UPDATE articulos A 
SET status_a = 'D' 
WHERE
	existencia = 0 
	AND ( SELECT MAX ( fecha_emision ) FROM facturas WHERE num_factura IN ( SELECT ( num_factura ) FROM facturas_detalles WHERE A.cod_articulo = cod_articulo ) ) < CURRENT_DATE - '1 YEAR' :: INTERVAL