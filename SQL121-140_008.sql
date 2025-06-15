SET GLOBAL log_output = 'TABLE';
SET GLOBAL general_log = 'ON';

SHOW VARIABLES WHERE variable_name = 'log_output';
SHOW VARIABLES WHERE variable_name = 'general_log';


-- 122

WITH OrderedOrders AS  
(  
    SELECT SalesOrderID, OrderDate,  
    ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNumber  
    FROM SalesOrderHeader   
)   
SELECT /* ++A20538828 ++SQL122 */
	SalesOrderID, OrderDate, RowNumber    
FROM OrderedOrders   
WHERE RowNumber BETWEEN 50 AND 60;


-- 126

SELECT /* ++A20538828 ++SQL126 */
	BusinessEntityID, SalariedFlag  
FROM Employee  
ORDER BY 
         CASE WHEN SalariedFlag  = 'true' 
           THEN BusinessEntityID END 
 DESC  
        ,CASE WHEN SalariedFlag = 'false'
           THEN BusinessEntityID END;


-- 127

SELECT /* ++A20538828 ++SQL127 */
	ProductNumber, NAME, listprice, 
      CASE 
         WHEN ListPrice =  0 THEN 'Mfg item - not for resale'  
         WHEN ListPrice < 50 THEN 'Under $50'  
         WHEN ListPrice >= 50 AND ListPrice < 250 THEN 'Under $250'  
         WHEN ListPrice >= 250 AND ListPrice < 1000 THEN 'Under $1000'  
         ELSE 'Over $1000'  
      END "Price Range" 
FROM Product  
ORDER BY ProductNumber ;


-- 128

SELECT /* ++A20538828 ++SQL128 */
	ProductNumber,   
      CASE ProductLine  
         WHEN 'R' THEN 'Road'  
         WHEN 'M' THEN 'Mountain'  
         WHEN 'T' THEN 'Touring'  
         WHEN 'S' THEN 'Other sale items'  
         ELSE 'Not for sale'  
      END "Category",  
   NAME  
FROM Product  
ORDER BY ProductNumber;


-- 129

SELECT /* ++A20538828 ++SQL129 */
	ProductID,  
   CASE  
       WHEN MakeFlag = FinishedGoodsFlag THEN NULL  
       ELSE MakeFlag  
   END AS MakeFlag, 
   FinishedGoodsFlag, 
   MakeFlag
FROM Product  
WHERE ProductID < 10;


-- 130

SELECT /* ++A20538828 ++SQL130 */
	NAME, Class, Color, ProductNumber,  
COALESCE(Class, Color, ProductNumber) AS FirstNotNull  
FROM Product;


-- 132

SELECT /* ++A20538828 ++SQL132 */
	ProductID   
FROM Product  
INTERSECT  
SELECT ProductID   
FROM WorkOrder ;


-- 133

SELECT /* ++A20538828 ++SQL133 */
	ProductID   
FROM Product  
EXCEPT  
SELECT ProductID   
FROM WorkOrder ;


-- 134

SELECT /* ++A20538828 ++SQL134 */
	ProductID   
FROM WorkOrder  
EXCEPT  
SELECT ProductID   
FROM Product ;


-- 135

SELECT /* ++A20538828 ++SQL135 */
	businessentityid   
FROM businessentity    
INTERSECT   
SELECT businessentityid   
FROM person
WHERE persontype = 'IN'  
ORDER BY businessentityid;


-- 136

SELECT /* ++A20538828 ++SQL136 */
	businessentityid   
FROM businessentity    
EXCEPT  
SELECT businessentityid   
FROM person
WHERE persontype = 'IN'  
ORDER BY businessentityid;


-- 137

SELECT /* ++A20538828 ++SQL137 */
	ProductID, NAME  
FROM Product  
WHERE ProductID NOT IN (3, 4)  
UNION  
SELECT ProductModelID, NAME  
FROM ProductModel   
ORDER BY NAME;


-- 139

SELECT /* ++A20538828 ++SQL139 */
	MAX(TaxRate) - MIN(TaxRate) AS "Tax Rate Difference"  
FROM SalesTaxRate  
WHERE StateProvinceID IS NOT NULL;


-- 140

SELECT /* ++A20538828 ++SQL140 */
	s.BusinessEntityID AS SalesPersonID, FirstName, LastName, SalesQuota, SalesQuota/12 AS "Sales Target Per Month" 
FROM SalesPerson AS s   
JOIN Employee AS e   
    ON s.BusinessEntityID = e.BusinessEntityID  
JOIN Person AS p   
    ON e.BusinessEntityID = p.BusinessEntityID;
    