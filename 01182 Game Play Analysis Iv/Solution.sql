WITH FIRST_LOGIN AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_login 
    FROM activity
    GROUP BY player_id
),
NEXT_LOGIN AS (
    SELECT 
        a.player_id,
        a.event_date
    FROM activity a
    JOIN FIRST_LOGIN f
        ON a.player_id = f.player_id
       AND DATEDIFF(a.event_date, f.first_login) = 1
)
SELECT 
    ROUND(COUNT(DISTINCT nl.player_id) / COUNT(DISTINCT fl.player_id), 2) AS fraction
FROM FIRST_LOGIN fl
LEFT JOIN NEXT_LOGIN nl
    ON fl.player_id = nl.player_id;
