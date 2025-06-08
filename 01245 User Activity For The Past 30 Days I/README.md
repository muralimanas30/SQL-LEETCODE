# 01245 - User Activity For The Past 30 Days I
    
**Language:** Mysql  
**Runtime:** 429 ms (Beats 99.70% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                           | 🔗 Link                                                              |
| ------------------ | --------------------------------- | --------------------------------------------------------------------- |
| 1141               | User Activity for the Past 30 Days I | [LeetCode Problem](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/) |

## 💡 **Problem Explanation**

The problem asks us to find the number of active users each day within a specific 30-day window leading up to '2019-07-27'. An active user is defined as a user who has at least one activity on a given day. We need to group the activities by date and count the distinct user IDs for each day, filtering the results to include only the days within the specified date range.

**Example:**

**Activity Table:**

| user_id | activity_date |
| ------- | ------------- |
| 1       | 2019-07-01    |
| 1       | 2019-07-02    |
| 2       | 2019-07-01    |
| 3       | 2019-07-08    |
| 1       | 2019-07-27    |
| 4       | 2019-07-28    |
| 2       | 2019-07-27    |

**Expected Output:**

| day        | active_users |
| ---------- | ------------ |
| 2019-07-01 | 2            |
| 2019-07-02 | 1            |
| 2019-07-08 | 1            |
| 2019-07-27 | 2            |

## 📊 **Algorithm**

*   Select the `activity_date` as `day` and count of distinct `user_id` as `active_users`.
*   Group the results by `activity_date`.
*   Filter the results to include only the activities within the 30-day window from '2019-07-27' (inclusive).
*   Ensure that there is at least one activity on each selected day (`COUNT(*) >= 1`). This condition may not be strictly necessary since grouping by date inherently ensures at least one activity, but it's good practice to include such constraints if they are part of the problem requirements or assumptions.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT
    activity_date AS day,
    COUNT(DISTINCT(user_id)) AS active_users
FROM
    Activity
WHERE
    activity_date BETWEEN ADDDATE('2019-07-27', INTERVAL -29 DAY) AND '2019-07-27'
GROUP BY
    activity_date
```

## 📊 **ASCII Representation**

Here's an ASCII representation of the `Activity` table structure:

```
+-------------+---------------+
| Column Name | Data Type     |
+-------------+---------------+
| user_id     | INT           |
| activity_date| DATE          |
+-------------+---------------+
```

## 📊 **WORKING**

Let's trace the query execution with the sample input.

**Activity Table:**

| user_id | activity_date |
| ------- | ------------- |
| 1       | 2019-07-01    |
| 1       | 2019-07-02    |
| 2       | 2019-07-01    |
| 3       | 2019-07-08    |
| 1       | 2019-07-27    |
| 4       | 2019-07-28    |
| 2       | 2019-07-27    |

1.  **Filtering the dates:**

    The `WHERE` clause filters the table to include only the activities between '2019-06-28' and '2019-07-27'.  The activities on '2019-07-28' are excluded.

    | user_id | activity_date |
    | ------- | ------------- |
    | 1       | 2019-07-01    |
    | 1       | 2019-07-02    |
    | 2       | 2019-07-01    |
    | 3       | 2019-07-08    |
    | 1       | 2019-07-27    |
    | 2       | 2019-07-27    |

2.  **Grouping by date:**

    The `GROUP BY` clause groups the filtered activities by `activity_date`.

    | activity_date | user_ids |
    | ------------- | -------- |
    | 2019-07-01    | 1, 2     |
    | 2019-07-02    | 1        |
    | 2019-07-08    | 3        |
    | 2019-07-27    | 1, 2     |

3.  **Counting distinct users:**

    The `COUNT(DISTINCT(user_id))` function counts the number of unique users for each date.

    | activity_date | active_users |
    | ------------- | ------------ |
    | 2019-07-01    | 2            |
    | 2019-07-02    | 1            |
    | 2019-07-08    | 1            |
    | 2019-07-27    | 2            |

4.  **Final Result:**

    The query returns the `activity_date` as `day` and the `active_users` count.

    | day        | active_users |
    | ---------- | ------------ |
    | 2019-07-01 | 2            |
    | 2019-07-02 | 1            |
    | 2019-07-08 | 1            |
    | 2019-07-27 | 2            |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The time complexity is primarily determined by the filtering, grouping, and counting operations. In general, for a table of size *N*, the time complexity is **O(N)** because of the need to scan the table to filter rows and group them based on date. The aggregate function `COUNT(DISTINCT user_id)` also contributes to this complexity.

*   **Space Complexity:**  The space complexity is dependent on the number of unique dates within the specified range and the number of distinct user IDs associated with those dates. In the worst-case scenario, if all rows fall within the date range and each row has a unique date and user ID, the space complexity can be **O(N)** to store the grouped data. However, in many cases, the number of unique dates and users will be smaller than *N*, resulting in a space complexity that is less than O(N).
    