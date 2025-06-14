USE AdventureWorksLT2022;
GO
DROP VIEW IF EXISTS vwCustomerOrders;
GO

CREATE VIEW vwCustomerOrders AS
SELECT
    c.CompanyName,
    soh.SalesOrderID AS OrderID,
    soh.OrderDate,
    sod.ProductID,
    p.Name AS ProductName,
    sod.OrderQty AS Quantity,
    sod.UnitPrice,
    (sod.OrderQty * sod.UnitPrice) AS TotalPrice
FROM SalesLT.SalesOrderHeader soh
JOIN SalesLT.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN SalesLT.Product p ON sod.ProductID = p.ProductID
JOIN SalesLT.Customer c ON soh.CustomerID = c.CustomerID;
