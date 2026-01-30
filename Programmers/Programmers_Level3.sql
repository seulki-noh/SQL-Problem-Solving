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
