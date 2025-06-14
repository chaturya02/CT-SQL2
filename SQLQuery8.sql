DROP VIEW IF EXISTS vwCustomerOrdersYesterday;
GO

CREATE VIEW vwCustomerOrdersYesterday AS
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
JOIN SalesLT.Customer c ON soh.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN SalesLT.Product p ON sod.ProductID = p.ProductID
WHERE CAST(soh.OrderDate AS DATE) = CAST(GETDATE() - 1 AS DATE);
