# 01965 - Employees With Missing Information
    
**Language:** Mysql  
**Runtime:** 620 ms (Beats 31.92% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1965 | Employees With Missing Information | [LeetCode Problem](https://leetcode.com/problems/employees-with-missing-information/) |

---

## 💡 **Problem Explanation**

The problem requires identifying `employee_id`s that are present in either the `employees` table or the `salaries` table, but not in both. Essentially, we need to find employees who have information in one table but are missing in the other.

**Sample Input:**

**Employees Table:**

| employee_id | name   |
|-------------|--------|
| 2           | Crew   |
| 4           | Haven  |
| 5           | Kristian |

**Salaries Table:**

| employee_id | salary |
|-------------|--------|
| 5           | 76071  |
| 1           | 22517  |
| 4           | 63539  |

**Expected Output:**

| employee_id |
|-------------|
| 1           |
| 2           |

**Explanation:**
- Employee with `employee_id = 1` is present in the `Salaries` table but not in the `Employees` table.
- Employee with `employee_id = 2` is present in the `Employees` table but not in the `Salaries` table.
- Employee with `employee_id = 4` and `employee_id = 5` are present in both tables.

## 📊 **Algorithm**

*   Find all `employee_id`s that exist in the `employees` table but not in the `salaries` table.
*   Find all `employee_id`s that exist in the `salaries` table but not in the `employees` table.
*   Combine these two sets of `employee_id`s using `UNION` to remove duplicates.
*   Order the result by `employee_id` in ascending order.

## 🔥 **Code Implementation**

```mysql
SELECT employee_id 
FROM employees
WHERE employee_id NOT IN (SELECT employee_id FROM salaries)
UNION
SELECT employee_id 
FROM salaries
WHERE employee_id NOT IN (SELECT employee_id FROM employees)
ORDER BY employee_id;
```

## 📊 **ASCII Representation**

```
Employees Table:

+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+

Salaries Table:

+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 5           | 76071  |
| 1           | 22517  |
| 4           | 63539  |
+-------------+--------+
```

## 📊 **WORKING**

**Step-by-step explanation using the sample input:**

1.  **`SELECT employee_id FROM employees WHERE employee_id NOT IN (SELECT employee_id FROM salaries)`**

    *   The subquery `(SELECT employee_id FROM salaries)` returns `[5, 1, 4]`.
    *   The outer query selects `employee_id` from `employees` where it's not in `[5, 1, 4]`.
    *   This results in `[2]` because employee 2 is in the `employees` table but not in the `salaries` table.

2.  **`SELECT employee_id FROM salaries WHERE employee_id NOT IN (SELECT employee_id FROM employees)`**

    *   The subquery `(SELECT employee_id FROM employees)` returns `[2, 4, 5]`.
    *   The outer query selects `employee_id` from `salaries` where it's not in `[2, 4, 5]`.
    *   This results in `[1]` because employee 1 is in the `salaries` table but not in the `employees` table.

3.  **`UNION`**

    *   The `UNION` combines the results `[2]` and `[1]` and removes any duplicates (though there aren't any here).
    *   The result is `[2, 1]`.

4.  **`ORDER BY employee_id`**

    *   Orders the combined results in ascending order.
    *   The final result is `[1, 2]`.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The query involves two subqueries and a `UNION`.  Each subquery scans one of the tables (`employees` and `salaries`).  Assuming the tables have sizes `m` and `n` respectively, each `NOT IN` operation would take O(m*n) in worst case, however, with database indexing (which is typical), this operation can be optimized to O(m log n). The `UNION` operation and `ORDER BY` has **O(m+n)** time complexity due to merging and sorting the results. Therefore the overall time complexity is **O(m log n)** if indexing is enabled, or **O(m\*n)** without index.
*   **Space Complexity:** The space complexity depends on the size of the temporary tables created by the subqueries and the `UNION` operation. In the worst case, it is **O(m+n)**, where `m` and `n` are the number of rows in the `employees` and `salaries` tables, respectively because space is needed to store the employee IDs.
    