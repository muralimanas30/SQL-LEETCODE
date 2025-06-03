# Write your MySQL query statement below
SELECT player_id,min(event_date) as first_login
FROM ACTIVITY
GROUP BY PLAYER_ID
ORDER BY PLAYER_ID