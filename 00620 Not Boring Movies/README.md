# 00620 - Not Boring Movies
    
**Language:** Mysql  
**Runtime:** 209 ms (Beats 99.94% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 620 | Not Boring Movies | [LeetCode Problem](https://leetcode.com/problems/not-boring-movies/) |

---

## 💡 **Problem Explanation**

The "Not Boring Movies" problem asks you to retrieve information about movies from a `Cinema` table that meet two criteria:

1.  The movie's `id` is an odd number.
2.  The movie's `description` is not "boring".

The result should be ordered by the `rating` in descending order.

**Example:**

**Input Table:**

```
+---------+-----------+--------------+-----------+
|   id    | movie     | description  |  rating   |
+---------+-----------+--------------+-----------+
|   1     | War        | great        |  8.9      |
|   2     | Science    | boring       |  7.2      |
|   3     | Story      | good         |  8.5      |
|   4     | Adventure  | boring       |  6.1      |
+---------+-----------+--------------+-----------+
```

**Output Table:**

```
+---------+-----------+--------------+-----------+
|   id    | movie     | description  |  rating   |
+---------+-----------+--------------+-----------+
|   1     | War        | great        |  8.9      |
|   3     | Story      | good         |  8.5      |
+---------+-----------+--------------+-----------+
```

Only movies with odd IDs (1 and 3) and descriptions that are not "boring" are included.  They are then ordered by rating in descending order.

## 📊 **Algorithm**

*   Select the `id`, `movie`, `description`, and `rating` columns from the `Cinema` table.
*   Filter the rows to include only those where `id` is odd and `description` is not equal to 'boring'.
*   Order the results by `rating` in descending order.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT id, movie, description, rating
FROM Cinema
WHERE id % 2 = 1
  AND description != 'boring'
ORDER BY rating DESC;
```

## 📊 **ASCII Representation**

The Cinema table can be visualized as follows:

```
+---------+-----------+--------------+-----------+
|   id    | movie     | description  |  rating   |
+---------+-----------+--------------+-----------+
|   INT   | VARCHAR   | VARCHAR      |  DECIMAL  |
+---------+-----------+--------------+-----------+
|  ...    |  ...      |  ...         |  ...      |
```

## 📊 **WORKING**

Let's consider the sample input from the Problem Explanation. The query does the following:

1.  **Filters by Odd ID:** Keeps rows with `id` = 1 and `id` = 3.
2.  **Filters by Description:** From those remaining rows, keeps only rows where `description` is not 'boring'.  So, the row with `id` = 1 (`War`, `great`, 8.9) and `id` = 3 (`Story`, `good`, 8.5) are kept.
3.  **Orders by Rating:** Orders the resulting rows by the `rating` in descending order, resulting in `War` (8.9) appearing before `Story` (8.5).

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity depends on the size of the `Cinema` table and the efficiency of the database's query optimizer. In general, filtering and sorting operations can have a time complexity of **O(n log n)** in the worst case, where n is the number of rows in the table. However, with proper indexing, the query could perform much faster.

*   **Space Complexity:** The space complexity is primarily determined by the size of the result set that the query produces. In the worst case, if all rows in the table satisfy the conditions, the space complexity could be **O(n)**, where n is the number of rows in the table. However, if the conditions filter out a significant portion of the rows, the space complexity would be lower.
    