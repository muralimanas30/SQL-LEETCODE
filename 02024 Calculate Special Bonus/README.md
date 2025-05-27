# 02024 - Calculate Special Bonus
    
**Language:** Mysql  
**Runtime:** 733 ms (Beats 13.09% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 2024 | Calculate Special Bonus | [LeetCode Problem](https://leetcode.com/problems/calculate-special-bonus/) |

---

## 💡 **Problem Explanation**

The problem requires calculating a bonus for each employee based on two conditions:

1.  If the employee's ID is odd.
2.  If the employee's name does not start with 'M'.

If both conditions are met, the employee receives their salary as a bonus. Otherwise, they receive a bonus of 0. The result should be ordered by employee ID.

**Example:**

**Input:**

`Employees` table:

| employee_id | name    | salary |
|-------------|---------|--------|
| 2           | Meir    | 3000   |
| 3           | Michael | 3800   |
| 7           | Addison | 7400   |
| 8           | Rose    | 7000   |
| 9           | Moishe  | 1000   |

**Output:**

| employee_id | bonus |
|-------------|-------|
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 8           | 0     |
| 9           | 0     |

---

## 📊 **Algorithm**

*   Iterate through each employee.
*   Check if the `employee_id` is odd using the modulo operator (`%`).
*   Check if the `name` does not start with 'M' using the `NOT LIKE` operator.
*   If both conditions are true, set the `bonus` to `salary`. Otherwise, set it to 0.
*   Order the result by `employee_id`.

## 🔥 **Code Implementation**

```mysql
select employee_id, 
if(employee_id%2 != 0 and name NOT LIKE 'M%', salary, 0) as bonus
from employees order by employee_id;
```

## 📊 **ASCII Representation**

This problem does not involve grids or trees, so an ASCII representation is not applicable.

## 📊 **WORKING**

Let's walk through the example input:

`Employees` table:

| employee_id | name    | salary |
|-------------|---------|--------|
| 2           | Meir    | 3000   |
| 3           | Michael | 3800   |
| 7           | Addison | 7400   |
| 8           | Rose    | 7000   |
| 9           | Moishe  | 1000   |

1.  **employee_id = 2, name = 'Meir', salary = 3000:**
    *   `employee_id % 2 != 0` (2 % 2 != 0) is false.
    *   `name NOT LIKE 'M%'` ('Meir' NOT LIKE 'M%') is false.
    *   bonus = 0.

2.  **employee_id = 3, name = 'Michael', salary = 3800:**
    *   `employee_id % 2 != 0` (3 % 2 != 0) is true.
    *   `name NOT LIKE 'M%'` ('Michael' NOT LIKE 'M%') is false.
    *   bonus = 0.

3.  **employee_id = 7, name = 'Addison', salary = 7400:**
    *   `employee_id % 2 != 0` (7 % 2 != 0) is true.
    *   `name NOT LIKE 'M%'` ('Addison' NOT LIKE 'M%') is true.
    *   bonus = 7400.

4.  **employee_id = 8, name = 'Rose', salary = 7000:**
    *   `employee_id % 2 != 0` (8 % 2 != 0) is false.
    *   `name NOT LIKE 'M%'` ('Rose' NOT LIKE 'M%') is true.
    *   bonus = 0.

5.  **employee_id = 9, name = 'Moishe', salary = 1000:**
    *   `employee_id % 2 != 0` (9 % 2 != 0) is true.
    *   `name NOT LIKE 'M%'` ('Moishe' NOT LIKE 'M%') is false.
    *   bonus = 0.

Finally, the result is ordered by `employee_id`.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N log N)** due to the `ORDER BY` clause, where N is the number of employees. Without the ordering, the time complexity would be **O(N)** because we iterate through each row once.
*   **Space Complexity:** The space complexity is **O(1)** because we are not using any extra space that scales with the input size.
    