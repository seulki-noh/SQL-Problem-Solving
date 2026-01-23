# Programmers Level 1 Colliection

# Reverse Sorting
Link: https://school.programmers.co.kr/learn/courses/30/lessons/59035

## Problem 
Please write an SQL query to retrieve the name and date of admission for every animal that has entered the animal shelter. The results should be displayed in reverse ANIMAL_ID order. 

## Solution
```sql
SELECT
    NAME,
    DATETIME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID DESC; 
```

# Finding sick Animals 
 Link: https://school.programmers.co.kr/learn/courses/30/lessons/59036

## Problem
Please write an SQL query to retrieve the ID and name of the sick animal among those admitted to the animal shelter. The results should be retrieved in ID order.

## Solution
```sql
SELECT
    ANIMAL_ID,
    NAME
FROM ANIMAL_INS
WHERE
    INTAKE_CONDITION = "sick"
ORDER BY ANIMAL_ID;
```


# Popular ice cream
Link: https://school.programmers.co.kr/learn/courses/30/lessons/133024

## Problem
Please write an SQL query that sorts the flavors of ice cream sold in the first half of the year in descending order based on total order volume. If the total order volume is the same, sort them in ascending order based on the shipment number.

## Solution
```sql
SELECT
    DISTINCT FLAVOR  
FROM FIRST_HALF
ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID ASC; 
```

# Calculating the average daily rental rate
Link: https://school.programmers.co.kr/learn/courses/30/lessons/151136

# Problem
Please write an SQL statement that outputs the average daily rental fee for vehicles with the type ‘SUV’ in the CAR_RENTAL_COMPANY_CAR table. Round the average daily rental fee to the first decimal place, and name the column AVERAGE_FEE.

# Solution
```sql
SELECT ROUND(AVG(DAILY_FEE)) AS AVERAGE_FEE
FROM CAR_RENTAL_COMPANY_CAR
WHERE CAR_TYPE = "SUV" ;
```

# Finding a list of cars with specific options
Link: https://school.programmers.co.kr/learn/courses/30/lessons/157343

# Problem
Please write an SQL statement that outputs a list of cars from the CAR_RENTAL_COMPANY_CAR table that include the ‘Navigation’ option. Sort the results in descending order by car ID.

# Solution
```sql
SELECT CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS 
FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS like "%네비게이션%"
ORDER BY CAR_ID DESC;
```
