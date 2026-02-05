/* "The Pad"
Link: https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=true
Problem: Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

*/
-- Solution
SELECT 
CONCAT(NAME, "(", LEFT(OCCUPATION,1), ")") AS NAME_INFO
FROM OCCUPATIONS
ORDER BY NAME  ;

SELECT 
CONCAT("There are a total of", " ", COUNT(*), " " , LOWER(OCCUPATION), "s.") AS OCCU_INFO
FROM OCCUPATIONS 
GROUP BY OCCUPATION
ORDER BY COUNT(*) , OCCUPATION ;

/* "Occupations"
Link: https://www.hackerrank.com/challenges/occupations/problem?isFullScreen=true
Problem: Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output should consist of four columns (Doctor, Professor, Singer, and Actor) in that specific order, with their respective names listed alphabetically under each column.
Note: Print NULL when there are no more names corresponding to an occupation.
*/
-- Solution 
WITH A AS (
    SELECT
    CASE WHEN OCCUPATION = 'Doctor' THEN NAME END AS Doctor,
    CASE WHEN OCCUPATION = 'Professor' THEN NAME END AS Professor,
    CASE WHEN OCCUPATION = 'Singer' THEN NAME END AS Singer,
    CASE WHEN OCCUPATION = 'Actor' THEN NAME END AS Actor,
    ROW_NUMBER( ) over(PARTITION BY OCCUPATION ORDER BY NAME) AS NR
    FROM OCCUPATIONS
    )

SELECT MAX(Doctor), MAX(Professor), MAX(Singer), MAX(Actor)
FROM A  
GROUP BY NR ; 

/* "Binary Tree Nodes"
Link: https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true
Problem: You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
*/
-- Solution
WITH A AS (
    SELECT 
    CASE 
    WHEN P IS NULL THEN 'Root' 
    WHEN N IN (SELECT P FROM BST) THEN 'Inner'
    ELSE 'Leaf'
    END AS ART ,
    N, P
    FROM BST
) 

SELECT N, ART
FROM A
ORDER BY N ; 

/* "New Companies"
Link: https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true
Problem: Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy:
Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
Note:
The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.
*/
-- Solution 1
SELECT
C.COMPANY_CODE, FOUNDER, 
COUNT(DISTINCT L.LEAD_MANAGER_CODE),
COUNT(DISTINCT S.SENIOR_MANAGER_CODE),
COUNT(DISTINCT M.MANAGER_CODE),
COUNT(DISTINCT E.EMPLOYEE_CODE)
FROM COMPANY C 
JOIN Lead_Manager L
ON C.COMPANY_CODE = L.COMPANY_CODE 
JOIN SENIOR_MANAGER S 
ON C.COMPANY_CODE = S.COMPANY_CODE
JOIN MANAGER M 
ON C.COMPANY_CODE = M.COMPANY_CODE
JOIN EMPLOYEE E 
ON C.COMPANY_CODE = E.COMPANY_CODE
GROUP BY C.COMPANY_CODE, founder
ORDER BY COMPANY_CODE
-- Solution 2 
SELECT 
C.COMPANY_CODE, C.FOUNDER,
COALESCE(L.CNT, 0) AS Lead_managers,
COALESCE(S.CNT, 0) AS Senior_managers,
COALESCE(M.CNT, 0) AS Managers,
COALESCE(E.CNT, 0) AS employees
FROM COMPANY C
LEFT JOIN (SELECT COMPANY_CODE, COUNT(DISTINCT LEAD_MANAGER_CODE) AS CNT FROM LEAD_MANAGER GROUP BY COMPANY_CODE) L 
ON L.COMPANY_CODE = C.COMPANY_CODE 
LEFT JOIN (SELECT COMPANY_CODE, COUNT(DISTINCT SENIOR_MANAGER_CODE) AS CNT FROM SENIOR_MANAGER GROUP BY COMPANY_CODE ) S
ON S.COMPANY_CODE = C.COMPANY_CODE 
LEFT JOIN (SELECT COMPANY_CODE, COUNT(DISTINCT MANAGER_CODE) AS CNT FROM MANAGER GROUP BY COMPANY_CODE) M
ON M.COMPANY_CODE = C.COMPANY_CODE
LEFT JOIN (SELECT COMPANY_CODE, COUNT(DISTINCT EMPLOYEE_CODE) AS CNT FROM EMPLOYEE GROUP BY COMPANY_CODE) E
ON E.COMPANY_CODE = C.COMPANY_CODE 
ORDER BY C.COMPANY_CODE ; 