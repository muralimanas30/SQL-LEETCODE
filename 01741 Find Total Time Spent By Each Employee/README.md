# 01741 - Find Total Time Spent By Each Employee
    
**Language:** Mysql  
**Runtime:** 523 ms (Beats 70.04% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1741 | FIND TOTAL TIME SPENT BY EACH EMPLOYEE | [LeetCode Problem](https://leetcode.com/problems/find-total-time-spent-by-each-employee/) |

---

## 💡 **Problem Explanation**

The problem requires us to calculate the total time spent by each employee on each day, given a table of employee time logs. Each log includes the employee's ID (`emp_id`), the day of the event (`event_day`), the time they checked in (`in_time`), and the time they checked out (`out_time`). The goal is to aggregate this data to show the total time each employee spent working on each day.

**Sample Input:**

```
+-------+------------+---------+----------+
| emp_id | event_day  | in_time | out_time |
+-------+------------+---------+----------+
| 1      | 2020-11-28 | 4       | 32       |
| 1      | 2020-11-28 | 5       | 55       |
| 1      | 2020-12-03 | 1       | 9        |
| 2      | 2020-11-28 | 23      | 41       |
| 2      | 2020-12-09 | 5       | 63       |
+-------+------------+---------+----------+
```

**Expected Output:**

```
+------------+--------+------------+
| day        | emp_id | total_time |
+------------+--------+------------+
| 2020-11-28 | 1      | 83         |
| 2020-11-28 | 2      | 18         |
| 2020-12-03 | 1      | 8          |
| 2020-12-09 | 2      | 58         |
+------------+--------+------------+
```

## 📊 **Algorithm**

*   **Group By:** Group the rows by `event_day` and `emp_id` to aggregate the time spent by each employee on each day.
*   **Calculate Time Difference:** For each group, calculate the difference between `out_time` and `in_time` to find the time spent in each session.
*   **Sum Time Differences:** Sum up all the time differences for each group to get the total time spent by each employee on each day.
*   **Select and Display:** Select the `event_day` as `day`, `emp_id`, and the calculated `total_time` for the final output.

## 🔥 **Code Implementation**

```mysql
SELECT event_day as day,emp_id,
    (SELECT ((SUM(out_time-in_time)))) as total_time
FROM EMPLOYEES
GROUP BY event_day,emp_id
```

## 📊 **ASCII Representation**

Let's visualize the `EMPLOYEES` table:

```
+------------+-------------+-------------+------------+
| Column     | Type        | Constraints | Description               |
+------------+-------------+-------------+---------------------------+
| emp_id     | INT         |             | Employee ID               |
| event_day  | DATE        |             | Day of the event          |
| in_time    | INT         |             | Check-in time             |
| out_time   | INT         |             | Check-out time            |
+------------+-------------+-------------+---------------------------+
```

## 📊 **WORKING**

Consider the following input:

**EMPLOYEES Table:**

```
+-------+------------+---------+----------+
| emp_id | event_day  | in_time | out_time |
+-------+------------+---------+----------+
| 1      | 2020-11-28 | 4       | 32       |
| 1      | 2020-11-28 | 5       | 55       |
| 1      | 2020-12-03 | 1       | 9        |
| 2      | 2020-11-28 | 23      | 41       |
| 2      | 2020-12-09 | 5       | 63       |
+-------+------------+---------+----------+
```

1.  **Grouping:** The query groups the data by `event_day` and `emp_id`.

2.  **Calculating Time Differences and Summing:**

    *   For `emp_id = 1` and `event_day = 2020-11-28`, the total time is `(32 - 4) + (55 - 5) = 28 + 50 = 78`.
    *   For `emp_id = 1` and `event_day = 2020-12-03`, the total time is `9 - 1 = 8`.
    *   For `emp_id = 2` and `event_day = 2020-11-28`, the total time is `41 - 23 = 18`.
    *   For `emp_id = 2` and `event_day = 2020-12-09`, the total time is `63 - 5 = 58`.

3.  **Final Result:**

```
+------------+--------+------------+
| day        | emp_id | total_time |
+------------+--------+------------+
| 2020-11-28 | 1      | 78         |
| 2020-12-03 | 1      | 8          |
| 2020-11-28 | 2      | 18         |
| 2020-12-09 | 2      | 58         |
+------------+--------+------------+
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the `GROUP BY` operation. In the worst case, it could be **O(N log N)**, where N is the number of rows in the `EMPLOYEES` table.
*   **Space Complexity:** The space complexity depends on the number of groups formed by the `GROUP BY` operation. In the worst case, where each row forms a unique group, the space complexity could be **O(N)**. However, in practice, it will likely be less if there are many duplicate combinations of `event_day` and `emp_id`.
    