# 01251 - Average Selling Price
    
**Language:** Mysql  
**Runtime:** 915 ms (Beats 24.73% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                  | 🔗 Link                                                                 |
|------------------|---------------------------|-------------------------------------------------------------------------|
| 1251             | Average Selling Price     | [LeetCode Problem](https://leetcode.com/problems/average-selling-price/) |

---

## 💡 **Problem Explanation**

The problem requires you to calculate the average selling price for each product.  You are given two tables: `Prices` which contains the price range for each product and `UnitsSold` which contains the number of units sold for each product on a specific date. The average price should be calculated only for the units sold within the product's price range. If a product has no sales within its price ranges, the average price should be 0.

**Example:**

**Prices Table:**

| product_id | start_date | end_date   | price |
|------------|------------|------------|-------|
| 1          | 2019-02-17 | 2019-02-28 | 5     |
| 1          | 2019-03-01 | 2019-03-22 | 20    |
| 2          | 2019-02-01 | 2019-02-20 | 15    |
| 2          | 2019-02-21 | 2019-03-31 | 30    |

**UnitsSold Table:**

| product_id | purchase_date | units |
|------------|---------------|-------|
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |

**Output:**

| product_id | average_price |
|------------|---------------|
| 1          | 10.00         |
| 2          | 18.00         |

**Explanation:**

*   For product 1:
    *   From 2019-02-17 to 2019-02-28, the price is 5 and 100 units were sold (2019-02-25 falls within this range).
    *   From 2019-03-01 to 2019-03-22, the price is 20 and 15 units were sold (2019-03-01 falls within this range).
    *   Average price = (5 * 100 + 20 * 15) / (100 + 15) = 800 / 115 = 6.95652 ≈ 6.96 (After Rounding)
*   For product 2:
    *   From 2019-02-01 to 2019-02-20, the price is 15 and 200 units were sold (2019-02-10 falls within this range).
    *   From 2019-02-21 to 2019-03-31, the price is 30 and 30 units were sold (2019-03-22 falls within this range).
    *   Average price = (15 * 200 + 30 * 30) / (200 + 30) = 3900 / 230 = 16.95652 ≈ 16.96 (After Rounding)

## 📊 **Algorithm**

*   Perform a LEFT JOIN between the `Prices` and `UnitsSold` tables on `product_id` and the condition that the `purchase_date` from `UnitsSold` is within the `start_date` and `end_date` range of `Prices`.
*   Calculate the total price by multiplying the `price` from `Prices` with the `units` from `UnitsSold` and summing them up.
*   Calculate the total units sold by summing up the `units` from `UnitsSold`.
*   Divide the total price by the total units to get the average price.
*   Use `IFNULL` to handle cases where there are no sales for a product, setting the average price to 0 in such cases.
*   Round the average price to 2 decimal places.
*   Group the results by `product_id`.

## 🔥 **Code Implementation**

```mysql
SELECT P.product_id ,
    IFNULL(
    ROUND(SUM(P.price * U.units) / SUM(U.units),2)
    ,0)  AS average_price
FROM PRICES P
LEFT JOIN UNITSSOLD U
ON P.PRODUCT_ID = U.PRODUCT_ID AND
U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE
GROUP BY P.PRODUCT_ID
```

## 📊 **ASCII Representation**

```
Prices Table:

+-------------+-------------+-------------+-------+
| product_id  | start_date  | end_date    | price |
+-------------+-------------+-------------+-------+
| 1           | 2019-02-17  | 2019-02-28  | 5     |
| 1           | 2019-03-01  | 2019-03-22  | 20    |
| 2           | 2019-02-01  | 2019-02-20  | 15    |
| 2           | 2019-02-21  | 2019-03-31  | 30    |
+-------------+-------------+-------------+-------+

UnitsSold Table:

+-------------+---------------+-------+
| product_id  | purchase_date | units |
+-------------+---------------+-------+
| 1           | 2019-02-25    | 100   |
| 1           | 2019-03-01    | 15    |
| 2           | 2019-02-10    | 200   |
| 2           | 2019-03-22    | 30    |
+-------------+---------------+-------+
```

## 📊 **WORKING**

Let's trace the query execution with the given example data:

1.  **JOIN Operation**:
    The `LEFT JOIN` combines the `Prices` and `UnitsSold` tables based on `product_id` and the date range.

2.  **Intermediate Result After JOIN**:

    | P.product\_id | P.start\_date | P.end\_date | P.price | U.purchase\_date | U.units |
    |---------------|---------------|-------------|---------|-----------------|---------|
    | 1             | 2019-02-17    | 2019-02-28  | 5       | 2019-02-25      | 100     |
    | 1             | 2019-03-01    | 2019-03-22  | 20      | 2019-03-01      | 15      |
    | 2             | 2019-02-01    | 2019-02-20  | 15      | 2019-02-10      | 200     |
    | 2             | 2019-02-21    | 2019-03-31  | 30      | 2019-03-22      | 30      |

3.  **Aggregation (SUM and COUNT)**:
    The `SUM(P.price * U.units)` calculates the total revenue for each product.
    The `SUM(U.units)` calculates the total units sold for each product.

4.  **Average Price Calculation**:
    The average price is calculated as `SUM(P.price * U.units) / SUM(U.units)`.

5.  **IFNULL Handling**:
    If `SUM(U.units)` is 0 (meaning no units were sold within the price range), `IFNULL` sets the average price to 0.

6.  **Rounding**:
    The `ROUND` function rounds the average price to 2 decimal places.

7.  **Final Result**:

    | product\_id | average\_price |
    |-------------|----------------|
    | 1           | 10.00          |
    | 2           | 18.00          |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the join operation and the aggregation.  In the worst case, where every row in `Prices` matches every row in `UnitsSold`, the time complexity could be **O(m\*n)**, where `m` is the number of rows in `Prices` and `n` is the number of rows in `UnitsSold`.  However, with proper indexing on `product_id` and the date fields, the join operation can be optimized, potentially reducing the time complexity. The aggregation (group by) has a time complexity of **O(n)**, where n is the number of rows after the join.

*   **Space Complexity:** The space complexity depends on the size of the intermediate result after the join.  In the worst case, it could be **O(m\*n)**, where `m` is the number of rows in `Prices` and `n` is the number of rows in `UnitsSold`. The space complexity for the aggregation is **O(p)**, where `p` is the number of distinct product IDs.
    