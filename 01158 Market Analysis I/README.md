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

The task is to analyze user and order data to determine the number of orders placed by each user in the year 2019. We need to output a table containing each user's ID, their join date, and the number of orders they placed in 2019.  If a user didn't place any orders in 2019, the number of orders should be 0.

**Sample Input:**

**Users Table:**

| user_id | join_date  |
|---------|------------|
| 1       | 2018-01-01 |
| 2       | 2019-01-05 |
| 3       | 2019-12-01 |
| 4       | 2018-07-22 |

**Orders Table:**

| order_id | order_date | buyer_id | seller_id |
|----------|------------|----------|-----------|
| 1        | 2019-08-01 | 1        | 2          |
| 2        | 2018-08-02 | 1        | 3          |
| 3        | 2019-08-03 | 2        | 3          |
| 4        | 2019-08-04 | 3        | 2          |
| 5        | 2019-08-05 | 1        | 4          |

**Expected Output:**

| buyer_id | join_date  | orders_in_2019 |
|----------|------------|----------------|
| 1        | 2018-01-01 | 3              |
| 2        | 2019-01-05 | 1              |
| 3        | 2019-12-01 | 1              |
| 4        | 2018-07-22 | 0              |

---

## 📊 **Algorithm**

*   Start with the `Users` table as the base for our result.
*   Left join `Orders` table with `Users` table on `user_id = buyer_id` to get all users and their corresponding orders.
*   Filter the orders to only include those placed in 2019 using the `ORDER_DATE` column.
*   Group the results by `user_id` to count the number of orders for each user.
*   Use `COUNT(O.ORDER_ID)` to count the number of orders for each user (this will handle cases where users have no orders in 2019 by returning 0 due to the left join).
*   Select `U.USER_ID` as `BUYER_ID`, `U.JOIN_DATE`, and the count of orders as `ORDERS_IN_2019`.

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
| 4       | 2018-07-22 |
+---------+------------+

Orders Table:

+----------+------------+----------+-----------+
| order_id | order_date | buyer_id | seller_id |
+----------+------------+----------+-----------+
| 1        | 2019-08-01 | 1        | 2         |
| 2        | 2018-08-02 | 1        | 3         |
| 3        | 2019-08-03 | 2        | 3         |
| 4        | 2019-08-04 | 3        | 2         |
| 5        | 2019-08-05 | 1        | 4         |
+----------+------------+----------+-----------+
```

## 📊 **WORKING**

Let's walk through the execution of the SQL query using the sample input:

1.  **JOIN Operation:**

    We perform a `LEFT JOIN` between the `Users` and `Orders` tables on `U.USER_ID = O.BUYER_ID`. Also, filter `Orders` table with the condition `O.ORDER_DATE BETWEEN '2019-01-01' AND '2019-12-31'`.

    | user\_id | join\_date  | order\_id | order\_date | buyer\_id | seller\_id |
    | :-------- | :----------- | :--------- | :----------- | :--------- | :---------- |
    | 1        | 2018-01-01 | 1         | 2019-08-01  | 1         | 2          |
    | 1        | 2018-01-01 | 5         | 2019-08-05  | 1         | 4          |
    | 2        | 2019-01-05 | 3         | 2019-08-03  | 2         | 3          |
    | 3        | 2019-12-01 | 4         | 2019-08-04  | 3         | 2          |
    | 4        | 2018-07-22 | NULL       | NULL        | NULL       | NULL        |

2.  **GROUP BY and COUNT:**

    We group the joined table by `U.USER_ID` and count the number of orders for each user within the specified date range:

    | user\_id | join\_date  | COUNT(O.ORDER\_ID) |
    | :-------- | :----------- | :----------------- |
    | 1        | 2018-01-01 | 2                  |
    | 2        | 2019-01-05 | 1                  |
    | 3        | 2019-12-01 | 1                  |
    | 4        | 2018-07-22 | 0                  |

3.  **Final Result:**

    The final output includes `BUYER_ID`, `JOIN_DATE`, and `ORDERS_IN_2019`:

    | BUYER\_ID | JOIN\_DATE  | ORDERS\_IN\_2019 |
    | :-------- | :----------- | :----------------- |
    | 1        | 2018-01-01 | 2                  |
    | 2        | 2019-01-05 | 1                  |
    | 3        | 2019-12-01 | 1                  |
    | 4        | 2018-07-22 | 0                  |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The time complexity is primarily determined by the `JOIN` operation. In the worst case, if every user has a large number of orders, the join could take **O(U \* O)** time, where U is the number of users and O is the number of orders.  However, with proper indexing on `USER_ID` and `BUYER_ID`, the join can be significantly faster. The `GROUP BY` operation adds an additional **O(U)** complexity.

*   **Space Complexity:** The space complexity is affected by the size of the joined table. In the worst case, the joined table could require **O(U \* O)** space. However, since we are grouping the data, the final space complexity is more likely to be **O(U)**, where U is the number of users, as we store the count of orders for each user.
    