
-- data flow source query
SELECT
	a.SalesOrderId as SalesOrderNumber,
	b.SalesOrderDetailID as SalesOrderLineNumber,
	c.ProductNumber as ProductAlternateKey,
	b.SpecialOfferID as PromotionAlternateKey,
	cast(a.OrderDate as date) as OrderDateAlternateKey,
	cast(a.DueDate as date) as DueDateAlternateKey,
	cast(a.ShipDate as date) as ShipDateAlternateKey,
	d.AccountNumber as CustomerAlternateKey,
	a.TerritoryID as SalesTerritoryAlternateKey,
	N'USD' as CurrencyAlternateKey,
	b.OrderQty as OrderQuantity,
	b.OrderQty * UnitPrice as SalesAmountBeforeDiscount,
	b.OrderQty * UnitPrice * UnitPriceDiscount as DiscountAmount,
	b.UnitPrice,
	b.LineTotal as SalesAmount,
	IIF(a.ModifiedDate > b.ModifiedDate, a.ModifiedDate, b.ModifiedDate) as LastModifiedDateTime
FROM Sales.SalesOrderHeader a
INNER JOIN Sales.SalesOrderDetail b
	ON	a.SalesOrderId=b.SalesOrderId
LEFT OUTER JOIN Production.Product c
	ON	b.ProductID=c.ProductID
LEFT OUTER JOIN Sales.Customer d
	ON	a.CustomerId=d.CustomerId
WHERE
	a.OnlineOrderFlag = 1 AND (
		a.ModifiedDate >= ? OR 
		b.ModifiedDate >= ?
		);
		

-- get last modified date time		
SELECT coalesce(max(LastModifiedDateTime), cast('01/01/1900' as date)) as LastModifiedDateTime
FROM FactInternetSales;


-- lookup queries

SELECT 
	ProductKey,
	ProductAlternateKey
FROM DimProduct
WHERE EndDate Is Null;

SELECT 
	PromotionKey,
	PromotionAlternateKey
FROM DimPromotion
WHERE EndDate Is Null;

SELECT 
	SalesTerritoryKey,
	SalesTerritoryAlternateKey
FROM DimSalesTerritory;

SELECT 
	CustomerKey,
	CustomerAlternateKey
FROM DimCustomer
WHERE EndDate Is Null;

SELECT 
	CurrencyKey,
	CurrencyAlternateKey
FROM DimCurrency;

SELECT 
	DateKey,
	FullDateAlternateKey
FROM DimDate;


-- staging merge
merge	FactInternetSales as target
using	staging_FactInternetSales as source
	on	coalesce(source.SalesOrderNumber,-1)=coalesce(target.SalesOrderNumber,-1) AND
		coalesce(source.SalesOrderLineNumber,-1)=coalesce(target.SalesOrderLineNumber,-1)
when matched then 
	update set
		ProductKey=source.ProductKey,
		OrderDateKey=source.OrderDateKey,
		DueDateKey=source.DueDateKey,
		ShipDateKey=source.ShipDateKey,
		CustomerKey=source.CustomerKey,
		PromotionKey=source.PromotionKey,
		CurrencyKey=source.CurrencyKey,
		SalesTerritoryKey=source.SalesTerritoryKey,
		OrderQuantity=source.OrderQuantity,
		UnitPrice=source.UnitPrice,
		SalesAmount=source.SalesAmount,
		SalesAmountBeforeDiscount=source.SalesAmountBeforeDiscount,
		DiscountAmount=source.DiscountAmount,
		LastModifiedDateTime=source.LastModifiedDateTime
when not matched then 
	insert (
		SalesOrderNumber,
		SalesOrderLineNumber,
		ProductKey,
		OrderDateKey,
		DueDateKey,
		ShipDateKey,
		CustomerKey,
		PromotionKey,
		CurrencyKey,
		SalesTerritorykey,
		OrderQuantity,
		UnitPrice,
		SalesAmount,
		SalesAmountBeforeDiscount,
		DiscountAmount,
		LastModifiedDateTime
		)
	values(
		COALESCE(source.SalesOrderNumber,-1),
		COALESCE(source.SalesOrderLineNumber,-1),
		source.ProductKey,
		source.OrderDateKey,
		source.DueDateKey,
		source.ShipDateKey,
		source.CustomerKey,
		source.PromotionKey,
		source.CurrencyKey,
		source.SalesTerritorykey,
		source.OrderQuantity,
		source.UnitPrice,
		source.SalesAmount,
		source.SalesAmountBeforeDiscount,
		source.DiscountAmount,
		source.LastModifiedDateTime
		);



-- staging truncate 

truncate table staging_FactInternetSales;