# 00596 - Classes More Than 5 Students
    
**Language:** Mysql  
**Runtime:** 371 ms (Beats 19.18% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 596 | Classes More Than 5 Students | [LeetCode Problem](https://leetcode.com/problems/classes-more-than-5-students/) |

---

## 💡 **Problem Explanation**

This problem asks us to find all the classes that have 5 or more students. We are given a table named `courses` with a column `class`. We need to write a SQL query that groups the rows by the `class` column and then filters those groups to only include classes with a count of 5 or more.

**Example:**

Let's say our `courses` table looks like this:

| student | class      |
|---------|------------|
| A       | Math       |
| B       | English    |
| C       | Math       |
| D       | Biology    |
| E       | Math       |
| F       | Computer   |
| G       | Math       |
| H       | Math       |
| I       | English    |

The expected output of our query should be:

| class      |
|------------|
| Math       |

Because only the "Math" class has 5 or more students enrolled.

## 📊 **Algorithm**

*   Group the rows in the `courses` table by the `class` column.
*   Count the number of students in each class using `COUNT(CLASS)`.
*   Filter the groups to include only those with a count greater than or equal to 5 using `HAVING`.
*   Select the `class` column from the filtered groups.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT class
FROM COURSES
GROUP BY CLASS
HAVING COUNT(CLASS) >= 5;
```

## 📊 **ASCII Representation**

This problem doesn't involve grids or trees, so an ASCII representation isn't directly applicable. However, we can think of the `courses` table as a simple database table:

```
Table: COURSES

+---------+-----------+
| student | class     |
+---------+-----------+
| A       | Math      |
| B       | English   |
| C       | Math      |
| D       | Biology   |
| E       | Math      |
| F       | Computer  |
| G       | Math      |
| H       | Math      |
| I       | English   |
+---------+-----------+
```

## 📊 **WORKING**

Let's trace the SQL query with the example table above:

1.  **`GROUP BY CLASS`**: This groups the table by distinct class values.
    ```
    Math: A, C, E, G, H
    English: B, I
    Biology: D
    Computer: F
    ```

2.  **`COUNT(CLASS)`**: Calculates the count of students in each class.
    ```
    Math: 5
    English: 2
    Biology: 1
    Computer: 1
    ```

3.  **`HAVING COUNT(CLASS) >= 5`**: Filters the groups where the count is greater than or equal to 5.  Only `Math` satisfies this condition.

4.  **`SELECT CLASS`**: Selects the `class` column of the filtered group `Math`. The final result is:

    ```
    +-------+
    | class |
    +-------+
    | Math  |
    +-------+
    ```

## 🚀 **Time & Space Complexity**

*   **Time Complexity: O(N)**, where N is the number of rows in the `courses` table.  This is because we need to iterate through all the rows to group them and count the students in each class.
*   **Space Complexity: O(M)**, where M is the number of distinct classes. This is because we need to store the counts for each distinct class in the `GROUP BY` operation.
    