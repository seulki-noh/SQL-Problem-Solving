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
Link: https://www.hackerrank.com/challenges/japanese-cities-name/problem?isFullScreen=true
Problem: Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
*/
-- Solution
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = "JPN" ;


/* "Weather Observation Station 1"
Link: https://blog.naver.com/kino_de/223805424690
Problem: Query a list of CITY and STATE from the STATION table.
*/
-- Solution 
SELECT CITY, STATE 
FROM STATION ; 


/* "Weather Observation Station 3"
Link: https://www.hackerrank.com/challenges/weather-observation-station-3/problem?isFullScreen=true
Problem: Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
*/
-- Solution
SELECT DISTINCT CITY
FROM STATION
WHERE MOD(ID,2)=0 ; 


/* "Weather Observation Station 4"
Link: https://www.hackerrank.com/challenges/weather-observation-station-4/problem?isFullScreen=true
Problem:  Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
*/
-- Solution 
SELECT 
COUNT(*) - COUNT(DISTINCT CITY)
FROM STATION ;  

/* "Weather Observation Station 5"
Link: https://www.hackerrank.com/challenges/weather-observation-station-5/problem?isFullScreen=true
Problem: Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
*/
-- Solution 
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY), CITY LIMIT 1 ; 
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC, CITY LIMIT 1 ;

/* "Weather Observation Station 6"
Link: https://www.hackerrank.com/challenges/weather-observation-station-6/problem?isFullScreen=true
Problem: Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
*/
-- Solution 
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY REGEXP('^[AEIOU]') ;

/*"Weather Observation Station 7"
Link: https://www.hackerrank.com/challenges/weather-observation-station-7/problem?isFullScreen=true
Problem: Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
*/
-- Solution 
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY REGEXP('[AEIOU]$') ;

/* "Weather Observation station 8"
Link: https://www.hackerrank.com/challenges/weather-observation-station-8/problem?isFullScreen=true
Problem: Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
*/
-- Solution
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY REGEXP('^[AEIOU]') AND 
CITY REGEXP('[AEIOU]$');

/* "Weather Observation Station 9"
Link: https://www.hackerrank.com/challenges/weather-observation-station-9/problem?isFullScreen=true
Problem: Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
*/
-- Solution
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY REGEXP('^[^AEIOU]');

/* "Weather Observation Station 10"
Link: https://www.hackerrank.com/challenges/weather-observation-station-10/problem?isFullScreen=true
Problem: Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
*/
-- Solution
SELECT 
DISTINCT CITY
FROM STATION
WHERE CITY REGEXP('[^AEIOU]$') ;

/* "Weather Observation Station 11"
Link: https://www.hackerrank.com/challenges/weather-observation-station-11/problem?isFullScreen=true
Problem: Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
*/
-- Solution
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY REGEXP('^[^AEIOU]') OR 
CITY REGEXP('[^AEIOU]$') ; 

/* "Weather Observation Station 12 "
Link: https://www.hackerrank.com/challenges/weather-observation-station-12/problem?isFullScreen=true
Problem: Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
*/
-- Solution
SELECT 
DISTINCT CITY 
FROM STATION 
WHERE CITY REGEXP('^[^AEIOU]') AND 
CITY REGEXP('[^AEIOU]$') ; 

/* "Higher Than 75 Marks"
Link: https://www.hackerrank.com/challenges/more-than-75-marks/problem?isFullScreen=true
Problem: 
Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
*/
-- Solution
SELECT NAME 
FROM STUDENTS
WHERE Marks > 75 
ORDER BY RIGHT(NAME, 3), ID ; 

/* "Employee Names"
Link: https://www.hackerrank.com/challenges/name-of-employees/problem?isFullScreen=true
Problem: Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
*/
-- Solution
SELECT NAME
FROM EMPLOYEE
ORDER BY NAME ;

/* "Employee Salaries"
Link: https://www.hackerrank.com/challenges/salary-of-employees/problem?isFullScreen=true
Problem: Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.
*/
--Solution
SELECT NAME 
FROM EMPLOYEE
WHERE SALARY > 2000 AND MONTHS < 10
ORDER BY EMPLOYEE_ID ; 

/* "Revising Aggregations  - The Count Function"
Link : https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/problem?isFullScreen=true
Problem: Query a count of the number of cities in CITY having a Population larger than 100,000.
*/
-- Solution
SELECT 
COUNT(*)
FROM CITY 
WHERE POPULATION > 100000; 

/* "Revising Aggregations  - The Sum Function"
Link: https://www.hackerrank.com/challenges/revising-aggregations-sum/problem?isFullScreen=true
Problem: Query the total population of all cities in CITY where District is California.
*/
-- Solution
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = "California" ; 


/* "Revising Aggregations - Average"
Link: https://www.hackerrank.com/challenges/revising-aggregations-the-average-function/problem?isFullScreen=true
Problem: Query the average population of all cities in CITY where District is California.
*/
-- Solution
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = "California" ; 

/* "Average Population"
Link: https://www.hackerrank.com/challenges/average-population/problem?isFullScreen=true
Problem: Query the average population for all cities in CITY, rounded down to the nearest integer.
*/
-- Solution 
SELECT ROUND(AVG(POPULATION), 0)
FROM CITY ; 

/* "Japan Population"
Link: https://www.hackerrank.com/challenges/japan-population/problem?isFullScreen=true
Problem: Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
*/
-- Solution
SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = "JPN" ; 

/* "Population Density Differnce"
Link: https://www.hackerrank.com/challenges/population-density-difference/problem?isFullScreen=true
Problem: Query the difference between the maximum and minimum populations in CITY.
*/
-- Solution 
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM CITY ;

/* "The Blunder"
Link: https://www.hackerrank.com/challenges/the-blunder/problem?isFullScreen=true
Problem: https://www.hackerrank.com/challenges/the-blunder/problem?isFullScreen=true
Problem:  Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), and round it up to the next integer.
*/
-- Solution
SELECT CEIL(AVG(SALARY) - AVG(REPLACE(SALARY, "0" , "")) )
FROM EMPLOYEES
