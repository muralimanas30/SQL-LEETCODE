# Write your MySQL query statement below

SELECT ID,
    (
        CASE WHEN P_ID IS NULL THEN "Root"
            WHEN ID IN (SELECT P_ID FROM TREE) THEN "Inner"
            ELSE "Leaf"
        END
    ) as type
FROM TREE;