-- DimPromotion

CREATE TABLE DimPromotion (
 PromotionKey int not null identity(1,1) primary key,
 PromotionAlternateKey int null,
 Description nvarchar(255) null, 
 DiscountPercent smallmoney null, 
 Type nvarchar(50) null,
 Category nvarchar(50) null,
 PromotionStartDate datetime null,
 PromotionEndDate datetime null,
 MinimumQuantity int null,
 MaximumQuantity int null,
 StartDate datetime not null default(getdate()),
 EndDate datetime null
 );
 
 ALTER TABLE DimPromotion
 ADD CONSTRAINT AK_DimPromotion
 UNIQUE (PromotionAlternateKey, StartDate);
 
 SET IDENTITY_INSERT DimPromotion ON;
 
 INSERT INTO DimPromotion (PromotionKey, StartDate) VALUES(-1, '01/01/1900');
 
 SET IDENTITY_INSERT DimPromotion OFF;

