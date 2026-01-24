/* "View comments on used goods listings that meet the criteria" 
Link: https://school.programmers.co.kr/learn/courses/30/lessons/164673
Problem:
Please write an SQL query to retrieve the post title, post ID, comment ID, comment author ID, comment content, and comment date from the USED_GOODS_BOARD and USED_GOODS_REPLY tables for posts created in October 2022. 
Sort the results in ascending order by comment date. If the comment dates are the same, sort in ascending order by post title.
*/

-- Solution 
SELECT B.TITLE, B.BOARD_ID, R.REPLY_ID, R.WRITER_ID, R.CONTENTS, 
DATE_FORMAT(R.CREATED_DATE,'%Y-%m-%d') AS CREATED_DATE
FROM USED_GOODS_BOARD B
    JOIN USED_GOODS_REPLY R
    ON B.BOARD_ID = R.BOARD_ID
WHERE B.CREATED_DATE LIKE '2022-10%'
ORDER BY R.CREATED_DATE, B.TITLE ;



/* "Reverse Sorting"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/59035
Problem :
Please write an SQL query to retrieve the name and date of admission for every animal that has entered the animal shelter. The results should be displayed in reverse ANIMAL_ID order. 
*/

-- Solution 
SELECT
    NAME,
    DATETIME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID DESC; 


/* "Finding sick Animals" 
Link: https://school.programmers.co.kr/learn/courses/30/lessons/59036
Problem:
Please write an SQL query to retrieve the ID and name of the sick animal among those admitted to the animal shelter. The results should be retrieved in ID order.
*/

-- Solution 

SELECT
    ANIMAL_ID,
    NAME
FROM ANIMAL_INS
WHERE
    INTAKE_CONDITION = "sick"
ORDER BY ANIMAL_ID;



/* "Popular ice cream"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/133024

Problem
Please write an SQL query that sorts the flavors of ice cream sold in the first half of the year in descending order based on total order volume. If the total order volume is the same, sort them in ascending order based on the shipment number.
*/

--Solution

SELECT
    DISTINCT FLAVOR  
FROM FIRST_HALF
ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID ASC; 


/* "Calculating the average daily rental rate"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/151136
Problem
Please write an SQL statement that outputs the average daily rental fee for vehicles with the type ‘SUV’ in the CAR_RENTAL_COMPANY_CAR table. Round the average daily rental fee to the first decimal place, and name the column AVERAGE_FEE.
*/

-- Solution

SELECT ROUND(AVG(DAILY_FEE)) AS AVERAGE_FEE
FROM CAR_RENTAL_COMPANY_CAR
WHERE CAR_TYPE = "SUV" ;


/* "Finding a list of cars with specific options"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/157343
Problem:
Please write an SQL statement that outputs a list of cars from the CAR_RENTAL_COMPANY_CAR table that include the ‘Navigation’ option. Sort the results in descending order by car ID.
*/

-- Solution

SELECT CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS 
FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS like "%네비게이션%"
ORDER BY CAR_ID DESC;

/* "Top n records"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/59405
Problem:
Please write an SQL statement to retrieve the name of the first animal admitted to the animal shelter.
*/

-- Solution
SELECT
    NAME
FROM ANIMAL_INS
ORDER BY DATETIME
LIMIT 1; 

/* "The ID of the nameless animal"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/59039

