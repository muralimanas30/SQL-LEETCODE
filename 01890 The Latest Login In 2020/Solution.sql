select 
    l.user_id,
    MAX(l.time_stamp) last_stamp
from 
    Logins l
where
    YEAR(l.time_stamp) = 2020
group by
    l.user_id