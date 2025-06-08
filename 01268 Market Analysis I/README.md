# 01268 - Market Analysis I
    
**Language:** Mysql  
**Runtime:** 1003 ms (Beats 100.00% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1158 | Market Analysis I | [LeetCode Problem](https://leetcode.com/problems/market-analysis-i/) |

---

## 💡 **Problem Explanation**

The problem requires us to analyze user purchasing behavior within the year 2019.  Specifically, we need to determine the number of orders each user placed during 2019. The output should consist of the user ID (as `buyer_id`), their join date, and the total orders made in 2019.  Users who joined but did not place any orders in 2019 should have a count of 0.

**Sample Input:**

**Users Table:**

| user_id | join_date  |
|---------|------------|
| 1       | 2018-01-01 |
| 2       | 2019-01-05 |
| 3       | 2019-12-01 |
| 4       | 2020-01-01 |

**Orders Table:**

| order_id | order_date | buyer_id | seller_id | item_id |
|----------|------------|----------|-----------|---------|
| 1        | 2019-01-01 | 1        | 2         | 1       |
| 2        | 2019-01-02 | 2        | 3         | 2       |
| 3        | 2019-01-03 | 1        | 4         | 3       |
| 4        | 2019-01-04 | 3        | 1         | 4       |
| 5        | 2019-02-01 | 2        | 4         | 5       |
| 6        | 2020-03-01 | 1        | 2         | 6       |
| 7        | 2020-03-02 | 2        | 3         | 7       |
| 8        | 2020-03-03 | 3        | 4         | 8       |

**Expected Output:**

| buyer_id | join_date  | orders_in_2019 |
|----------|------------|----------------|
| 1        | 2018-01-01 | 2              |
| 2        | 2019-01-05 | 2              |
| 3        | 2019-12-01 | 1              |
| 4        | 2020-01-01 | 0              |

---

## 📊 **Algorithm**

*   Select the `user_id` as `buyer_id` and `join_date` from the `Users` table.
*   Perform a `LEFT JOIN` between the `Users` and `Orders` tables on the `user_id` and `buyer_id` respectively.  This ensures all users are included, regardless of whether they placed orders.
*   Filter the orders in the `Orders` table to only include those placed in 2019 using a `WHERE` clause in the `JOIN` condition.
*   Count the number of orders for each user using `COUNT(O.ORDER_ID)`.
*   Group the results by `U.USER_ID` to count orders per user.

---

## 🔥 **Code Implementation**

```mysql
SELECT 
  U.user_id AS buyer_id,
  U.join_date,
  COUNT(O.order_id) AS orders_in_2019
FROM Users U
LEFT JOIN Orders O
  ON U.user_id = O.buyer_id 
  AND O.order_date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY U.user_id
```

---

## 📊 **ASCII Representation**

**Users Table:**

```
+---------+------------+
| user_id | join_date  |
+---------+------------+
| 1       | 2018-01-01 |
| 2       | 2019-01-05 |
| 3       | 2019-12-01 |
| 4       | 2020-01-01 |
+---------+------------+
```

**Orders Table:**

```
+----------+------------+----------+-----------+---------+
| order_id | order_date | buyer_id | seller_id | item_id |
+----------+------------+----------+-----------+---------+
| 1        | 2019-01-01 | 1        | 2         | 1       |
| 2        | 2019-01-02 | 2        | 3         | 2       |
| 3        | 2019-01-03 | 1        | 4         | 3       |
| 4        | 2019-01-04 | 3        | 1         | 4       |
| 5        | 2019-02-01 | 2        | 4         | 5       |
| 6        | 2020-03-01 | 1        | 2         | 6       |
| 7        | 2020-03-02 | 2        | 3         | 7       |
| 8        | 2020-03-03 | 3        | 4         | 8       |
+----------+------------+----------+-----------+---------+
```

---

## 📊 **WORKING**

Let's trace the query with the sample input:

1.  **JOIN Operation:** The `LEFT JOIN` combines `Users` and `Orders` tables. The `ON` condition includes a date filter, so only orders from 2019 are considered during the join.

    | user_id | join_date  | order_id | order_date | buyer_id |
    |---------|------------|----------|------------|----------|
    | 1       | 2018-01-01 | 1        | 2019-01-01 | 1        |
    | 1       | 2018-01-01 | 3        | 2019-01-03 | 1        |
    | 2       | 2019-01-05 | 2        | 2019-01-02 | 2        |
    | 2       | 2019-01-05 | 5        | 2019-02-01 | 2        |
    | 3       | 2019-12-01 | 4        | 2019-01-04 | 3        |
    | 4       | 2020-01-01 | NULL     | NULL       | NULL     |

2.  **COUNT(O.order\_id):**  Counts the number of orders for each user within the joined table, considering only orders from 2019.

    | user_id | join_date  | COUNT(O.order_id) |
    |---------|------------|-------------------|
    | 1       | 2018-01-01 | 2                 |
    | 2       | 2019-01-05 | 2                 |
    | 3       | 2019-12-01 | 1                 |
    | 4       | 2020-01-01 | 0                 |

3.  **GROUP BY U.user\_id:** Groups the results by user ID, enabling the `COUNT` function to operate correctly and provide the order count for each user.

4.  **Final Result:** The query returns the `user_id` as `buyer_id`, `join_date`, and the count of orders made in 2019 for each user.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N + M)**, where N is the number of rows in the `Users` table and M is the number of rows in the `Orders` table.  This is because the `LEFT JOIN` operation generally takes O(N + M) time. The `GROUP BY` operation depends on the database implementation but is usually efficient.

*   **Space Complexity:** The space complexity is **O(N + M)** in the worst-case scenario, where N is the size of the `Users` table and M is the size of the `Orders` table.  This accounts for the space required to store the joined table during the `LEFT JOIN` operation.  In practice, the actual space used might be less, depending on database optimizations and indexing.
    