# 00176 - Second Highest Salary
    
**Language:** Mysql  
**Runtime:** 268 ms (Beats 79.53% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title               | 🔗 Link                                                     |
| ------------------ | --------------------- | ---------------------------------------------------------- |
| 176                | Second Highest Salary | [LeetCode Problem](https://leetcode.com/problems/second-highest-salary/) |

---

## 💡 **Problem Explanation**

The problem requires you to find the second highest salary from the `Employee` table. If there is no second highest salary (i.e., the table is empty or all salaries are the same), you should return `NULL`.

**Example:**

**Input:**

`Employee` table:

| id  | salary |
| --- | ------ |
| 1   | 100    |
| 2   | 200    |
| 3   | 300    |

**Output:**

| SecondHighestSalary |
| ------------------- |
| 200                 |

**Input:**

`Employee` table:

| id  | salary |
| --- | ------ |
| 1   | 100    |

**Output:**

| SecondHighestSalary |
| ------------------- |
| NULL                |

---

## 📊 **Algorithm**

*   Select distinct salaries from the `Employee` table.
*   Order the salaries in descending order.
*   Limit the result to the second row (offset 1, limit 1).
*   Use `COALESCE` to return `NULL` if the subquery returns an empty set.

---

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

---

## 📊 **ASCII Representation**

Here's a simplified representation of the `Employee` table:

```
Employee Table
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
```

---

## 📊 **WORKING**

Let's trace the query with the sample input:

**Employee Table:**

| id  | salary |
| --- | ------ |
| 1   | 100    |
| 2   | 200    |
| 3   | 300    |

1.  **Subquery:**
    *   `select distinct(salary) from Employee order by salary desc limit 1,1`
    *   Distinct salaries: `100, 200, 300`
    *   Ordered in descending order: `300, 200, 100`
    *   `limit 1,1` selects the second row: `200`

2.  **Outer Query:**
    *   `coalesce(200, null)` returns `200` because `200` is not `NULL`.
    *   If the subquery returned an empty set, `coalesce(null, null)` would return `NULL`.

**Result:**

| SecondHighestSalary |
| ------------------- |
| 200                 |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(n log n)** due to the sorting operation (`order by`). In the best-case scenario, if an index exists on the `salary` column, the time complexity can be reduced.

*   **Space Complexity:** The space complexity is **O(n)** in the worst case, where *n* is the number of rows in the `Employee` table, due to the space required to store the distinct salaries. If the number of distinct salaries is small compared to the total number of rows, the space complexity will be lower.
    