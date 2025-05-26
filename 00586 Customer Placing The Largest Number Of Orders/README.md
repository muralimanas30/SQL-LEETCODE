# 00586 - Customer Placing The Largest Number Of Orders
    
**Language:** Mysql  
**Runtime:** 489 ms (Beats 59.67% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 586 | Customer Placing the Largest Number of Orders | [LeetCode Problem](https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/) |

---

## 💡 **Problem Explanation**

The problem requires you to find the `customer_number` who placed the largest number of orders. If multiple customers have the same maximum number of orders, the query should return only one of them.

**Example:**

Suppose we have an `Orders` table like this:

| order_number | customer_number |
|--------------|-----------------|
| 1            | 1               |
| 2            | 2               |
| 3            | 1               |
| 4            | 3               |

The customer with `customer_number = 1` placed two orders, which is the largest number of orders placed by any customer.  Therefore, the output should be `1`.

## 📊 **Algorithm**
*   Group the orders by `customer_number`.
*   Count the number of orders for each customer.
*   Order the results in descending order based on the order count.
*   Limit the result to the first customer, which represents the customer with the most orders.

## 🔥 **Code Implementation**

```mysql
SELECT customer_number
FROM ORDERS
GROUP BY CUSTOMER_NUMBER
ORDER BY COUNT(CUSTOMER_NUMBER) DESC LIMIT 1;
```

## 📊 **ASCII Representation**

This problem doesn't involve grids or trees, so an ASCII representation isn't directly applicable. However, we can visualize the database table structure as follows:

```
Orders Table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
|      1       |        1        |
|      2       |        2        |
|      3       |        1        |
|      4       |        3        |
+--------------+-----------------+
```

## 📊 **WORKING**

Let's trace the execution with the example data provided in the problem explanation.

1.  **`FROM ORDERS`**: Select from the `ORDERS` table.

2.  **`GROUP BY CUSTOMER_NUMBER`**: Group the orders by customer number.  This results in the following logical groups:

    *   Customer 1: Orders 1, 3
    *   Customer 2: Order 2
    *   Customer 3: Order 4

3.  **`ORDER BY COUNT(CUSTOMER_NUMBER) DESC`**:  Count the orders in each group and sort in descending order.

    *   Customer 1: 2 orders
    *   Customer 3: 1 order
    *   Customer 2: 1 order

    The order becomes: Customer 1, Customer 3, Customer 2

4.  **`LIMIT 1`**: Take only the top row, which is Customer 1.

Therefore, the query returns `1`.

## 🚀 **Time & Space Complexity**

*   **Time Complexity**: The time complexity is dominated by the `GROUP BY` and `ORDER BY` operations.  In general, the time complexity is **O(N log N)**, where N is the number of rows in the `ORDERS` table, due to the sorting.
*   **Space Complexity**: The space complexity is **O(N)**, where N is the number of unique customer numbers, as it depends on the space required to store the groups during the `GROUP BY` operation.
    