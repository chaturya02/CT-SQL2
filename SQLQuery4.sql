CREATE PROCEDURE DeleteOrderDetails
    @OrderID INT,
    @ProductID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sales.OrderDetail WHERE OrderID = @OrderID AND ProductID = @ProductID)
    BEGIN
        PRINT 'Invalid OrderID or ProductID'
        RETURN -1
    END

    DELETE FROM Sales.OrderDetail
    WHERE OrderID = @OrderID AND ProductID = @ProductID
END
