# 02110 - Employees With Missing Information
    
**Language:** Mysql  
**Runtime:** 620 ms (Beats 30.43% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 2110 | Employees With Missing Information | [LeetCode Problem](https://leetcode.com/problems/employees-with-missing-information/) |

---

## 💡 **Problem Explanation**

The problem requires identifying `employee_id` values that are present in either the `Employees` table or the `Salaries` table, but not in both. Essentially, we need to find employees who are missing either salary information or employee details.

**Example:**

Consider the following `Employees` and `Salaries` tables:

**Employees Table:**

| employee_id | name    |
|-------------|---------|
| 2           | Crew    |
| 4           | Haven   |
| 5           | Kristoffer|

**Salaries Table:**

| employee_id | salary |
|-------------|--------|
| 5           | 76951  |
| 1           | 71766  |
| 4           | 13852  |

The desired output should include `employee_id` 1 and 2. Employee 1 is in the `Salaries` table but not in the `Employees` table, and employee 2 is in the `Employees` table but not in the `Salaries` table. Employees 4 and 5 are present in both tables, so they are excluded from the result.

## 📊 **Algorithm**

*   Find `employee_id` values that exist in the `Employees` table but not in the `Salaries` table.
*   Find `employee_id` values that exist in the `Salaries` table but not in the `Employees` table.
*   Combine the results from the above two steps.
*   Order the combined result by `employee_id` in ascending order.

## 🔥 **Code Implementation**

```mysql
SELECT employee_id 
FROM employees
WHERE employee_id NOT IN (SELECT employee_id FROM salaries)
UNION
SELECT employee_id 
FROM salaries
WHERE employee_id NOT IN (SELECT employee_id FROM employees)
ORDER BY employee_id;
```

## 📊 **ASCII Representation**

Since this problem involves database tables, an ASCII representation of the data structure is not directly applicable. However, the relational aspect can be conceptually visualized.

## 📊 **WORKING**

Let's walk through the provided example tables:

**Employees Table:**

| employee_id | name    |
|-------------|---------|
| 2           | Crew    |
| 4           | Haven   |
| 5           | Kristoffer|

**Salaries Table:**

| employee_id | salary |
|-------------|--------|
| 5           | 76951  |
| 1           | 71766  |
| 4           | 13852  |

1.  **Find `employee_id` in `Employees` but not in `Salaries`:**
    *   `Employees` table: \[2, 4, 5]
    *   `Salaries` table: \[5, 1, 4]
    *   Result: \[2]

2.  **Find `employee_id` in `Salaries` but not in `Employees`:**
    *   `Salaries` table: \[5, 1, 4]
    *   `Employees` table: \[2, 4, 5]
    *   Result: \[1]

3.  **Combine the results (using `UNION` which removes duplicates):**
    *   \[2] UNION \[1] results in \[2, 1] which becomes \[1,2] after ordering.

4.  **Final Result (ordered):** \[1, 2]

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the subqueries and the `UNION` operation. In the worst case, where the tables are large, the `NOT IN` operator can lead to a time complexity of **O(N\*M)**, where N is the size of the `Employees` table and M is the size of the `Salaries` table. The `UNION` operation can also take **O(N+M)** time. The `ORDER BY` clause contributes **O(K log K)** where K is the number of elements after the UNION, making the total time complexity approximately **O(N\*M + K log K)**.

*   **Space Complexity:** The space complexity is **O(K)**, where K is the number of `employee_id` values that are either unique to the `Employees` table or unique to the `Salaries` table. This accounts for the temporary storage required to hold the intermediate results of the subqueries and the final combined result.
    