DROP TRIGGER IF EXISTS trg_CheckStockBeforeInsert;
GO

CREATE TRIGGER trg_CheckStockBeforeInsert
ON SalesLT.SalesOrderDetail
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @ProductID INT, @Quantity INT, @Stock INT;

    SELECT TOP 1 @ProductID = ProductID, @Quantity = OrderQty
    FROM inserted;

    SELECT @Stock = UnitsInStock
    FROM SalesLT.Product
    WHERE ProductID = @ProductID;

    IF @Stock >= @Quantity
    BEGIN
        -- Insert the order
        INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, ProductID, OrderQty, UnitPrice)
        SELECT SalesOrderID, ProductID, OrderQty, UnitPrice FROM inserted;

        -- Decrease the stock
        UPDATE SalesLT.Product
        SET UnitsInStock = UnitsInStock - @Quantity
        WHERE ProductID = @ProductID;
    END
    ELSE
    BEGIN
        PRINT 'Order could not be placed due to insufficient stock.';
    END
END;
