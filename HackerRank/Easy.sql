/* "Revising the Select Query 1"
Link: https://www.hackerrank.com/challenges/revising-the-select-query/problem?isFullScreen=true
Problem: Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
The CITY table is described as follows:
*/
-- Solution
SELECT *
FROM CITY
WHERE POPULATION >= 100000 AND COUNTRYCODE = "USA" ;

/* "Revising the Select Query II"
Link: https://www.hackerrank.com/challenges/revising-the-select-query-2/problem?isFullScreen=true
Problem: Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
*/

-- Solution 
SELECT NAME
FROM CITY
WHERE POPULATION > 120000 AND COUNTRYCODE = "USA";

/* "Select All "
Link: https://www.hackerrank.com/challenges/select-all-sql/problem?isFullScreen=true
Problem: Query all columns (attributes) for every row in the CITY table.
*/
-- Solution 
SELECT * FROM CITY ;

/* "Select ID "
Link: https://www.hackerrank.com/challenges/select-by-id/problem?isFullScreen=true
Problem: Query all columns for a city in CITY with the ID 1661.
*/
-- Solution 
SELECT *
FROM CITY
WHERE ID = 1661 ;

/* "Japanese Cities' Attributes"
Link: https://www.hackerrank.com/challenges/japanese-cities-attributes/problem?isFullScreen=true
Problem: Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
*/
-- Solution 
SELECT *
FROM CITY
WHERE COUNTRYCODE = "JPN" ; 

/* "Japanese Cities' Names"
Link: 