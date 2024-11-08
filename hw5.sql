/*Задание: Создайте таблицу EmployeeDetails для хранения информации о
сотрудниках. Таблица должна содержать следующие столбцы:
● EmployeeID (INTEGER, PRIMARY KEY)
● EmployeeName (TEXT)
● Position (TEXT)
● HireDate (DATE)
● Salary (NUMERIC)
После создания таблицы добавьте в неё три записи с произвольными данными о
сотрудниках.*/

CREATE TABLE EmployeeDetails (
	EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
	EmployeeName VARCHAR(20),
	Position VARCHAR(50),
	HireDate DATE,
	Salary NUMERIC
);

INSERT INTO EmployeeDetails 
(EmployeeName, `Position`, HireDate, Salary)
VALUES
	('Alex', 'Manager', '2020-02-02', 1234),
	('Gleb', 'Coder', '2019-12-02', 1234000),
	('Anton', 'HR', '2016-06-24', 2000);

/*Задание: Создайте представление HighValueOrders для отображения всех заказов,
сумма которых превышает 10000. В представлении должны быть следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● TotalAmount (общая сумма заказа, вычисленная как сумма всех Quantity *
Price).
Используйте таблицы Orders, OrderDetails и Products.*/

DROP VIEW IF EXISTS HighValueOrders;

CREATE VIEW HighValueOrders AS (
	WITH Totals AS (
		SELECT DISTINCT 
			o.OrderID,
			o.OrderDate,
			SUM(p.Price * od.Quantity) OVER(PARTITION BY o.OrderID) AS total_amount
		FROM OrderDetails od 
		JOIN Products p ON od.ProductID = p.ProductID 
		JOIN Orders o ON od.OrderID = o.OrderID 
	)
	SELECT *
	FROM Totals
	WHERE total_amount > 10000
);

SELECT *
FROM HighValueOrders hvo;

/*Задание: Удалите все записи из таблицы EmployeeDetails, где Salary меньше
50000. Затем удалите таблицу EmployeeDetails из базы данных.*/

DELETE FROM EmployeeDetails 
WHERE Salary < 50000;

DROP TABLE IF EXISTS EmployeeDetails;

/*Задание: Создайте хранимую процедуру GetProductSales с одним параметром
ProductID. Эта процедура должна возвращать список всех заказов, в которых
участвует продукт с заданным ProductID, включая следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● CustomerID (идентификатор клиента).*/

CALL GetProductSales(8);