SELECT event_day as day,emp_id,
    (SELECT ((SUM(out_time-in_time)))) as total_time
FROM EMPLOYEES
GROUP BY event_day,emp_id
