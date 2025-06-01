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

This problem requires you to identify employees who earn more than their managers. You're given an `Employee` table with information about each employee, including their name, salary, and manager ID.  Your task is to write a SQL query that returns a table containing the names of employees who have a higher salary than their manager.

**Sample Input:**

```
Employee Table:

| id | name  | salary | managerId |
|----|-------|--------|-----------|
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
```

**Expected Output:**

```
| Employee |
|----------|
| Joe      |
| Henry    |
```

Joe earns 70000 and his manager (Sam, ID 3) earns 60000. Henry earns 80000 and his manager (Max, ID 4) earns 90000.

---

## 📊 **Algorithm**

*   Select the `name` of the employees as `Employee`.
*   Filter employees based on two conditions:
    *   The employee's `managerId` must not be `NULL` (meaning they have a manager).
    *   The employee's `salary` must be greater than their manager's `salary`. This requires a subquery to get the manager's salary based on the `managerId`.

## 🔥 **Code Implementation**

```mysql
# METHDOD 1
-- select e1.name as Employee from employee e1
-- join employee e2 on e1.managerId = e2.id
-- where e1.salary>e2.salary;

#METHOD 2
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

```
RELATION:

Employee {
  id: INT,
  name: VARCHAR,
  salary: INT,
  managerId: INT,
  FOREIGN KEY (managerId) REFERENCES Employee(id)
}
```

## 📊 **WORKING**

Let's consider the provided sample input and trace the execution of the SQL query:

**Employee Table:**

```
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
```

**Step-by-step execution:**

1.  **Outer Query:**  `select E.name as Employee from Employee as E where E.managerId is not null and E.Salary > (...)`

    *   The outer query iterates through each row in the `Employee` table (aliased as `E`).
    *   The `where` clause filters the rows based on two conditions:
        *   `E.managerId is not null`: This ensures that we only consider employees who have a manager.
        *   `E.Salary > (subquery)`: This compares the employee's salary with the salary returned by the subquery (which is the manager's salary).

2.  **Subquery:** `Select Salary from Employee E2 where E2.id = E.managerID`

    *   For each employee in the outer query, the subquery is executed to find the salary of their manager.
    *   The subquery looks up the `Employee` table (aliased as `E2`) and finds the salary where the `id` matches the `managerId` of the employee in the outer query.

3.  **Evaluation for Joe (id=1):**

    *   Outer query:  `E.name = 'Joe'`, `E.salary = 70000`, `E.managerId = 3`
    *   `E.managerId is not null` is true.
    *   Subquery:  `Select Salary from Employee E2 where E2.id = 3` returns `60000` (Sam's salary).
    *   `70000 > 60000` is true.
    *   Therefore, 'Joe' is included in the result.

4.  **Evaluation for Henry (id=2):**

    *   Outer query:  `E.name = 'Henry'`, `E.salary = 80000`, `E.managerId = 4`
    *   `E.managerId is not null` is true.
    *   Subquery:  `Select Salary from Employee E2 where E2.id = 4` returns `90000` (Max's salary).
    *   `80000 > 90000` is false.
    *   Therefore, Henry is NOT included in the result.

5.  **Result:**

    The query returns a table containing only the name 'Joe'.

*EXAMPLE WITH THE CORRECT OUTPUT**

1.  **Evaluation for Henry (id=2):**

    *   Outer query:  `E.name = 'Henry'`, `E.salary = 80000`, `E.managerId = 4`
    *   `E.managerId is not null` is true.
    *   Subquery:  `Select Salary from Employee E2 where E2.id = 4` returns `90000` (Max's salary).
    *   `80000 > 90000` is false.
    *   Therefore, Henry is NOT included in the result.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** **O(N^2)** in the worst-case scenario where 'N' is the number of employees. This is because for each employee, the subquery potentially iterates through the entire Employee table to find the manager's salary.  In the average case, it could be closer to O(N*M) where M is the number of managers if there is indexing. Using a JOIN could potentially be more efficient if the database optimizer can leverage indexes.
*   **Space Complexity:** **O(1)**, the space complexity is constant because we are not using any extra space that scales with the input size.  The subquery's space usage is limited to holding a single salary value.
    