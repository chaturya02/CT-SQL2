USE AdventureWorksLT2022;
GO

DROP TRIGGER IF EXISTS trg_DeleteOrder;
GO

CREATE TRIGGER trg_DeleteOrder
ON SalesLT.SalesOrderHeader
INSTEAD OF DELETE
AS
BEGIN
    DELETE FROM SalesLT.SalesOrderDetail
    WHERE SalesOrderID IN (SELECT SalesOrderID FROM deleted);

    DELETE FROM SalesLT.SalesOrderHeader
    WHERE SalesOrderID IN (SELECT SalesOrderID FROM deleted);
END;
