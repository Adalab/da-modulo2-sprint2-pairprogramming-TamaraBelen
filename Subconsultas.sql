/* 1. Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada. */

SELECT employee_id, customer_id, order_id, required_date, order_date  FROM orders
WHERE order_date = (
	SELECT MAX(order_date) FROM orders)
GROUP BY orders.employee_id;


/* 2. Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. De nuevo lo tendréis que hacer con queries correlacionadas. */

SELECT product_id, MAX(unit_price) AS PrecioUnitarioMaximo FROM order_details
GROUP BY product_id;


/* 3. Extraed información de los productos "Beverages".
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto.
En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría. */


SELECT product_id, product_name, category_id, category_name
FROM products JOIN categories ON 
WHERE category_name = 'Beverages';


SELECT product_id, product_name, category_id
FROM products 
WHERE category_id = (SELECT category_id FROM categories WHERE category_name = 'Beverages');


/* 4. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país.
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar proveedores adicionales. */

SELECT DISTINCT country FROM customers
WHERE country NOT IN (SELECT DISTINCT country FROM suppliers);


/* 5. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread".
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido. */

SELECT customer_id FROM orders
WHERE order_id = (
	SELECT order_id, product_id FROM order_details
	WHERE product_id = 6 AND quantity >= 20)
GROUP BY customer_id;

SELECT product_id FROM products WHERE product_name = "Grandma's Boysenberry Spread";

SELECT customer_id;

/* 6. Extraed los 10 productos más caros.
Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros. */

SELECT;

SELECT * FROM products ORDER BY unit_price DESC LIMIT 10;


/* 7. Qué producto es más popular.
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.*/


