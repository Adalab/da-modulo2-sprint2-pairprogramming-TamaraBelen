/* 1
Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.
Los resultados de esta query serán:
*/

USE northwind;

#WITH nombres AS(SELECT company_name, customer_id FROM customers);


WITH nombres_compañias AS (SELECT company_name,customer_id FROM customers),
identificacion_cliente AS (SELECT customer_id,company_name FROM nombres_compañias)
SELECT * FROM identificacion_cliente;

/*2.
Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".
Los resultados de esta query serán:
*/
WITH nombres_compañias AS (SELECT company_name,customer_id,country FROM customers),
identificacion_cliente AS (SELECT customer_id,company_name FROM nombres_compañias WHERE country = "Germany")
SELECT * FROM identificacion_cliente;

/* 3.
Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).
*/
WITH facturas_cliente AS (
	SELECT orders.order_id,orders.order_date,customers.customer_id,customers.company_name
	FROM ORDERS
	INNER JOIN customers
	ON orders.customer_id = customers.customer_id)
SELECT * FROM facturas_cliente;

/*4.
Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.
*/
WITH num_facturas_cliente AS (
	SELECT COUNT(orders.order_id)AS numero_facturas,customers.customer_id,customers.company_name
	FROM customers
	INNER JOIN orders
	ON orders.customer_id = customers.customer_id
    GROUP BY customers.customer_id)
    
SELECT * FROM num_facturas_cliente;

/*5.
Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.
Los resultados de esta query serán:
*/

WITH cantidad_pedida AS ( SELECT products.product_id,products.product_name, AVG(order_details.quantity) AS Media
	FROM order_details
    INNER JOIN products
    ON order_details.product_id = products.product_id
    GROUP BY product_id)
SELECT * FROM cantidad_pedida;

/*6.
Usando una CTE, extraer el nombre de las diferentes categorías de productos, con su precio medio, máximo y mínimo.
*/

WITH precios_categoria AS (SELECT 
		
		categories.category_name,
        categories.category_id,
        AVG(products.unit_price)AS Precio_Medio, 
		MAX(products.unit_price) as Precio_Maximo,
		MIN(products.unit_price) AS Precio_Minimo 
    FROM products
    INNER JOIN categories
    ON categories.category_id = products.category_id
    GROUP BY categories.category_name)

SELECT * FROM precios_categoria;

    




