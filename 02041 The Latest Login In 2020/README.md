# 02041 - The Latest Login In 2020
    
**Language:** Mysql  
**Runtime:** 699 ms (Beats 27.48% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                    | 🔗 Link                                                                 |
|------------------|-----------------------------|-------------------------------------------------------------------------|
| 2041             | The Latest Login in 2020 | [LeetCode Problem](https://leetcode.com/problems/the-latest-login-in-2020/) |

---

## 💡 **Problem Explanation**

The problem requires us to find the latest login timestamp for each user in the year 2020 from a table of user login activities. We need to return the `user_id` and the latest `time_stamp` for each user, but only for the logins that occurred in the year 2020.

**Example:**

Let's say we have a `Logins` table like this:

```
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 6       | 2020-06-30 23:59:59 |
| 6       | 2021-01-01 12:00:00 |
| 6       | 2020-01-01 00:00:00 |
| 3       | 2019-01-01 00:00:00 |
| 3       | 2020-01-01 00:00:00 |
| 5       | 2020-12-31 23:59:59 |
+---------+---------------------+
```

The expected output should be:

```
+---------+---------------------+
| user_id | last_stamp          |
+---------+---------------------+
| 6       | 2020-06-30 23:59:59 |
| 3       | 2020-01-01 00:00:00 |
| 5       | 2020-12-31 23:59:59 |
+---------+---------------------+
```

Only the logins in 2020 are considered, and for each `user_id`, the latest timestamp is returned.

## 📊 **Algorithm**

*   Filter the `Logins` table to include only the records where the year of `time_stamp` is 2020.
*   Group the filtered records by `user_id`.
*   Find the maximum `time_stamp` (i.e., the latest login) for each group.
*   Select the `user_id` and the corresponding maximum `time_stamp` as `last_stamp`.

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

This problem primarily involves table manipulation rather than spatial structures, so ASCII diagrams are not directly applicable.

## 📊 **WORKING**

Let's walk through the given sample input:

```
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 6       | 2020-06-30 23:59:59 |
| 6       | 2021-01-01 12:00:00 |
| 6       | 2020-01-01 00:00:00 |
| 3       | 2019-01-01 00:00:00 |
| 3       | 2020-01-01 00:00:00 |
| 5       | 2020-12-31 23:59:59 |
+---------+---------------------+
```

1.  **Filter by Year:**  The `WHERE` clause `YEAR(l.time_stamp) = 2020` filters the table.

    ```
    +---------+---------------------+
    | user_id | time_stamp          |
    +---------+---------------------+
    | 6       | 2020-06-30 23:59:59 |
    | 6       | 2020-01-01 00:00:00 |
    | 3       | 2020-01-01 00:00:00 |
    | 5       | 2020-12-31 23:59:59 |
    +---------+---------------------+
    ```

2.  **Group by User ID:** The `GROUP BY l.user_id` clause groups the filtered data by user ID.

    *   User ID 6:  Timestamps `2020-06-30 23:59:59` and `2020-01-01 00:00:00`.
    *   User ID 3:  Timestamp `2020-01-01 00:00:00`.
    *   User ID 5:  Timestamp `2020-12-31 23:59:59`.

3.  **Find Maximum Timestamp:** The `MAX(l.time_stamp)` function finds the latest timestamp within each group.

    *   User ID 6: `2020-06-30 23:59:59`.
    *   User ID 3: `2020-01-01 00:00:00`.
    *   User ID 5: `2020-12-31 23:59:59`.

4.  **Final Result:** The query returns the `user_id` and the corresponding `last_stamp`.

    ```
    +---------+---------------------+
    | user_id | last_stamp          |
    +---------+---------------------+
    | 6       | 2020-06-30 23:59:59 |
    | 3       | 2020-01-01 00:00:00 |
    | 5       | 2020-12-31 23:59:59 |
    +---------+---------------------+
    ```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity mainly depends on the table size and the indexing on the `time_stamp` and `user_id` columns. In general, it's **O(n)**, where n is the number of rows in the `Logins` table because the query might need to scan all rows. However, if appropriate indexes are set, this can be significantly reduced.  The `MAX()` function within the groups typically has a low impact.
*   **Space Complexity:** The space complexity is **O(m)**, where m is the number of distinct `user_id` values that have at least one login in 2020.  This is because we need to store the maximum timestamp for each user.
    