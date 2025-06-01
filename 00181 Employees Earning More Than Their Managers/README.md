# 00181 - Employees Earning More Than Their Managers
    
**Language:** Mysql  
**Runtime:** 896 ms (Beats 11.84% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                                       | 🔗 Link                                                                                   |
| ------------------ | --------------------------------------------- | ----------------------------------------------------------------------------------------- |
| 181                | Employees Earning More Than Their Managers | [LeetCode Problem](https://leetcode.com/problems/employees-earning-more-than-their-managers/) |

---

## 💡 **Problem Explanation**

This problem requires us to find employees who earn more than their managers. We are given an `Employee` table with columns for `id`, `name`, `salary`, and `managerId`. The goal is to output a table containing the names of employees who have a higher salary than their managers.

**Example:**

**Input Table:** `Employee`

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

Joe's salary is 70000, and his manager (Sam)'s salary is 60000. Since 70000 > 60000, Joe is included in the output.

---

## 📊 **Algorithm**

*   Select the employee's name as "Employee" from the `Employee` table.
*   Filter employees based on the following conditions:
    *   The employee's `managerId` is not `NULL` (meaning they have a manager).
    *   The employee's salary is greater than their manager's salary.
*   Use a subquery to get the salary of each employee's manager.

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

---

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

Let's walk through how the query works with the example input:

**Input Table:** `Employee`

| id  | name   | salary | managerId |
| --- | ------ | ------ | --------- |
| 1   | Joe    | 70000  | 3         |
| 2   | Henry  | 80000  | 4         |
| 3   | Sam    | 60000  | NULL      |
| 4   | Max    | 90000  | NULL      |

1.  **Outer Query:**
    *   `SELECT E.name AS Employee FROM Employee AS E`: This selects the name of the employee and aliases it as "Employee".
    *   `WHERE E.managerId IS NOT NULL`: This filters out employees who don't have a manager (Sam and Max in this case).  So, we're left with Joe and Henry.

2.  **Subquery:**
    *   The subquery `(SELECT Salary FROM Employee E2 WHERE E2.id = E.managerID)` is executed for each row remaining after the first filter (Joe and Henry):
        *   **For Joe (id=1, managerId=3, salary=70000):** The subquery becomes `SELECT Salary FROM Employee E2 WHERE E2.id = 3`, which returns 60000 (Sam's salary).
        *   **For Henry (id=2, managerId=4, salary=80000):** The subquery becomes `SELECT Salary FROM Employee E2 WHERE E2.id = 4`, which returns 90000 (Max's salary).

3.  **Final Comparison:**
    *   `E.Salary > (subquery)`:  This compares the employee's salary to the manager's salary obtained from the subquery:
        *   **For Joe:** 70000 > 60000 is true, so Joe is included in the output.
        *   **For Henry:** 80000 > 90000 is false, so Henry is excluded.

4.  **Result:**
    *   The query returns only Joe's name as "Employee".

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N)**, where N is the number of rows in the `Employee` table.  The outer query iterates through the table once, and the subquery is executed for each row that has a manager.  In the worst case, the subquery could take O(1) if the `id` column is indexed, but generally, we consider the overall complexity to be dominated by the scan of the main table.

*   **Space Complexity:** The space complexity is **O(1)** because we are only using a constant amount of extra space, regardless of the input size. The subquery only stores a single salary value, and the outer query does not create any large data structures.
    