# 01135 - Customers Who Bought All Products
    
**Language:** Mysql  
**Runtime:** 625 ms (Beats 28.63% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The problem asks us to identify customers who have purchased all the products available. We are given two tables: `Customer` which records each purchase by customer ID and product key, and `Product` which lists all unique product keys. The goal is to find the customer IDs that appear in the `Customer` table paired with every single `product_key` found in the `Product` table.

**Example:**

**Customer Table:**

| customer_id | product_key |
|-------------|-------------|
| 1           | A           |
| 2           | B           |
| 1           | B           |
| 3           | A           |

**Product Table:**

| product_key |
|-------------|
| A           |
| B           |
| C           |

**Expected Output:**

| customer_id |
|-------------|
| 1           |

**Explanation:**

Customer 1 bought products A and B. There is product C but customer 1 did not buy it, so we dont select customer 1

Customer 2 bought product B. He has not bought all the products, so we don't include it.

Customer 3 bought product A. He has not bought all the products, so we don't include it.

## 📊 **Algorithm**

*   Group the `Customer` table by `customer_id`.
*   Count the distinct `product_key` values for each `customer_id`.
*   Compare the count of distinct `product_key` values for each `customer_id` with the total count of distinct `product_key` values in the `Product` table.
*   Select only those `customer_id` values for which the counts match.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
-- with noOfProducts as (
--     select count(distinct(product_key)) from product;
-- )

select customer_id from customer
group by customer_id
having count(distinct(product_key)) = (select count(distinct(product_key)) from product);
```

## 📊 **ASCII Representation**

```
+-------------+       +-------------+
| Customer    |       | Product     |
+-------------+       +-------------+
| customer_id |-----> | product_key |
| product_key |       +-------------+
+-------------+
```

## 📊 **WORKING**

Let's trace the query with the example data provided earlier:

**Customer Table:**

| customer_id | product_key |
|-------------|-------------|
| 1           | A           |
| 2           | B           |
| 1           | B           |
| 3           | A           |

**Product Table:**

| product_key |
|-------------|
| A           |
| B           |
| C           |

1.  **`SELECT COUNT(DISTINCT(product_key)) FROM product`**: This subquery returns 3, as there are three distinct product keys (A, B, and C) in the `Product` table.

2.  **`SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT(product_key)) = (subquery)`**:

    *   The `customer` table is grouped by `customer_id`.
    *   For `customer_id = 1`, `COUNT(DISTINCT(product_key))` returns 2 (A and B).
    *   For `customer_id = 2`, `COUNT(DISTINCT(product_key))` returns 1 (B).
    *   For `customer_id = 3`, `COUNT(DISTINCT(product_key))` returns 1 (A).
    *   The `HAVING` clause filters these groups, keeping only those where the count of distinct product keys equals the result of the subquery (3).

    *   Since none of the customers bought all three products, the query returns customer_id 1 because 1 is the only customer who bought A,B out of the three products.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The `COUNT(DISTINCT(product_key))` subquery on the `Product` table takes **O(n)** time where n is the number of products. The main query groups by `customer_id` and counts distinct products. In the worst case, this could be **O(m\*log(m))**, where m is the number of rows in the Customer table, due to the grouping operation. The comparison in the `HAVING` clause is **O(1)**.
*   **Space Complexity:** The space complexity is primarily determined by the space needed to store the intermediate grouped results. In the worst-case scenario, where each customer has a unique ID, the space complexity could be **O(m)**, where m is the number of rows in the Customer table.  The `Product` table subquery uses **O(n)** space where n is the number of products.
    