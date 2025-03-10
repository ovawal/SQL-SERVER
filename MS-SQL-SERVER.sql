USE salesdata1;
CREATE TABLE SalesPerson (
    SalesPersonID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL
);
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    State NVARCHAR(50) NOT NULL,
    SalesPersonID INT NOT NULL,
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
);
CREATE TABLE Orders (
    OrderNumber INT PRIMARY KEY IDENTITY(1000,1),
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
); 

CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY IDENTITY(2000,1),
    OrderNumber INT NOT NULL,
    ItemName NVARCHAR(100) NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    PriceUSD DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderNumber) REFERENCES Orders(OrderNumber)
);

INSERT INTO SalesPerson (FirstName, LastName)
VALUES 
('Jayson', 'Tatum'), ('Devin', 'Booker'), 
('Anthony', 'Davis'),('Damian', 'Lillard'),
('Jimmy', 'Butler'), ('DeAaron', 'Fox'),
('Ja', 'Morant'), ('Kevin', 'Durant'),
('Joel','Embiid'),('Luka', 'Doncic'),
 ('Nikola', 'Jokic'), ('Stephen', 'Curry'), 
('LeBron', 'James'), ('Grace', 'Jane'),
 ('John', 'Doe'), ('Jane', 'Smith'),
 ('Michael', 'Johnson'), ('Chris', 'Brown'), 
('Patricia', 'Williams'), ('Robert', 'Jones'),
('Emily', 'Taylor'), ('David', 'Anderson'),
('Laura', 'Miller'), ('Daniel', 'Martinez'), 
('Sophia', 'Harris'), ('James', 'Clark');


INSERT INTO customer (Name, State, SalesPersonID)
VALUES 
('Patrick Mahomes', 'MO', 5), ('Travis Kelce', 'PA', 12),
('Lamar Jackson', 'MD', 3), ('Tom Brady', 'FL', 9),
('Aaron Rodgers', 'NY', 17), ('Josh Allen', 'NY', 22),
('Joe Burrow', 'OH', 8), ('Justin Jefferson', 'MN', 14),
('JaMarr Chase', 'OH', 1), ('Saquon Barkley', 'PA', 20),
('Tyreek Hill', 'FL', 11), ('Jalen Hurts', 'PA', 6),
('CeeDee Lamb', 'TX', 15), ('Micah Parsons', 'TX', 4),
('Derrick Henry', 'TN', 19), ('Christian McCaffrey', 'CA', 7),
('Dak Prescott', 'TX', 25), ('Nick Bosa', 'CA', 10),
('Justin Herbert', 'CA', 2), ('Cooper Kupp', 'CA', 18),
('Davante Adams', 'NV', 21),('Deebo Samuel', 'CA', 16),
('Khalil Mack', 'CA', 23),('T.J. Watt', 'PA', 13),
('Trevor Lawrence', 'FL', 24);

INSERT INTO Orders (CustomerID, OrderDate) 
VALUES
(14, '2022-01-18'), (7, '2022-02-05'),
(22, '2022-03-12'), (3, '2022-04-03'),
(19, '2022-05-21'), (5, '2022-06-14'),
(11, '2022-07-08'), (24, '2022-08-17'),
(9, '2022-09-02'), (16, '2022-10-11'),
(1, '2022-11-24'), (20, '2022-12-05'),
(8, '2022-01-31'), (17, '2022-02-19'),
(4, '2022-03-27'), (23, '2022-04-16'),
(12, '2022-05-09'), (6, '2022-06-22'),
(25, '2022-07-14'), (10, '2022-08-03'),
(18, '2022-09-29'), (2, '2022-10-18'),
(15, '2022-11-07'), (21, '2022-12-19'),
(13, '2022-05-30');

INSERT INTO orderdetail (OrderNUmber, ItemName,
Quantity, PriceUSD)
VALUES
(1000, 'UltraHD TV', 2, 899.99),
(1001, 'Premium Coffee Maker', 1, 349.99),
(1002, 'Wireless Headphones', 1, 299.99),
(1003, 'Robot Vacuum Cleaner', 1, 549.99),
(1004, 'Gaming Laptop', 1, 1899.99),
(1005, 'Air Purifier', 2, 329.99),
(1006, 'Smartphone', 1, 1099.99),
(1007, 'Stand Mixer', 1, 399.99),
(1008, 'Wireless Speaker System', 3, 599.99),
(1009, 'Memory Foam Mattress', 1, 899.99),
(1010, 'Digital Camera', 1, 749.99),
(1011, 'Smart Refrigerator', 1, 2499.99),
(1012, 'Tablet', 2, 649.99),
(1013, 'High-End Blender', 1, 379.99),
(1014, 'Smartwatch', 4, 349.99),
(1015, 'Electric Pressure Cooker', 2, 199.99),
(1016, 'Bluetooth Speaker', 3, 159.99),
(1017, 'Cordless Vacuum', 1, 499.99),
(1018, 'Desktop Computer', 1, 1499.99),
(1019, 'Espresso Machine', 1, 799.99),
(1020, 'Wireless Earbuds', 3, 199.99),
(1021, 'Food Processor', 1, 279.99),
(1022, 'Gaming Console', 1, 499.99),
(1023, 'Smart Thermostat', 2, 249.99),
(1024, 'Office Chair', 1, 699.99);

CREATE VIEW CustomerSalesPerson AS
SELECT c.Name AS CustomerName, c.State, s.FirstName, s.LastName
FROM Customer c
JOIN SalesPerson s ON c.SalesPersonID = s.SalesPersonID;

SELECT * FROM CustomerSalesPerson;

CREATE VIEW ExpensiveItemPerCustomer AS
SELECT c.Name, od.ItemName, MAX(od.PriceUSD) AS MaxPrice
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetail od ON o.OrderNumber = od.OrderNumber
GROUP BY c.Name, od.ItemName;

SELECT * FROM ExpensiveItemPerCustomer;

CREATE VIEW ExpensiveItemPerSalesPerson AS
SELECT s.FirstName, s.LastName, od.ItemName, MAX(od.PriceUSD) AS MaxPrice
FROM SalesPerson s
JOIN Customer c ON s.SalesPersonID = c.SalesPersonID
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetail od ON o.OrderNumber = od.OrderNumber
GROUP BY s.FirstName, s.LastName, od.ItemName;

SELECT * FROM ExpensiveItemPerSalesPerson;

CREATE VIEW TotalPurchasePerCustomer AS
SELECT c.Name, SUM(od.Quantity * od.PriceUSD) AS TotalSpent
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetail od ON o.OrderNumber = od.OrderNumber
GROUP�BY�c.Name;


CREATE FUNCTION ConvertUSDToEUR (@PriceUSD DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @ConversionRate DECIMAL(10,4) = 0.92;
    RETURN @PriceUSD * @ConversionRate;
END;

SELECT 
    OrderDetailID,
    PriceUSD,
    dbo.ConvertUSDToEUR(PriceUSD) AS PriceEUR
FROM 
    OrderDetail;

