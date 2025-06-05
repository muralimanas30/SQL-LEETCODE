# Write your MySQL query statement below

SELECT 
  ID,
  CASE
    WHEN ID % 2 = 1 THEN COALESCE(LEAD(student) OVER (ORDER BY ID), student)
    WHEN ID % 2 = 0 THEN LAG(student) OVER (ORDER BY ID)
  END AS student
FROM SEAT;
