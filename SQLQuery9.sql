USE AdventureWorksLT2022;
GO

DROP VIEW IF EXISTS MyProducts;
GO

CREATE VIEW MyProducts AS
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    p.ListPrice AS UnitPrice,
    p.Size AS QuantityPerUnit,
    c.Name AS CategoryName
FROM SalesLT.Product p
JOIN SalesLT.ProductCategory c ON p.ProductCategoryID = c.ProductCategoryID
WHERE p.DiscontinuedDate IS NULL;
