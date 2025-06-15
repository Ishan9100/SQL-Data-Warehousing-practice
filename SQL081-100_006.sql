SET GLOBAL log_output = 'TABLE';
SET GLOBAL general_log = 'ON';

SHOW VARIABLES WHERE variable_name = 'log_output';
SHOW VARIABLES WHERE variable_name = 'general_log';



SELECT /* ++A20538828 ++SQL081 */
    SalesYTD, CommissionPCT, ROUND(SalesYTD / NULLIF(CommissionPCT, 0), 0) AS Computed
FROM SalesPerson
WHERE CommissionPCT != 0;



SELECT /* ++A20538828 ++SQL082 */
    p.FirstName, p.LastName, CONVERT(s.SalesYTD, CHAR(20)) AS SalesYTD, s.BusinessEntityID
FROM Person AS p
JOIN SalesPerson AS s
ON p.BusinessEntityID = s.BusinessEntityID
WHERE CONVERT(s.SalesYTD, CHAR(20)) LIKE '2%';



SELECT /* ++A20538828 ++SQL083 */
    SUBSTRING(NAME, 1, 16) AS NAME, ListPrice  
FROM Product  
WHERE NAME LIKE 'Long-Sleeve Logo Jersey%';



SELECT /* ++A20538828 ++SQL084 */
    productid, UnitPrice, UnitPriceDiscount,  
    CAST(ROUND(UnitPrice * UnitPriceDiscount, 2) AS DECIMAL(10, 2)) AS DiscountPrice  
FROM salesorderdetail  
WHERE SalesOrderid = 46672   
    AND UnitPriceDiscount > 0.02;




SELECT /* ++A20538828 ++SQL085 */
    AVG(VacationHours) AS `Average vacation hours`,   
    SUM(SickLeaveHours) AS `Total sick leave hours`  
FROM Employee  
WHERE JobTitle LIKE 'Vice President%';




SELECT /* ++A20538828 ++SQL086 */
    TerritoryID, AVG(Bonus) AS `Average bonus`, SUM(SalesYTD) AS `YTD sales`  
FROM SalesPerson  
GROUP BY TerritoryID;



SELECT  /* ++A20538828 ++SQL088 */
    sp.BusinessEntityID, sp.TerritoryID, YEAR(sp.ModifiedDate) AS SalesYear, FORMAT(sp.SalesYTD, 2) AS SalesYTD,
    (SELECT AVG(sp2.SalesYTD)
     FROM SalesPerson sp2
     WHERE sp2.TerritoryID = sp.TerritoryID
       AND YEAR(sp2.ModifiedDate) <= YEAR(sp.ModifiedDate)) AS MovingAvg,
    (SELECT SUM(sp3.SalesYTD)
     FROM SalesPerson sp3
     WHERE sp3.TerritoryID = sp.TerritoryID
       AND YEAR(sp3.ModifiedDate) <= YEAR(sp.ModifiedDate)) AS CumulativeTotal
FROM 
    SalesPerson sp
WHERE 
    sp.TerritoryID IS NULL OR sp.TerritoryID < 5
ORDER BY 
    sp.TerritoryID, SalesYear;




SELECT /* ++A20538828 ++SQL089 */
     BusinessEntityID, TerritoryID, YEAR(ModifiedDate) AS SalesYear, SalesYTD,
    (SELECT AVG(SalesYTD)
     FROM SalesPerson sp2
     WHERE YEAR(sp2.ModifiedDate) <= YEAR(sp.ModifiedDate)) AS MovingAvg,
    (SELECT SUM(SalesYTD)
     FROM SalesPerson sp3
     WHERE YEAR(sp3.ModifiedDate) <= YEAR(sp.ModifiedDate)) AS CumulativeTotal
FROM 
    SalesPerson sp
WHERE 
    TerritoryID IS NOT NULL
ORDER BY SalesYear;




SELECT /* ++A20538828 ++SQL090 */
	COUNT(DISTINCT jobTitle) AS "Number of Jobtitles" 
FROM Employee;



SELECT /* ++A20538828 ++SQL091 */
	COUNT(*)  AS "Number of Employees"
FROM Employee;



SELECT /* ++A20538828 ++SQL092 */
	COUNT(*), AVG(Bonus)  
FROM SalesPerson  
WHERE SalesQuota > 25000;



SELECT /* ++A20538828 ++SQL093 */
	DISTINCT NAME  
       , MIN(Rate) OVER (PARTITION BY edh.DepartmentID) AS MinSalary  
       , MAX(Rate) OVER (PARTITION BY edh.DepartmentID) AS MaxSalary  
       , AVG(Rate) OVER (PARTITION BY edh.DepartmentID) AS AvgSalary  
       ,COUNT(edh.BusinessEntityID) OVER (PARTITION BY edh.DepartmentID) AS EmployeesPerDept  
FROM EmployeePayHistory AS eph  
JOIN EmployeeDepartmentHistory AS edh  
     ON eph.BusinessEntityID = edh.BusinessEntityID  
JOIN Department AS d  
ON d.DepartmentID = edh.DepartmentID
WHERE edh.EndDate IS NULL  
ORDER BY NAME;



SELECT /* ++A20538828 ++SQL094 */
	jobtitle,   
       COUNT(businessentityid) AS EmployeesInDesig  
FROM employee e  
GROUP BY jobtitle  
HAVING COUNT(businessentityid) > 15;



SELECT /* ++A20538828 ++SQL098 */
	Color, SUM(ListPrice), SUM(StandardCost)  
FROM Product  
WHERE Color IS NOT NULL   
    AND ListPrice != 0.00   
    AND NAME LIKE 'Mountain%'  
GROUP BY Color  
ORDER BY Color;



SELECT /* ++A20538828 ++SQL100 */
	Color, SUM(ListPrice)AS TotalList,   
       SUM(StandardCost) AS TotalCost  
FROM product  
GROUP BY Color  
ORDER BY Color;



SELECT *	
FROM mysql.general_log
WHERE command_type = 'Query'
AND argument LIKE '%++SQL%'
AND argument NOT LIKE '%general_log%'
ORDER BY event_time DESC;