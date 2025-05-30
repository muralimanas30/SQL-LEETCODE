# 00184 - Department Highest Salary
    
**Language:** Mysql  
**Runtime:** 586 ms (Beats 98.67% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 184 | Department Highest Salary | [LeetCode Problem](https://leetcode.com/problems/department-highest-salary/) |

---

## 💡 **Problem Explanation**

The problem requires you to find the employees who have the highest salary within their respective departments. The output should include the department name, employee name, and their salary.  If multiple employees in a department share the same highest salary, all of them should be included in the result.

**Example:**

`Employee` Table:

| id  | name  | salary | departmentId |
|-----|-------|--------|--------------|
| 1   | Joe   | 70000  | 1            |
| 2   | Henry | 80000  | 2            |
| 3   | Sam   | 60000  | 2            |
| 4   | Max   | 90000  | 1            |
| 5   | Janet | 69000  | 1            |
| 6   | Randy | 85000  | 1            |

`Department` Table:

| id  | name       |
|-----|------------|
| 1   | IT         |
| 2   | Sales      |

**Expected Output:**

| Department | Employee | Salary |
|------------|----------|--------|
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |

---

## 📊 **Algorithm**

*   Join the `Employee` and `Department` tables on `departmentId = id`.
*   Use the `RANK()` window function to assign a rank to each employee within their department based on their salary in descending order.
*   Filter the result to include only those employees where the rank is equal to 1 (highest salary in the department).
*   Select the Department name, Employee name, and Salary for the final output.

---

## 🔥 **Code Implementation**

```mysql
SELECT Department,Employee,Salary
FROM (
    SELECT 
        D.NAME AS Department,
        E.Name AS Employee,
        E.salary AS Salary,
        RANK() OVER (PARTITION BY D.ID ORDER BY E.Salary DESC) AS rk
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPARTMENTID = D.ID
) AS Ranked
WHERE rk = 1;
```

---

## 📊 **ASCII Representation**

Let's visualize the database tables and their relationship.

```
Employee Table:

+-------------+---------+
| Column Name | Data Type |
+-------------+---------+
| id          | INT     |
| name        | VARCHAR |
| salary      | INT     |
| departmentId| INT     |
+-------------+---------+

Department Table:

+-------------+---------+
| Column Name | Data Type |
+-------------+---------+
| id          | INT     |
| name        | VARCHAR |
+-------------+---------+

Relationship:
Employee.departmentId --> Department.id
```

## 📊 **WORKING**

Let's trace the execution of the provided query with the example data.

1.  **JOIN**: The `EMPLOYEE` and `DEPARTMENT` tables are joined.
2.  **RANK()**: The `RANK()` function assigns a rank to each employee within each department based on the salary in descending order.
3.  **WHERE**: The outer `WHERE` clause filters the result to only include the employees with the highest salary (rank = 1) within their department.

**Intermediate Table (Ranked):**

| Department | Employee | Salary | rk |
|------------|----------|--------|----|
| IT         | Max      | 90000  | 1  |
| IT         | Randy    | 85000  | 2  |
| IT         | Joe      | 70000  | 3  |
| IT         | Janet    | 69000  | 4  |
| Sales      | Henry    | 80000  | 1  |
| Sales      | Sam      | 60000  | 2  |

**Final Output:**

| Department | Employee | Salary |
|------------|----------|--------|
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The time complexity is dominated by the join operation and the window function `RANK()`. In the worst case, both operations can take **O(N log N)** time, where N is the total number of rows in the `Employee` table.
*   **Space Complexity:** The space complexity is mainly determined by the intermediate table created during the join and ranking process. In the worst case, the space complexity can be **O(N)**, where N is the number of rows in the `Employee` table.
    