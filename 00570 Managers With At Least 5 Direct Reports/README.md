# 00570 - Managers With At Least 5 Direct Reports
    
**Language:** Mysql  
**Runtime:** 349 ms (Beats 62.93% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                                    | 🔗 Link                                                                  |
| ------------------ | ------------------------------------------ | ------------------------------------------------------------------------ |
| 570                | Managers with at Least 5 Direct Reports | [LeetCode Problem](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/) |

---

## 💡 **Problem Explanation**

The problem requires us to find all managers who have at least 5 employees reporting directly to them.  We are given an `Employee` table and need to identify managers based on the count of their direct reports.

**Sample Input:**

```
Employee table:
+-----+-------+----------+-----------+
| id  | name  | department | managerId |
+-----+-------+----------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+----------+-----------+
```

**Expected Output:**

```
+-------+
| name  |
+-------+
| John  |
+-------+
```

## 📊 **Algorithm**

*   **Method 1 (Using JOIN):**
    *   Join the `Employee` table with itself using the manager-employee relationship.
    *   Group by the manager's ID.
    *   Filter the groups where the count of employees is greater than 4.
    *   Select the names of these managers.

*   **Method 2 (Using Subquery):**
    *   Find all manager IDs that have at least 5 direct reports using a subquery.
    *   Select the names of employees whose IDs are in the list of manager IDs obtained from the subquery.

## 🔥 **Code Implementation**

```mysql
-- METHOD 1
SELECT E1.NAME as name
from EMPLOYEE E1
JOIN EMPLOYEE E2
ON E1.ID = E2.MANAGERID
GROUP BY E2.MANAGERID
HAVING COUNT(*)>4

-- METHOD 2
-- SELECT E1.NAME AS name
-- FROM EMPLOYEE E1
-- WHERE E1.ID IN (
--     SELECT E2.MANAGERID
--     FROM EMPLOYEE E2
--     GROUP BY E2.MANAGERID
--     HAVING COUNT(*) > 4
-- )
```

## 📊 **ASCII Representation**

The `Employee` table has the following schema:

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

The relationship is that an employee can have a `managerId` referring to another employee's `id` in the same table.

## 📊 **WORKING**

Let's consider the sample input and trace how Method 1 works:

```
Employee Table:
+-----+-------+----------+-----------+
| id  | name  | department | managerId |
+-----+-------+----------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+----------+-----------+
```

1.  **JOIN Operation**:
    The table is joined with itself. `E1` represents managers, and `E2` represents employees.  The join condition is `E1.ID = E2.MANAGERID`.

2.  **GROUP BY E2.MANAGERID**:
    The result is grouped by `MANAGERID`.  In this case, all employees except John (who has `null` as `managerId`) have a manager.

3.  **HAVING COUNT(\*)>4**:
    The `HAVING` clause filters the groups where the count of employees is greater than 4.  In this example, John (ID 101) has 5 direct reports (Dan, James, Amy, Anne, and Ron).  Thus, the group with `MANAGERID = 101` satisfies this condition.

4.  **SELECT E1.NAME**:
    Finally, the name of the manager (`E1.NAME`) is selected.  Since `MANAGERID = 101` corresponds to the manager John, the query returns "John".

## 🚀 **Time & Space Complexity**

*   **Method 1 (Using JOIN):**
    *   **Time Complexity:**  _**O(N)**_  where N is the number of rows in the `Employee` table.  The join and group by operations depend on the size of the table.
    *   **Space Complexity:** _**O(N)**_ in the worst-case scenario due to the creation of temporary tables during the join and group by operations.

*   **Method 2 (Using Subquery):**
    *   **Time Complexity:** _**O(N^2)**_ in the worst case. The subquery iterates through the Employee table, and for each row in the outer query, it needs to search the subquery's result.
    *   **Space Complexity:** _**O(N)**_ for storing the result of the subquery (the manager IDs).
    