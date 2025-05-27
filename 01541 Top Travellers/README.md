# 01541 - Top Travellers
    
**Language:** Mysql  
**Runtime:** 859 ms (Beats 53.09% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1541 | Top Travellers | [LeetCode Problem](https://leetcode.com/problems/top-travellers/) |

---

## 💡 **Problem Explanation**

The problem requires us to retrieve a list of user names and their total travelled distances. The `Users` table contains user IDs and names, while the `Rides` table contains user IDs and the distance they have travelled. We must sum the distances for each user, even if a user hasn't travelled at all (in which case, their distance should be 0). The result should be ordered by the total travelled distance in descending order, and if multiple users have the same travelled distance, they should be ordered by their name in ascending order.

**Example:**

**Users table:**
```
+----+-------+
| id | name  |
+----+-------+
| 1  | Alice |
| 2  | Bob   |
| 3  | Alex  |
| 4  | Donald|
+----+-------+
```

**Rides table:**
```
+----+---------+----------+
| id | user_id | distance |
+----+---------+----------+
| 1  | 1       | 120      |
| 2  | 2       | 317      |
| 3  | 3       | 222      |
| 4  | 1       | 230      |
| 5  | 4       | 5        |
+----+---------+----------+
```

**Expected Output:**
```
+-------+--------------------+
| name  | travelled_distance |
+-------+--------------------+
| Alice | 350                |
| Bob   | 317                |
| Alex  | 222                |
| Donald| 5                  |
+-------+--------------------+
```

## 📊 **Algorithm**

*   Join the `Users` and `Rides` tables using a `LEFT JOIN` to include all users, even if they have no rides.
*   Use `IFNULL` to handle cases where a user has no rides, setting their distance to 0.
*   Sum the distances for each user using `SUM` and `GROUP BY`.
*   Order the results by `travelled_distance` in descending order and then by `name` in ascending order.

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

Since this problem doesn't involve grids, trees, or movements, an ASCII representation is not applicable. However, we can visualize the table structure using ASCII.

**Users Table:**

```
+--------+--------+
|  id    |  name  |
+--------+--------+
|        |        |
+--------+--------+
```

**Rides Table:**

```
+--------+---------+----------+
|  id    | user_id | distance |
+--------+---------+----------+
|        |         |          |
+--------+---------+----------+
```

## 📊 **WORKING**

Let's walk through the provided example.

**Users table:**

```
+----+-------+
| id | name  |
+----+-------+
| 1  | Alice |
| 2  | Bob   |
| 3  | Alex  |
| 4  | Donald|
+----+-------+
```

**Rides table:**

```
+----+---------+----------+
| id | user_id | distance |
+----+---------+----------+
| 1  | 1       | 120      |
| 2  | 2       | 317      |
| 3  | 3       | 222      |
| 4  | 1       | 230      |
| 5  | 4       | 5        |
+----+---------+----------+
```

1.  **Join and Sum:**

    *   Alice (ID 1): 120 + 230 = 350
    *   Bob (ID 2): 317
    *   Alex (ID 3): 222
    *   Donald (ID 4): 5

2.  **Ordering:**

    *   First by `travelled_distance` DESC: Alice (350), Bob (317), Alex (222), Donald (5)
    *   Since no distances are equal, no further ordering by `name` is needed.

3.  **Final Result:**

```
+-------+--------------------+
| name  | travelled_distance |
+-------+--------------------+
| Alice | 350                |
| Bob   | 317                |
| Alex  | 222                |
| Donald| 5                  |
+-------+--------------------+
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is mainly determined by the `LEFT JOIN`, `GROUP BY`, and `ORDER BY` operations. In the worst case, the time complexity is **O(N log N)** due to the sorting operation, where N is the total number of rows after the join. However, MySQL's query optimizer often makes this operation faster.
*   **Space Complexity:** The space complexity depends on the size of the intermediate table created during the `JOIN` operation and the size of the data being sorted. In the worst case, the space complexity is **O(N)**, where N is the total number of rows after the join, as we need to store the intermediate table and the sorted results.
    