# 00177 - Nth Highest Salary
    
**Language:** Mysql  
**Runtime:** 412 ms (Beats 93.19% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 177 | NTH HIGHEST SALARY | [LeetCode Problem](https://leetcode.com/problems/nth-highest-salary/) |

---

## 💡 **Problem Explanation**

The problem requires you to write a SQL function `getNthHighestSalary(N INT)` that returns the nth highest salary from the `Employee` table. If there is no nth highest salary, the function should return `NULL`.

**Example:**

Consider the following `Employee` table:

| id  | salary |
|-----|--------|
| 1   | 100    |
| 2   | 200    |
| 3   | 300    |

- `getNthHighestSalary(2)` should return `200`.
- `getNthHighestSalary(4)` should return `NULL`.

---

## 📊 **Algorithm**

*   The steps to solve the problem are:
    *   Adjust the input `N` to account for zero-based indexing in `LIMIT`.
    *   Use a subquery to select distinct salaries from the `Employee` table.
    *   Order the distinct salaries in descending order.
    *   Use `LIMIT` with an offset `N` to get the Nth highest salary.
    *   If no such salary exists, return `NULL`.

## 🔥 **Code Implementation**

```mysql
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  SET N=N-1;
  RETURN (
      SELECT DISTINCT salary
      FROM Employee
      ORDER BY salary DESC
      LIMIT N, 1
  );
END;
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the `ORDER BY` clause. In the worst case, it would be **O(n log n)** where n is the number of rows in the Employee table. The `LIMIT` clause does not affect the time complexity significantly since it only retrieves a constant number of rows.
*   **Space Complexity:** The space complexity is **O(n)** due to the need to store the salaries for sorting. In practice, the database system can optimize this, but in the worst case, it's linear. The distinct salaries are stored temporarily to be sorted.
    