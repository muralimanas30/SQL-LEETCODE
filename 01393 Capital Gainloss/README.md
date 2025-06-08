# 01393 - Capital Gainloss
    
**Language:** Mysql  
**Runtime:** 582 ms (Beats 19.91% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1393 | Capital Gain/Loss | [LeetCode Problem](https://leetcode.com/problems/capital-gainloss/) |

---

## 💡 **Problem Explanation**

The problem requires you to calculate the capital gain or loss for each stock in a portfolio. You are given a table with stock transactions, where each transaction is either a buy or a sell. The goal is to sum the prices of all sell transactions and subtract the sum of the prices of all buy transactions for each stock.

For instance, consider the following transactions:

| stock_name | operation | price |
|------------|-----------|-------|
| 'ABC'      | 'Buy'     | 10    |
| 'ABC'      | 'Sell'    | 15    |
| 'XYZ'      | 'Buy'     | 20    |
| 'XYZ'      | 'Sell'    | 25    |

The expected output would be:

| stock_name | capital_gain_loss |
|------------|--------------------|
| 'ABC'      | 5                  |
| 'XYZ'      | 5                  |

For 'ABC', the capital gain is 15 (sell) - 10 (buy) = 5.  Similarly, for 'XYZ', the capital gain is 25 (sell) - 20 (buy) = 5.

## 📊 **Algorithm**

*   Group the transactions by `stock_name`.
*   For each group, sum the `price` values.
*   If the `operation` is 'Buy', consider the price as negative.  If the `operation` is 'Sell', consider the price as positive.
*   The final sum represents the capital gain or loss for that stock.

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

Let's visualize the `Stocks` table:

```
Stocks Table:

+---------------+-------------+-------+
| stock_name    | operation   | price |
+---------------+-------------+-------+
| ABC           | Buy         | 10    |
| ABC           | Sell        | 15    |
| XYZ           | Buy         | 20    |
| XYZ           | Sell        | 25    |
+---------------+-------------+-------+
```

## 📊 **WORKING**

Here’s a step-by-step breakdown using the example provided:

1.  **Original Table:**

    ```
    +---------------+-------------+-------+
    | stock_name    | operation   | price |
    +---------------+-------------+-------+
    | ABC           | Buy         | 10    |
    | ABC           | Sell        | 15    |
    | XYZ           | Buy         | 20    |
    | XYZ           | Sell        | 25    |
    +---------------+-------------+-------+
    ```

2.  **Apply `IF` condition & `SUM` within each group of stock:**

    For stock 'ABC':

    *   Buy: -1 \* 10 = -10
    *   Sell: 15
    *   Sum: -10 + 15 = 5

    For stock 'XYZ':

    *   Buy: -1 \* 20 = -20
    *   Sell: 25
    *   Sum: -20 + 25 = 5

3.  **Final Result:**

    ```
    +---------------+--------------------+
    | stock_name    | capital_gain_loss  |
    +---------------+--------------------+
    | ABC           | 5                  |
    | XYZ           | 5                  |
    +---------------+--------------------+
    ```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The query involves a `GROUP BY` operation and a `SUM` aggregation.  In the worst case, the database might need to scan all rows in the `Stocks` table. Thus, the time complexity is **O(N)**, where N is the number of rows in the `Stocks` table.  The `IF` condition adds a negligible constant time to each row processed.

*   **Space Complexity:** The space complexity depends on the number of unique stock names.  The `GROUP BY` operation requires storing intermediate results for each stock. In the worst case, if all stock names are unique, the space complexity will be **O(M)**, where M is the number of unique stock names.
    