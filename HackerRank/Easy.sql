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

/* "Weather Observation Station 2"
Link: https://www.hackerrank.com/challenges/weather-observation-station-2/problem?isFullScreen=true
Problem: Query the following two values from the STATION table:

The sum of all values in LAT_N rounded to a scale of  2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.
*/
-- Solution 
SELECT ROUND(SUM(LAT_N), 2),
ROUND(SUM(LONG_W), 2)
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


/* "Weather Observation Station 13"
Link: https://www.hackerrank.com/challenges/weather-observation-station-13/problem?isFullScreen=true
Problem: Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  38.7880 and less than 137.2345. Truncate your answer to 4 decimal places.
*/
-- Solution
SELECT ROUND(SUM(LAT_N), 4)
FROM STATION
WHERE LAT_N >38.7880 AND LAT_N < 137.2345 ;

/* "Weather Observation Station 14"
Link: https://www.hackerrank.com/challenges/weather-observation-station-14/problem?isFullScreen=true
Problem: Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than  137.2345. Truncate your answer to  4 decimal places.
*/
-- Solution 
SELECT 
ROUND(MAX(LAT_N), 4)
FROM STATION
WHERE LAT_N < 137.2345 ;

/* "Weather Observation Station 15"
Link: https://www.hackerrank.com/challenges/weather-observation-station-15/problem?isFullScreen=true
Problem: Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345 . Round your answer to  4 decimal places.
*/
-- Solution
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N < 137.2345) ; 


/* "Weather Observation Station 16"
Link: https://www.hackerrank.com/challenges/weather-observation-station-16/problem?isFullScreen=true
Problem: Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780 . Round your answer to 4 decimal places.
*/
-- Solution 
SELECT ROUND(MIN(LAT_N), 4)
FROM STATION
WHERE LAT_N > 38.7780 ; 

/* "Weather Observation Station 17"
Link: https://www.hackerrank.com/challenges/weather-observation-station-17/problem?isFullScreen=true
Problem: Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780 . Round your answer to  4 decimal places.
*/
-- Solution
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (SELECT MIN(LAT_N) FROM STATION WHERE LAT_N > 38.7780) ;

/* "Weather Observation Station 18"
Link: https://www.hackerrank.com/challenges/weather-observation-station-18/problem?isFullScreen=true
Problem: Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.

 a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 b chappens to equal the minimum value in Western Longitude (LONG_W in STATION).
 c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places.

*/
-- Solution
-- Manhatten Distance (|a-c| + |b-d|)
SELECT 
ROUND((ABS(MIN(LAT_N)-MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W))), 4)
FROM STATION ; 

/* "Weather Observation Station 19"
Link: https://www.hackerrank.com/challenges/weather-observation-station-19/problem?isFullScreen=true
Problem: Consider P1(a,c) and P2(b,d) to be two points on a 2D plane where (a,b) are the respective minimum and maximum values of Northern Latitude (LAT_N) and (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points P1(a,c) and  P2(b,d) and format your answer to display  4 decimal digits.
*/
-- Solution 
-- sqrt((x2-x1)^2 +(y2-y2)^2)
SELECT
ROUND(
    SQRT(
        POW(MAX(LAT_N) - MIN(LAT_N), 2) + POW(MAX(LONG_W) - MIN(LONG_W),2)
        ), 4
    )
FROM STATION ;



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

/*"Top Earners"
Link: https://www.hackerrank.com/challenges/earnings-of-employees/problem?isFullScreen=true
Problem: We define an employee's total earnings to be their monthly "salary x month" worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.
*/

-- Solution
SELECT MAX(SALARY * MONTHS),COUNT(*)
FROM EMPLOYEE
WHERE SALARY * MONTHS = (SELECT MAX(SALARY * MONTHS) FROM EMPLOYEE) ;

/* "Type of Triangle"
Link: https://www.hackerrank.com/challenges/what-type-of-triangle/problem?isFullScreen=true
Problem: 
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  3 sides of equal length.
Isosceles: It's a triangle with  2 sides of equal length.
Scalene: It's a triangle with  3 sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/
-- Solution
SELECT 
    CASE 
        WHEN (A + B > C) AND (A + C > B) AND (B + C > A) THEN
            CASE 
                WHEN  A = B and B = C THEN "Equilateral"
                WHEN A = B or B = C OR A = C THEN "Isosceles"
                WHEN A <> B AND B <> C AND A <> C THEN "Scalene"    
                ELSE "Not A Triangle"
            END
        ELSE "Not A Triangle"
    END
FROM TRIANGLES ; 

/* "Population Census"
Link: https://www.hackerrank.com/challenges/asian-population/problem?isFullScreen=true
Problem: Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/
-- Solution
SELECT SUM(C.POPULATION)
FROM CITY C
JOIN COUNTRY T
ON C.COUNTRYCODE = T.CODE
WHERE T.CONTINENT = "Asia"

/* "Afrian Cities"
Link: https://www.hackerrank.com/challenges/african-cities/problem?isFullScreen=true
Problem: Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/
-- Solution
SELECT 
C.NAME
FROM CITY C
JOIN COUNTRY T
ON C.COUNTRYCODE = T.CODE 
WHERE T.CONTINENT = "Africa"

/* "Average Population of Each Continent"
Link: https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?isFullScreen=true
Problem: Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/
-- Solution
SELECT
T.CONTINENT,
FLOOR(AVG(C.POPULATION))
FROM CITY C
JOIN COUNTRY T
ON C.COUNTRYCODE = T.CODE 
GROUP BY T.CONTINENT ;

/* "Draw The Triangle 1 "
Link: https://www.hackerrank.com/challenges/draw-the-triangle-1/problem
Problem: P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
*/
-- Solution 
SET @n = 21;
SELECT REPEAT('* ', @n := @n-1)
FROM INFORMATION_SCHEMA.tables
LIMIT 20 ; 

/* "Draw The Triangle 2"
Link: https://www.hackerrank.com/challenges/draw-the-triangle-2/problem
Problem: P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
*/
-- Solution
SET @n = 0;
SELECT REPEAT('* ', @n := @n+1)
FROM INFORMATION_SCHEMA.TABLES
LIMIT 20; 

/* "Revising Aggregations - The Count Function"
Link: https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/problem?isFullScreen=true
Problem: Query a count of the number of cities in CITY having a Population larger than 100,000.
*/
-- Solution 
SELECT COUNT(*)
FROM CITY
WHERE POPULATION > 100000 ; 

