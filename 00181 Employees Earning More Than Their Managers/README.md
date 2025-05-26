# 00181 - Employees Earning More Than Their Managers
    
**Language:** Mysql  
**Runtime:** 463 ms (Beats 18.62% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 181 | Employees Earning More Than Their Managers | [LeetCode Problem](https://leetcode.com/problems/employees-earning-more-than-their-managers/) |

---

## 💡 **Problem Explanation**

The problem requires us to find employees who earn more than their managers.  We are given a table named `Employee` with columns like `Id`, `Name`, `Salary`, and `ManagerId`. We need to write a SQL query that returns the names of employees who have a higher salary than their managers.

For Example:

**Employee Table:**

| Id  | Name   | Salary | ManagerId |
|-----|--------|--------|-----------|
| 1   | Joe    | 70000  | 3         |
| 2   | Henry  | 80000  | 4         |
| 3   | Sam    | 60000  | NULL      |
| 4   | Max    | 90000  | NULL      |

**Expected Output:**

| Employee |
|----------|
| Joe      |

Joe earns 70000, and his manager (Sam, Id=3) earns 60000.  Thus, Joe satisfies the condition.

## 📊 **Algorithm**
*   Join the `Employee` table with itself using the `ManagerId` to link employees to their managers.
*   Filter the results to include only employees whose salary is greater than their manager's salary.
*   Select the names of these employees.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
select e1.name as Employee from employee e1
join employee e2 on e1.managerId = e2.id
where e1.salary>e2.salary;
```

## 📊 **ASCII Representation**
This problem doesn't directly involve grids or trees, so an ASCII representation isn't applicable. However, we can visualize the database relationship.

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

Database Relationship:

```
  Employee (e1)        Employee (e2 - Manager)
+---------+           +---------+
| id      |---------->| id      |
| name    |           | name    |
| salary  |           | salary  |
| managerId|           |         |
+---------+           +---------+
  ^
  |
  +--------------------(ManagerId = id)
```

## 📊 **WORKING**

Let's trace the query using the sample input:

**Employee Table:**

| Id  | Name   | Salary | ManagerId |
|-----|--------|--------|-----------|
| 1   | Joe    | 70000  | 3         |
| 2   | Henry  | 80000  | 4         |
| 3   | Sam    | 60000  | NULL      |
| 4   | Max    | 90000  | NULL      |

1.  **Join:**
    We join the table with itself. `e1` represents the employee, and `e2` represents the manager.

    | e1.Id | e1.Name | e1.Salary | e1.ManagerId | e2.Id | e2.Name | e2.Salary |
    |-------|---------|-----------|--------------|-------|---------|-----------|
    | 1     | Joe     | 70000     | 3            | 3     | Sam     | 60000     |
    | 2     | Henry   | 80000     | 4            | 4     | Max     | 90000     |

2.  **Where Clause:**
    We filter where `e1.salary > e2.salary`.

    *   For Joe: `70000 > 60000` is true.
    *   For Henry: `80000 > 90000` is false.

3.  **Select:**
    We select `e1.name` (the employee's name) for the rows that satisfy the `where` condition.

Result:

| Employee |
|----------|
| Joe      |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The time complexity is **O(N)**, where N is the number of rows in the `Employee` table, due to the join operation and the filtering.  In the worst case, we might have to compare every employee with their manager.
*   **Space Complexity:** The space complexity is **O(N)** in the worst case, where N is the number of rows in the `Employee` table. This is because, in the worst-case scenario, the joined table could contain a row for each employee.
    