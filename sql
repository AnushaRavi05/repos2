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

