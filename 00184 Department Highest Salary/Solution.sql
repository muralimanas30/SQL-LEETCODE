SELECT Department,Employee,Salary
FROM (
    SELECT 
        D.NAME AS Department,
        E.Name AS Employee,
        E.salary AS Salary,
        RANK() OVER (PARTITION BY D.ID ORDER BY E.Salary DESC) AS rk
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPARTMENTID = D.ID
) AS Ranked
WHERE rk = 1;
