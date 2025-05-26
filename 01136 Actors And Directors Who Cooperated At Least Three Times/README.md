# 01136 - Actors And Directors Who Cooperated At Least Three Times
    
**Language:** Mysql  
**Runtime:** 475 ms (Beats 9.56% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The problem requires you to identify pairs of `actor_id` and `director_id` from the `ActorDirector` table who have collaborated on at least three movies together.  In simpler terms, you need to group the data by actor and director, and then filter those groups where the count of collaborations is greater than 2.

**Example:**

**Input Table:** `ActorDirector`

| actor_id | director_id | timestamp |
|---|---|---|
| 1 | 1 | 0 |
| 1 | 1 | 1 |
| 1 | 1 | 2 |
| 1 | 2 | 3 |
| 1 | 2 | 4 |
| 2 | 1 | 5 |

**Expected Output:**

| actor_id | director_id |
|---|---|
| 1 | 1 |

Explanation: The actor with id '1' and the director with id '1' cooperated 3 times.

## 📊 **Algorithm**

*   Group the rows in the `ActorDirector` table by `actor_id` and `director_id`.
*   Count the number of occurrences for each group.
*   Filter the groups where the count is greater than 2.
*   Select the `actor_id` and `director_id` from the filtered groups.

## 🔥 **Code Implementation**

```mysql
SELECT actor_id , director_id 
FROM ACTORDIRECTOR
GROUP BY ACTOR_ID,DIRECTOR_ID
HAVING COUNT(*)>2;
```

## 📊 **ASCII Representation**

This problem doesn't directly involve grids or trees, so an ASCII representation isn't applicable. However, if we consider the grouping, you can visualize it as such:

```
ActorDirector Table:
+----------+-------------+-----------+
| actor_id | director_id | timestamp |
+----------+-------------+-----------+
| 1        | 1           | 0         |
| 1        | 1           | 1         |
| 1        | 1           | 2         |
| 1        | 2           | 3         |
| 1        | 2           | 4         |
| 2        | 1           | 5         |
+----------+-------------+-----------+

Grouping & Counting:
+----------+-------------+-------+
| actor_id | director_id | count |
+----------+-------------+-------+
| 1        | 1           | 3     |
| 1        | 2           | 2     |
| 2        | 1           | 1     |
+----------+-------------+-------+

Filtering (count > 2):
+----------+-------------+
| actor_id | director_id |
+----------+-------------+
| 1        | 1           |
+----------+-------------+
```

## 📊 **WORKING**

Let's trace the provided SQL query with the sample input.

**Input Table:** `ActorDirector`

| actor_id | director_id | timestamp |
|---|---|---|
| 1 | 1 | 0 |
| 1 | 1 | 1 |
| 1 | 1 | 2 |
| 1 | 2 | 3 |
| 1 | 2 | 4 |
| 2 | 1 | 5 |

1.  **`GROUP BY ACTOR_ID, DIRECTOR_ID`**:  The table is grouped by combinations of `actor_id` and `director_id`.  This results in the following groups:

    *   (1, 1)
    *   (1, 2)
    *   (2, 1)

2.  **`HAVING COUNT(*) > 2`**: For each group, the `COUNT(*)` function calculates the number of rows. The `HAVING` clause filters these groups, keeping only those where the count is greater than 2.

    *   Group (1, 1) has 3 rows (count = 3), so it passes the filter.
    *   Group (1, 2) has 2 rows (count = 2), so it's filtered out.
    *   Group (2, 1) has 1 row (count = 1), so it's filtered out.

3.  **`SELECT actor_id, director_id`**: Finally, the query selects the `actor_id` and `director_id` columns for the groups that passed the filter. This results in the following output:

| actor_id | director_id |
|---|---|
| 1 | 1 |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the `GROUP BY` operation. In the worst case, the database might need to sort the entire table, leading to a complexity of **O(N log N)**, where N is the number of rows in the `ActorDirector` table.  However, with appropriate indexing, the grouping could be optimized.

*   **Space Complexity:** The space complexity depends on the number of distinct groups formed by `actor_id` and `director_id`.  In the worst case, where each row has a unique combination of actor and director, the space complexity would be **O(N)**, where N is the number of rows. In a more realistic scenario where the number of distinct actor-director pairs is smaller than N, the space complexity would be less than O(N).
    