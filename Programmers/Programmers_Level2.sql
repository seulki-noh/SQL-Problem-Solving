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

/* "Search for employee information matching the criteria"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/284527
Problem: 
I need to retrieve information about the employees with the highest annual evaluation scores for 2022 from the HR_DEPARTMENT, HR_EMPLOYEES, and HR_GRADE tables. Please write an SQL statement to retrieve the scores, employee IDs, names, positions, and emails of the employees with the highest 2022 evaluation scores.
The 2022 evaluation score represents the sum of the first and second half scores. Please name the column representing the evaluation score SCORE.
*/
-- Solution
SELECT 
SUM(SCORE) AS SCORE,
G.EMP_NO,
E.EMP_NAME,
E.POSITION, 
E.EMAIL
FROM HR_GRADE G 
JOIN HR_EMPLOYEES E
ON G.EMP_NO = E.EMP_NO
WHERE G.YEAR LIKE "2022%"
GROUP BY EMP_NO
ORDER BY SCORE DESC
LIMIT 1 ;

/* "Finding developers who meet the requirements"
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


/*"Calculating the total sum of prices for items that meet the conditions"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/273709
Problem: Please write an SQL statement to calculate the total price of items with a rarity of ‘LEGEND’ in the ITEM_INFO table. Specify the column name as ‘TOTAL_PRICE’.
*/

-- Solution
SELECT SUM(PRICE) AS TOTAL_PRICE
FROM ITEM_INFO
WHERE RARITY = 'LEGEND'

/* "Check the status of used items that meet the conditions"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/164672
Problem: Please write an SQL query to retrieve the post ID, author ID, post title, price, and transaction status for a used goods listing registered on October 5, 2022, from the USED_GOODS_BOARD table. Classify and output the transaction status as ‘SALE’ for ‘Selling’, ‘RESERVED’ for ‘Reserved’, and ‘DONE’ for ‘Transaction Complete’. Sort the results in descending order by post ID.
*/

-- Solution
SELECT
BOARD_ID,
WRITER_ID,
TITLE,
PRICE,
CASE
    WHEN STATUS = 'SALE' THEN '판매중'
    WHEN STATUS = 'RESERVED' THEN '예약중'
    WHEN STATUS = 'DONE' THEN '거래완료'
    END AS 'STATUS'
FROM USED_GOODS_BOARD
WHERE CREATED_DATE = '2022-10-05'
ORDER BY BOARD_ID DESC; 

/* "Calculating the average car rental period"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/157342
Problem: Please write an SQL statement that outputs a list of car IDs and their average rental duration (column name: AVERAGE_DURATION) for cars with an average rental duration of 7 days or more from the CAR_RENTAL_COMPANY_RENTAL_HISTORY table. Round the average rental duration to the second decimal place. Sort the results in descending order by average rental duration. If the average rental duration is the same, sort in descending order by vehicle ID.
*/

-- Solution
SELECT
CAR_ID,
ROUND(AVG(DATEDIFF(END_DATE, START_DATE) + 1), 1) AS "AVERAGE_DURATION"
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
HAVING AVERAGE_DURATION >= 7
ORDER BY AVERAGE_DURATION DESC, CAR_ID DESC ;

/* "Counting the number of vehicles with specific options by vehicle type"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/151137
Problem:
Please write an SQL statement that outputs the number of cars in the CAR_RENTAL_COMPANY_CAR table that include one or more of the options ‘ventilated seats’, ‘heated seats’, or ‘leather seats’, broken down by car type. Specify the column name for the car count as CARS, and sort the results in ascending order by car type.
*/

-- Solution 

