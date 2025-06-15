SET GLOBAL log_output = 'TABLE';
SET GLOBAL general_log = 'ON';

SHOW VARIABLES WHERE variable_name = 'log_output';
SHOW VARIABLES WHERE variable_name = 'general_log';


-- 141

SELECT /* ++A20538828 ++SQL141 */
    ProductID, UnitPrice, OrderQty, FLOOR(UnitPrice) % OrderQty AS Modulo 
FROM SalesOrderDetail;


-- 142

SELECT /* ++A20538828 ++SQL142 */
	BusinessEntityID, LoginID, JobTitle, VacationHours   
FROM Employee  
WHERE JobTitle = 'Marketing Assistant'  
AND VacationHours > 41 ;


-- 144

SELECT /* ++A20538828 ++SQL144 */
	BusinessEntityID, RateChangeDate  
FROM EmployeePayHistory  
WHERE RateChangeDate BETWEEN '20111212' AND '20120105';


-- 146

SELECT /* ++A20538828 ++SQL146 */
	a.FirstName, a.LastName  
FROM Person AS a  
WHERE EXISTS  
(SELECT *   
    FROM Employee AS b  
    WHERE a.BusinessEntityID = b.BusinessEntityID  
    AND a.LastName = 'Johnson') ; 


-- 147

SELECT /* ++A20538828 ++SQL147 */
	DISTINCT s.Name  
FROM Store AS s   
WHERE s.Name = ANY  
(SELECT v.Name  
    FROM Vendor AS v ) ;	


-- 148

SELECT /* ++A20538828 ++SQL148 */
	p.FirstName, p.LastName, e.JobTitle  
FROM Person AS p JOIN Employee AS e  
   ON e.BusinessEntityID = p.BusinessEntityID   
JOIN EmployeeDepartmentHistory AS edh  
   ON e.BusinessEntityID = edh.BusinessEntityID   
WHERE edh.DepartmentID IN  
(SELECT DepartmentID  
   FROM Department  
   WHERE NAME LIKE 'P%') ;


-- 149

SELECT /* ++A20538828 ++SQL149 */
	p.FirstName, p.LastName, e.JobTitle  
FROM Person AS p   
JOIN Employee AS e  
   ON e.BusinessEntityID = p.BusinessEntityID   
WHERE NOT EXISTS  
(SELECT *  
   FROM Department AS d  
   JOIN EmployeeDepartmentHistory AS edh  
      ON d.DepartmentID = edh.DepartmentID  
   WHERE e.BusinessEntityID = edh.BusinessEntityID  
   AND d.Name LIKE 'P%')  
ORDER BY LastName, FirstName  ;


-- 150

SELECT /* ++A20538828 ++SQL150 */
	p.FirstName, p.LastName, e.JobTitle  
FROM Person AS p  
JOIN Employee AS e  
    ON p.BusinessEntityID = e.BusinessEntityID  
WHERE e.JobTitle IN ('Design Engineer', 'Tool Designer', 'Marketing Assistant');


-- 151

SELECT /* ++A20538828 ++SQL151 */
	p.FirstName, p.LastName  
FROM Person AS p  
    JOIN SalesPerson AS sp  
    ON p.BusinessEntityID = sp.BusinessEntityID  
WHERE p.BusinessEntityID IN  
   (SELECT BusinessEntityID  
   FROM SalesPerson  
   WHERE SalesQuota > 250000);


-- 152

SELECT /* ++A20538828 ++SQL152 */
	p.FirstName, p.LastName  
FROM Person AS p  
    JOIN SalesPerson AS sp  
    ON p.BusinessEntityID = sp.BusinessEntityID  
WHERE p.BusinessEntityID NOT IN  
   (SELECT BusinessEntityID  
   FROM SalesPerson  
   WHERE SalesQuota > 250000);


-- 153

SELECT /* ++A20538828 ++SQL153 */ * 
	FROM salesorderheadersalesreason  
WHERE salesreasonid   
IN (SELECT salesreasonid  FROM SalesReason);


-- 154

SELECT /* ++A20538828 ++SQL154 */
	p.FirstName, p.LastName, ph.PhoneNumber  
FROM PersonPhone AS ph  
INNER JOIN Person AS p  
ON ph.BusinessEntityID = p.BusinessEntityID  
WHERE ph.PhoneNumber LIKE '415%'  
ORDER BY p.LastName;


-- 155

SELECT /* ++A20538828 ++SQL155 */
	p.FirstName, p.LastName, ph.PhoneNumber  
FROM PersonPhone AS ph  
INNER JOIN Person AS p  
ON ph.BusinessEntityID = p.BusinessEntityID  
WHERE ph.PhoneNumber NOT LIKE '415%' AND p.FirstName = 'Gail'  
ORDER BY p.LastName;


-- 156

SELECT /* ++A20538828 ++SQL156 */
	ProductID, NAME, Color, StandardCost  
FROM Product  
WHERE ProductNumber LIKE 'BK-%' AND Color = 'Silver' AND NOT StandardCost > 400;


-- 158

SELECT /* ++A20538828 ++SQL158 */
	FirstName, LastName  
FROM Person  
WHERE FirstName LIKE '_an'  
ORDER BY FirstName;



SELECT *	
FROM mysql.general_log
WHERE command_type = 'Query'
AND argument LIKE '%++SQL%'
AND argument NOT LIKE '%general_log%'
ORDER BY event_time DESC;