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