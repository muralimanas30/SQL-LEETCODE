# 01581 - Customer Who Visited But Did Not Make Any Transactions
    
**Language:** Mysql  
**Runtime:** 1421 ms (Beats 44.61% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1581 | Customer Who Visited but Did Not Make Any Transactions | [LeetCode Problem](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/) |

---

## 💡 **Problem Explanation**

The problem requires us to identify customers who visited a store but did not make any transactions. We are given two tables: `Visits` and `Transactions`.  The `Visits` table contains information about customer visits, and the `Transactions` table contains information about transactions made by customers during their visits.  Our goal is to find the `customer_id` of customers who have entries in the `Visits` table but do not have corresponding entries in the `Transactions` table and the number of such visits.

**Example:**

**Visits Table:**

| visit_id | customer_id | visit_date |
|----------|-------------|------------|
| 1        | 23          | 2021-01-01 |
| 2        | 9           | 2021-01-02 |
| 4        | 30          | 2021-01-04 |
| 5        | 23          | 2021-01-05 |
| 6        | 23          | 2021-01-06 |

**Transactions Table:**

| transaction_id | visit_id | amount | transaction_date |
|----------------|----------|--------|------------------|
| 2              | 5        | 30     | 2021-01-05       |
| 3              | 2        | 40     | 2021-01-02       |

**Expected Output:**

| customer_id | count_no_trans |
|-------------|----------------|
| 30          | 1              |
| 23          | 2              |

Explanation:

- Customer 23 visited three times (visit_id 1, 5, and 6), but only made one transaction (visit_id 5). Thus, they have two visits without transactions.
- Customer 9 visited once (visit_id 2) and made one transaction (visit_id 2).
- Customer 30 visited once (visit_id 4) and made no transactions.
---

## 📊 **Algorithm**

*   Perform a left join between the `Visits` table and the `Transactions` table using `visit_id` as the joining key.
*   Filter the result to include only those visits for which there is no corresponding transaction (i.e., `transaction_id` is NULL).
*   Group the results by `customer_id`.
*   Count the number of visits without transactions for each customer.
*   Return the `customer_id` and the count of visits without transactions (`count_no_trans`).

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT v.customer_id
,COUNT(IFNULL(T.transaction_id,0)) AS count_no_trans
FROM VISITS V
LEFT JOIN TRANSACTIONS T
ON V.VISIT_ID = T.VISIT_ID
WHERE T.transaction_id IS NULL
GROUP BY v.CUSTOMER_ID
```

## 📊 **ASCII Representation**

**VISITS Table:**

```
+----------+-------------+------------+
| visit_id | customer_id | visit_date |
+----------+-------------+------------+
| 1        | 23          | 2021-01-01 |
| 2        | 9           | 2021-01-02 |
| 4        | 30          | 2021-01-04 |
| 5        | 23          | 2021-01-05 |
| 6        | 23          | 2021-01-06 |
+----------+-------------+------------+
```

**TRANSACTIONS Table:**

```
+----------------+----------+--------+------------------+
| transaction_id | visit_id | amount | transaction_date |
+----------------+----------+--------+------------------+
| 2              | 5        | 30     | 2021-01-05       |
| 3              | 2        | 40     | 2021-01-02       |
+----------------+----------+--------+------------------+
```

**LEFT JOIN operation `VISITS LEFT JOIN TRANSACTIONS ON VISITS.visit_id = TRANSACTIONS.visit_id`**

```
+----------+-------------+------------+----------------+----------+--------+------------------+
| visit_id | customer_id | visit_date | transaction_id | visit_id | amount | transaction_date |
+----------+-------------+------------+----------------+----------+--------+------------------+
| 1        | 23          | 2021-01-01 | NULL           | NULL     | NULL   | NULL             |
| 2        | 9           | 2021-01-02 | 3              | 2        | 40     | 2021-01-02       |
| 4        | 30          | 2021-01-04 | NULL           | NULL     | NULL   | NULL             |
| 5        | 23          | 2021-01-05 | 2              | 5        | 30     | 2021-01-05       |
| 6        | 23          | 2021-01-06 | NULL           | NULL     | NULL   | NULL             |
+----------+-------------+------------+----------------+----------+--------+------------------+
```

## 📊 **WORKING**

Let's trace the execution with the sample data.

1.  **JOIN Operation:**

    The `LEFT JOIN` combines `VISITS` and `TRANSACTIONS` on `VISITS.visit_id = TRANSACTIONS.visit_id`. The `transaction_id` will be `NULL` for visits without corresponding transactions.
2.  **WHERE Clause:**

    `WHERE T.transaction_id IS NULL` filters the joined table, keeping only rows where there was no transaction for a visit.

    Result after WHERE clause:

    ```
    +----------+-------------+------------+----------------+----------+--------+------------------+
    | visit_id | customer_id | visit_date | transaction_id | visit_id | amount | transaction_date |
    +----------+-------------+------------+----------------+----------+--------+------------------+
    | 1        | 23          | 2021-01-01 | NULL           | NULL     | NULL   | NULL             |
    | 4        | 30          | 2021-01-04 | NULL           | NULL     | NULL   | NULL             |
    | 6        | 23          | 2021-01-06 | NULL           | NULL     | NULL   | NULL             |
    +----------+-------------+------------+----------------+----------+--------+------------------+
    ```

3.  **GROUP BY Clause:**

    `GROUP BY v.CUSTOMER_ID` groups the results by `customer_id`.
4.  **COUNT and SELECT Clause:**

    `COUNT(IFNULL(T.transaction_id,0))` counts the number of visits without transactions for each customer. The `IFNULL` is used so that `COUNT` counts rows where `transaction_id` is null instead of skipping them.

    -   Customer 23: 2 visits
    -   Customer 30: 1 visit

5.  **Final Result:**

    ```
    +-------------+----------------+
    | customer_id | count_no_trans |
    +-------------+----------------+
    | 23          | 2              |
    | 30          | 1              |
    +-------------+----------------+
    ```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The time complexity is dominated by the join operation, which is **O(N + M)**, where N is the number of rows in the `Visits` table and M is the number of rows in the `Transactions` table. The `GROUP BY` operation adds another **O(N)** in the worst case.

*   **Space Complexity:** The space complexity is **O(N + M)** in the worst case, as the joined table could potentially contain all rows from both tables before filtering. The `GROUP BY` operation can also require additional space, depending on the number of distinct `customer_id` values.
    