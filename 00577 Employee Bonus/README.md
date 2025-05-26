# 00577 - Employee Bonus
    
**Language:** Mysql  
**Runtime:** 962 ms (Beats 68.88% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 577 | Employee Bonus | [LeetCode Problem](https://leetcode.com/problems/employee-bonus/) |

---

## 💡 **Problem Explanation**

The problem requires us to find the names of employees who have a bonus less than 1000 or have no bonus at all. We are given two tables: `Employee` and `Bonus`.  The `Employee` table contains employee IDs and names, and the `Bonus` table contains employee IDs and bonus amounts. We need to return a table with the names of the employees and their bonus amounts (if any), filtered according to the given condition.

**Example:**

**Employee Table:**

| empId | name  |
|-------|-------|
| 2     | Meir  |
| 3     | Michael |
| 7     | Addilyn |
| 8     | Juan  |
| 9     | Kannon |

**Bonus Table:**

| empId | bonus |
|-------|-------|
| 2     | 500   |
| 3     | 1500  |
| 7     | NULL  |

**Expected Output:**

| name    | bonus |
|---------|-------|
| Meir    | 500   |
| Addilyn | NULL  |

---

## 📊 **Algorithm**

*   Join the `Employee` and `Bonus` tables on `Employee.empId = Bonus.empId`.
*   Filter the result to include only employees where the bonus is less than 1000 or the bonus is null.
*   Select the `name` from the `Employee` table and the `bonus` from the `Bonus` table.
*   Alias the `name` column as `name` and the `bonus` column as `bonus`.

## 🔥 **Code Implementation**

```mysql
-- Write your MySQL query statement below
SELECT E.NAME as name,B.BONUS as bonus
FROM EMPLOYEE E
LEFT JOIN BONUS B
ON E.EMPID = B.EMPID
WHERE B.BONUS <1000 OR B.BONUS IS NULL;
```

## 📊 **ASCII Representation**

This problem does not involve grids, trees, or movements. Therefore, an ASCII representation is not applicable.

## 📊 **WORKING**

Let's walk through how the provided query works with the example data:

**Employee Table:**

| empId | name    |
|-------|---------|
| 2     | Meir    |
| 3     | Michael |
| 7     | Addilyn |
| 8     | Juan    |
| 9     | Kannon   |

**Bonus Table:**

| empId | bonus |
|-------|-------|
| 2     | 500   |
| 3     | 1500  |
| 7     | NULL  |

1.  **JOIN Operation:**

    ```
    SELECT E.NAME as name,B.BONUS as bonus
    FROM EMPLOYEE E
    LEFT JOIN BONUS B
    ON E.EMPID = B.EMPID
    ```

    This step joins the `Employee` and `Bonus` tables based on the `empId`. A `LEFT JOIN` ensures that all employees are included, even if they don't have an entry in the `Bonus` table.

    Result of JOIN:

    | name    | bonus |
    |---------|-------|
    | Meir    | 500   |
    | Michael | 1500  |
    | Addilyn | NULL  |
    | Juan    | NULL  |
    | Kannon  | NULL  |

2.  **WHERE Clause:**

    ```
    WHERE B.BONUS < 1000 OR B.BONUS IS NULL;
    ```

    This filters the joined table to include rows where the bonus is less than 1000 or the bonus is NULL.

    Filtered Result:

    | name    | bonus |
    |---------|-------|
    | Meir    | 500   |
    | Addilyn | NULL  |
    | Juan    | NULL  |
    | Kannon   | NULL  |

3.  **Final SELECT:**

    The query selects the `name` and `bonus` columns from the filtered result:

    Final Output:

    | name    | bonus |
    |---------|-------|
    | Meir    | 500   |
    | Addilyn | NULL  |

*Note:*

Employees Juan and Kannon has a NULL value in BONUS Table.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N + M)**, where N is the number of rows in the `Employee` table and M is the number of rows in the `Bonus` table. This is due to the `LEFT JOIN` operation.
*   **Space Complexity:** The space complexity is **O(K)**, where K is the number of rows in the joined table that satisfy the `WHERE` clause. In the worst case, if all rows satisfy the `WHERE` clause, the space complexity could be **O(N)**, where N is the number of employees.
    