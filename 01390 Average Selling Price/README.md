# 01390 - Average Selling Price
    
**Language:** Mysql  
**Runtime:** 915 ms (Beats 23.74% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1390 | AVERAGE SELLING PRICE | [LeetCode Problem](https://leetcode.com/problems/average-selling-price/) |

---

## 💡 **Problem Explanation**

The problem requires calculating the average selling price for each product. Given two tables, `Prices` and `UnitsSold`, you need to determine the average price for each product based on the units sold within the product's price validity period.

- **`Prices` table:** Contains the product ID, start date, end date, and price.
- **`UnitsSold` table:** Contains the product ID, purchase date, and units sold.

The average price is calculated by summing the product of `price * units` for each sale within the price validity period, and then dividing by the total units sold for that product. If a product has no sales within its price validity period, the average price should be 0.

**Example:**

**Prices table:**

| product_id | start_date | end_date   | price |
|------------|------------|------------|-------|
| 1          | 2019-02-17 | 2019-02-28 | 5     |
| 1          | 2019-03-01 | 2019-03-22 | 20    |
| 2          | 2019-02-01 | 2019-02-20 | 15    |
| 2          | 2019-02-21 | 2019-03-31 | 30    |

**UnitsSold table:**

| product_id | purchase_date | units |
|------------|---------------|-------|
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |

**Output:**

| product_id | average_price |
|------------|---------------|
| 1          | 8.96          |
| 2          | 18.18         |

For product 1:
- From 2019-02-17 to 2019-02-28, price is 5, and 100 units were sold: `5 * 100 = 500`
- From 2019-03-01 to 2019-03-22, price is 20, and 15 units were sold: `20 * 15 = 300`
Total sales: `500 + 300 = 800`. Total units sold: `100 + 15 = 115`. Average price: `800 / 115 = 6.96`

For product 2:
- From 2019-02-01 to 2019-02-20, price is 15, and 200 units were sold: `15 * 200 = 3000`
- From 2019-02-21 to 2019-03-31, price is 30, and 30 units were sold: `30 * 30 = 900`
Total sales: `3000 + 900 = 3900`. Total units sold: `200 + 30 = 230`. Average price: `3900 / 230 = 16.96`
---

## 📊 **Algorithm**
* Join the `Prices` and `UnitsSold` tables on `product_id` and filter by the date condition (`U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE`).
* Calculate the total sales amount for each product using `SUM(P.price * U.units)`.
* Calculate the total units sold for each product using `SUM(U.units)`.
* Calculate the average price by dividing the total sales amount by the total units sold.
* Handle cases where there are no sales for a product by using `IFNULL` to return 0 in those cases.
* Group the results by `product_id`.
---

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

---

## 📊 **ASCII Representation**

This problem does not directly involve grids, trees, or movements. However, conceptually, the data tables can be visualized as relations in a database.

```
Prices Table:

+------------+------------+------------+-------+
| product_id | start_date | end_date   | price |
+------------+------------+------------+-------+
|     1      | 2019-02-17 | 2019-02-28 |   5   |
|     1      | 2019-03-01 | 2019-03-22 |  20   |
|     2      | 2019-02-01 | 2019-02-20 |  15   |
|     2      | 2019-02-21 | 2019-03-31 |  30   |
+------------+------------+------------+-------+

UnitsSold Table:

+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
|     1      |  2019-02-25   |  100  |
|     1      |  2019-03-01   |  15   |
|     2      |  2019-02-10   |  200  |
|     2      |  2019-03-22   |  30   |
+------------+---------------+-------+
```

---

## 📊 **WORKING**

Let's take the sample input and trace how the query would execute.

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

1.  **JOIN & Filter:**

    The `LEFT JOIN` combines the tables and filters rows based on the date condition:

    | product_id | start_date | end_date   | price | purchase_date | units |
    |------------|------------|------------|-------|---------------|-------|
    | 1          | 2019-02-17 | 2019-02-28 | 5     | 2019-02-25    | 100   |
    | 1          | 2019-03-01 | 2019-03-22 | 20    | 2019-03-01    | 15    |
    | 2          | 2019-02-01 | 2019-02-20 | 15    | 2019-02-10    | 200   |
    | 2          | 2019-02-21 | 2019-03-31 | 30    | 2019-03-22    | 30    |

2.  **SUM(P.price \* U.units) & SUM(U.units):**

    For `product_id = 1`:
    * `SUM(P.price * U.units)` = (5 * 100) + (20 * 15) = 500 + 300 = 800
    * `SUM(U.units)` = 100 + 15 = 115

    For `product_id = 2`:
    * `SUM(P.price * U.units)` = (15 * 200) + (30 * 30) = 3000 + 900 = 3900
    * `SUM(U.units)` = 200 + 30 = 230

3.  **Average Price Calculation:**

    For `product_id = 1`:
    * `average_price` = 800 / 115 ≈ 6.96

    For `product_id = 2`:
    * `average_price` = 3900 / 230 ≈ 16.96

4.  **Final Result:**

    | product_id | average_price |
    |------------|---------------|
    | 1          | 6.96          |
    | 2          | 16.96         |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the join operation. In the worst case, it could be **O(N*M)**, where N is the number of rows in the `Prices` table and M is the number of rows in the `UnitsSold` table. However, with proper indexing and database optimizations, this can be significantly improved. The aggregation using `GROUP BY` also contributes to the time complexity.

*   **Space Complexity:** The space complexity depends on the size of the intermediate joined table and the space required to store the aggregated results. It is roughly **O(K)** where K is the number of unique product IDs.
    