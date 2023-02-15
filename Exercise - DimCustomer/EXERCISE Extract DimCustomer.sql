-- DimCustomer

SELECT
	a.AccountNumber as CustomerAlternateKey
	,b.PersonType
	,b.Title
	,b.FirstName
	,b.LastName
	,b.MiddleName
	,b.Suffix
	,b.EmailPromotion
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:BirthDate)[1]', 'date'
		) as BirthDate
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:MaritalStatus)[1]', 'nvarchar(10)'
		) as MaritalStatus 
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:YearlyIncome)[1]', 'nvarchar(50)'
		) as YearlyIncome
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:Gender)[1]', 'nvarchar(10)'
		) as Gender
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:TotalChildren)[1]', 'int'
		) as TotalChildren
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:NumberChildrenAtHome)[1]', 'int'
		) as NumberChildrenAtHome
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:Education)[1]', 'nvarchar(50)'
		) as Education
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:Occupation)[1]', 'nvarchar(50)'
		) as Occupation
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:HomeOwnerFlag)[1]', 'bit'
		) as IsHomeOwner
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:NumberCarsOwned)[1]', 'int'
		) as NumberOfCarsOwned
	,b.Demographics.value(
		'declare namespace ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
		(/ns:IndividualSurvey/ns:CommuteDistance)[1]', 'nvarchar(50)'
		) as CommuteDistance 
FROM Sales.Customer a
LEFT OUTER JOIN Person.Person b
	ON	a.PersonId=b.BusinessEntityId;
	
