CREATE PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity INT = NULL,
    @Discount FLOAT = NULL
AS
BEGIN
    DECLARE @CurrentUnitPrice MONEY, @CurrentQuantity INT, @CurrentDiscount FLOAT

    SELECT @CurrentUnitPrice = UnitPrice, @CurrentQuantity = Quantity, @CurrentDiscount = Discount
    FROM Sales.OrderDetail
    WHERE OrderID = @OrderID AND ProductID = @ProductID

    IF @CurrentUnitPrice IS NULL
    BEGIN
        PRINT 'Order or Product not found'
        RETURN
    END

    UPDATE Sales.OrderDetail
    SET
        UnitPrice = ISNULL(@UnitPrice, UnitPrice),
        Quantity = ISNULL(@Quantity, Quantity),
        Discount = ISNULL(@Discount, Discount)
    WHERE OrderID = @OrderID AND ProductID = @ProductID

    -- Adjust stock logic here if needed
END