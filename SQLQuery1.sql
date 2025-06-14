DROP PROCEDURE IF EXISTS InsertOrderDetails;
GO
CREATE PROCEDURE InsertOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity INT,
    @Discount FLOAT = 0
AS
BEGIN
    DECLARE @Stock INT, @ReorderLevel INT, @DefaultUnitPrice MONEY

    SELECT @Stock = p.UnitsInStock, @ReorderLevel = p.ReorderLevel, @DefaultUnitPrice = p.UnitPrice
    FROM Production.Product p
    WHERE p.ProductID = @ProductID

    IF @Stock IS NULL
    BEGIN
        PRINT 'Invalid ProductID'
        RETURN
    END

    IF @Stock < @Quantity
    BEGIN
        PRINT 'Insufficient stock'
        RETURN
    END

    IF @UnitPrice IS NULL
        SET @UnitPrice = @DefaultUnitPrice

    INSERT INTO Sales.OrderDetail(OrderID, ProductID, UnitPrice, Quantity, Discount)
    VALUES (@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount)

    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'Failed to place the order. Please try again.'
    END
    ELSE
    BEGIN
        UPDATE Production.Product
        SET UnitsInStock = UnitsInStock - @Quantity
        WHERE ProductID = @ProductID

        IF (@Stock - @Quantity) < @ReorderLevel
        BEGIN
            PRINT 'Warning: Quantity in stock below Reorder Level.'
        END
    END
END