# 01873 - Calculate Special Bonus
    
**Language:** Mysql  
**Runtime:** 733 ms (Beats 13.49% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1873 | Calculate Special Bonus | [LeetCode Problem](https://leetcode.com/problems/calculate-special-bonus/) |

---

## 💡 **Problem Explanation**

The task is to calculate the bonus for each employee based on the following conditions:

1.  If the employee's `employee_id` is odd and the employee's `name` does not start with 'M', then the bonus is equal to the employee's salary.
2.  Otherwise, the bonus is 0.

The result should be ordered by `employee_id`.

**Example:**

**Input Table: `Employees`**

| employee_id | name      | salary |
|-------------|-----------|--------|
| 2           | Meir      | 3000   |
| 3           | Michael   | 3800   |
| 7           | Addison   | 7400   |
| 8           | Kurt      | 6100   |
| 9           | Mark      | 1000   |

**Output Table:**

| employee_id | bonus |
|-------------|-------|
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 8           | 0     |
| 9           | 0     |

## 📊 **Algorithm**

*   Iterate through each employee in the `Employees` table.
*   Check if the `employee_id` is odd using the modulo operator (`%`).
*   Check if the `name` starts with 'M' using the `NOT LIKE 'M%'` condition.
*   If both conditions are true, assign the `salary` as the `bonus`.
*   Otherwise, assign 0 as the `bonus`.
*   Order the result by `employee_id`.

## 🔥 **Code Implementation**

```mysql
SELECT
    employee_id,
    IF(employee_id % 2 != 0 AND name NOT LIKE 'M%', salary, 0) AS bonus
FROM
    Employees
ORDER BY
    employee_id;
```

## 📊 **ASCII Representation**

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
| salary      | int     |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the name and the salary of an employee.
```

## 📊 **WORKING**

Let's trace the execution with the provided example input:

**Input Table: `Employees`**

| employee_id | name      | salary |
|-------------|-----------|--------|
| 2           | Meir      | 3000   |
| 3           | Michael   | 3800   |
| 7           | Addison   | 7400   |
| 8           | Kurt      | 6100   |
| 9           | Mark      | 1000   |

1.  **employee_id = 2, name = 'Meir', salary = 3000**

    *   `employee_id % 2 != 0` (2 % 2 != 0) is false.
    *   `name NOT LIKE 'M%'` ('Meir' NOT LIKE 'M%') is false.
    *   `bonus` = 0.
2.  **employee_id = 3, name = 'Michael', salary = 3800**

    *   `employee_id % 2 != 0` (3 % 2 != 0) is true.
    *   `name NOT LIKE 'M%'` ('Michael' NOT LIKE 'M%') is false.
    *   `bonus` = 0.
3.  **employee_id = 7, name = 'Addison', salary = 7400**

    *   `employee_id % 2 != 0` (7 % 2 != 0) is true.
    *   `name NOT LIKE 'M%'` ('Addison' NOT LIKE 'M%') is true.
    *   `bonus` = 7400.
4.  **employee_id = 8, name = 'Kurt', salary = 6100**

    *   `employee_id % 2 != 0` (8 % 2 != 0) is false.
    *   `name NOT LIKE 'M%'` ('Kurt' NOT LIKE 'M%') is true.
    *   `bonus` = 0.
5.  **employee_id = 9, name = 'Mark', salary = 1000**

    *   `employee_id % 2 != 0` (9 % 2 != 0) is true.
    *   `name NOT LIKE 'M%'` ('Mark' NOT LIKE 'M%') is false.
    *   `bonus` = 0.

**Final Output:**

| employee_id | bonus |
|-------------|-------|
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 8           | 0     |
| 9           | 0     |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N)**, where N is the number of rows in the `Employees` table. This is because we need to iterate through each row once to calculate the bonus. The `ORDER BY` clause contributes **O(N log N)** in the worst-case scenario.

*   **Space Complexity:** The space complexity is **O(1)**, as we are only using a constant amount of extra space to store the result. The sorting operation might require additional space depending on the database implementation, but it's generally considered to be in place or using a small amount of auxiliary space.
    