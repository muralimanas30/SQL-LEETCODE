# 00185 - Department Top Three Salaries
    
**Language:** Mysql  
**Runtime:** 1020 ms (Beats 49.51% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                     | 🔗 Link                                                        |
| ------------------ | --------------------------- | ------------------------------------------------------------ |
| 185                | Department Top Three Salaries | [LeetCode Problem](https://leetcode.com/problems/department-top-three-salaries/) |

---

## 💡 **Problem Explanation**

The goal is to find the top three highest salaries for each department in a company.  If a department has fewer than three employees, list all employees in that department.  The output should include the department name, employee name, and salary for those employees who are in the top three highest salaries within their respective departments.

**Example:**

**Input:**

`Employee` table:

| id  | name   | salary | departmentId |
| --- | ------ | ------ | ------------ |
| 1   | Joe    | 70000  | 1            |
| 2   | Henry  | 80000  | 2            |
| 3   | Sam    | 60000  | 2            |
| 4   | Max    | 90000  | 1            |
| 5   | Janet  | 69000  | 1            |
| 6   | Randy  | 85000  | 1            |

`Department` table:

| id  | name        |
| --- | ----------- |
| 1   | IT          |
| 2   | Sales       |

**Output:**

| Department | Employee | Salary |
| ---------- | -------- | ------ |
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |

---

## 📊 **Algorithm**

*   Join the `Employee` and `Department` tables on their respective `departmentId` and `id` columns.
*   Use the `DENSE_RANK()` window function to rank employees within each department based on their salary in descending order.  `DENSE_RANK()` assigns ranks without gaps, even if there are ties in salary.
*   Filter the results to include only those employees whose rank is less than or equal to 3.
*   Select the department name, employee name, and salary for the filtered results.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT Department,
        Employee,
        Salary
FROM
(
    SELECT D.NAME AS Department,
    E.NAME AS Employee,
    E.SALARY AS Salary,
    DENSE_RANK() OVER (PARTITION BY D.ID ORDER BY SALARY DESC) AS "S_RANK"
    FROM EMPLOYEE E
    JOIN DEPARTMENT D
    ON E.DEPARTMENTID = D.ID
) AS SUBQUERY
where SUBQUERY.S_RANK<=3
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
| departmentId| int     |
+-------------+---------+

Department Table:

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
```

## 📊 **WORKING**

Let's trace the SQL query with the sample input.

1. **Join and Rank:** The `EMPLOYEE` and `DEPARTMENT` tables are joined. `DENSE_RANK()` calculates the rank of each employee's salary within their department.

| Department | Employee | Salary | S_RANK |
| ---------- | -------- | ------ | ------ |
| IT         | Max      | 90000  | 1      |
| IT         | Randy    | 85000  | 2      |
| IT         | Joe      | 70000  | 3      |
| IT         | Janet    | 69000  | 4      |
| Sales      | Henry    | 80000  | 1      |
| Sales      | Sam      | 60000  | 2      |

2. **Filter:** The `WHERE` clause filters the results, keeping only those rows where `S_RANK` is less than or equal to 3.

| Department | Employee | Salary | S_RANK |
| ---------- | -------- | ------ | ------ |
| IT         | Max      | 90000  | 1      |
| IT         | Randy    | 85000  | 2      |
| IT         | Joe      | 70000  | 3      |
| Sales      | Henry    | 80000  | 1      |
| Sales      | Sam      | 60000  | 2      |

3. **Select:** Finally, the query selects the `Department`, `Employee`, and `Salary` columns to produce the final output.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The dominant operation is the join and the window function (`DENSE_RANK`). The join operation's complexity depends on the size of the tables and the join algorithm used by the database. Assuming a reasonable join algorithm (e.g., hash join), the complexity is approximately **O(N + M)**, where N is the number of rows in `Employee` and M is the number of rows in `Department`. The `DENSE_RANK` function adds another **O(N log N)** component due to the sorting within each partition. Thus, the overall time complexity is approximately **O(N log N)** in the worst case.

*   **Space Complexity:** The space complexity is mainly determined by the storage required for the intermediate results, such as the joined table and the ranked table. In the worst case, where the database needs to store all rows of the joined table, the space complexity would be **O(N + M)**. The `DENSE_RANK` function might require additional space for sorting, which is **O(N)**. Therefore, the overall space complexity is approximately **O(N + M)**.
    