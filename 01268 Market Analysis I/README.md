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

The problem requires us to analyze user behavior in an e-commerce platform. Specifically, for each user, we need to determine the number of orders they placed in the year 2019.  The desired output should include the user's ID, their join date, and the count of their orders in 2019.

**Example:**

**Users Table:**

| user_id | join_date  |
|---------|------------|
| 1       | 2018-01-01 |
| 2       | 2019-01-05 |
| 3       | 2019-02-01 |

**Orders Table:**

| order_id | order_date | buyer_id | item_id |
|----------|------------|----------|---------|
| 1        | 2019-01-01 | 1        | 1       |
| 2        | 2019-01-02 | 2        | 2       |
| 3        | 2019-01-03 | 1        | 3       |
| 4        | 2019-01-04 | 3        | 4       |
| 5        | 2019-01-05 | 1        | 5       |
| 6        | 2019-01-06 | 2        | 6       |

**Expected Output:**

| buyer_id | join_date  | orders_in_2019 |
|----------|------------|----------------|
| 1        | 2018-01-01 | 3              |
| 2        | 2019-01-05 | 2              |
| 3        | 2019-02-01 | 1              |

---

## 📊 **Algorithm**

*   **Join Tables:** Perform a left join between the `Users` and `Orders` tables on `Users.user_id = Orders.buyer_id`. This ensures that all users are included in the output, even those who haven't placed any orders.
*   **Filter Orders:** Filter the orders to include only those placed in the year 2019. This is achieved by checking if `Orders.order_date` falls within the range '2019-01-01' and '2019-12-31'.
*   **Group by User:** Group the results by `Users.user_id` to count the number of orders for each user.
*   **Count Orders:** Use the `COUNT()` aggregate function to count the number of orders for each user within the specified year.
*   **Select Columns:** Select the `Users.user_id` as `buyer_id`, `Users.join_date`, and the count of orders as `orders_in_2019`.

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

```
Users Table:

+---------+------------+
| user_id | join_date  |
+---------+------------+
| 1       | 2018-01-01 |
| 2       | 2019-01-05 |
| 3       | 2019-02-01 |
+---------+------------+

Orders Table:

+----------+------------+----------+---------+
| order_id | order_date | buyer_id | item_id |
+----------+------------+----------+---------+
| 1        | 2019-01-01 | 1        | 1       |
| 2        | 2019-01-02 | 2        | 2       |
| 3        | 2019-01-03 | 1        | 3       |
| 4        | 2019-01-04 | 3        | 4       |
| 5        | 2019-01-05 | 1        | 5       |
| 6        | 2019-01-06 | 2        | 6       |
+----------+------------+----------+---------+
```

---

## 📊 **Working**

Let's trace the query execution with the provided sample input.

1.  **Join and Filter:**

    The `LEFT JOIN` combines `Users` and `Orders` based on `user_id` and `buyer_id`.  The `WHERE` clause filters the orders to include only those in 2019.

2.  **Group By:**

    The results are grouped by `user_id`.

3.  **Count:**

    The `COUNT(O.ORDER_ID)` function counts the number of orders for each user in 2019.

4.  **Final Result:**

    | buyer_id | join_date  | orders_in_2019 |
    |----------|------------|----------------|
    | 1        | 2018-01-01 | 3              |
    | 2        | 2019-01-05 | 2              |
    | 3        | 2019-02-01 | 1              |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the join operation and the group by operation. In the worst case, if all orders are from 2019 and all users have placed orders, the complexity is **O(U + O)**, where U is the number of users and O is the number of orders. However, with proper indexing, the complexity can be optimized.

*   **Space Complexity:** The space complexity depends on the size of the intermediate result set created during the join and grouping operations.  In the worst case, if all orders are from 2019, the space complexity could be **O(U + O)** in the worst case, where U is number of users and O is the number of orders. This includes the space to store the joined table and the grouped results.
    