CREATE TABLE FactInternetSales (
	ProductKey int not null,
	OrderDateKey int not null,
	DueDateKey int not null,
	ShipDateKey int not null,
	CustomerKey int not null,
	PromotionKey int not null,
	CurrencyKey int not null,
	SalesTerritoryKey int not null,
	SalesOrderNumber int null,
	SalesOrderLineNumber int null,
	OrderQuantity smallint null,
	UnitPrice money null,
	SalesAmount numeric(38,6) null,
	SalesAmountBeforeDiscount money null,
	DiscountAmount money null,
	LastModifiedDateTime datetime null
	);