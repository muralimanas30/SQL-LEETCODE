# 01407 - Top Travellers
    
**Language:** Mysql  
**Runtime:** 859 ms (Beats 54.65% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1407 | Top Travellers | [LeetCode Problem](https://leetcode.com/problems/top-travellers/) |

---

## 💡 **Problem Explanation**

The "Top Travellers" problem requires us to write a SQL query to determine the distance each user has travelled. The task involves joining two tables, `Users` and `Rides`, to aggregate the distances travelled by each user. If a user hasn't travelled any distance (i.e., has no entries in the `Rides` table), we should consider their travelled distance as 0. The final result should be sorted in descending order of the total distance travelled and then, in ascending order of the user's name.

**Sample Input:**

**Users table:**

| id  | name    |
|-----|---------|
| 1   | Alice   |
| 2   | Bob     |
| 3   | Alex    |
| 4   | Donald  |
| 5   | Lee     |
| 6   | Elon    |
| 7   | Brad    |

**Rides table:**

| id  | user_id | distance |
|-----|---------|----------|
| 1   | 1       | 120      |
| 2   | 2       | 317      |
| 3   | 3       | 222      |
| 4   | 7       | 100      |
| 5   | 1       | 230      |
| 6   | 4       | 5        |
| 7   | 6       | 503      |

**Expected Output:**

| name   | travelled_distance |
|--------|--------------------|
| Elon   | 503                |
| Bob    | 317                |
| Alice  | 350                |
| Alex   | 222                |
| Brad   | 100                |
| Donald | 5                  |
| Lee    | 0                  |

## 📊 **Algorithm**

*   Join the `Users` table with the `Rides` table using a `LEFT JOIN` on `Users.id = Rides.user_id`. This ensures that all users are included in the result, even if they have no rides.
*   Use `IFNULL` to treat `NULL` values in `Rides.distance` as 0. This handles cases where a user has no rides.
*   Use `SUM` to aggregate the distances for each user.
*   Group the results by `Users.id` to calculate the total distance for each user.
*   Order the results first by `travelled_distance` in descending order and then by `name` in ascending order.

## 🔥 **Code Implementation**

```mysql
SELECT U.name,SUM(IFNULL(R.DISTANCE,0)) AS travelled_distance
FROM USERS U
LEFT JOIN RIDES R
ON U.ID = R.USER_ID
GROUP BY U.ID
ORDER BY travelled_distance DESC,name ASC
```

## 📊 **ASCII Representation**

**Users Table:**

```
+-------+----------+
|  id   |   name   |
+-------+----------+
|   1   |  Alice   |
|   2   |   Bob    |
|   3   |   Alex   |
|   4   |  Donald  |
|   5   |   Lee    |
|   6   |   Elon   |
|   7   |   Brad   |
+-------+----------+
```

**Rides Table:**

```
+-------+---------+----------+
|  id   | user_id | distance |
+-------+---------+----------+
|   1   |    1    |   120    |
|   2   |    2    |   317    |
|   3   |    3    |   222    |
|   4   |    7    |   100    |
|   5   |    1    |   230    |
|   6   |    4    |     5    |
|   7   |    6    |   503    |
+-------+---------+----------+
```

**Relationship:**

```
Users.id  <----  Rides.user_id
(One-to-Many Relationship)
```

## 📊 **WORKING**

Let's walk through the query step by step with the given sample data:

1.  **LEFT JOIN:** Join `Users` and `Rides` on `Users.id = Rides.user_id`.

    ```
    +-------+----------+-------+---------+----------+
    | U.id  |  U.name  | R.id  | R.user_id | R.distance |
    +-------+----------+-------+---------+----------+
    |   1   |  Alice   |   1   |    1    |   120    |
    |   1   |  Alice   |   5   |    1    |   230    |
    |   2   |   Bob    |   2   |    2    |   317    |
    |   3   |   Alex   |   3   |    3    |   222    |
    |   4   |  Donald  |   6   |    4    |     5    |
    |   5   |   Lee    |  NULL |   NULL  |   NULL   |
    |   6   |   Elon   |   7   |    6    |   503    |
    |   7   |   Brad   |   4   |    7    |   100    |
    +-------+----------+-------+---------+----------+
    ```

2.  **IFNULL and SUM:** Calculate the total distance for each user, treating `NULL` distances as 0.

    ```
    Alice: 120 + 230 = 350
    Bob: 317
    Alex: 222
    Donald: 5
    Lee: 0 (NULL becomes 0)
    Elon: 503
    Brad: 100
    ```

3.  **GROUP BY U.id:** Group the results by user ID.

4.  **ORDER BY:** Order the results by `travelled_distance` descending and `name` ascending.

    ```
    Elon: 503
    Alice: 350
    Bob: 317
    Alex: 222
    Brad: 100
    Donald: 5
    Lee: 0
    ```

Thus, the final output is:

```
+--------+--------------------+
| name   | travelled_distance |
+--------+--------------------+
| Elon   | 503                |
| Alice  | 350                |
| Bob    | 317                |
| Alex   | 222                |
| Brad   | 100                |
| Donald | 5                  |
| Lee    | 0                  |
+--------+--------------------+
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the `LEFT JOIN`, `GROUP BY`, and `ORDER BY` operations. In the worst case, if there are *n* users and *m* rides, the complexity can be **O(m\*log(m) + n\*log(n))** due to sorting (ordering). However, database systems are highly optimized for these operations.

*   **Space Complexity:** The space complexity is primarily determined by the storage required for the joined data and the temporary storage used for grouping and sorting. In the worst case, this can be **O(m + n)** where *n* is the number of rows in Users and *m* is the number of rows in Rides
    