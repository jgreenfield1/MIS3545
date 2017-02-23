USE AdventureWorks2012; /*Set current database*/

/*1, Display the total amount collected from the orders for each order date. */
/* Table: Sales.SalesOrderHeader*/
SELECT OrderDate, SUM(TotalDue) as DailyAmount, Count(SalesOrderID) as Daily_Number_of_Orders
FROM Sales.SalesOrderHeader
GROUP BY OrderDate
ORDER BY OrderDate;

/*2, Display the total amount collected from selling the products, 774 and 777. */
/* Table: Sales.SalesOrderDetail*/
SELECT ProductID, SUM(LineTotal) as Total_Amount,
AVG(UnitPrice) as AVG_Unit_Price
FROM Sales.SalesOrderDetail
WHERE ProductID = 774 OR ProductID = 777
GROUP BY ProductID;

/*3, Write a query to display the sales person BusinessEntityID, last name and first name of all the sales persons and the name of the territory to which they belong.*/
SELECT sp.BusinessEntityID, p.LastName, p.FirstName, st.Name as "Territory Name"
FROM Sales.SalesPerson as sp LEFT OUTER JOIN Person.Person as p on sp.BusinessEntityID = p.BusinessEntityID LEFT OUTER JOIN Sales.SalesTerritory as st on st.TerritoryID = sp.TerritoryID; 



/*4,  Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/
SELECT pcc.BusinessEntityID, cc.CardType
FROM Sales.CreditCard as cc LEFT OUTER JOIN Sales.PersonCreditCard as pcc on cc.CreditCardID = pcc.CreditCardID
WHERE CardType = 'Vista';

/*Show the number of customers for each type of credit cards*/
SELECT COUNT(pcc.BusinessEntityID) as 'Number of Customers', cc.CardType
FROM Sales.CreditCard as cc LEFT OUTER JOIN Sales.PersonCreditCard as pcc on cc.CreditCardID = pcc.CreditCardID
GROUP BY cc.CardType;


/*5, Write a query to display ALL the country region codes along with their corresponding territory IDs*/
/* tables: Sales.SalesTerritory,  Person.CountryRegion*/
SELECT CR.CountryRegionCode, CR.Name, ST.TerritoryID
FROM Person.CountryRegion as CR
LEFT JOIN Sales.SalesTerritory as ST
on CR.CountryRegionCode = ST.CountryRegionCode;

SELECT CR.CountryRegionCode, CR.Name, ST.TerritoryID
FROM Person.CountryRegion as CR
LEFT JOIN Sales.SalesTerritory as ST
on CR.CountryRegionCode = ST.CountryRegionCode
WHERE ST.TerritoryID is NULL; /*List all the countries/regions that do not belong to any territory*/



/*6, Find out the average of the total dues of all the orders.*/
/* tables: Sales.SalesOrderHeader*/
SELECT AVG(TotalDue) as 'avg of the total dues'
FROM Sales.SalesOrderHeader;

/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders*/
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue > 
(SELECT AVG(TotalDue)
FROM Sales.SalesOrderHeader)
ORDER By TotalDue;


