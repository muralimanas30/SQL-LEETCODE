# 01724 - Customer Who Visited But Did Not Make Any Transactions
    
**Language:** Mysql  
**Runtime:** 1421 ms (Beats 43.74% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                                                          | 🔗 Link                                                                                                     |
| ------------------ | ---------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| 1581               | Customer Who Visited but Did Not Make Any Transactions            | [LeetCode Problem](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/) |

---

## 💡 **Problem Explanation**

The problem requires identifying customers who visited the store but did not make any transactions. We are given two tables: `Visits` and `Transactions`.  The `Visits` table contains information about customer visits, and the `Transactions` table contains information about transactions made during those visits. We need to find the `customer_id` from the `Visits` table where there is no corresponding `visit_id` in the `Transactions` table. The result should list the `customer_id` and the number of visits without transactions.

**Sample Input:**

`Visits` table:

| visit_id | customer_id |
| -------- | ----------- |
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 23          |
| 6        | 9           |

`Transactions` table:

| id | visit_id | amount |
| -- | -------- | ------ |
| 1  | 5        | 300    |
| 2  | 2        | 200    |

**Expected Output:**

| customer_id | count_no_trans |
| ----------- | -------------- |
| 30          | 1              |
| 23          | 1              |

**Explanation:**

- Customer 23 visited twice (visit\_id 1 and 5), but only made one transaction (visit\_id 5). Thus, one visit without a transaction.
- Customer 9 visited twice (visit\_id 2 and 6), but only made one transaction (visit\_id 2). Thus, one visit without a transaction.
- Customer 30 visited once (visit\_id 4) and made no transactions. Thus, one visit without a transaction.

---

## 📊 **Algorithm**

*   Perform a left join between the `Visits` and `Transactions` tables on the `visit_id` column.
*   Filter out the rows where `transaction_id` is NULL, indicating that the visit did not result in a transaction.
*   Group the results by `customer_id` to count the number of visits without transactions for each customer.
*   Count the number of visits without transactions using `COUNT()` function.
*   Select the `customer_id` and the calculated count as `count_no_trans`.

---

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

---

## 📊 **ASCII Representation**

**Visits Table:**

```
+------------+-------------+
| visit_id   | customer_id |
+------------+-------------+
| 1          | 23          |
| 2          | 9           |
| 4          | 30          |
| 5          | 23          |
| 6          | 9           |
+------------+-------------+
```

**Transactions Table:**

```
+------------+------------+--------+
| id         | visit_id   | amount |
+------------+------------+--------+
| 1          | 5          | 300    |
| 2          | 2          | 200    |
+------------+------------+--------+
```

**Combined Table (After LEFT JOIN):**

```
+------------+-------------+------------+--------+
| visit_id   | customer_id | id         | amount |
+------------+-------------+------------+--------+
| 1          | 23          | NULL       | NULL   |
| 2          | 9           | 2          | 200    |
| 4          | 30          | NULL       | NULL   |
| 5          | 23          | 1          | 300    |
| 6          | 9           | NULL       | NULL   |
+------------+-------------+------------+--------+
```

---

## 📊 **WORKING**

Let's trace the execution with the given sample data:

1.  **LEFT JOIN:** The `VISITS` table is left-joined with the `TRANSACTIONS` table using `VISIT_ID`. If a `VISIT_ID` from `VISITS` does not exist in `TRANSACTIONS`, the columns from `TRANSACTIONS` will be `NULL`.

2.  **WHERE Clause:** `WHERE T.transaction_id IS NULL` filters the joined table to only include rows where there was no transaction for a visit.

    Result after WHERE clause:

    ```
    +------------+-------------+------------+--------+
    | visit_id   | customer_id | id         | amount |
    +------------+-------------+------------+--------+
    | 1          | 23          | NULL       | NULL   |
    | 4          | 30          | NULL       | NULL   |
    | 6          | 9           | NULL       | NULL   |
    +------------+-------------+------------+--------+
    ```

3.  **GROUP BY:** The results are grouped by `customer_id`.

4.  **COUNT and SELECT:** For each `customer_id`, `COUNT(IFNULL(T.transaction_id,0))` counts the number of visits without transactions. `IFNULL` function changes the `NULL` values to `0`, so the count aggregate function can function properly.

    | customer\_id | count(IFNULL(T.transaction\_id,0)) |
    | :----------- | :---------------------------------- |
    | 9            | 1                                   |
    | 23           | 1                                   |
    | 30           | 1                                   |

5.  **Final Output:**

    | customer\_id | count\_no\_trans |
    | :----------- | :--------------- |
    | 9            | 1                |
    | 23           | 1                |
    | 30           | 1                |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N + M)**, where N is the number of rows in the `Visits` table and M is the number of rows in the `Transactions` table. This is due to the left join operation, which can take O(N + M) time in the worst case. The grouping operation takes O(N) time.
*   **Space Complexity:** The space complexity is **O(N)**, where N is the number of rows in the `Visits` table.  This is due to the space required to store the joined table and the intermediate results of the grouping operation.
    