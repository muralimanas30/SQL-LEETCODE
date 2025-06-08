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

The problem requires us to analyze user and order data to determine the number of orders placed by each user in the year 2019. We need to output a table containing the user's ID, join date, and the count of orders they placed in 2019.  If a user didn't place any orders in 2019, the order count should be 0.

**Sample Input:**

**Users Table:**

| user_id | join_date  |
|---------|------------|
| 1       | 2018-01-01 |
| 2       | 2019-01-05 |
| 3       | 2019-12-01 |
| 4       | 2020-01-01 |

**Orders Table:**

| order_id | order_date | buyer_id | item_id |
|----------|------------|----------|---------|
| 1        | 2019-01-01 | 1        | 1       |
| 2        | 2019-01-02 | 2        | 2       |
| 3        | 2019-01-03 | 1        | 3       |
| 4        | 2019-01-04 | 3        | 4       |
| 5        | 2019-02-01 | 4        | 5       |
| 6        | 2020-01-01 | 1        | 6       |

**Expected Output:**

| buyer_id | join_date  | orders_in_2019 |
|----------|------------|----------------|
| 1        | 2018-01-01 | 2              |
| 2        | 2019-01-05 | 1              |
| 3        | 2019-12-01 | 1              |
| 4        | 2020-01-01 | 0              |

## 📊 **Algorithm**

*   Select the user ID and join date from the `Users` table.
*   Perform a left join with the `Orders` table using the `user_id` and `buyer_id` columns.
*   Filter the orders to include only those placed in 2019 using the `order_date` column.
*   Group the results by `user_id` to count the number of orders for each user.
*   Count the number of orders in 2019 for each user using `COUNT(O.ORDER_ID)`.
*   Rename the `user_id` column to `buyer_id` and the count of orders to `orders_in_2019`.

## 🔥 **Code Implementation**

```mysql
SELECT
  U.USER_ID AS BUYER_ID,
  U.JOIN_DATE,
  COUNT(O.ORDER_ID) AS ORDERS_IN_2019
FROM USERS U
LEFT JOIN ORDERS O
  ON U.USER_ID = O.BUYER_ID
  AND O.ORDER_DATE BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY U.USER_ID

```

## 📊 **ASCII Representation**

```
Users Table:
+---------+------------+
| user_id | join_date  |
+---------+------------+
| 1       | 2018-01-01 |
| 2       | 2019-01-05 |
| 3       | 2019-12-01 |
| 4       | 2020-01-01 |
+---------+------------+

Orders Table:
+----------+------------+----------+---------+
| order_id | order_date | buyer_id | item_id |
+----------+------------+----------+---------+
| 1        | 2019-01-01 | 1        | 1       |
| 2        | 2019-01-02 | 2        | 2       |
| 3        | 2019-01-03 | 1        | 3       |
| 4        | 2019-01-04 | 3        | 4       |
| 5        | 2019-02-01 | 4        | 5       |
| 6        | 2020-01-01 | 1        | 6       |
+----------+------------+----------+---------+
```

## 📊 **Working**

Let's trace the execution with the provided sample input.

1.  **Join and Filter:** The `LEFT JOIN` combines `Users` and `Orders` tables on `U.USER_ID = O.BUYER_ID`. The `WHERE` clause filters orders within 2019.

    *   User 1 (2018-01-01) joins with orders 1 & 3.
    *   User 2 (2019-01-05) joins with order 2.
    *   User 3 (2019-12-01) joins with order 4.
    *   User 4 (2020-01-01) has no orders in 2019, so it joins with NULL.

2.  **Group and Count:** The `GROUP BY U.USER_ID` groups the results by user. `COUNT(O.ORDER_ID)` counts orders for each user.

    *   User 1: COUNT = 2
    *   User 2: COUNT = 1
    *   User 3: COUNT = 1
    *   User 4: COUNT = 0 (because of the `LEFT JOIN`, User 4 is present even with no matching orders and COUNT aggregate function handles the null values correctly)

3.  **Final Result:** The query returns `buyer_id`, `join_date`, and `orders_in_2019`.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the join operation. In the worst case (if every user has many orders), the time complexity could be **O(U\*O)**, where U is the number of users and O is the number of orders.  However, with appropriate indexing on `USER_ID` and `BUYER_ID`, and assuming the database query optimizer makes efficient choices, it can be closer to **O(U + O)**.
*   **Space Complexity:** The space complexity depends on the size of the intermediate joined table and the final result set. In the worst case, if all users have many orders in 2019, the intermediate table could be large. The space complexity is roughly proportional to the size of the output, which is **O(U)**, where U is the number of users, as we need to store data for each user.
    