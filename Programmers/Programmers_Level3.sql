/* "Classifying E. coli by size 1"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/299307
Problem: 
If the size of an E. coli individual is 100 or below, classify it as ‘LOW’; if it is over 100 but 1000 or below, classify it as ‘MEDIUM’; if it is over 1000, classify it as ‘HIGH’. Write an SQL statement that outputs the ID (ID) and classification (SIZE) of E. coli individuals. Sort the results in ascending order by individual ID.
*/
-- Solution 
SELECT
    ID,
    CASE
        WHEN SIZE_OF_COLONY < 100 THEN "LOW"
        WHEN SIZE_OF_COLONY < 1000 THEN "MEDIUM"
        ELSE "HIGH" 
        END AS "SIZE"
FROM ECOLI_DATA
ORDER BY ID ;

/* "Counting the number of offspring produced by E. coli"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/299305#qna
Problem: 
Please write an SQL statement that outputs the ID of each E. coli individual and the number of its children (CHILD_COUNT). If there are no children, output the child count as 0. Sort the results in ascending order by the individual's ID.
*/
-- Solution
SELECT 
    P.ID,
    COUNT(C.ID) AS "CHILD_COUNT"
FROM ECOLI_DATA P
    LEFT JOIN ECOLI_DATA C
    ON P.ID = C.PARENT_ID
GROUP BY ID
ORDER BY ID

/* "Finding the number of fish per species and the maximum length that satisfy specific conditions"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/298519
Problem: 
Write an SQL statement that sorts fish with an average length of 33cm or more by species in FISH_INFO, then outputs the number caught, maximum length, and fish species. Sort the results in ascending order by fish species. Treat fish 10cm or shorter as 10cm when calculating the average length.

Use the following column names: fish type ‘FISH_TYPE’, number caught ‘FISH_COUNT’, maximum length ‘MAX_LENGTH’.
*/
-- Solution
SELECT
    COUNT(ID) AS FISH_COUNT,
    MAX(LENGTH) AS MAX_LENGTH,
    FISH_TYPE
FROM FISH_INFO
GROUP BY FISH_TYPE
HAVING AVG(IFNULL(LENGTH, 10)) >= 33
ORDER BY FISH_TYPE ;

/* "Finding the Biggest Fish by Species"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/293261#qna
Problem: 
Write an SQL statement that outputs the ID, name, and length of the largest fish for each fish species.

The ID column name is ID, the name column name is FISH_NAME, and the length column name is LENGTH.
Sort the results in ascending order by fish ID.
Note: There is only one largest fish per species, and no fish under 10cm is the largest.
*/
-- Solution 
SELECT 
    F.ID,
    N.FISH_NAME,
    F.LENGTH
FROM 
    (SELECT ID, FISH_TYPE, LENGTH, 
     MAX(LENGTH) OVER (PARTITION BY FISH_TYPE) AS MAX_LENGTH 
     FROM FISH_INFO ) AS F
    JOIN FISH_NAME_INFO N
    ON F.FISH_TYPE = N.FISH_TYPE
WHERE F.LENGTH = F.MAX_LENGTH
ORDER BY ID ;

/* "View Average Annual Salary by Department"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/284529
Problem: I want to retrieve the average salary by department using the HR_DEPARTMENT and HR_EMPLOYEES tables. Please write a SQL statement that retrieves the department ID, English name, and average salary for each department.
Round the average salary to the first decimal place and name the column AVG_SAL.
Sort the results in descending order based on the average salary by department.
*/
-- Solution 
SELECT D.DEPT_ID, D.DEPT_NAME_EN, ROUND(AVG(E.SAL),0) AS AVG_SAL
FROM HR_DEPARTMENT D
JOIN HR_EMPLOYEES E
ON D.DEPT_ID = E.DEPT_ID
GROUP BY D.DEPT_ID
ORDER BY AVG_SAL DESC;

/* "obtaining items that cannot be upgraded"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/273712
Problem: Please write an SQL statement that outputs the item ID (ITEM_ID), item name (ITEM_NAME), and rarity (RARITY) of items that can no longer be upgraded. Sort the results in descending order by item ID.
*/
-- Solution 
SELECT I.ITEM_ID, I.ITEM_NAME, I.RARITY 
FROM ITEM_INFO I
LEFT JOIN ITEM_TREE T
ON I.ITEM_ID = T.PARENT_ITEM_ID
WHERE T.ITEM_ID IS NULL
ORDER BY ITEM_ID DESC ;


/* "Viewing attachments on the most popular used goods trading board"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/164671#qna
Problem: Please write an SQL statement to retrieve the attachment file paths for the most viewed used goods posts in the USED_GOODS_BOARD and USED_GOODS_FILE tables. Sort the attachment paths in descending order by FILE ID. The base file path is `/home/grep/src/`. Output the directory structure organized by post ID, with filenames composed of the file ID, file name, and file extension. Only one post with the highest number of views exists.
*/
-- Solution
SELECT 
CONCAT("/home/grep/src/", B.BOARD_ID, "/", FILE_ID, FILE_NAME, FILE_EXT) AS FILE_PATH
FROM USED_GOODS_BOARD B 
LEFT JOIN USED_GOODS_FILE F 
ON B.BOARD_ID = F.BOARD_ID
WHERE B.BOARD_ID = (SELECT BOARD_ID FROM USED_GOODS_BOARD ORDER BY VIEWS DESC LIMIT 1)
ORDER BY FILE_ID DESC

/* "Retrieve user information matching the specified conditions"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/164670
Problem: 
Please write an SQL query to retrieve the user ID, nickname, full address, and phone number of users who have posted three or more used goods listings in the USED_GOODS_BOARD and USED_GOODS_USER tables. Ensure the full address includes the city, street address, and detailed address. For the phone number, output it in the format xxx-xxxx-xxxx with hyphens (-). Sort the results in descending order by member ID.
*/
-- Solution
SELECT
USER_ID, NICKNAME, 
CONCAT(CITY," ",STREET_ADDRESS1," ", STREET_ADDRESS2) AS 전체주소,
CONCAT(SUBSTRING(TLNO, 1,3), "-", SUBSTRING(TLNO, 4,4), "-" , SUBSTRING(TLNO,8, 4)) AS 전화번호
FROM USED_GOODS_USER
WHERE USER_ID IN (SELECT WRITER_ID 
                   FROM USED_GOODS_BOARD GROUP BY WRITER_ID
                   HAVING COUNT(*) >= 3)
ORDER BY USER_ID DESC; 

/* "View users matching the criteria and total transaction amount"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/164668
Problem: Please write an SQL query to retrieve the member ID, nickname, and total transaction amount for users whose total amount of completed used goods transactions in the USED_GOODS_BOARD and USED_GOODS_USER tables is 700,000 KRW or more. Sort the results in ascending order based on the total transaction amount.
*/
-- Solution
SELECT
U.USER_ID, U.NICKNAME, SUM(B.PRICE) AS TOTAL_SALES
FROM USED_GOODS_BOARD B
LEFT JOIN USED_GOODS_USER U
ON B.WRITER_ID = U.USER_ID
WHERE B.STATUS = "DONE"
GROUP BY B.WRITER_ID
HAVING SUM(B.PRICE) >= 700000 
ORDER BY TOTAL_SALES ; 

/* "Obtaining a list of vehicles with rental records"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/157341
Problem: Please write an SQL statement that outputs a list of car IDs from the CAR_RENTAL_COMPANY_CAR table and the CAR_RENTAL_COMPANY_RENTAL_HISTORY table. These cars must be sedans and have a rental start date in October. The car ID list must be unique and sorted in descending order by car ID.
*/
-- Solution
SELECT
DISTINCT C.CAR_ID
FROM CAR_RENTAL_COMPANY_CAR C
LEFT JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY H
ON C.CAR_ID = H.CAR_ID
WHERE CAR_TYPE REGEXP('세단') AND
MONTH(START_DATE) = 10
ORDER BY C.CAR_ID DESC;

/* "Distinguishing between “Currently Rented” and “Available for Rental” in Car Rental Records"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/157340#qna
Problem: Please write an SQL statement that outputs the car ID and AVAILABILITY list by adding a column (column name: AVAILABILITY) to the CAR_RENTAL_COMPANY_RENTAL_HISTORY table. For cars rented on October 16, 2022, display ‘Rented’, and for cars not rented, display ‘Available’. If the return date is October 16, 2022, also display it as ‘Rented’. Sort the results in descending order by vehicle ID.
*/
-- Solution
SELECT
DISTINCT CAR_ID, 
CASE
    WHEN MAX(START_DATE <= '2022-10-16' AND END_DATE >= '2022-10-16')= 1 THEN '대여중' 
    ELSE '대여 가능'
END AS AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC;

/* "Calculating the monthly rental frequency for frequently rented vehicles"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/151139
Problem: Please write an SQL statement that outputs a list of the total number of rentals per month and per car ID (column name: RECORDS) for vehicles with 5 or more total rentals from August 2022 to October 2022, based on the rental start date in the CAR_RENTAL_COMPANY_RENTAL_HISTORY table. Sort the results in ascending order by month. If the month is the same, sort in descending order by vehicle ID. Exclude any vehicles with zero total rentals for a specific month from the results.
*/
-- Solution
SELECT
MONTH(START_DATE) AS MONTH, 
CAR_ID,
COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE CAR_ID IN 
(SELECT CAR_ID FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
                WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
                GROUP BY CAR_ID
                HAVING COUNT(*) >= 5)
AND START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
GROUP BY MONTH, CAR_ID
HAVING RECORDS > 0 
ORDER BY MONTH, CAR_ID DESC ;

/* "Calculating Book Sales by Category "
Link: https://school.programmers.co.kr/learn/courses/30/lessons/144855
Problem: Please write an SQL statement that calculates the total book sales by category for January 2022 and outputs a list of categories (CATEGORY) and total sales (TOTAL_SALES).
Sort the results in ascending order by category name.
*/
-- Solution
SELECT
CATEGORY,
SUM(SALES) AS TOTAL_SALES
FROM BOOK B
LEFT JOIN BOOK_SALES S
ON B.BOOK_ID = S.BOOK_ID
WHERE YEAR(SALES_DATE) = 2022 AND MONTH(SALES_DATE) = 1
GROUP BY CATEGORY
ORDER BY CATEGORY ; 


/* "Print restaurant information with the most favorites"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/131123
Problem: Please write an SQL statement to retrieve the food category, ID, restaurant name, and number of favorites for the restaurant with the most favorites in each food category from the REST_INFO table. Sort the results in descending order by food category.
*/
-- Solution 1
SELECT
FOOD_TYPE, 
REST_ID,
REST_NAME,
FAVORITES
FROM REST_INFO
WHERE (FOOD_TYPE, FAVORITES) IN (SELECT FOOD_TYPE, MAX(FAVORITES)
                   FROM REST_INFO
                   GROUP BY FOOD_TYPE)
ORDER BY FOOD_TYPE DESC; 
-- Solution 2
SELECT
FOOD_TYPE, 
REST_ID,
REST_NAME,
FAVORITES
FROM (SELECT * , 
     MAX(FAVORITES) OVER(PARTITION BY FOOD_TYPE) AS MAX_FAV FROM REST_INFO) AS M
WHERE FAVORITES = MAX_FAV
ORDER BY FOOD_TYPE DESC;



/* "Print order status by sorting by condition"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/131113
Problem: Please write a SQL statement to retrieve the order ID, product ID, shipping date, and shipping status from the FOOD_ORDER table as of May 1, 2022. For shipping status, output "Shipped Completed" as of May 1, 2022, "Pending Shipment" for any date after May 1, 2022, and "Undecided Shipment" if undecided. Sort the results in ascending order by order ID.
*/
-- Solution 
SELECT
ORDER_ID,
PRODUCT_ID, 
DATE_FORMAT(OUT_DATE, '%Y-%m-%d') AS OUT_DATE, 
CASE 
    WHEN OUT_DATE <= '2022-05-01' THEN "출고완료"
    WHEN OUT_DATE > '2022-05-01' THEN "출고대기"
    ELSE "출고미정"
END AS "출고여부"
FROM FOOD_ORDER
ORDER BY ORDER_ID ; 


/* "Places owned by heavy users"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/77487
Problem: This service refers to people who have registered more than one space as "heavy users." Please write an SQL statement that retrieves information about spaces registered by heavy users, sorted by ID.
*/
-- Solution 
SELECT
ID,
NAME,
HOST_ID
FROM PLACES
WHERE HOST_ID IN (SELECT HOST_ID FROM PLACES 
                 GROUP BY HOST_ID
                 HAVING COUNT(HOST_ID) >= 2)
ORDER BY ID ; 



/* "Long-term protected animals (2)"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/59411#qna
Problem: Please write a SQL statement to retrieve the IDs and names of the two animals with the longest foster care periods among those adopted. The results should be sorted by longest foster care period.
*/
-- Solution 
SELECT
ANIMAL_ID,
NAME
FROM (SELECT I.ANIMAL_ID, I.NAME, DATEDIFF(O.DATETIME, I.DATETIME) AS DURATION
     FROM ANIMAL_INS I
     LEFT JOIN ANIMAL_OUTS O
     ON I.ANIMAL_ID = O.ANIMAL_ID
     ORDER BY DURATION DESC
     LIMIT 2) AS A ;

 
 /* "Long-term protected animals (1)"
 Link: https://school.programmers.co.kr/learn/courses/30/lessons/59044
 Problem: Please write a SQL statement to retrieve the names and start dates of the three animals that have been in the shelter the longest, among those who have not yet been adopted. The results should be sorted by start date.
 */
 -- Solution 
 SELECT
I.NAME,
I.DATETIME
FROM ANIMAL_INS I 
LEFT JOIN ANIMAL_OUTS O
ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE O.DATETIME IS NULL
ORDER BY I.DATETIME 
LIMIT 3 ; 

/* "It was there, but it wasn't there"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/59043
Problem: An administrator's mistake resulted in incorrect adoption dates for some animals. Please write a SQL statement to retrieve the IDs and names of animals whose adoption dates are earlier than their care start dates. The results should be sorted by the earliest care start date.
*/
-- Solution 
SELECT
I.ANIMAL_ID,
I.NAME
FROM ANIMAL_INS I
LEFT JOIN ANIMAL_OUTS O
ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE I.DATETIME > O.DATETIME 
ORDER BY I.DATETIME ; 


/* "Finding Lost Records"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/59042
Problem: Due to a natural disaster, some data was lost. Please write an SQL statement to retrieve the IDs and names of animals that have been adopted but have no record of entering the shelter, sorted by ID.
*/
-- Solution 
SELECT
O.ANIMAL_ID, 
O.NAME
FROM ANIMAL_INS I
RIGHT JOIN ANIMAL_OUTS O
ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE I.DATETIME IS NULL AND O.DATETIME IS NOT NULL
ORDER BY I.ANIMAL_ID ;

-- DONE 