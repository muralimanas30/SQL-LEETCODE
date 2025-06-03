# 00570 - Managers With At Least 5 Direct Reports
    
**Language:** Mysql  
**Runtime:** 349 ms (Beats 62.93% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                                   | 🔗 Link                                                                 |
| ------------------ | ----------------------------------------- | ----------------------------------------------------------------------- |
| 570                | Managers with at Least 5 Direct Reports | [LeetCode Problem](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/) |

---

## 💡 **Problem Explanation**

The problem requires identifying managers who have at least five employees reporting directly to them.  The `Employee` table contains information about each employee, including their ID, name, and manager ID.  We need to find the names of all managers who appear as `managerId` in the table at least five times.

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

**Sample Output:**

```
+-------+
| name  |
+-------+
| John  |
+-------+
```

John (id 101) is the manager of Dan, James, Amy, Anne and Ron, so he has five direct reports.

---

## 📊 **Algorithm**

*   **Method 1 (Using JOIN):**
    *   Join the `Employee` table with itself using `managerId` to link managers with their direct reports.
    *   Group the results by `managerId` (which is the manager's ID).
    *   Filter the groups to include only those with a count greater than 4 (meaning at least 5 direct reports).
    *   Select the name of the manager from the first `Employee` table.
*   **Method 2 (Using Subquery):**
    *   Create a subquery that groups the `Employee` table by `managerId`.
    *   Filter the groups in the subquery to include only those with a count greater than 4.
    *   Select the `managerId` from this filtered subquery.
    *   Select the name of the employees whose IDs are in the result of the subquery.

---

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

---

## 📊 **ASCII Representation**

```
Employee Table:

+--------+----------+--------------+-------------+
|   id   |   name   |  department  |  managerId  |
+--------+----------+--------------+-------------+
|  INT   |  VARCHAR |   VARCHAR    |    INT      |
+--------+----------+--------------+-------------+
|  101   |  'John'  |     'A'      |    NULL     |
|  102   |  'Dan'   |     'A'      |    101      |
|  103   | 'James'  |     'A'      |    101      |
|  104   |  'Amy'   |     'A'      |    101      |
|  105   |  'Anne'  |     'A'      |    101      |
|  106   |  'Ron'   |     'B'      |    101      |
+--------+----------+--------------+-------------+
```

---

## 📊 **WORKING**

**Method 1 - JOIN Explanation**

Let's use the sample input table given in the problem explanation.

1.  **JOIN:** `EMPLOYEE E1 JOIN EMPLOYEE E2 ON E1.ID = E2.MANAGERID`

    This join creates a combined table where each row represents an employee and their manager.
    For example, one row might be (John, Dan) where John is the manager of Dan.

2.  **GROUP BY:** `GROUP BY E2.MANAGERID`

    The combined table is grouped by `E2.MANAGERID`.
    This groups all employees reporting to the same manager together.

3.  **HAVING:** `HAVING COUNT(*) > 4`

    This filters the groups, keeping only those where the count of employees in the group is greater than 4.
    This effectively selects only managers who have at least 5 direct reports.

4.  **SELECT:** `SELECT E1.NAME as name`

    Finally, the names of the selected managers are retrieved and displayed. In this case, John satisfies all condition to have 5 or more direct employees so it is returned as the correct result.

**Method 2 - Subquery Explanation**

The subquery finds all `managerId` that occur at least 5 times.  The outer query then selects the `name` from the `Employee` table where the `id` matches one of those `managerId` values. It achieves the same goal but in a different order.

---

## 🚀 **Time & Space Complexity**

**Method 1 (JOIN):**

*   **Time Complexity:**  O(N\*M), where N is the number of records in the EMPLOYEE table and M is the average number of employees per manager, because of the join and group by operations. In the worst case, if all employees report to a single manager, it would be O(N^2). However, assuming the number of reports is roughly distributed, this can be closer to **O(N log N)**  due to the `GROUP BY`.
*   **Space Complexity:** **O(N)** due to the size of the intermediate joined table, which depends on the relationships between employees and managers.

**Method 2 (Subquery):**

*   **Time Complexity:** O(N), where N is the number of records in the EMPLOYEE table. The subquery iterates over the table once to count the number of employees under each manager and filter those with more than four. The outer query then iterates to select the managers name. Hence the overall **O(N)**
*   **Space Complexity:** O(N) to store the intermediate results of the subquery. Specifically, for cases with few managers but many reports, this would be **O(N)**
    