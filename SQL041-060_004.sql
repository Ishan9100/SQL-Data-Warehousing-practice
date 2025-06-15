SET GLOBAL log_output = 'TABLE';
SET GLOBAL general_log = 'ON';

SHOW VARIABLES WHERE variable_name = 'log_output';
SHOW VARIABLES WHERE variable_name = 'general_log';


SELECT /* ++A20538828 ++SQL041 */
	t.Name AS Territory, p.BusinessEntityID  
FROM SalesTerritory AS t   
RIGHT OUTER JOIN SalesPerson AS p  
ON t.TerritoryID = p.TerritoryID ;



SELECT /* ++A20538828 ++SQL042 */
	CONCAT(RTRIM(p.FirstName),' ', LTRIM(p.LastName)) AS Full_Name, a.City  
FROM Person AS p  
INNER JOIN Employee e ON p.BusinessEntityID = e.BusinessEntityID   
INNER JOIN BusinessEntityAddress AS bea ON p.BusinessEntityID = bea.BusinessEntityID
INNER JOIN Address AS a ON bea.AddressID = a.AddressID
ORDER BY p.LastName, p.FirstName;



SELECT /* ++A20538828 ++SQL043 */
businessentityid, firstname,lastname  
FROM (SELECT * FROM person WHERE persontype = 'IN') AS personDerivedTable 
WHERE lastname = 'Adams'  
ORDER BY firstname;



SELECT /* ++A20538828 ++SQL044 */
	businessentityid, firstname,LastName  
FROM person 
WHERE businessentityid <= 1500 AND LastName LIKE '%Al%' AND FirstName LIKE '%M%';



WITH SalesData (SalesPersonID, SalesOrderID, SalesYear)
AS
(
    SELECT /* ++A20538828 ++SQL046 */
    SalesPersonID, SalesOrderID, EXTRACT(YEAR FROM OrderDate) AS SalesYear
    FROM SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM SalesData
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;



WITH SalesData (SalesPersonID, NumberOfOrders)
AS
(
    SELECT /* ++A20538828 ++SQL047 */
	SalesPersonID, COUNT(*)
    FROM SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
    GROUP BY SalesPersonID
)
SELECT AVG(NumberOfOrders) AS "Average Sales Per Person"
FROM SalesData;


SELECT /* ++A20538828 ++SQL049 */
	AddressLine1, AddressLine2, City, PostalCode, CountryRegionCode    
FROM Address AS a  
JOIN StateProvince AS s ON a.StateProvinceID = s.StateProvinceID  
WHERE CountryRegionCode NOT IN ('US')  
AND City LIKE 'Pa%';



SELECT /* ++A20538828 ++SQL050 */
	JobTitle, HireDate  
FROM Employee
ORDER BY HireDate DESC
LIMIT 20;



SELECT /* ++A20538828 ++SQL051 */ *  
FROM SalesOrderHeader AS soh  
INNER JOIN SalesOrderDetail AS sod 
    ON soh.SalesOrderID = sod.SalesOrderID   
WHERE soh.TotalDue > 100  
AND (sod.OrderQty > 5 OR sod.unitpricediscount < 1000.00);



SELECT /* ++A20538828 ++SQL059 */
	NAME, LOCATE('Yellow', NAME) AS "String Position" 
FROM product
WHERE LOCATE('Yellow', NAME)>0;



SELECT /* ++A20538828 ++SQL060 */
	CONCAT_WS(', ', NAME, '   color:-',color,' Product Number:', productnumber ) AS result, color
FROM product;



SELECT *	
FROM mysql.general_log
WHERE command_type = 'Query'
AND argument LIKE '%++SQL%'
AND argument NOT LIKE '%general_log%'
ORDER BY event_time DESC;

