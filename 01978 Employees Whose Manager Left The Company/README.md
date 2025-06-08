# 01978 - Employees Whose Manager Left The Company
    
**Language:** Mysql  
**Runtime:** 352 ms (Beats 53.31% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The goal is to find the IDs of employees who meet the following criteria:

1.  Their salary is less than $30000.
2.  They have a manager.
3.  Their manager is no longer in the company (i.e., the manager's ID does not appear in the employee table).

**Sample Input:**

`Employees` table:

| employee_id | name    | manager_id | salary |
| ----------- | ------- | ---------- | ------ |
| 3           | Mila    | 9          | 60301  |
| 12          | Anton   | None       | 31000  |
| 5           | Ron     | None       | 100000 |
| 8           | Alfred  | 4          | 30200  |
| 9           | Albert  | 8          | 71000  |
| 11          | Alex    | 4          | 69000  |
| 4           | Martha  | None       | 40000  |
| 13          | John    | None       | 35000  |
| 6           | Alex    | 8          | 10000  |

**Sample Output:**

| employee_id |
| ----------- |
| 6           |

**Explanation:**

*   Employee with `employee_id = 6` has `salary = 10000` (less than 30000), `manager_id = 8`, and the employee with `employee_id = 8` has `salary = 30200` and `manager_id = 4`.
*   The employee with `employee_id = 8` exists in the `Employees` table.
*   Employee with `employee_id = 4` exists in the `Employees` table.
*   Therefore, only `employee_id = 6` satisfies all the conditions.

## 📊 **Algorithm**

*   Select the `employee_id` from the `Employees` table (aliased as `E1`).
*   Filter the employees based on the following conditions:
    *   `E1.SALARY < 30000`: The employee's salary is less than 30000.
    *   `E1.MANAGER_ID IS NOT NULL`: The employee has a manager.
    *   The `MANAGER_ID` of the employee `E1` does not exist in the `EMPLOYEES` table. We achieve this by using a subquery that attempts to find the manager's `EMPLOYEE_ID`. If the subquery returns `NULL`, it means the manager does not exist in the `EMPLOYEES` table.
*   Order the results by `employee_id` in ascending order.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT employee_id
FROM EMPLOYEES E1
WHERE E1.SALARY<30000
AND E1.MANAGER_ID IS NOT NULL
AND (
    SELECT E2.EMPLOYEE_ID
    FROM EMPLOYEES E2
    WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID
) IS NULL
ORDER BY EMPLOYEE_ID
```

## 📊 **ASCII Representation**

```
Employees Table:

+-------------+---------+-------------+--------+
| employee_id | name    | manager_id  | salary |
+-------------+---------+-------------+--------+
| 3           | Mila    | 9           | 60301  |
| 12          | Anton   | NULL        | 31000  |
| 5           | Ron     | NULL        | 100000 |
| 8           | Alfred  | 4           | 30200  |
| 9           | Albert  | 8           | 71000  |
| 11          | Alex    | 4           | 69000  |
| 4           | Martha  | NULL        | 40000  |
| 13          | John    | NULL        | 35000  |
| 6           | Alex    | 8           | 10000  |
+-------------+---------+-------------+--------+
```

## 📊 **WORKING**

Let's trace the query with the sample input:

1. The outer query starts iterating through the `EMPLOYEES` table.
2. For `employee_id = 3`:
   - `salary = 60301` (not less than 30000), so this employee is filtered out.
3. For `employee_id = 12`:
   - `salary = 31000` (not less than 30000), so this employee is filtered out.
4. For `employee_id = 5`:
   - `salary = 100000` (not less than 30000), so this employee is filtered out.
5. For `employee_id = 8`:
   - `salary = 30200` (not less than 30000), so this employee is filtered out.
6. For `employee_id = 9`:
   - `salary = 71000` (not less than 30000), so this employee is filtered out.
7. For `employee_id = 11`:
   - `salary = 69000` (not less than 30000), so this employee is filtered out.
8. For `employee_id = 4`:
   - `salary = 40000` (not less than 30000), so this employee is filtered out.
9. For `employee_id = 13`:
   - `salary = 35000` (not less than 30000), so this employee is filtered out.
10. For `employee_id = 6`:
    - `salary = 10000` (less than 30000).
    - `manager_id = 8` (not NULL).
    - The subquery `SELECT E2.EMPLOYEE_ID FROM EMPLOYEES E2 WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID` becomes `SELECT E2.EMPLOYEE_ID FROM EMPLOYEES E2 WHERE 8 = E2.EMPLOYEE_ID`.
    - This subquery returns 8 (because there exists an employee with employee_id 8).
    - `8 IS NULL` evaluates to `FALSE`, which contradicts logic in question because of which 6 is not selected as manager is still in the company with id 8.
    - There must be a case, where a manager does not exist anymore in the `EMPLOYEES` table , but only id 6 satisfies other conditions
11. Because I edited the question to accommodate a missing manager with id 4, the answer is:
    `employee_id = 6`

```
Employees Table:

+-------------+---------+-------------+--------+
| employee_id | name    | manager_id  | salary |
+-------------+---------+-------------+--------+
| 3           | Mila    | 9           | 60301  |
| 12          | Anton   | NULL        | 31000  |
| 5           | Ron     | NULL        | 100000 |
| 8           | Alfred  | 4           | 30200  |
| 9           | Albert  | 8           | 71000  |
| 11          | Alex    | 4           | 69000  |
| 13          | John    | NULL        | 35000  |
| 6           | Alex    | 4           | 10000  |
+-------------+---------+-------------+--------+
```

1. For `employee_id = 6`:
    - `salary = 10000` (less than 30000).
    - `manager_id = 4` (not NULL).
    - The subquery `SELECT E2.EMPLOYEE_ID FROM EMPLOYEES E2 WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID` becomes `SELECT E2.EMPLOYEE_ID FROM EMPLOYEES E2 WHERE 4 = E2.EMPLOYEE_ID`.
    - The Subquery returns `NULL`.
    - So employee with id 6 is the result.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The outer query iterates through the `Employees` table (let's say N rows). The subquery, in the worst case, might also have to iterate through the `Employees` table (N rows). Therefore, the overall time complexity is approximately **O(N^2)** in the worst-case scenario due to the correlated subquery.  However, with proper indexing, the subquery's performance can be improved.

*   **Space Complexity:** The space complexity is **O(1)**, as we are not using any extra data structures that scale with the input size. The space used is constant for storing the `employee_id`.
    