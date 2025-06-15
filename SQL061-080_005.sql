SET GLOBAL log_output = 'TABLE';
SET GLOBAL general_log = 'ON';

SHOW VARIABLES WHERE variable_name = 'log_output';
SHOW VARIABLES WHERE variable_name = 'general_log';



SELECT /* ++A20538828 ++SQL062 */
	LEFT(NAME, 5)   
FROM Product  
ORDER BY ProductID;



WITH INDIVIDUAL_CUSTOMER (FirstName, LastName) AS (
SELECT 'Jon', 'Yang' FROM DUAL UNION ALL
SELECT 'Eugene' , 'Huang' FROM DUAL UNION ALL
SELECT 'Ruben', 'Torres' FROM DUAL UNION ALL
SELECT 'Christy', 'Zhu' FROM DUAL UNION ALL
SELECT 'Elizabeth', 'Johnson' FROM DUAL UNION ALL
SELECT 'Julio', 'Ruiz' FROM DUAL UNION ALL
SELECT 'Janet', 'Alvarez' FROM DUAL UNION ALL
SELECT 'Marco', 'Mehta' FROM DUAL UNION ALL
SELECT 'Rob', 'Verhoff' FROM DUAL UNION ALL
SELECT 'Shannon', 'Carlson' FROM DUAL UNION ALL
SELECT 'Jacquelyn', 'Suarez' FROM DUAL
)
SELECT /* ++A20538828 ++SQL063 */
	LENGTH(FirstName) AS LENGTH, FirstName, LastName   
FROM INDIVIDUAL_CUSTOMER;



SELECT /* ++A20538828 ++SQL064 */
	LENGTH(FirstName) AS fnamelength, FirstName, LastName
FROM (
    SELECT 'Ann' AS FirstName, 'Wilson' AS LastName UNION ALL
    SELECT 'Don', 'Funk' UNION ALL
    SELECT 'Jay', 'Fluegel' UNION ALL
    SELECT 'Mae', 'Anderson' UNION ALL
    SELECT 'Ole', 'Weldon' UNION ALL
    SELECT 'Eric', 'Coleman' UNION ALL
    SELECT 'Jeff', 'Hay' UNION ALL
    SELECT 'Jeff', 'Henshaw' UNION ALL
    SELECT 'John', 'Fredericksen' UNION ALL
    SELECT 'Jose', 'Lugo' UNION ALL
    SELECT 'Judy', 'Storjohann' UNION ALL
    SELECT 'Lynn', 'Gonzales' UNION ALL
    SELECT 'Neal', 'Hasty' UNION ALL
    SELECT 'Neil', 'Charney' UNION ALL
    SELECT 'Scot', 'Bent'
) AS INDIVIDUAL_CUSTOMER;



SELECT /* ++A20538828 ++SQL065 */
	LOWER(SUBSTRING(NAME, 1, 25)) AS LOWER,   
       UPPER(SUBSTRING(NAME, 1, 25)) AS UPPER,   
       LOWER(UPPER(SUBSTRING(NAME, 1, 25))) AS LowerUpper  
FROM Product  
WHERE standardcost BETWEEN 1000.00 AND 1220.00;



SELECT /* ++A20538828 ++SQL066 */
	'          ten space then the text' AS "Original Text",
       TRIM(LEADING ' ' FROM '          ten space then the text') AS "Trimmed Text(space removed)";



SELECT /* ++A20538828 ++SQL067 */
	productnumber,
       LTRIM(REPLACE(productnumber, 'HN', '')) AS "TrimmedProductnumber"
FROM product
WHERE LEFT(productnumber, 2) = 'HN';



SELECT /* ++A20538828 ++SQL068 */
	NAME, CONCAT(REPEAT('0', 4) , ProductLine) AS "Line Code"  
FROM Product  
WHERE ProductLine = 'T'  
ORDER BY NAME;



SELECT /* ++A20538828 ++SQL069 */
	FirstName, REVERSE(FirstName) AS REVERSE  
FROM Person  
WHERE BusinessEntityID < 6 
ORDER BY FirstName;



SELECT /* ++A20538828 ++SQL070 */
	NAME, productnumber, RIGHT(NAME, 8) AS "Product Name"  
FROM product 
ORDER BY productnumber;



SELECT /* ++A20538828 ++SQL071 */ 
	CONCAT('text then ten spaces          ','after space') AS "Original Text",
CONCAT(RTRIM('text then ten spaces          '),'after space') AS "Trimmed Text(space removed)";



SELECT /* ++A20538828 ++SQL072 */
	productnumber, NAME
FROM product
WHERE RIGHT(NAME,1) IN ('S','M','L');



SELECT /* ++A20538828 ++SQL073 */
	GROUP_CONCAT(COALESCE(firstname, 'N/A') SEPARATOR ', ') AS NAMES
FROM Person;



SELECT /* ++A20538828 ++SQL074 */
	GROUP_CONCAT(COALESCE(FirstName, ' ', LastName, ' (', ModifiedDate, ')'),', ') 
AS NameAndDate FROM Person;



SELECT /* ++A20538828 ++SQL075 */
	City, GROUP_CONCAT(EmailAddress SEPARATOR ';') AS emails 
FROM BusinessEntityAddress AS BEA  
INNER JOIN Address AS A ON BEA.AddressID = A.AddressID
INNER JOIN EmailAddress AS EA 
ON BEA.BusinessEntityID = EA.BusinessEntityID 
GROUP BY City
LIMIT 10;



-- SELECT 
--    jobtitle, CONCAT(SUBSTR(jobtitle, 1, 11), 'Assistant') AS "New Jobtitle"
-- FROM employee e 
-- WHERE SUBSTR(jobtitle, 12, 10) = 'Supervisor';


SELECT /* ++A20538828 ++SQL076 */
    jobtitle, REPLACE(jobtitle, 'Supervisor', 'Assistant') AS "New Jobtitle"
FROM employee e 
WHERE jobtitle LIKE '%Supervisor';



SELECT /* ++A20538828 ++SQL077 */
    per.firstname, per.middlename, per.lastname, humemp.jobtitle
FROM person AS per
INNER JOIN employee AS humemp ON per.businessentityid = humemp.businessentityid
WHERE SUBSTR(humemp.jobtitle, 1, 5) = 'Sales';



SELECT /* ++A20538828 ++SQL078 */
	CONCAT(UPPER(RTRIM(LastName)) , ', ' , FirstName) AS NAME  
FROM person  
ORDER BY LastName;



SELECT *	
FROM mysql.general_log
WHERE command_type = 'Query'
AND argument LIKE '%++SQL%'
AND argument NOT LIKE '%general_log%'
ORDER BY event_time DESC;