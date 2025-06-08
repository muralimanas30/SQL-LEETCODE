# 01084 - Sales Analysis Iii
    
**Language:** Mysql  
**Runtime:** 1005 ms (Beats 99.67% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The problem asks us to find the products that were only sold in the first quarter of 2019. This means we need to identify products that had sales within the date range '2019-01-01' to '2019-03-31' and *no sales* outside this range.

**Example:**

**Input:**

`Product` table:

| product_id | product_name |
|---|---|
| 1 | S8 |
| 2 | G4 |
| 3 | H8 |

`Sales` table:

| sale_id | product_id | sale_date  | quantity | price |
|---|---|---|---|---|
| 1 | 1 | 2019-01-21 | 2 | 2000 |
| 2 | 2 | 2019-02-17 | 1 | 800 |
| 3 | 2 | 2019-06-02 | 2 | 700 |
| 4 | 3 | 2019-05-13 | 2 | 900 |
| 5 | 3 | 2019-06-25 | 3 | 800 |

**Output:**

| product_id | product_name |
|---|---|
| 1 | S8 |

**Explanation:**

*   Product 1 (S8) was only sold in January 2019 (within the first quarter).
*   Product 2 (G4) was sold in February 2019 (first quarter) and June 2019 (outside the first quarter).
*   Product 3 (H8) was sold in May and June 2019 (outside the first quarter).

Therefore, only product 1 (S8) satisfies the condition.

## 📊 **Algorithm**

*   Select the `product_id` and `product_name` from the `Product` table.
*   Join `Product` and `Sales` tables on `product_id`.
*   Filter the sales within the date range '2019-01-01' to '2019-03-31'.
*   Exclude products that have sales outside the date range '2019-01-01' to '2019-03-31'.
*   Use `DISTINCT` to avoid duplicate entries.

## 🔥 **Code Implementation**

```mysql
SELECT DISTINCT P.product_id, P.product_name
FROM Product P
JOIN Sales S
  ON P.product_id = S.product_id
WHERE S.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
  AND P.product_id NOT IN (
    SELECT product_id
    FROM Sales
    WHERE sale_date < '2019-01-01' OR sale_date > '2019-03-31'
  );
```

## 📊 **ASCII Representation**

```
Product Table:

+-------------+---------------+
| product_id  | product_name  |
+-------------+---------------+
|      1      |     S8        |
|      2      |     G4        |
|      3      |     H8        |
+-------------+---------------+

Sales Table:

+-------------+---------------+-------------+
| sale_id  | product_id  | sale_date   |
+-------------+---------------+-------------+
|      1      |     1         | 2019-01-21  |
|      2      |     2         | 2019-02-17  |
|      3      |     2         | 2019-06-02  |
|      4      |     3         | 2019-05-13  |
|      5      |     3         | 2019-06-25  |
+-------------+---------------+-------------+
```

## 📊 **WORKING**

Let's trace the given SQL query using the sample input:

1.  **Initial Tables:** We start with the `Product` and `Sales` tables as defined in the problem.

2.  **Join and Filter (WHERE clause):**

    *   The `JOIN` combines rows from `Product` and `Sales` where `P.product_id = S.product_id`.
    *   The `WHERE` clause `S.sale_date BETWEEN '2019-01-01' AND '2019-03-31'` filters the joined table to include only sales within the first quarter of 2019.

    This effectively selects products (with their names) sold in the first quarter.

3.  **Subquery:**

    *   The subquery `SELECT product_id FROM Sales WHERE sale_date < '2019-01-01' OR sale_date > '2019-03-31'` identifies `product_id`s that were sold *outside* the first quarter of 2019.  In our example, this subquery returns `{2, 3}`.

4.  **NOT IN:**

    *   The `P.product_id NOT IN (subquery)` clause excludes the products identified in the subquery from the results of the main query.  This means we only keep products that *weren't* sold outside the first quarter.

5.  **Final Result:**
    * After applying the where clause and the not in condition the only product id remaining is `1` so the final answer is product_id `1` which corresponds to product_name `S8`

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**
    *   The join operation has a time complexity of **O(n\*m)**, where *n* is the number of rows in the `Product` table and *m* is the number of rows in the `Sales` table.
    *   The subquery iterates through the `Sales` table, resulting in a time complexity of **O(m)**.
    *   The `NOT IN` operator, in the worst case, can have a time complexity proportional to the size of the subquery result.
    *   Overall, the dominant factor is often the join, giving a time complexity of **O(n\*m)**.

*   **Space Complexity:**
    *   The space complexity depends on the size of the intermediate tables created during the join and the subquery. In the worst case, it could be **O(n+m)**, where *n* is the number of rows in the `Product` table and *m* is the number of rows in the `Sales` table, if all rows satisfy the join and `WHERE` conditions. The subquery requires extra space to save the result of `product_id` so can be said to be **O(m)**
    