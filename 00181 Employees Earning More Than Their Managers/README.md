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

The problem requires you to find the employees who earn more than their managers. You are given an `Employee` table with columns: `Id` (employee ID), `name` (employee name), `salary` (employee salary), and `managerId` (ID of the employee's manager). The goal is to return a table with a single column, `Employee`, containing the names of all employees who earn more than their managers.

**Sample Input:**

```
Employee table:
+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
```

**Sample Output:**

```
+----------+
| Employee |
+----------+
| Joe      |
+----------+
```

**Explanation:**

- Joe (ID 1) has a salary of 70000 and reports to Manager with ID 3 (Sam). Sam's salary is 60000. Since Joe's salary (70000) is greater than Sam's salary (60000), Joe should be included in the output.
- Henry (ID 2) has a salary of 80000 and reports to Manager with ID 4 (Max). Max's salary is 90000. Since Henry's salary (80000) is not greater than Max's salary (90000), Henry should not be included in the output.

---

## 📌 **Algorithm**

1.  Select the name of the employee.
2.  Filter the employees who have a manager (managerId is not NULL).
3.  Compare the salary of each employee with the salary of their manager.
4.  If the employee's salary is greater than the manager's salary, include the employee's name in the result.

---

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

**Method 2: Subquery Approach**

This method uses a subquery to fetch the manager's salary for each employee.

---

## 📊 **ASCII Representation**

```
Employee Table:

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+

Employee (Id)  ---- Reports to ---- Manager (Id)
  1 (Joe)      ------------------> 3 (Sam)
  2 (Henry)    ------------------> 4 (Max)
```

---

## 🔄 **Working / Execution Flow**

Let's trace the second query's execution with the sample input.

```sql
select E.name as Employee from Employee as E
where E.managerId is not null
and E.Salary > (
    Select Salary from Employee E2
    where E2.id = E.managerID
)
```

1.  **First Iteration (E.Id = 1, E.Name = Joe, E.Salary = 70000, E.ManagerId = 3):**
    *   `E.managerId is not null` evaluates to `3 is not null`, which is TRUE.
    *   Subquery: `Select Salary from Employee E2 where E2.id = E.managerID` becomes `Select Salary from Employee E2 where E2.id = 3`.
    *   The subquery returns `60000` (Sam's salary).
    *   `E.Salary > (Subquery Result)` becomes `70000 > 60000`, which is TRUE.
    *   Since both conditions are TRUE, 'Joe' is selected.

2.  **Second Iteration (E.Id = 2, E.Name = Henry, E.Salary = 80000, E.ManagerId = 4):**
    *   `E.managerId is not null` evaluates to `4 is not null`, which is TRUE.
    *   Subquery: `Select Salary from Employee E2 where E2.id = E.managerID` becomes `Select Salary from Employee E2 where E2.id = 4`.
    *   The subquery returns `90000` (Max's salary).
    *   `E.Salary > (Subquery Result)` becomes `80000 > 90000`, which is FALSE.
    *   Since the salary condition is FALSE, 'Henry' is not selected.

3.  **Third Iteration (E.Id = 3, E.Name = Sam, E.Salary = 60000, E.ManagerId = NULL):**
    *   `E.managerId is not null` evaluates to `NULL is not null`, which is FALSE.
    *   Since the first condition is FALSE, this row is skipped.

4.  **Fourth Iteration (E.Id = 4, E.Name = Max, E.Salary = 90000, E.ManagerId = NULL):**
    *   `E.managerId is not null` evaluates to `NULL is not null`, which is FALSE.
    *   Since the first condition is FALSE, this row is skipped.

Therefore, the final result will only contain 'Joe'.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** **O(n<sup>2</sup>)** -  The subquery is executed for each row, resulting in a nested loop behavior in the worst case.

*   **Space Complexity:** **O(1)** - The query uses a constant amount of extra space.
    