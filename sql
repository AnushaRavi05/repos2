1.You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.

SELECT 
    N, 
    CASE 
        WHEN P IS NULL THEN 'Root'
        WHEN N NOT IN (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS NodeType
FROM BST
ORDER BY N;

2.Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 
Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers,
total number of senior managers, total number of managers, and total number of employees. 
 Order your output by ascending company_code.

    SELECT c.company_code, 
       c.founder, 
       COUNT(DISTINCT lm.lead_manager_code) AS total_lead_managers, 
       COUNT(DISTINCT sm.senior_manager_code) AS total_senior_managers, 
       COUNT(DISTINCT m.manager_code) AS total_managers, 
       COUNT(DISTINCT e.employee_code) AS total_employees
FROM Company c
LEFT JOIN Lead_Manager lm ON c.company_code = lm.company_code
LEFT JOIN Senior_Manager sm ON c.company_code = sm.company_code
LEFT JOIN Manager m ON c.company_code = m.company_code
LEFT JOIN Employee e ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;
3.Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal places.
    select TRUNC(SUM(LAT_N),4) AS truncated value 
    from STATION
    where LAT_N>38.7880  and LAT_N <137.2345 ;
4.Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.
 SELECT TRUNC(MAX(LAT_N),4) AS truncated_value
from STATION
where LAT_N < 137.2345;
5.Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to 4 decimal places.
    select ROUND(MIN(LAT_N),4) AS rounded_value
    from STATION
    WHERE LAT_N > 38.7780;
6.Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
    SELECT SUM(POPULATIONS) AS total_population
    FROM CITY c
    JOIN COUNTRY co ON c.countrycode=co.code
    where co.CONTINENT='Asia';
 7.Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output should consist of four columns (Doctor, Professor, Singer, and Actor) in that specific order, with their respective names listed alphabetically under each column.
Note: Print NULL when there are no more names corresponding to an occupation.
    SELECT
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
FROM (
    SELECT 
        Name, 
        Occupation, 
        ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS row_num
    FROM OCCUPATIONS
) ranked
GROUP BY row_num
ORDER BY row_num;
8.A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
    WITH Ordered_Latitudes AS (
    SELECT LAT_N, 
           ROW_NUMBER() OVER (ORDER BY LAT_N) AS RowAsc,
           COUNT(*) OVER () AS TotalRows
    FROM STATION
)
SELECT 
    ROUND(
        CASE 
            WHEN MOD(TotalRows, 2) = 1 THEN  
                (SELECT LAT_N 
                 FROM Ordered_Latitudes 
                 WHERE RowAsc = (TotalRows + 1) / 2)
            ELSE  
                (SELECT AVG(LAT_N) 
                 FROM Ordered_Latitudes 
                 WHERE RowAsc IN (TotalRows / 2, TotalRows / 2 + 1))
        END,
        4
    ) AS Median_Latitude
FROM Ordered_Latitudes
WHERE RowAsc = 1;


    

