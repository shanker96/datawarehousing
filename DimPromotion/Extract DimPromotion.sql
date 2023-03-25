-- DimPromotion

SELECT
	SpecialOfferID as PromotionAlternateKey,
	Description,
	DiscountPct as DiscountPercent,
	Type,
	Category,
	StartDate as PromotionStartDate,
	EndDate as PromotionEndDate,
	MinQty as MinimumQuantity,
	MaxQty as MaximumQuantity
FROM Sales.SpecialOffer;