
USE northwind;
/* EJERCICIO 1
Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con 
la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK.
 Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.
Deberéis obtener una tabla similar a esta:

*/
SELECT c.customer_id,c.company_name,COUNT(o.order_id )AS NumeroPedidos
FROM CUSTOMERS c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.country="UK"
GROUP BY c.customer_id;


/* EJERCICIO 2
Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior
y han decidido pedirnos una serie de consultas adicionales. La primera de ellas consiste en una query
que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año.
Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
 */

SELECT 
c.company_name as NombreEmpresa,
YEAR(o.order_date) as Año,
od.quantity AS NumObjetos
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_details od
ON o.order_id = od.order_id
WHERE c.country="UK";

 
 
 /* EJERCICIO 3
 Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad
de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. Ojo 
que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.
*/
SELECT 
c.company_name as NombreEmpresa,
YEAR(o.order_date) as Año,
od.quantity AS NumObjetos,
SUM(od.unit_price) as DineroTotal
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_details od
ON o.order_id = od.order_id
WHERE c.country="UK" ;

SELECT
    c.company_name AS company_name,
    YEAR(o.order_date) AS order_year,
    COUNT(o.order_id) AS num_objects_ordered,
    SUM(od.unit_price * od.quantity * (1 - COALESCE(od.discount, 0))) AS total_amount_with_discount
FROM
    customers c
JOIN
    orders o ON c.customer_id = o.customer_id
JOIN
    order_details od ON o.order_id = od.order_id
WHERE
    c.country = 'UK'
GROUP BY
    c.company_name, YEAR(o.order_date),c.customer_id;




 /*
 EJERCICIO 4 BONUS
 BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, 
desde la central nos han pedido una consulta que indique el nombre de cada compañia 
cliente junto con cada pedido que han realizado y su fecha.
*/
SELECT 
		 o.order_id,
         c.company_name,
         o.order_date
        
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE country='UK'
ORDER BY c.company_name;

/*EJERCICIO 5 BONUS
BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, 
nombre de la categoría y el nombre del producto, y el total de dinero por el que se ha 
vendido cada tipo de producto (teniendo en cuenta los descuentos).
Pista Necesitaréis usar 3 joins.
*/

       


/* EJERCICIO 6
Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas.
Los resultados deberán similares a la siguiente tabla:
*/
SELECT c.company_name,
	   o.order_id,
       o.order_date
FROM customers c
INNER JOIN orders o
ON C.customer_id = o.customer_id
ORDER BY c.company_name;

/* EJERCICIO 7
Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos 
que ha realizado cada cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse 
al mercado actual. Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos.
La tabla resultante será:
*/
SELECT c.company_name as NombreCliente,COUNT(o.order_id) as NumeroPedidos
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.country = "UK"
GROUP BY c.company_name;

/* EJERCICIO 8
Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido 
(tengan pedidos o no) junto con los ID de todos los pedidos que han realizado y la fecha del pedido.
Los resultados de la query deberán ser:
*/
SELECT o.order_id,
	   c.company_name AS NombreCliente,
       o.order_date AS FechaPedido
       FROM customers c
       INNER JOIN orders o
       ON c.customer_id = o.customer_id
       WHERE c.country = "UK"
       GROUP BY c.company_name,o.order_id,o.order_date;
       



/* EJERCICIO 9
Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla 
los datos de todas las empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, y 
apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?
La tabla resultado de la query deberá ser:
*/
SELECT e.city,
	   e.first_name AS NombreEmpleado,
       e.last_name AS ApellidoEmpleado,
       j.city,
       j.first_name AS NombreJefe,
       j.last_name AS ApellidoJefe
FROM employees e,employees j;


 /* EJERCICIO 10
BONUS: FULL OUTER JOIN Pedidos y empresas con pedidos asociados o no:
*/
SELECT *
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
UNION
SELECT *
FROM customers
RIGHT JOIN orders
ON customers.customer_id = orders.customer_id;
