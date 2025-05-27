# 01523 - Capital Gainloss
    
**Language:** Mysql  
**Runtime:** 582 ms (Beats 19.38% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1523 | Capital Gain/Loss | [LeetCode Problem](https://leetcode.com/problems/capital-gainloss/) |

---

## 💡 **Problem Explanation**

The "Capital Gain/Loss" problem requires calculating the total capital gain or loss for each stock.  You are given a table of stock transactions, where each transaction includes the stock name, operation type (buy or sell), and price. The goal is to determine the net profit (or loss) for each stock by summing the prices of sell operations and subtracting the prices of buy operations.

**Example:**

**Input:**

```
Stocks table:
+---------------+-------------+-------------+---------+
| stock_name    | operation   | operation_day | price   |
+---------------+-------------+-------------+---------+
| Leetcode      | BUY         | 1             | 1000    |
| Corona Masks  | BUY         | 2             | 10      |
| Leetcode      | SELL        | 5             | 9000    |
| Corona Masks  | SELL        | 5             | 10      |
| Leetcode      | BUY         | 10            | 1000    |
| Corona Masks  | BUY         | 20            | 17      |
| Leetcode      | SELL        | 30            | 8000    |
+---------------+-------------+-------------+---------+
```

**Output:**

```
+---------------+-------------------+
| stock_name    | capital_gain_loss |
+---------------+-------------------+
| Corona Masks  | -7                |
| Leetcode      | 15000             |
+---------------+-------------------+
```

In this example, Leetcode stock has a capital gain of 9000 (sell) + 8000 (sell) - 1000 (buy) - 1000 (buy) = 15000. Corona Masks stock has a capital gain/loss of 10 (sell) - 10 (buy) - 17 (buy) = -7.

## 📊 **Algorithm**

*   Group the transactions by `stock_name`.
*   For each `stock_name`, calculate the sum of prices, considering `BUY` operations as negative prices and `SELL` operations as positive prices.
*   Return the `stock_name` and the calculated `capital_gain_loss`.

## 🔥 **Code Implementation**

```mysql
select stock_name,
    SUM(
        IF(OPERATION="BUY",-1*price,price)
    ) as capital_gain_loss
FROM STOCKS
GROUP BY STOCK_NAME
```

## 📊 **ASCII Representation**

Since this problem involves database operations rather than grids or trees, an ASCII representation of the database schema might be helpful.

```
+---------------+-------------+-------------+---------+
| stock_name    | operation   | operation_day | price   |
+---------------+-------------+-------------+---------+
| Leetcode      | BUY         | 1             | 1000    |
| Corona Masks  | BUY         | 2             | 10      |
| Leetcode      | SELL        | 5             | 9000    |
| ...           | ...         | ...           | ...     |
+---------------+-------------+-------------+---------+

The query groups by stock_name and calculates the sum of prices based on the operation.
```

## 📊 **WORKING**

Let's trace how the provided SQL query operates on the sample input:

1.  **FROM STOCKS:**  The query starts by selecting data from the `STOCKS` table.

2.  **GROUP BY STOCK\_NAME:** The rows are grouped by the `stock_name` column.  This results in two groups: "Leetcode" and "Corona Masks".

3.  **SUM(IF(OPERATION="BUY", -1\*price, price))**:
    *   For the "Leetcode" group, the calculation is:  `-1*1000 + 9000 + -1*1000 + 8000 = 15000`
    *   For the "Corona Masks" group, the calculation is: `-1*10 + 10 + -1*17 = -7`

4.  **SELECT stock\_name, ... AS capital\_gain\_loss**:  The query selects the `stock_name` and the calculated sum (aliased as `capital_gain_loss`).

The final result is a table showing the `stock_name` and the corresponding `capital_gain_loss`.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N)**, where N is the number of rows in the `STOCKS` table. This is because the query needs to scan all rows to perform the grouping and aggregation.

*   **Space Complexity:** The space complexity is **O(M)**, where M is the number of distinct stock names. This is because the `GROUP BY` operation may need to store intermediate results for each stock name.
    