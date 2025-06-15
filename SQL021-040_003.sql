SET GLOBAL log_output = 'TABLE';
SET GLOBAL general_log = 'ON';

SHOW VARIABLES WHERE variable_name = 'log_output';
SHOW VARIABLES WHERE variable_name = 'general_log';


SELECT /* ++A20538828 ++SQL022 */
    bec.ContactTypeID,
    ct.Name AS CTypeName,
    COUNT(*) AS NUMcontacts
FROM BusinessEntityContact AS bec
INNER JOIN ContactType AS ct ON ct.ContactTypeID = bec.ContactTypeID
GROUP BY bec.ContactTypeID, ct.Name
HAVING NUMcontacts >= 100
ORDER BY NUMcontacts DESC;


SELECT /* ++A20538828 ++SQL023 */
    DATE_FORMAT(hur.RateChangeDate, '%Y-%m-%d') AS FromDate,
    CONCAT_WS(', ', per.LastName, per.FirstName, per.MiddleName) AS NameInFull,
    (40 * hur.Rate) AS SalaryInAWeek
FROM 
    Person AS per
INNER JOIN 
    EmployeePayHistory AS hur ON hur.BusinessEntityID = per.BusinessEntityID      
ORDER BY 
    NameInFull;



SELECT /* ++A20538828 ++SQL027 */
	SalesOrderID, SUM(orderqty*unitprice) AS OrderIDCost  
FROM SalesOrderDetail  
GROUP BY SalesOrderID  
HAVING SUM(orderqty*unitprice) > 100000.00  
ORDER BY SalesOrderID;


SELECT /* ++A20538828 ++SQL028 */
	ProductID, NAME 
FROM Product  
WHERE NAME LIKE 'Lock Washer%'  
ORDER BY ProductID; 


SELECT /* ++A20538828 ++SQL029 */
	ProductID, NAME, Color  
FROM Product  
ORDER BY ListPrice;

SELECT /* ++A20538828 ++SQL030 */
    BusinessEntityID, JobTitle, HireDate
FROM Employee
ORDER BY 
    YEAR(HireDate), 
    BusinessEntityID;


SELECT /* ++A20538828 ++SQL031 */
	LastName, FirstName 
FROM Person  
WHERE LastName LIKE 'R%'  
ORDER BY FirstName ASC, LastName DESC;

SELECT /* ++A20538828 ++SQL032 */
	BusinessEntityID, SalariedFlag  
FROM Employee  
ORDER BY CASE SalariedFlag WHEN 'true' THEN BusinessEntityID END DESC  
        ,CASE WHEN SalariedFlag ='false' THEN BusinessEntityID END;



SELECT /* ++A20538828 ++SQL033 */
    sp.BusinessEntityID, p.LastName, st.Name AS TerritoryName, c.Name AS CountryRegionName
FROM COUNTRYREGION AS c 
INNER JOIN SalesTERRITORY AS st ON c.CountryRegionCode = st.CountryRegionCode
INNER JOIN SALESPERSON AS sp ON st.TerritoryID = sp.TerritoryID 
INNER JOIN PERSON AS p ON p.BusinessEntityID = sp.BusinessEntityID
WHERE sp.TerritoryID IS NOT NULL  
ORDER BY 
    CASE 
        WHEN c.CountryRegionCode = 'United States' THEN st.Name
        ELSE c.CountryRegionCode END;

         


SELECT /* ++A20538828 ++SQL035 */
	DepartmentID, NAME, GroupName  
FROM Department  
ORDER BY DepartmentID LIMIT 10, 20;


SELECT /* ++A20538828 ++SQL036 */
	DepartmentID, NAME, GroupName  
FROM Department  
ORDER BY DepartmentID   
    LIMIT 5, 5 ;



SELECT /* ++A20538828 ++SQL037 */
NAME, Color, ListPrice  
FROM Product  
WHERE Color = 'Red'  
UNION ALL  
SELECT NAME, Color, ListPrice  
FROM Product  
WHERE Color = 'Blue'  
ORDER BY ListPrice ASC;



SELECT /* ++A20538828 ++SQL038 */
    p.Name, sod.SalesOrderID
FROM Product AS p
LEFT JOIN SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
UNION
SELECT 
    NULL AS NAME, sod.SalesOrderID
FROM SalesOrderDetail AS sod
WHERE sod.ProductID IS NULL
UNION
SELECT 
    p.Name, NULL AS SalesOrderID
FROM Product AS p
RIGHT JOIN SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
WHERE p.ProductID IS NULL
ORDER BY NAME;



SELECT /* ++A20538828 ++SQL039 */
	p.Name, sod.SalesOrderID  
FROM Product AS p  
LEFT OUTER JOIN SalesOrderDetail AS sod  
ON p.ProductID = sod.ProductID  
ORDER BY p.Name ;



SELECT /* ++A20538828 ++SQL040 */
	p.Name, sod.SalesOrderID  
FROM Product AS p  
INNER JOIN SalesOrderDetail AS sod  
ON p.ProductID = sod.ProductID  
ORDER BY p.Name ;


SELECT *	
FROM mysql.general_log
WHERE command_type = 'Query'
AND argument LIKE '%++SQL%'
AND argument NOT LIKE '%general_log%'
ORDER BY event_time DESC;