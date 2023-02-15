-- DimCustomer

CREATE TABLE DimCustomer (
 CustomerKey int not null identity(1,1) primary key,
 CustomerAlternateKey varchar(10) null,
 CustomerType nvarchar(50) null,
 Title nvarchar(8) null,
 FirstName nvarchar(50) null,
 LastName nvarchar(50) null,
 MiddleName nvarchar(50) null,
 Suffix nvarchar(10) null,
 EmailRequest nvarchar(50) null,
 BirthDate date null,
 MaritalStatus nvarchar(10) null,
 YearlyIncome nvarchar(50) null,
 Gender nvarchar(10) null,
 TotalChildren int null,
 NumberChildrenAtHome int null,
 Education nvarchar(50) null,
 Occupation nvarchar(50) null,
 IsHomeOwner bit null,
 NumberCarsOwned int null,
 CommuteDistance nvarchar(50) null,
 StartDate datetime not null default(getdate()),
 EndDate datetime null
 );

ALTER TABLE DimCustomer
ADD CONSTRAINT AK_DimCustomer
UNIQUE (CustomerAlternateKey, StartDate);

SET IDENTITY_INSERT DimCustomer ON;

INSERT INTO DimCustomer (CustomerKey, StartDate) VALUES(-1, '01/01/1900');

SET IDENTITY_INSERT DimCustomer OFF;


