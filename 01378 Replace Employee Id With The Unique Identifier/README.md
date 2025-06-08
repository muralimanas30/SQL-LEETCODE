# 01378 - Replace Employee Id With The Unique Identifier
    
**Language:** Mysql  
**Runtime:** 1268 ms (Beats 42.18% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1378 | REPLACE EMPLOYEE ID WITH THE UNIQUE IDENTIFIER | [LeetCode Problem](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/) |

---

## 💡 **Problem Explanation**

The problem requires you to write a SQL query that replaces the employee ID (`id`) in the `Employees` table with the corresponding unique identifier (`unique_id`) from the `EmployeeUNI` table. If an employee doesn't have a unique identifier in `EmployeeUNI`, you should still include them in the result, but with `unique_id` as `NULL`.  Essentially, you are performing a LEFT JOIN between the `Employees` and `EmployeeUNI` tables.

**Example:**

**Employees Table:**

| id  | name  |
|-----|-------|
| 1   | Alice |
| 7   | Bob   |
| 11  | Meir  |
| 90  | Winston |
| 3   | Jonathan |

**EmployeeUNI Table:**

| id  | unique_id |
|-----|-----------|
| 3   | 1         |
| 11  | 2         |
| 90  | 3         |

**Expected Output:**

| unique_id | name      |
|-----------|-----------|
| null      | Alice     |
| null      | Bob       |
| 2         | Meir      |
| 3         | Winston   |
| 1         | Jonathan  |

---

## 📊 **Algorithm**

*   Perform a LEFT JOIN between the `Employees` table (aliased as `e`) and the `EmployeeUNI` table (aliased as `u`).
*   Join the tables on the `id` column, which is common to both tables.
*   Select the `unique_id` from the `EmployeeUNI` table and the `name` from the `Employees` table.
*   The LEFT JOIN ensures that all employees from the `Employees` table are included in the result, even if they don't have a matching `unique_id` in the `EmployeeUNI` table.  In those cases, the `unique_id` will be `NULL`.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT u.unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI u
ON e.id = u.id;
```

---

## 📊 **ASCII Representation**

**Employees Table:**

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains the id and the name of an employee in the company.
```

**EmployeeUNI Table:**

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| unique_id   | int     |
+-------------+---------+
(id, unique_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id and the corresponding unique identifier of an employee in the company.
```

**Relationship:**

```
 Employees.id  <----- EmployeeUNI.id
       |
       |
       LEFT JOIN
```

---

## 📊 **WORKING**

Let's trace the query execution with the sample data.

**Employees Table:**

| id  | name      |
|-----|-----------|
| 1   | Alice     |
| 7   | Bob       |
| 11  | Meir      |
| 90  | Winston   |
| 3   | Jonathan  |

**EmployeeUNI Table:**

| id  | unique_id |
|-----|-----------|
| 3   | 1         |
| 11  | 2         |
| 90  | 3         |

**Query Execution:**

1.  **LEFT JOIN:** The query starts by performing a LEFT JOIN between `Employees` (e) and `EmployeeUNI` (u) on `e.id = u.id`.

2.  **Row by Row Matching:**

    *   **Alice (id=1):** No match in `EmployeeUNI`.  `u.unique_id` becomes `NULL`. Result: `(NULL, Alice)`
    *   **Bob (id=7):** No match in `EmployeeUNI`.  `u.unique_id` becomes `NULL`. Result: `(NULL, Bob)`
    *   **Meir (id=11):**  Match found in `EmployeeUNI`: `u.unique_id = 2`. Result: `(2, Meir)`
    *   **Winston (id=90):** Match found in `EmployeeUNI`: `u.unique_id = 3`. Result: `(3, Winston)`
    *   **Jonathan (id=3):** Match found in `EmployeeUNI`: `u.unique_id = 1`. Result: `(1, Jonathan)`

3.  **Final Result:** The query combines the `unique_id` and `name` columns, resulting in the expected output.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the `LEFT JOIN` operation. In the worst case, it can be **O(m + n)**, where n is the number of rows in the `Employees` table and m is the number of rows in the `EmployeeUNI` table.  However, with proper indexing, the join operation can be optimized.
*   **Space Complexity:**  The space complexity depends on the size of the result set, which is proportional to the number of rows in the `Employees` table.  Therefore, the space complexity is **O(n)**, where n is the number of rows in the `Employees` table.
    