# 01141 - User Activity For The Past 30 Days I
    
**Language:** Mysql  
**Runtime:** 786 ms (Beats 5.44% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                         | 🔗 Link                                                              |
|------------------|----------------------------------|----------------------------------------------------------------------|
| 1141             | User Activity for the Past 30 Days I | [LeetCode Problem](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/) |

---

## 💡 **Problem Explanation**

The problem asks us to find the number of active users each day for the past 30 days (inclusive) from a given date. We are provided with an `Activity` table containing `user_id` and `activity_date`. The goal is to group the activities by date and count the distinct users who were active on each day within the specified date range.

**Example:**

**Activity Table:**

| user_id | activity_date |
|---------|---------------|
| 1       | 2019-07-01    |
| 1       | 2019-07-02    |
| 2       | 2019-07-01    |
| 2       | 2019-07-03    |
| 3       | 2019-07-01    |
| 3       | 2019-07-03    |
| 3       | 2019-07-27    |
| 4       | 2019-07-27    |

**Expected Output (for the 30 days up to and including 2019-07-27):**

| day        | active_users |
|------------|--------------|
| 2019-07-01 | 3            |
| 2019-07-02 | 1            |
| 2019-07-03 | 2            |
| 2019-07-27 | 2            |

---

## 📊 **Algorithm**

*   Filter the `Activity` table to include only records within the last 30 days from '2019-07-27'.
*   Group the filtered data by `activity_date`.
*   Count the distinct `user_id` for each `activity_date`.
*   Rename the `activity_date` column to `day` and the count of distinct users to `active_users`.
*   Consider only days with at least one active user.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT ACTIVITY_DATE AS day,COUNT(DISTINCT(USER_ID)) AS active_users
FROM ACTIVITY
WHERE ACTIVITY_DATE BETWEEN ADDDATE('2019-07-27', INTERVAL -29 DAY) AND '2019-07-27'
GROUP BY ACTIVITY_DATE
```

---

## 📊 **ASCII Representation**

```
Activity Table:

+---------+---------------+
| user_id | activity_date |
+---------+---------------+
| 1       | 2019-07-01    |
| 1       | 2019-07-02    |
| 2       | 2019-07-01    |
| 2       | 2019-07-03    |
| 3       | 2019-07-01    |
| 3       | 2019-07-03    |
| 3       | 2019-07-27    |
| 4       | 2019-07-27    |
+---------+---------------+
```

---

## 📊 **WORKING**

Let's trace the query execution with the given sample data:

1.  **Filtering:**

    The `WHERE` clause filters the `Activity` table to include only records with `activity_date` between '2019-06-28' and '2019-07-27'.

2.  **Grouping:**

    The filtered table is then grouped by `activity_date`.

    | activity\_date | user\_id |
    | :------------- | :------- |
    | 2019-07-01     | 1        |
    | 2019-07-01     | 2        |
    | 2019-07-01     | 3        |
    | 2019-07-02     | 1        |
    | 2019-07-03     | 2        |
    | 2019-07-03     | 3        |
    | 2019-07-27     | 3        |
    | 2019-07-27     | 4        |

3.  **Counting Distinct Users:**

    For each group (i.e., each `activity_date`), the `COUNT(DISTINCT(USER_ID))` function counts the number of unique users.

    | activity\_date | COUNT(DISTINCT(USER\_ID)) |
    | :------------- | :------------------------- |
    | 2019-07-01     | 3                          |
    | 2019-07-02     | 1                          |
    | 2019-07-03     | 2                          |
    | 2019-07-27     | 2                          |

4.  **Final Result:**

    The query returns the `activity_date` as `day` and the count of distinct users as `active_users`.

    | day        | active\_users |
    | :--------- | :------------ |
    | 2019-07-01 | 3             |
    | 2019-07-02 | 1             |
    | 2019-07-03 | 2             |
    | 2019-07-27 | 2             |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the filtering, grouping, and counting operations.  In the worst case, where the `Activity` table is large and all records fall within the 30-day window, the time complexity is **O(N)** where N is the number of rows in the Activity table.  This is due to the need to scan all rows.  The GROUP BY operation typically has O(N log N) time complexity in general, but the time complexity becomes closer to O(N) as we are only grouping by 30 different dates at most, and in worst case we are iterating through the whole table.

*   **Space Complexity:** The space complexity is mainly determined by the space required to store the intermediate grouped data and the final result. In the worst case, the query might need to store up to 30 groups, each containing distinct user IDs.  The space complexity can be approximated as **O(1)** as the number of possible dates (30) is constant and relatively small irrespective of the table size.
    