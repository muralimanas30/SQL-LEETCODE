# 01158 - Market Analysis I
    
**Language:** Mysql  
**Runtime:** 1003 ms (Beats 100.00% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1158 | Market Analysis I | [LeetCode Problem](https://leetcode.com/problems/market-analysis-i/) |

---

## 💡 **Problem Explanation**

The "Market Analysis I" problem requires us to analyze user purchasing behavior in the year 2019. Given two tables, `Users` and `Orders`, our task is to determine the number of orders each user placed in 2019.  For each user, we need to output their user ID (as `buyer_id`), their join date, and the total number of orders they made in 2019. If a user didn't place any orders in 2019, the corresponding order count should be 0.

**Example:**

**Users Table:**

| user_id | join_date  |
|---------|------------|
| 1       | 2018-01-01 |
| 2       | 2019-01-05 |
| 3       | 2019-02-01 |

**Orders Table:**

| order_id | buyer_id | order_date |
|----------|----------|------------|
| 1        | 1        | 2019-01-01 |
| 2        | 2        | 2019-01-05 |
| 3        | 3        | 2019-02-01 |
| 4        | 1        | 2019-03-01 |
| 5        | 2        | 2018-01-01 |
| 6        | 3        | 2020-01-01 |

**Expected Output:**

| buyer_id | join_date  | orders_in_2019 |
|----------|------------|----------------|
| 1        | 2018-01-01 | 2              |
| 2        | 2019-01-05 | 1              |
| 3        | 2019-02-01 | 1              |

---

## 📊 **Algorithm**

*   Start with the `Users` table, aliased as `U`.
*   Perform a left join with the `Orders` table, aliased as `O`, on the condition `U.USER_ID = O.BUYER_ID`. This ensures that all users are included in the result, even if they have no orders.
*   Filter the orders to include only those placed in 2019 by adding the condition `O.ORDER_DATE BETWEEN '2019-01-01' AND '2019-12-31'`.
*   Group the results by `U.USER_ID` to count the number of orders for each user.
*   Select the user's `USER_ID` as `BUYER_ID`, `JOIN_DATE`, and count the number of orders as `ORDERS_IN_2019`.

---

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

---

## 📊 **ASCII Representation**

Here's a simple ASCII representation of the database schema:

```
Users Table
+---------+-----------+
| user_id | join_date |
+---------+-----------+
| INT     | DATE      |
+---------+-----------+

Orders Table
+----------+----------+------------+
| order_id | buyer_id | order_date |
+----------+----------+------------+
| INT      | INT      | DATE       |
+----------+----------+------------+

Relationship:
Users.user_id  <-----> Orders.buyer_id
```

---

## 📊 **WORKING**

Let's walk through the query with the provided sample data:

1.  **Initial Tables:**

    **Users Table (U):**

    ```
    +---------+------------+
    | user_id | join_date  |
    +---------+------------+
    | 1       | 2018-01-01 |
    | 2       | 2019-01-05 |
    | 3       | 2019-02-01 |
    +---------+------------+
    ```

    **Orders Table (O):**

    ```
    +----------+----------+------------+
    | order_id | buyer_id | order_date |
    +----------+----------+------------+
    | 1        | 1        | 2019-01-01 |
    | 2        | 2        | 2019-01-05 |
    | 3        | 3        | 2019-02-01 |
    | 4        | 1        | 2019-03-01 |
    | 5        | 2        | 2018-01-01 |
    | 6        | 3        | 2020-01-01 |
    +----------+----------+------------+
    ```

2.  **LEFT JOIN and Filtering:**

    The `LEFT JOIN` combines `Users` and `Orders` where `U.USER_ID = O.BUYER_ID`, and the `WHERE` clause filters for orders in 2019.  The combined data looks conceptually like this before the `GROUP BY`:

    ```
    +---------+------------+----------+----------+------------+
    | user_id | join_date  | order_id | buyer_id | order_date |
    +---------+------------+----------+----------+------------+
    | 1       | 2018-01-01 | 1        | 1        | 2019-01-01 |
    | 1       | 2018-01-01 | 4        | 1        | 2019-03-01 |
    | 2       | 2019-01-05 | 2        | 2        | 2019-01-05 |
    | 3       | 2019-02-01 | 3        | 3        | 2019-02-01 |
    +---------+------------+----------+----------+------------+
    ```

    Note:  Orders 5 and 6 are filtered out because their `order_date` is not in 2019.

3.  **GROUP BY and COUNT:**

    The `GROUP BY U.USER_ID` groups the results by user ID.  The `COUNT(O.ORDER_ID)` counts the number of orders for each user in 2019.

4.  **Final Result:**

    ```
    +----------+------------+----------------+
    | BUYER_ID | JOIN_DATE  | ORDERS_IN_2019 |
    +----------+------------+----------------+
    | 1        | 2018-01-01 | 2              |
    | 2        | 2019-01-05 | 1              |
    | 3        | 2019-02-01 | 1              |
    +----------+------------+----------------+
    ```

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the `LEFT JOIN` and the `GROUP BY` operations.  In the worst case, the `LEFT JOIN` could take **O(m*n)** time, where 'm' is the number of rows in the `Users` table and 'n' is the number of rows in the `Orders` table.  The `GROUP BY` operation then takes **O(k log k)** time, where 'k' is the number of distinct user IDs.  Thus, the overall time complexity is approximately **O(m\*n + k log k)**, where **m and n** are the sizes of the `Users` and `Orders` tables, respectively.

*   **Space Complexity:** The space complexity depends on the size of the intermediate table created during the `LEFT JOIN` and the space required to store the grouped results. In the worst case, the intermediate table could be as large as **O(m\*n)**. The space required for the grouped results is **O(k)**, where 'k' is the number of distinct user IDs. Thus, the overall space complexity is **O(m\*n + k)**.
    