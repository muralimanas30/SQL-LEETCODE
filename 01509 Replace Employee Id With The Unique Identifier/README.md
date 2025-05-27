# 01509 - Replace Employee Id With The Unique Identifier
    
**Language:** Mysql  
**Runtime:** 1268 ms (Beats 40.34% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1509 | Replace Employee ID With The Unique Identifier | [LeetCode Problem](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/) |

---

## 💡 **Problem Explanation**

The problem requires you to write a SQL query that combines information from two tables, `Employees` and `EmployeeUNI`, to replace the original employee ID with a unique identifier if it exists. If an employee doesn't have a unique identifier, you should still include their name in the result.

**Sample Input:**

**Employees Table:**

| id  | name  |
|-----|-------|
| 1   | Alice |
| 7   | Bob   |
| 11  | Mead  |
| 90  | Alice |

**EmployeeUNI Table:**

| id  | unique_id |
|-----|-----------|
| 3   | 1         |
| 11  | 2         |
| 90  | 3         |

**Expected Output:**

| unique_id | name  |
|-----------|-------|
| null      | Alice |
| null      | Bob   |
| 2         | Mead  |
| 3         | Alice |

---

## 📊 **Algorithm**

*   Use a `LEFT JOIN` to combine the `Employees` table with the `EmployeeUNI` table.
*   The `LEFT JOIN` ensures that all employees from the `Employees` table are included in the result, even if they don't have a corresponding entry in the `EmployeeUNI` table.
*   Select the `unique_id` from the `EmployeeUNI` table and the `name` from the `Employees` table.
*   If an employee doesn't have a `unique_id`, the `unique_id` will be `NULL` in the result.

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

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N + M)**, where N is the number of rows in the `Employees` table and M is the number of rows in the `EmployeeUNI` table. This is because we need to scan both tables during the join operation. However, the actual execution time depends on the database system's query optimizer and the presence of indexes.

*   **Space Complexity:** The space complexity depends on the size of the result set. In the worst case, if all employees have a unique ID, the space complexity will be **O(N)**, where N is the number of employees.
    