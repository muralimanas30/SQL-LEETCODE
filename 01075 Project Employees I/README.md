# 01075 - Project Employees I
    
**Language:** Mysql  
**Runtime:** 465 ms (Beats 97.89% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1075 | Project Employees I | [LeetCode Problem](https://leetcode.com/problems/project-employees-i/) |

---

## 💡 **Problem Explanation**

The problem requires us to find the average experience years of employees for each project. We are given two tables: `Project` and `Employee`. The `Project` table contains the project ID and the employee ID of employees working on that project. The `Employee` table contains the employee ID and their experience in years. We need to join these two tables on `employee_id`, group the results by `project_id`, and calculate the average `experience_years` for each project.

**Example:**

**Employee Table:**

| employee_id | experience_years |
|-------------|------------------|
| 1           | 3                |
| 2           | 4                |
| 3           | 5                |

**Project Table:**

| project_id | employee_id |
|------------|-------------|
| 1          | 1           |
| 1          | 2           |
| 2          | 1           |
| 2          | 3           |

**Expected Output:**

| project_id | average_years |
|------------|---------------|
| 1          | 3.50          |
| 2          | 4.00          |

---

## 📊 **Algorithm**

*   Join the `Project` and `Employee` tables on the `employee_id` column.
*   Group the joined table by `project_id`.
*   Calculate the average `experience_years` for each group (project).
*   Round the average to two decimal places.
*   Select the `project_id` and the calculated average.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT P.project_id , ROUND(AVG(E.EXPERIENCE_YEARS),2) as average_years
FROM PROJECT P
JOIN EMPLOYEE E
ON P.EMPLOYEE_ID = E.EMPLOYEE_ID
GROUP BY P.PROJECT_ID
```

---

## 📊 **ASCII Representation**

```
Employee Table:

+-------------+------------------+
| employee_id | experience_years |
+-------------+------------------+
| 1           | 3                |
| 2           | 4                |
| 3           | 5                |
+-------------+------------------+

Project Table:

+------------+-------------+
| project_id | employee_id |
+------------+-------------+
| 1          | 1           |
| 1          | 2           |
| 2          | 1           |
| 2          | 3           |
+------------+-------------+
```

---

## 📊 **WORKING**

Let's trace the execution with the sample input.

1.  **JOIN:**

    The `JOIN` operation combines the `Project` and `Employee` tables based on the `employee_id`.

    ```
    +------------+-------------+------------------+
    | project_id | employee_id | experience_years |
    +------------+-------------+------------------+
    | 1          | 1           | 3                |
    | 1          | 2           | 4                |
    | 2          | 1           | 3                |
    | 2          | 3           | 5                |
    +------------+-------------+------------------+
    ```

2.  **GROUP BY:**

    The `GROUP BY` operation groups the joined table by `project_id`.

    *   Project ID 1:
        ```
        +------------+-------------+------------------+
        | project_id | employee_id | experience_years |
        +------------+-------------+------------------+
        | 1          | 1           | 3                |
        | 1          | 2           | 4                |
        +------------+-------------+------------------+
        ```
    *   Project ID 2:
        ```
        +------------+-------------+------------------+
        | project_id | employee_id | experience_years |
        +------------+-------------+------------------+
        | 2          | 1           | 3                |
        | 2          | 3           | 5                |
        +------------+-------------+------------------+
        ```

3.  **AVG and ROUND:**

    The `AVG` function calculates the average `experience_years` for each group.

    *   Project ID 1: `(3 + 4) / 2 = 3.5`  Rounded to two decimal places: 3.50
    *   Project ID 2: `(3 + 5) / 2 = 4`    Rounded to two decimal places: 4.00

4.  **Final Result:**

    ```
    +------------+---------------+
    | project_id | average_years |
    +------------+---------------+
    | 1          | 3.50          |
    | 2          | 4.00          |
    +------------+---------------+
    ```

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The time complexity is dominated by the `JOIN` and `GROUP BY` operations. In the worst case, the complexity can be **O(N log N)**, where N is the total number of rows after the join.  However, with appropriate indexing and optimization by the database engine, it can be closer to **O(N)**.
*   **Space Complexity:** The space complexity depends on the size of the intermediate joined table and the grouping. In the worst case, if all rows belong to the same group, the space complexity can be **O(N)**.  Generally, the space complexity is proportional to the number of groups (number of unique `project_id` values) and the average size of each group.
    