# 01045 - Customers Who Bought All Products
    
**Language:** Mysql  
**Runtime:** 625 ms (Beats 28.78% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                         | 🔗 Link                                                                  |
|------------------|-----------------------------------|-------------------------------------------------------------------------|
| 1045             | Customers Who Bought All Products | [LeetCode Problem](https://leetcode.com/problems/customers-who-bought-all-products/) |

---

## 💡 **Problem Explanation**

The problem asks us to identify the `customer_id` of customers who bought *all* the products listed in the `Product` table.  We need to find customers who have purchased a number of *distinct* products equal to the total number of distinct products available.

**Example:**

**Products Table:**

| product_key |
|-------------|
| 1           |
| 2           |

**Customers Table:**

| customer_id | product_key |
|-------------|-------------|
| 1           | 1           |
| 1           | 2           |
| 2           | 1           |

**Expected Output:**

| customer_id |
|-------------|
| 1           |

Customer 1 bought both products (1 and 2), which is all the products in the `Product` table. Customer 2 only bought product 1, so they are not included.

## 📊 **Algorithm**

Here's the algorithm we'll use in the SQL query:

*   **Count Distinct Products:** Determine the total number of distinct `product_key` values in the `Product` table.  This will be used as the benchmark to compare against.
*   **Group by Customer:** Group the rows in the `Customer` table by `customer_id`.
*   **Count Distinct Products per Customer:**  For each `customer_id`, count the number of distinct `product_key` values they have purchased.
*   **Filter with HAVING:**  Select only the `customer_id` values where the count of distinct products purchased equals the total count of distinct products from the `Product` table.

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

Here's an ASCII representation of the table relationships:

```
Product Table        Customer Table
+-------------+      +-------------+-------------+
| product_key |      | customer_id | product_key |
+-------------+      +-------------+-------------+
|     1       |----->|      1      |      1      |
|     2       |----->|      1      |      2      |
+-------------+      |      2      |      1      |
                     +-------------+-------------+
```

## 📊 **WORKING**

Let's trace the query with the example data provided earlier:

**Products Table:**

| product_key |
|-------------|
| 1           |
| 2           |

**Customers Table:**

| customer_id | product_key |
|-------------|-------------|
| 1           | 1           |
| 1           | 2           |
| 2           | 1           |

1.  **`SELECT count(distinct(product_key)) from product`**: This subquery returns `2` because there are two distinct product keys in the `Product` table.

2.  **`SELECT customer_id from customer GROUP BY customer_id`**:  This groups the `Customer` table by `customer_id`.

3.  **`HAVING count(distinct(product_key)) = (subquery)`**: This `HAVING` clause filters the grouped results:

    *   **Customer 1:**  The `count(distinct(product_key))` is 2 (bought products 1 and 2). Since 2 = 2 (from the subquery), Customer 1 is selected.
    *   **Customer 2:** The `count(distinct(product_key))` is 1 (bought product 1). Since 1 != 2, Customer 2 is not selected.

Therefore, the query returns only `customer_id = 1`.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the `GROUP BY` operation and the subquery.  The subquery `(select count(distinct(product_key)) from product)` takes O(N) time, where N is the number of rows in the Product table. The `GROUP BY` operation on the customer table takes O(M log M) time where M is the number of rows in Customer table. Thus, the overall time complexity is **O(N + M log M)**.  Since in SQL it's hard to get exact complexities for specific operations, this is a good general estimate.

*   **Space Complexity:** The space complexity is determined by the space needed to store the intermediate grouped results and the result of the subquery.  Grouping generally takes O(M) space in the worst case for storing each customer_id, where M is the number of rows in the Customer table. The subquery requires only constant space. Hence, the overall space complexity is **O(M)**.
    