SELECT *
FROM employee
ORDER BY jobtitle;

SET GLOBAL log_output = 'TABLE';
SET GLOBAL general_log = 'ON';

SHOW VARIABLES WHERE variable_name = 'log_output';
SHOW VARIABLES WHERE variable_name = 'general_log';


SELECT /* ++A20538828 ++SQL001 */
*
FROM employee
ORDER BY jobtitle;


SELECT /* ++A20538828 ++SQL002 */
e.*  
FROM person AS e  
ORDER BY LastName;


SELECT /* ++A20538828 ++SQL003 */
FirstName, LastName, businessentityid AS Employee_id
FROM person
ORDER BY LastName;


SELECT /* ++A20538828 ++SQL004 */
productid, productnumber, NAME
FROM product
WHERE sellstartdate IS NOT NULL AND productline = 'T'
ORDER BY NAME;


SELECT /* ++A20538828 ++SQL005 */
salesorderid, customerid, orderdate, subtotal,
    (taxamt / subtotal) * 100 AS tax_percentage
FROM salesorderheader
ORDER BY subtotal;


SELECT /* ++A20538828 ++SQL006 */
DISTINCT jobtitle
FROM employee
ORDER BY jobtitle;


SELECT /* ++A20538828 ++SQL007 */
customerid, SUM(freight) AS total_freight
FROM salesorderheader
GROUP BY customerid
ORDER BY customerid;


SELECT /* ++A20538828 ++SQL008 */
customerid, salespersonid,
    AVG(subtotal) AS average_subtotal,
    SUM(subtotal) AS total_subtotal
FROM salesorderheader
GROUP BY customerid, salespersonid
ORDER BY customerid DESC;



SELECT /* ++A20538828 ++SQL009 */
productid, SUM(quantity) AS total_quantity
FROM productinventory
WHERE shelf IN ('A', 'C', 'H')
GROUP BY productid
HAVING SUM(quantity) > 500
ORDER BY productid;



SELECT /* ++A20538828 ++SQL011 */
p.BusinessEntityID, FirstName, LastName, PhoneNumber AS PersonPhone
FROM Person AS p
JOIN PersonPhone ph 
ON p.BusinessEntityID = ph.BusinessEntityID
WHERE p.LastName LIKE 'L%'
ORDER BY p.LastName, p.FirstName;



SELECT /* ++A20538828 ++SQL016 */
    a.city, COUNT(b.AddressID) AS number_of_employees
FROM businessentityaddress As b
Inner join Address AS a
ON b.AddressID = a.AddressID
GROUP BY a.city
ORDER BY a.city;



SELECT /* ++A20538828 ++SQL017 */ 
    YEAR(orderdate) AS order_year,
    SUM(totaldue) AS total_due_amount
FROM salesorderheader
GROUP BY YEAR(orderdate)
ORDER BY order_year;



SELECT /* ++A20538828 ++SQL018 */
    YEAR(orderdate) AS order_year,
    SUM(totaldue) AS total_due_amount
FROM salesorderheader
WHERE YEAR(orderdate) <= 2016
GROUP BY YEAR(orderdate)
ORDER BY order_year;



SELECT /* ++A20538828 ++SQL019 */
    ContactTypeID, name
FROM contacttype
WHERE Name Like '%Manager%'
ORDER BY name DESC;


SELECT /* ++A20538828 ++SQL020 */
    p.BusinessEntityID,
    p.LastName,
    p.FirstName
FROM adventureworks.businessentitycontact AS b 
INNER JOIN 
    adventureworks.ContactType AS c ON c.ContactTypeID = b.ContactTypeID
INNER JOIN    
    adventureworks.Person AS p ON p.BusinessEntityID = b.BusinessEntityID
WHERE c.Name = 'Purchasing Manager'
ORDER BY p.LastName, p.FirstName;



SELECT *	
FROM mysql.general_log
WHERE command_type = 'Query'
AND argument LIKE '%++SQL%'
AND argument NOT LIKE '%general_log%'
ORDER BY event_time DESC;