DROP PROCEDURE IF EXISTS GetProductSales;

DELIMITER $$
$$
CREATE PROCEDURE GetProductSales(_ProductID int)
BEGIN
	SELECT DISTINCT 
		o.OrderID,
		o.OrderDate,
		o.CustomerID 
	FROM Orders o 
	JOIN OrderDetails od ON o.OrderID = od.OrderID 
	WHERE od.ProductID = _ProductID;
END$$
DELIMITER ;