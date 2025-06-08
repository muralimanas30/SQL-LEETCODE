# 00181 - Employees Earning More Than Their Managers
    
**Language:** Mysql  
**Runtime:** 356 ms (Beats 92.84% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                                           | 🔗 Link                                                                                      |
| ------------------ | ------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| 181               | Employees Earning More Than Their Managers        | [LeetCode Problem](https://leetcode.com/problems/employees-earning-more-than-their-managers/) |

---

## 💡 **Problem Explanation**

This problem requires us to find employees who earn more than their managers. We are given an `Employee` table containing employee IDs, names, salaries, and manager IDs.  We need to return the names of all employees who have a higher salary than their direct manager.

**Example:**

**Employee Table:**

| id  | name   | salary | managerId |
| --- | ------ | ------ | --------- |
| 1   | Joe    | 70000  | 3         |
| 2   | Henry  | 80000  | 4         |
| 3   | Sam    | 60000  | NULL      |
| 4   | Max    | 90000  | NULL      |

**Output:**

| Employee |
| -------- |
| Joe      |

**Explanation:**

Joe earns 70000 and his manager (Sam) earns 60000.

## 📊 **Algorithm**

*   **Method 1 (Using JOIN):**
    *   Join the `Employee` table with itself using the `managerId` and `id` columns.
    *   Filter the results to include only employees whose salary is greater than their manager's salary.
    *   Select the employee's name as the output.
*   **Method 2 (Using Subquery):**
    *   Select the name of employees from the `Employee` table.
    *   Ensure the `managerId` is not null, indicating they have a manager.
    *   Use a subquery to fetch the salary of each employee's manager.
    *   Filter employees whose salary is greater than their manager's salary returned by the subquery.

## 🔥 **Code Implementation**

```mysql
# METHDOD 1
select e1.name as Employee from employee e1
join employee e2 on e1.managerId = e2.id
where e1.salary>e2.salary;

#METHOD 2
-- select E.name as Employee from Employee as E
-- where E.managerId is not null
-- and E.Salary > (
--     Select Salary from Employee E2
--     where E2.id = E.managerID
-- )
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

Let's trace Method 1 with the example data.

**Employee Table:**

| id  | name   | salary | managerId |
| --- | ------ | ------ | --------- |
| 1   | Joe    | 70000  | 3         |
| 2   | Henry  | 80000  | 4         |
| 3   | Sam    | 60000  | NULL      |
| 4   | Max    | 90000  | NULL      |

**SQL Query:**

```sql
select e1.name as Employee from employee e1
join employee e2 on e1.managerId = e2.id
where e1.salary>e2.salary;
```

**Step-by-step Execution:**

1.  **JOIN:** The `Employee` table is joined with itself (aliased as `e1` and `e2`) where `e1.managerId = e2.id`. This combines each employee's information with their manager's information in a single row.

    | e1.id | e1.name | e1.salary | e1.managerId | e2.id | e2.name | e2.salary | e2.managerId |
    | ----- | ------- | --------- | ------------- | ----- | ------- | --------- | ------------- |
    | 1     | Joe     | 70000     | 3             | 3     | Sam     | 60000     | NULL          |
    | 2     | Henry   | 80000     | 4             | 4     | Max     | 90000     | NULL          |

2.  **WHERE Clause:** The `WHERE` clause filters these joined rows, keeping only the rows where the employee's salary (`e1.salary`) is greater than the manager's salary (`e2.salary`).

    *   For Joe: 70000 > 60000 is TRUE. Joe is selected.
    *   For Henry: 80000 > 90000 is FALSE. Henry is not selected.

3.  **SELECT Clause:** The `SELECT` clause then extracts the employee's name (`e1.name`) for the matching rows.

**Final Result:**

| Employee |
| -------- |
| Joe      |

## 🚀 **Time & Space Complexity**

*   **Method 1 (JOIN):**
    *   **Time Complexity:** **O(N),**  where N is the number of rows in the Employee table. This is because we are joining the table with itself, and the filtering is done in linear time.
    *   **Space Complexity:** **O(N),** in the worst-case scenario where almost all employees earn more than their managers.

*   **Method 2 (Subquery):**
    *   **Time Complexity:** **O(N^2),** where N is the number of rows in the Employee table.  The subquery is executed for each row in the outer query.
    *   **Space Complexity:** **O(1)** (excluding the space for the output) since the subquery's space usage is constant.
    