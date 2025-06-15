SET GLOBAL log_output = 'TABLE';
SET GLOBAL general_log = 'ON';

SHOW VARIABLES WHERE variable_name = 'log_output';
SHOW VARIABLES WHERE variable_name = 'general_log';



SELECT /* ++A20538828 ++SQL101 */
    edh.DepartmentID, e.Rate,
    CUME_DIST() OVER (PARTITION BY edh.DepartmentID ORDER BY e.Rate) AS CumeDist,
    PERCENT_RANK() OVER (PARTITION BY edh.DepartmentID ORDER BY e.Rate) AS PctRank
FROM EmployeeDepartmentHistory AS edh
INNER JOIN EmployeePayHistory AS e
    ON e.BusinessEntityID = edh.BusinessEntityID
WHERE edh.DepartmentID IN ('11', '12')
ORDER BY edh.DepartmentID ASC, e.Rate DESC;



SELECT /* ++A20538828 ++SQL102 */
	NAME, ListPrice, FIRST_VALUE(NAME) OVER (ORDER BY ListPrice ASC) AS LeastExpensive
FROM Product
WHERE ProductSubcategoryID = 37;



SELECT /* ++A20538828 ++SQL103 */
	JobTitle, LastName, VacationHours,
       FIRST_VALUE(LastName) OVER (PARTITION BY JobTitle
                                   ORDER BY VacationHours ASC
                                   ROWS UNBOUNDED PRECEDING
                                  ) AS FewestVacationHours
FROM Employee AS e
INNER JOIN Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY JobTitle;



SELECT /* ++A20538828 ++SQL104 */
    BusinessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS CurrentQuota,
    (
        SELECT COALESCE(SalesQuota, 0)
        FROM SalesPersonQuotaHistory AS sub
        WHERE sub.BusinessEntityID = main.BusinessEntityID
		AND YEAR(sub.QuotaDate) = YEAR(main.QuotaDate) - 1
        ORDER BY sub.QuotaDate DESC
        LIMIT 1
    ) AS PreviousQuota
FROM SalesPersonQuotaHistory AS main
WHERE BusinessEntityID = 275
    AND YEAR(QuotaDate) IN (2012, 2013);




SELECT /* ++A20538828 ++SQL105 */
    TerritoryID, BusinessEntityID, SalesYTD,   
       LAG (SalesYTD, 1, 0) OVER (PARTITION BY TerritoryID ORDER BY SalesYTD DESC) AS PrevRepSales  
FROM SalesPerson  
WHERE TerritoryID IN ('1', '6')   
ORDER BY TerritoryID LIMIT 0, 1000;



SELECT /* ++A20538828 ++SQL106 */
	DepartmentID, Rate, HireDate, LAST_VALUE(HireDate) OVER (
        PARTITION BY DepartmentID ORDER BY Rate) AS LastValue
FROM EmployeeDepartmentHistory AS edh
INNER JOIN EmployeePayHistory AS eph
    ON eph.BusinessEntityID = edh.BusinessEntityID
INNER JOIN Employee AS e
    ON e.BusinessEntityID = edh.BusinessEntityID
WHERE DepartmentID IN ('11', '12');



SELECT /* ++A20538828 ++SQL107 */
    BusinessEntityID, QUARTER(QuotaDate) AS QUARTER, YEAR(QuotaDate) AS SalesYear, SalesQuota AS QuotaThisQuarter,
    SalesQuota - 
        MIN(SalesQuota) OVER (PARTITION BY BusinessEntityID, YEAR(QuotaDate)
                              ORDER BY QUARTER(QuotaDate)
                              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS DifferenceFromFirstQuarter,
    SalesQuota - 
        MAX(SalesQuota) OVER (PARTITION BY BusinessEntityID, YEAR(QuotaDate)
                              ORDER BY QUARTER(QuotaDate)
                              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS DifferenceFromLastQuarter
FROM SalesPersonQuotaHistory
WHERE YEAR(QuotaDate) > 2005
    AND BusinessEntityID BETWEEN 274 AND 275
ORDER BY BusinessEntityID, SalesYear, QUARTER;




SELECT /* ++A20538828 ++SQL108 */
	YEAR(quotadate) AS YEAR, QUARTER(quotadate) AS QUARTER, SalesQuota,
       VAR_POP(SalesQuota) OVER (ORDER BY YEAR(quotadate), QUARTER(quotadate)) AS VARIANCE
FROM salespersonquotahistory
WHERE businessentityid = 277 AND YEAR(quotadate) = 2012
ORDER BY YEAR(quotadate), QUARTER(quotadate);


SELECT /* ++A20538828 ++SQL109 */
	BusinessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS CurrentQuota,
       LEAD(SalesQuota, 1, 0) OVER (ORDER BY YEAR(QuotaDate)) AS NextQuota
FROM SalesPersonQuotaHistory
WHERE BusinessEntityID = 277 AND YEAR(QuotaDate) IN (2011, 2012);



SELECT /* ++A20538828 ++SQL110 */
	TerritoryID, BusinessEntityID, SalesYTD,   
       LEAD (SalesYTD, 1, 0) OVER (PARTITION BY TerritoryID ORDER BY SalesYTD DESC) AS NextRepSales  
FROM SalesPerson  
WHERE TerritoryID IN ('1', '6')   
ORDER BY TerritoryID; 


SELECT /* ++A20538828 ++SQL111 */
	YEAR(quotadate) AS YEAR, QUARTER(quotadate) AS QUARTER, SalesQuota,
       LEAD(SalesQuota, 1, 0) OVER (ORDER BY YEAR(quotadate), QUARTER(quotadate)) AS NextQuota,
       SalesQuota - LEAD(SalesQuota, 1, 0) OVER (ORDER BY YEAR(quotadate), QUARTER(quotadate)) AS Diff
FROM salespersonquotahistory
WHERE businessentityid = 277 AND YEAR(quotadate) IN (2012, 2013)
ORDER BY YEAR(quotadate), QUARTER(quotadate);



SELECT /* ++A20538828 ++SQL112 */
	DepartmentID, Rate,
       CUME_DIST() OVER (PARTITION BY DepartmentID ORDER BY Rate) AS CumeDist,
       PERCENT_RANK() OVER (PARTITION BY DepartmentID ORDER BY Rate) AS PctRank
FROM EmployeeDepartmentHistory AS edh
INNER JOIN EmployeePayHistory AS e
ON e.BusinessEntityID = edh.BusinessEntityID
WHERE DepartmentID IN ('11', '12')
ORDER BY DepartmentID, Rate DESC;



SELECT /* ++A20538828 ++SQL113 */
    SalesOrderID, OrderDate, DATE_ADD(OrderDate, INTERVAL 2 DAY) AS PromisedShipDate
FROM salesorderheader LIMIT 1000;



SELECT /* ++A20538828 ++SQL114 */
	p.FirstName, p.LastName, (NOW() + INTERVAL 2 DAY) AS "New Date"
FROM SalesPerson AS s
INNER JOIN Person AS p
    ON s.BusinessEntityID = p.BusinessEntityID
INNER JOIN Address AS a
    ON a.AddressID = p.BusinessEntityID
WHERE TerritoryID IS NOT NULL
    AND SalesYTD <> 0;



SELECT /* ++A20538828 ++SQL115 */
	MAX(OrderDate) - MIN(OrderDate) FROM SalesOrderHeader LIMIT 0, 1000;


SELECT /* ++A20538828 ++SQL116 */
    i.LocationID, i.ProductID, i.Quantity,
    RANK() OVER (PARTITION BY i.LocationID ORDER BY i.Quantity DESC) AS RankValue
FROM ProductInventory AS i   
INNER JOIN Product AS p   
    ON i.ProductID = p.ProductID  
WHERE i.LocationID BETWEEN 3 AND 4  
ORDER BY i.LocationID;


	
SELECT /* ++A20538828 ++SQL117 */
	BusinessEntityID, Rate,   
       RANK() OVER (ORDER BY Rate DESC) AS RankBySalary  
FROM EmployeePayHistory
LIMIT 10;



SELECT /* ++A20538828 ++SQL119 */
    i.ProductID, p.Name, i.LocationID, i.Quantity,
    RANK() OVER (PARTITION BY i.LocationID ORDER BY i.Quantity DESC) AS Ranking
FROM ProductInventory AS i   
INNER JOIN Product AS p   
    ON i.ProductID = p.ProductID  
WHERE i.LocationID BETWEEN 3 AND 4  
ORDER BY i.LocationID;



