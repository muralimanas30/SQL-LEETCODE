# 01827 - Invalid Tweets
    
**Language:** Mysql  
**Runtime:** 529 ms (Beats 98.94% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1873 | Calculate Special Bonus | [LeetCode Problem](https://leetcode.com/problems/calculate-special-bonus/) |

---

## 💡 **Problem Explanation**
The problem asks us to calculate the bonus amount for each employee based on two conditions:

1.  If the employee's ID is an odd number.
2.  If the employee's name does not start with the character 'M'.

If both conditions are met, the bonus is equal to the employee's salary. Otherwise, the bonus is 0.

**Example:**

**Input:**

`Employees` table:

| employee_id | name    | salary |
|-------------|---------|--------|
| 2           | Meir    | 3000   |
| 3           | Michael | 3800   |
| 7           | Addilyn | 7400   |
| 1           | Juan    | 6100   |
| 4           | Jane    | 8000   |

**Output:**

| employee_id | bonus |
|-------------|-------|
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 1           | 6100  |
| 4           | 0     |

---

## 📊 **Algorithm**

*   Select `employee_id`.
*   Calculate the bonus using a `CASE` statement:
    *   If `employee_id` is odd and `name` does not start with 'M', then bonus = `salary`.
    *   Otherwise, bonus = 0.
*   Order the result by `employee_id`.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT employee_id,
       CASE
           WHEN employee_id % 2 != 0 AND name NOT LIKE 'M%' THEN salary
           ELSE 0
       END AS bonus
FROM Employees
ORDER BY employee_id;
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** **O(N)**, where N is the number of rows in the `Employees` table.  This is because we iterate through each row to apply the `CASE` statement.
*   **Space Complexity:** **O(N)**, where N is the number of rows in the `Employees` table. This accounts for storing the result set which includes each `employee_id` and calculated `bonus`. The sorting operation may require extra memory depending on the sorting algorithm used by the database.
    