/* "Finding E. coli from a specific generation"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/301650#qna
Problem:
Please write an SQL statement to output the IDs of the third generation of E. coli. Sort the results in ascending order by the E. coli ID.
*/
-- Solution
SELECT 
    T.ID
FROM ECOLI_DATA AS T
JOIN ECOLI_DATA AS S
ON T.PARENT_ID = S.ID
JOIN ECOLI_DATA AS F
ON S.PARENT_ID = F.ID
WHERE ISNULL(F.PARENT_ID)
ORDER BY T.ID ;

/* "Viewing the evaluation grade and performance bonus corresponding to the annual evaluation score"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/284528
Problem: I need to query performance bonus information for each employee using the HR_DEPARTMENT, HR_EMPLOYEES, and HR_GRADE tables. When the evaluation grade and corresponding bonus information per score are as follows, please write an SQL statement to retrieve the employee ID, name, evaluation grade, and bonus amount.

The column name for the evaluation grade should be GRADE, and the column name for the performance bonus should be BONUS.
Please sort the results in ascending order by employee ID.
*/
-- Solution 
SELECT 
    E.EMP_NO,
    E.EMP_NAME,
    G.GRADE,
    CASE
        WHEN GRADE = "S" THEN SAL * 0.2
        WHEN GRADE = "A" THEN SAL * 0.15
        WHEN GRADE = "B" THEN SAL * 0.1
        ELSE 0
        END AS BONUS
FROM (SELECT EMP_NO,
      CASE 
        WHEN AVG(SCORE) >= 96 THEN "S"
        WHEN AVG(SCORE) >= 90 THEN "A"
        WHEN AVG(SCORE) >= 80 THEN "B"
        ELSE "C"
        END AS GRADE 
     FROM HR_GRADE
     GROUP BY EMP_NO) G
JOIN HR_EMPLOYEES E
ON G.EMP_NO = E.EMP_NO
GROUP BY EMP_NO ;

/* "Classifying Developers by Language"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/276036
Problem: 
I want to query developer information by GRADE from the DEVELOPERS table. GRADE is defined as follows:

A: Developers possessing both Front End and Python skills
B: Developers possessing C# skills
C: Other Front End developers
Please write an SQL statement to retrieve the GRADE, ID, and EMAIL of developers for whom a GRADE exists.

Please sort the results in ascending order by GRADE and ID.
*/
-- Solution
WITH 
p as (
SELECT CODE FROM SKILLCODES WHERE NAME = "Python"),
c as (
SELECT CODE FROM SKILLCODES WHERE NAME = "C#"),
f as (
SELECT SUM(CODE) AS CODE FROM SKILLCODES WHERE CATEGORY = "Front End")

SELECT 
    CASE 
        WHEN SKILL_CODE & p.CODE && SKILL_CODE & f.CODE then 'A'
        WHEN SKILL_CODE & c.CODE THEN 'B'
        WHEN SKILL_CODE & f.CODE THEN 'C'
    END AS GRADE ,
    ID,
    EMAIL 
FROM DEVELOPERS, p, c, f
HAVING GRADE IS NOT NULL
ORDER BY GRADE, ID ;

/* "Looking for a Front-End Developer"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/276035#qna
Problem: I want to retrieve information about developers with Front End skills from the DEVELOPERS table. Please write an SQL statement to retrieve the ID, email, first name, and last name of developers matching the criteria.

Please sort the results in ascending order by ID.
*/
-- Solution
WITH F AS (
SELECT SUM(CODE) AS CODE FROM SKILLCODES WHERE CATEGORY = "Front End")

SELECT 
    D.ID,
    D.EMAIL,
    D.FIRST_NAME,
    D.LAST_NAME
FROM DEVELOPERS D, F
WHERE D.SKILL_CODE & F.CODE
ORDER BY D.ID ;

/* "Calculating the rental cost for vehicles available for rent during a specific period"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/157339#qna
Problem: 
The CAR_RENTAL_COMPANY_CAR table, CAR_RENTAL_COMPANY_RENTAL_HISTORY table, and CAR_RENTAL_COMPANY_DISCOUNT_PLAN table contain vehicles where the type is 'Sedan' or ‘SUV’ that are available for rental from November 1, 2022, to November 30, 2022, and have a rental fee for the 30-day period between 500,000 KRW and 2,000,000 KRW. Sort the results in descending order by rental fee. If rental fees are the same, sort in ascending order by vehicle type. If vehicle types are also the same, sort in descending order by vehicle ID.
*/
-- Solution 
SELECT
    DISTINCT C.CAR_ID,
    P.CAR_TYPE,
    FLOOR(DAILY_FEE * 30 * (1 - DISCOUNT_RATE/100)) AS FEE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY AS H
JOIN CAR_RENTAL_COMPANY_CAR C
    ON H.CAR_ID = C.CAR_ID 
JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN AS P
    ON C.CAR_TYPE = P.CAR_TYPE AND P.DURATION_TYPE = "30일 이상"
WHERE C.CAR_TYPE IN ('세단', 'SUV') 
    AND C.CAR_ID NOT IN (SELECT CAR_ID FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
              WHERE NOT (START_DATE > '2022-11-30' OR END_DATE < '2022-11-01') )
HAVING FEE BETWEEN 500000 AND 2000000-1
ORDER BY 3 DESC, 2 ASC, 1 DESC ;

/* "Find rental amount by car rental record"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/151141#qna
Problem: Please write a SQL statement that finds the rental amount (column name: FEE) for each rental record of a car whose type is 'Truck' in the CAR_RENTAL_COMPANY_CAR, CAR_RENTAL_COMPANY_RENTAL_HISTORY, and CAR_RENTAL_COMPANY_DISCOUNT_PLAN tables and outputs a list of rental record IDs and rental amounts. Sort the results in descending order by rental amount, and if the rental amounts are the same, sort them in descending order by rental record ID.
*/
-- Solution 
WITH A AS (
SELECT H.CAR_ID, CAR_TYPE, HISTORY_ID, (DATEDIFF(END_DATE, START_DATE)+1) AS DURATION, DAILY_FEE 
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
    LEFT JOIN CAR_RENTAL_COMPANY_CAR C
    ON H.CAR_ID = C.CAR_ID
    WHERE C.CAR_TYPE = '트럭'
)

SELECT HISTORY_ID, 
FLOOR(DAILY_FEE * DURATION * (1 - IFNULL(P.DISCOUNT_RATE, 0) / 100)) AS FEE
FROM A 
LEFT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN P
ON A.CAR_TYPE = P.CAR_TYPE AND 
P.DURATION_TYPE = 
    CASE
    WHEN DURATION >= 90 THEN "90일 이상"
    WHEN DURATION >= 30 THEN "30일 이상"
    WHEN DURATION >= 7 THEN "7일 이상"
    ELSE NULL
    END 
GROUP BY HISTORY_ID
ORDER BY FEE DESC, HISTORY_ID DESC ; 


/* "Aggregate sales by category and author"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/144856
Problem: Based on book sales data from January 2022, please write an SQL statement that calculates sales by author and category (TOTAL_SALES = sales volume * sales price) and outputs a list of author IDs (AUTHOR_ID), author names (AUTHOR_NAME), categories (CATEGORY), and sales (SALES). Sort the results in ascending order by author ID, or, if the author IDs are the same, in descending order by category.
*/
-- Solution 
SELECT
B.AUTHOR_ID,
A.AUTHOR_NAME,
B.CATEGORY,
SUM(S.SALES * B.PRICE) AS TOTAL_SALES
FROM BOOK B
LEFT JOIN AUTHOR A
ON B.AUTHOR_ID = A.AUTHOR_ID
LEFT JOIN BOOK_SALES S
ON B.BOOK_ID = S.BOOK_ID
WHERE DATE_FORMAT(S.SALES_DATE, '%Y-%m') = '2022-01'
GROUP BY A.AUTHOR_ID, B.CATEGORY 
ORDER BY AUTHOR_ID , CATEGORY DESC 


/* "Check out the most popular ice creams"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/133027
Problem: Please write a SQL statement to retrieve the top 3 flavors based on the sum of the total ice cream orders in July and the total ice cream orders in the first half of the year.
*/
-- Solution
WITH A AS (
SELECT FLAVOR, 
SUM(TOTAL_ORDER) AS TOTAL_ORDER 
    FROM JULY 
    GROUP BY FLAVOR 
)

SELECT FLAVOR
FROM (SELECT H.FLAVOR, 
      SUM(H.TOTAL_ORDER + A.TOTAL_ORDER) AS TOTAL
     FROM FIRST_HALF H 
     LEFT JOIN A 
     ON H.FLAVOR = A.FLAVOR
     GROUP BY FLAVOR
     ) F
ORDER BY TOTAL DESC
LIMIT 3 ; 



/* "Check your uncanceled appointments"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/132204#qna
Problem: Please write a SQL statement to retrieve all unreserved thoracic surgery (CS) appointments from the PATIENT, DOCTOR, and APPOINTMENT tables as of April 13, 2022. Please output the appointment number, patient name, patient ID, department code, physician name, and appointment date and time. Sort the results in ascending order by appointment date and time.
*/
-- Solution 
WITH A AS (
SELECT * 
    FROM APPOINTMENT 
    WHERE APNT_CNCL_YN = 'N' AND DATE_FORMAT(APNT_YMD, '%Y-%m-%d') = '2022-04-13' AND MCDP_CD = 'CS'
)

SELECT
A.APNT_NO,
P.PT_NAME,
P.PT_NO, 
D.MCDP_CD, 
D.DR_NAME, 
A.APNT_YMD 
FROM PATIENT P
RIGHT JOIN A
ON A.PT_NO = P.PT_NO
LEFT JOIN DOCTOR D
ON A.MDDR_ID = D.DR_ID
ORDER BY A.APNT_YMD ; 

/* "Integrating offline and online sales data"
Link: https://school.programmers.co.kr/learn/courses/30/lessons/131537#qna
Problem: Please write a SQL statement that outputs the sales date, product ID, user ID, and sales volume for offline/online product sales data for March 2022 from the ONLINE_SALE and OFFLINE_SALE tables. Please mark the USER_ID value in the OFFLINE_SALE table as NULL. Sort the results in ascending order by sales date. If the sales date is the same, sort by product ID in ascending order. If the product ID is the same, sort by user ID in ascending order.
*/
-- Solution
