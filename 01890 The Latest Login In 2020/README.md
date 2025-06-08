# 01890 - The Latest Login In 2020
    
**Language:** Mysql  
**Runtime:** 699 ms (Beats 28.44% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The problem requires us to find the latest login timestamp for each user in the year 2020 from a table called `Logins`. We need to return the user ID and their latest login timestamp, but only for those entries that occurred in the year 2020.

**Sample Input:**

```
Logins table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 6       | 2020-03-05 00:00:00 |
| 1       | 2020-02-10 00:00:00 |
| 6       | 2021-04-12 00:00:00 |
| 3       | 2019-01-01 00:00:00 |
| 2       | 2020-08-20 00:00:00 |
| 2       | 2020-08-03 00:00:00 |
| 7       | 2021-01-01 00:00:00 |
| 6       | 2020-05-14 00:00:00 |
| 2       | 2020-08-21 00:00:00 |
+---------+---------------------+
```

**Expected Output:**

```
+---------+---------------------+
| user_id | last_stamp          |
+---------+---------------------+
| 1       | 2020-02-10 00:00:00 |
| 2       | 2020-08-21 00:00:00 |
| 6       | 2020-05-14 00:00:00 |
+---------+---------------------+
```

Only the latest login for the year 2020 is considered. User ID 3 and 7 are excluded as they have no login records in 2020. User ID 6 has a login in 2021 but the query only considers 2020 logins.

## 📊 **Algorithm**

*   Filter the `Logins` table to include only entries from the year 2020.
*   Group the filtered results by `user_id`.
*   For each user, find the maximum (latest) `time_stamp`.
*   Return the `user_id` and the corresponding latest `time_stamp`.

## 🔥 **Code Implementation**

```mysql
select 
    l.user_id,
    MAX(l.time_stamp) last_stamp
from 
    Logins l
where
    YEAR(l.time_stamp) = 2020
group by
    l.user_id
```

## 📊 **ASCII Representation**

```
Logins Table:

+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 6       | 2020-03-05 00:00:00 |
| 1       | 2020-02-10 00:00:00 |
| 6       | 2021-04-12 00:00:00 |
| 3       | 2019-01-01 00:00:00 |
| 2       | 2020-08-20 00:00:00 |
| 2       | 2020-08-03 00:00:00 |
| 7       | 2021-01-01 00:00:00 |
| 6       | 2020-05-14 00:00:00 |
| 2       | 2020-08-21 00:00:00 |
+---------+---------------------+
```

## 📊 **WORKING**

Let's trace the execution with the provided sample input:

1.  **Filtering for the year 2020:**

    The `WHERE` clause `YEAR(l.time_stamp) = 2020` filters the `Logins` table to include only records where the year of the `time_stamp` is 2020.

    Filtered Table:

    ```
    +---------+---------------------+
    | user_id | time_stamp          |
    +---------+---------------------+
    | 6       | 2020-03-05 00:00:00 |
    | 1       | 2020-02-10 00:00:00 |
    | 2       | 2020-08-20 00:00:00 |
    | 2       | 2020-08-03 00:00:00 |
    | 6       | 2020-05-14 00:00:00 |
    | 2       | 2020-08-21 00:00:00 |
    +---------+---------------------+
    ```

2.  **Grouping by `user_id`:**

    The `GROUP BY l.user_id` clause groups the filtered table by the `user_id`.

    Groups:

    *   `user_id = 1`: Records `2020-02-10 00:00:00`
    *   `user_id = 2`: Records `2020-08-20 00:00:00`, `2020-08-03 00:00:00`, `2020-08-21 00:00:00`
    *   `user_id = 6`: Records `2020-03-05 00:00:00`, `2020-05-14 00:00:00`

3.  **Finding the Maximum `time_stamp` for each group:**

    The `MAX(l.time_stamp)` function calculates the maximum (latest) timestamp within each group.

    *   For `user_id = 1`, max(`2020-02-10 00:00:00`) is `2020-02-10 00:00:00`.
    *   For `user_id = 2`, max(`2020-08-20 00:00:00`, `2020-08-03 00:00:00`, `2020-08-21 00:00:00`) is `2020-08-21 00:00:00`.
    *   For `user_id = 6`, max(`2020-03-05 00:00:00`, `2020-05-14 00:00:00`) is `2020-05-14 00:00:00`.

4.  **Final Result:**

    The query returns the `user_id` and the calculated maximum `time_stamp` (aliased as `last_stamp`) for each group.

    ```
    +---------+---------------------+
    | user_id | last_stamp          |
    +---------+---------------------+
    | 1       | 2020-02-10 00:00:00 |
    | 2       | 2020-08-21 00:00:00 |
    | 6       | 2020-05-14 00:00:00 |
    +---------+---------------------+
    ```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the filtering (`WHERE`) and grouping (`GROUP BY`) operations. In the worst case, the query might have to scan the entire table. Therefore, the time complexity is **O(N)**, where N is the number of rows in the `Logins` table.
*   **Space Complexity:** The space complexity depends on the number of unique `user_id` values in the filtered table, as the `GROUP BY` operation requires storing intermediate results. In the worst case, if all rows have unique `user_id` values, the space complexity could be **O(N)**. However, in practice, it is usually less, depending on the data distribution.
    