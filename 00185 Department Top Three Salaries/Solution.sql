# Write your MySQL query statement below
SELECT Department,
        Employee,
        Salary
FROM
(
    SELECT D.NAME AS Department,
    E.NAME AS Employee,
    E.SALARY AS Salary,
    DENSE_RANK() OVER (PARTITION BY D.ID ORDER BY SALARY DESC) AS "S_RANK"
    FROM EMPLOYEE E
    JOIN DEPARTMENT D
    ON E.DEPARTMENTID = D.ID
) AS SUBQUERY
where SUBQUERY.S_RANK<=3