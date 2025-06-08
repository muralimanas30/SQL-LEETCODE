# Write your MySQL query statement below

SELECT ACTIVITY_DATE AS day,COUNT(DISTINCT(USER_ID)) AS active_users
FROM ACTIVITY
GROUP BY ACTIVITY_DATE
HAVING COUNT(*)>=1 -- consider having atleast one active user
AND ACTIVITY_DATE 
    BETWEEN ADDDATE('2019-07-27', INTERVAL -29 DAY)
    AND '2019-07-27'-- inclusive