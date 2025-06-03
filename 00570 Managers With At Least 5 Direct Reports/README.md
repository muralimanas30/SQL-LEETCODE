# 00570 - Managers With At Least 5 Direct Reports
    
**Language:** Mysql  
**Runtime:** 402 ms (Beats 16.93% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                                   | 🔗 Link                                                                    |
| ------------------ | ----------------------------------------- | -------------------------------------------------------------------------- |
| 570                | Managers with at Least 5 Direct Reports | [LeetCode Problem](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/) |

## 💡 **Problem Explanation**

The problem requires identifying managers who have at least five employees reporting directly to them. We are given an `Employee` table, and we need to find the names of the managers who meet this criterion.

**Sample Input:**

`Employee` table:

| id  | name  | department | managerId |
| --- | ----- | ---------- | --------- |
| 101 | John  | A          | Null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |

**Sample Output:**

| name |
| ----- |
| John |

## 📊 **Algorithm**

*   Join the `Employee` table with itself to link managers to their direct reports.
*   Group the results by `managerId` to count the number of direct reports each manager has.
*   Filter the groups using the `HAVING` clause to include only those managers with more than 4 direct reports.
*   Select the `name` of the managers who meet the criteria.

## 🔥 **Code Implementation**

```mysql
SELECT E1.NAME as name
from EMPLOYEE E1
JOIN EMPLOYEE E2
ON E1.ID = E2.MANAGERID
GROUP BY E2.MANAGERID
HAVING COUNT(*)>4
```

## 📊 **ASCII Representation**

```
Employee Table:

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+

```

## 📊 **Working**

Let's walk through a sample execution with the input table provided earlier.

1.  **Join the Table:**

    The `EMPLOYEE` table is joined with itself, linking managers to their direct reports.
    `E1` represents the manager and `E2` represents the employee.

2.  **Group by Manager ID:**

    The result is grouped by `E2.MANAGERID` to count the number of employees reporting to each manager.

3.  **Filter with HAVING:**

    The `HAVING COUNT(*)>4` clause filters out groups where the count is not greater than 4.

4.  **Select Manager Name:**

    Finally, the `E1.NAME` (the manager's name) is selected for the managers who satisfy the condition.

**Sample Input Table:**

```
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | NULL      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
```

**After Joining and Grouping:**

The query counts the number of employees for each `managerId`. `John` (ID: 101) has 5 direct reports (`102, 103, 104, 105, 106`).

**Final Result:**

The query returns `John` because he has more than 4 direct reports.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the join and group by operations. In the worst case, it can be **O(N\*log(N))** where N is the number of rows in the Employee table due to sorting during the group by operation.

*   **Space Complexity:** The space complexity depends on the size of the intermediate table created by the join and the grouping. In the worst case, it can be **O(N)**, where N is the number of rows in the `Employee` table.
    