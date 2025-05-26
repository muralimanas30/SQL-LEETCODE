# 00176 - Second Highest Salary
    
**Language:** Mysql  
**Runtime:** 268 ms (Beats 78.88% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 176 | SECOND HIGHEST SALARY | [LeetCode Problem](https://leetcode.com/problems/second-highest-salary/) |

---

## 💡 **Problem Explanation**

The task is to find the second highest salary from the `Employee` table. If there is no second highest salary (i.e., only one distinct salary exists), return `NULL`.

**Example:**

Consider the following `Employee` table:

| id  | salary |
|-----|--------|
| 1   | 100    |
| 2   | 200    |
| 3   | 300    |

The second highest salary is 200.

If the table is:

| id  | salary |
|-----|--------|
| 1   | 100    |

There is no second highest salary, so the output should be `NULL`.

---

## 📊 **Algorithm**

*   Select distinct salaries from the `Employee` table.
*   Order the salaries in descending order.
*   Limit the result to the second highest salary (offset 1, limit 1).
*   Use `COALESCE` to return `NULL` if the subquery returns an empty result.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
Select
    coalesce(
    (
        select distinct(salary)
        from Employee
        order by salary desc
        limit 1,1), null
    )
    as SecondHighestSalary;
```

## 📊 **WORKING**

Let's trace the query with an example `Employee` table:

| id | salary |
|----|--------|
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
| 4  | 300    |

1.  The subquery `select distinct(salary) from Employee order by salary desc limit 1,1` will:
    *   Select distinct salaries: `100, 200, 300`
    *   Order them in descending order: `300, 200, 100`
    *   Limit the result to the second row: `200`

2.  The outer query `coalesce((subquery), null)` will return `200` because the subquery result is not `NULL`.

Now, consider the following `Employee` table:

| id | salary |
|----|--------|
| 1  | 100    |
| 2  | 100    |

1.  The subquery `select distinct(salary) from Employee order by salary desc limit 1,1` will:
    *   Select distinct salaries: `100`
    *   Order them in descending order: `100`
    *   Limit the result to the second row: Returns an empty set.

2.  The outer query `coalesce((subquery), null)` will return `NULL` because the subquery result is an empty set.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** O(n log n) due to the sorting operation in the subquery, where n is the number of rows in the `Employee` table.  The `DISTINCT` also contributes to this complexity.
*   **Space Complexity:** O(n) in the worst case, to store the distinct salaries.
    