# 01978 - Employees Whose Manager Left The Company
    
**Language:** Mysql  
**Runtime:** 352 ms (Beats 53.31% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                                     | 🔗 Link                                                                                       |
| ------------------ | ------------------------------------------- | -------------------------------------------------------------------------------------------- |
| 1978               | Employees Whose Manager Left the Company | [LeetCode Problem](https://leetcode.com/problems/employees-whose-manager-left-the-company/) |

---

## 💡 **Problem Explanation**

This problem asks us to identify employees who meet specific criteria: their salary is less than \$30,000, they have a manager, and their manager is no longer with the company.  We need to return the `employee_id` of these employees in ascending order.

**Sample Input:**

Let's say we have the following `Employees` table:

| employee_id | name    | salary | manager_id |
|-------------|---------|--------|------------|
| 1           | John    | 20000  | 3          |
| 2           | Alex    | 40000  | NULL       |
| 3           | Alice   | 30000  | NULL       |
| 4           | Bob     | 15000  | 3          |
| 5           | Emily   | 25000  | 1          |

**Expected Output:**

| employee_id |
|-------------|
| 1           |
| 4           |
| 5           |

**Explanation:**

*   Employee 1 (John) has a salary of \$20,000 (less than \$30,000), a manager with `employee_id` 3 (Alice), and Alice's `employee_id` is present in the table meaning she is an employee. However if Alice was not present this would have fulfilled the final condition.
*   Employee 2 (Alex) has a salary greater than $30,000
*   Employee 3 (Alice) is a manager, so not important for us
*   Employee 4 (Bob) has a salary of \$15,000 (less than \$30,000), a manager with `employee_id` 3 (Alice), and Alice's `employee_id` is present in the table meaning she is an employee. However if Alice was not present this would have fulfilled the final condition.
*   Employee 5 (Emily) has a salary of \$25,000 (less than \$30,000), a manager with `employee_id` 1 (John), and John's `employee_id` is present in the table meaning he is an employee. However if John was not present this would have fulfilled the final condition.

## 📊 **Algorithm**

*   Select `employee_id` from the `Employees` table.
*   Filter the employees based on the following conditions:
    *   `salary` less than 30000.
    *   `manager_id` is not NULL (meaning they have a manager).
    *   The `manager_id` does not exist as an `employee_id` in the `Employees` table (meaning the manager has left the company).  We achieve this with a subquery that checks if the `manager_id` exists as an `employee_id`.
*   Order the results by `employee_id` in ascending order.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT employee_id
FROM EMPLOYEES E1
WHERE E1.SALARY<30000
AND E1.MANAGER_ID IS NOT NULL
AND E1.MANAGER_ID NOT IN (SELECT employee_id from EMPLOYEES)
ORDER BY employee_id
```

## 📊 **ASCII Representation**

Here's a simple representation of the `Employees` table structure:

```
Employees Table
+-------------+---------+--------+------------+
| employee_id | name    | salary | manager_id |
+-------------+---------+--------+------------+
| INT         | VARCHAR | INT    | INT        |
+-------------+---------+--------+------------+
```

## 📊 **WORKING**

Let's trace the query with the sample input:

**Initial `Employees` Table:**

| employee_id | name    | salary | manager_id |
|-------------|---------|--------|------------|
| 1           | John    | 20000  | 3          |
| 2           | Alex    | 40000  | NULL       |
| 3           | Alice   | 30000  | NULL       |
| 4           | Bob     | 15000  | 3          |
| 5           | Emily   | 25000  | 1          |

**1. Filtering `salary < 30000 AND manager_id IS NOT NULL`:**

| employee_id | name    | salary | manager_id |
|-------------|---------|--------|------------|
| 1           | John    | 20000  | 3          |
| 4           | Bob     | 15000  | 3          |
| 5           | Emily   | 25000  | 1          |

**2. Subquery `SELECT employee_id from EMPLOYEES` result:**

`[1, 2, 3, 4, 5]`

**3.  Filtering `manager_id NOT IN (SELECT employee_id from EMPLOYEES)`:**

In this step, we check if the `manager_id` of the remaining employees is present in the list of all employee IDs.
*   John's `manager_id` is 3, and 3 is in the subquery result.  Therefore John is filtered.
*   Bob's `manager_id` is 3, and 3 is in the subquery result. Therefore Bob is filtered.
*   Emily's `manager_id` is 1, and 1 is in the subquery result. Therefore Emily is filtered.

Since ALL Managers exist in the employees table, none are returned. Lets consider a hypothetical Employee 6, where Manager 7 does NOT exist in the employees table.

| employee_id | name    | salary | manager_id |
|-------------|---------|--------|------------|
| 6           | Emily   | 25000  | 7          |

**1. Filtering `salary < 30000 AND manager_id IS NOT NULL`:**

| employee_id | name    | salary | manager_id |
|-------------|---------|--------|------------|
| 6           | Emily   | 25000  | 7          |

**2. Subquery `SELECT employee_id from EMPLOYEES` result:**

`[1, 2, 3, 4, 5, 6]`

**3.  Filtering `manager_id NOT IN (SELECT employee_id from EMPLOYEES)`:**

In this step, we check if the `manager_id` of the remaining employees is present in the list of all employee IDs.
*   Emily's `manager_id` is 7, and 7 is NOT in the subquery result.  Therefore, Emily is NOT filtered

**4. Final Result (after ordering by `employee_id`):**

| employee_id |
|-------------|
| 6           |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The outer query iterates through a subset of the `Employees` table. The subquery `SELECT employee_id from EMPLOYEES` runs once. The overall time complexity is approximately **O(N)**, where N is the number of rows in the `Employees` table.

*   **Space Complexity:**  The space complexity is mainly determined by the storage required for the subquery's result set. In the worst case, the subquery returns all `employee_id` values, so the space complexity is **O(M)**, where M is the distinct number of `employee_id` values in the `Employees` table.  Since this number is bound by the size of the table (N), we can also express the space complexity as O(N).
    