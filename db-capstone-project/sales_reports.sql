
-- Task 1 virtual table
CREATE VIEW OrdersView
AS
SELECT order_id
	,ordersviewquantity
	,cost
FROM Orders
WHERE quantity > 2;
SELECT * FROM OrdersView;


-- Task 2 using the relevant JOIN clause
SELECT customers.customer_id
	,customers.first_name
	,customers.last_name
	,orders.order_id
	,orders.cost
	,menu.cuisine
	,menuitems.name
FROM customers
INNER JOIN bookings ON customers.customer_id = bookings.customer_id
INNER JOIN orders ON bookings.booking_id = orders.booking_id
INNER JOIN menu ON orders.menu_id = menu.menu_id
INNER JOIN menuitems ON menu.item_id = menuitems.item_id
WHERE menuitems.type = "Starters"
	AND orders.cost > 150;


-- Task 3 creating a subquery
SELECT DISTINCT (cuisine)
FROM menu
WHERE menu_id = ANY (
		SELECT menu_id
		FROM orders
		WHERE quantity > 2
		);


-- Task 1 Define a stored procedure to retrieve the maximum quantity from the "orders" table
CREATE PROCEDURE GetMaxQuantity ()
SELECT MAX(quantity) AS 'Max Quantity In Order'
FROM orders;
CALL GetMaxQuantity;


-- Task 2 Define a prepared statement to retrieve the details of an order for a given customer
PREPARE GetOrderDetail 
FROM 'SELECT order_id, quantity, cost 
      FROM orders inner join bookings on orders.booking_id=bookings.booking_id
      WHERE bookings.customer_id = ?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;


-- Task 3 create a stored procedure called CancelOrder. to delete an order record based on the user input of the order id
CREATE TRIGGER AfterDeleteOrder 
  AFTER DELETE   
  ON orders FOR EACH ROW 
INSERT INTO audits (Confirmation) VALUES(CONCAT('Order ',OLD.order_id, ' is cancelled at ', CURRENT_TIME(), ' on ', CURRENT_DATE() ));

CREATE PROCEDURE CancelOrder (inputOrderID INT)
DELETE FROM orders WHERE order_id = inputOrderID;

CALL CancelOrder(6);

select * from audits;


