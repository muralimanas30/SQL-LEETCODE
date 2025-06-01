# 00181 - Employees Earning More Than Their Managers
    
**Language:** Mysql  
**Runtime:** 896 ms (Beats 11.84% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 181 | Employees Earning More Than Their Managers | [LeetCode Problem](https://leetcode.com/problems/employees-earning-more-than-their-managers/) |

---

## 💡 **Problem Explanation**

The problem requires us to find employees who earn more than their managers. We are given an `Employee` table with columns like `id`, `name`, `salary`, and `managerId`. The `managerId` column refers to the `id` of the employee's manager. We need to write a SQL query that returns the names of all employees who earn more than their managers.

**Example:**

**Employee Table:**

| id  | name  | salary | managerId |
|-----|-------|--------|-----------|
| 1   | Joe   | 70000  | 3         |
| 2   | Henry | 80000  | 4         |
| 3   | Sam   | 60000  | NULL      |
| 4   | Max   | 90000  | NULL      |

**Expected Output:**

| Employee |
|----------|
| Joe      |

In this example, Joe earns 70000, and his manager (Sam) earns 60000. So, Joe's name should be in the output.

## 📊 **Algorithm**

**Method 2 Algorithm (using subquery):**

*   Select the name of the employee (`E.name`) as `Employee` from the `Employee` table (aliased as `E`).
*   Filter the results to include only employees who have a manager (`E.managerId is not null`).
*   Further filter the results to include only employees whose salary is greater than their manager's salary.  A subquery is used to get the manager's salary (`SELECT Salary FROM Employee E2 WHERE E2.id = E.managerID`).

## 🔥 **Code Implementation**

```mysql
# METHOD 2
-- Algorithm:
-- 1. Select the name of the employee as 'Employee'.
-- 2. Filter for employees who have a manager (managerId is not null).
-- 3. Ensure the employee's salary is greater than their manager's salary (using a subquery).

select E.name as Employee from Employee as E
where E.managerId is not null
and E.Salary > (
    Select Salary from Employee E2
    where E2.id = E.managerID
)
```

## 📊 **ASCII Representation**

```
Employee Table:

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
```

## 📊 **WORKING**

Let's trace the execution of the SQL query using the example table provided earlier:

**Employee Table:**

| id  | name  | salary | managerId |
|-----|-------|--------|-----------|
| 1   | Joe   | 70000  | 3         |
| 2   | Henry | 80000  | 4         |
| 3   | Sam   | 60000  | NULL      |
| 4   | Max   | 90000  | NULL      |

1.  **Outer Query:**
    *   The outer query starts by selecting `E.name` as `Employee` from the `Employee` table (aliased as `E`).

2.  **`WHERE` Clause Evaluation:**
    *   `E.managerId is not null`: This filters out employees who do not have a manager (Sam and Max are excluded in the first step).  So, we are left with Joe and Henry.
    *   `E.Salary > (Subquery)`: This is where the subquery comes into play.
        *   **For Joe (E.id = 1):**
            *   `E.salary = 70000`
            *   The subquery `SELECT Salary FROM Employee E2 WHERE E2.id = E.managerID` becomes `SELECT Salary FROM Employee E2 WHERE E2.id = 3`.  This returns 60000 (Sam's salary).
            *   The condition becomes `70000 > 60000`, which is true.  So, Joe is included in the result.
        *   **For Henry (E.id = 2):**
            *   `E.salary = 80000`
            *   The subquery `SELECT Salary FROM Employee E2 WHERE E2.id = E.managerID` becomes `SELECT Salary FROM Employee E2 WHERE E2.id = 4`.  This returns 90000 (Max's salary).
            *   The condition becomes `80000 > 90000`, which is false.  So, Henry is excluded.

3.  **Final Result:**
    *   The query returns only Joe as the `Employee` because he is the only one who satisfies all the conditions.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N^2)** in the worst-case scenario, where N is the number of employees. This is because for each employee, a subquery is executed to find the manager's salary. However, with optimizations in the database system, it can perform close to O(N).
*   **Space Complexity:** The space complexity is **O(1)** because the query uses a constant amount of extra space, regardless of the input size.
    