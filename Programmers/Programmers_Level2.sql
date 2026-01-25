/* "Determining the Number of E. coli Individuals Differentiated by Quarter "
Link: https://school.programmers.co.kr/learn/courses/30/lessons/299308
Prblem: 
Write an SQL statement that outputs the total number of differentiated E. coli individuals (ECOLI_COUNT) for each quarter (QUARTER). Prefix each quarter with ‘Q’ and sort the quarters in ascending order. There are no quarters where E. coli individuals have not differentiated.
*/

-- Solution
SELECT
CONCAT(QUARTER(DIFFERNTIATION_DATE), 'Q') AS QUATER,
COUNT(*) AS ECOLI_COUNT
FROM ECOLI_DATE
GROUP BY QUARTER
ORDER BY QUARTER ; 

/* "Total number of specific fish caught"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/298518
Problem:
Return the total number of fish records in FISH_INFO where the fish type corresponds to BASS or SNAPPER (via FISH_NAME_INFO). Output a single column named FISH_COUNT.
*/

-- Solution 
SELECT
COUNT(*) AS FISH_COUNT,
FROM FISH_INFO I
JOIN FISH_NAME_INFO N
ON I.FISH_TYPE = N.FISH_TYPE
WHERE FISH_NAME IN ("BASS", "SNAPPER") ; 

/* "Calculating the number of fish caught each month"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/293260
Problem:
Write an SQL statement to output the number of fish caught per month and the corresponding month.
Use FISH_COUNT as the column name for the number of fish caught and MONTH as the column name for the month.
Sort the results in increasing order by month.
However, output the month as a number (1-12), omitting the second digit for numbers 9 and below. Do not output months with no fish caught.
*/

-- Solution
SELECT
COUNT(ID) AS FISH_COUNT,
MONTH(TIME) AS MONTH
FROM FISH_INFO
GROUP BY MONTH
ORDER BY MONTH ; 

/* "Check the average distance between stations by line"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/284531
Problem:
Please write an SQL statement to query the route, total cumulative distance, and average distance between stations for each route from the SUBWAY_DISTANCE table.
The total cumulative distance refers to the sum of all distances between stations within the table. Name the columns for total cumulative distance and average distance between stations as TOTAL_DISTANCE and AVERAGE_DISTANCE, respectively. Round the total cumulative distance to the second decimal place and the average distance between stations to the third decimal place, then output both with the unit (km).
Sort the results in descending order based on total cumulative distance.
*/

-- Solution
SELECT 
ROUTE,
CONCAT(ROUND(SUM(D_BETWEEN_DIST), 1), 'km') AS TOTAL_DISTANCE,
CONCAT(ROUND(AVG(D_BETWEEN_DIST), 2), 'km') AS AVERAGE_DISTANCE
FROM SUBWAY_DISTANCE
GROUP BY ROUTE
ORDER BY ROUND(SUM(D_BETWEEN_DIST), 1) DESC; 
-- Sorting is based on numbers, not strings 


/* "Check the average fine dust concentration by year"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/284530
Problem:
Please write a SQL statement to retrieve the annual average fine dust and ultrafine dust pollution levels in the Suwon area from the AIR_POLLUTION table. Name the columns for average fine dust and ultrafine dust pollution levels PM10 and PM2.5, respectively, and round the values ​​to the third decimal place. Sort the results in ascending order by year.
*/

-- Solution
SELECT 
YEAR(YM) AS YEAR,
ROUND(AVG(PM_VAL1),2) AS "PM10",
ROUND(AVG(PM_VAL2),2) AS "PM2.5"
FROM AIR_POLLUTION
WHERE LOCATION2 = "수원"
GROUP BY YEAR(YM)
ORDER BY YEAR(YM) ;

/* "Finding a development vehicle that meets your requirements "
Link: https://blog.naver.com/kino_de/223714969149
Problem:
I want to retrieve information about developers with Python or C# skills from the DEVELOPERS table. Please write an SQL statement to retrieve the ID, email, first name, and last name of developers matching the criteria.
Please sort the results in ascending order by ID.
*/

-- Solution
SELECT 
ID,
EMAIL,
FIRST_NAME,
LAST_NAME
FROM DEVELOPERS 
WHERE SKILL_CODE & (SELECT SUM(CODE) FROM SKILLCODES 
                   WHERE NAME IN ("Python", "C#"))
ORDER BY ID ;

/* "Get upgraded items"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/273711
Problem: 
Please write an SQL statement that outputs the item ID (ITEM_ID), item name (ITEM_NAME), and item rarity (RARITY) for all subsequent upgrade items of items with a rarity of ‘RARE’. Sort the results in descending order by item ID.
*/

-- Solution 
SELECT 
ITEM_ID,
ITEM_NAME,
RARITY
FROM ITEM_INFO
WHERE ITEM_ID IN (SELECT T.ITEM_ID FROM ITEM_INFO I
                 JOIN ITEM_TREE T
                 ON T.PARENT_ITEM_ID = I.ITEM_ID
                 WHERE RARITY = "RARE") 
ORDER BY ITEM_ID DESC ;

/* "How to Get ROOT Items"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/273710
Problem: Please write an SQL statement to find the ROOT item and output the item ID (ITEM_ID) and item name (ITEM_NAME). At this time, please sort the results in ascending order based on the item ID.
*/

-- Solution
SELECT 
I.ITEM_ID, 
I.ITEM_NAME 
FROM ITEM_INFO I
JOIN ITEM_TREE T
ON I.ITEM_ID = T.ITEM_ID
WHERE PARENT_ITEM_ID IS NULL 
ORDER BY ITEM_ID ; 

/*