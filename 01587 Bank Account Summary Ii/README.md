# 01587 - Bank Account Summary Ii
    
**Language:** Mysql  
**Runtime:** 880 ms (Beats 33.01% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1587 | Bank Account Summary II | [LeetCode Problem](https://leetcode.com/problems/bank-account-summary-ii/) |

---

## 💡 **Problem Explanation**

The problem asks us to find the name and balance of users whose balance is greater than $10000. The balance is calculated by summing up all transaction amounts for each user account. We are given two tables: `Users` and `Transactions`.

*   **Users Table:** Contains user account information, including account number and name.
*   **Transactions Table:** Contains transaction details, including account number and transaction amount.

**Example:**

**Users Table:**

| account | name    |
| ------- | ------- |
| 90001   | Alice   |
| 90002   | Bob     |
| 90003   | Charlie |

**Transactions Table:**

| trans_id | account | amount |
| -------- | ------- | ------ |
| 1        | 90001   | 7000   |
| 2        | 90001   | 3000   |
| 3        | 90001   | 1000   |
| 4        | 90002   | 2000   |
| 5        | 90003   | 6000   |

**Expected Output:**

| name    | balance |
| ------- | ------- |
| Alice   | 11000   |

Alice's balance (7000 + 3000 + 1000 = 11000) is greater than $10000. Bob's and Charlie's balances are not.

## 📊 **Algorithm**

*   Join the `Users` and `Transactions` tables on the `account` column.
*   Group the results by `account` and calculate the sum of `amount` for each account.
*   Filter the results to include only accounts where the sum of `amount` is greater than 10000.
*   Select the `name` from the `Users` table and the calculated `balance`.
*   Order the results by `name`.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT U.NAME,
    SUM(T.AMOUNT) AS "BALANCE"
FROM USERS U
LEFT JOIN TRANSACTIONS T
ON U.ACCOUNT = T.ACCOUNT
GROUP BY T.ACCOUNT
HAVING BALANCE>10000
ORDER BY U.name
```

## 📊 **ASCII Representation**

**Users Table:**

```
+---------+---------+
| account | name    |
+---------+---------+
| 90001   | Alice   |
| 90002   | Bob     |
| 90003   | Charlie |
+---------+---------+
```

**Transactions Table:**

```
+----------+---------+--------+
| trans_id | account | amount |
+----------+---------+--------+
| 1        | 90001   | 7000   |
| 2        | 90001   | 3000   |
| 3        | 90001   | 1000   |
| 4        | 90002   | 2000   |
| 5        | 90003   | 6000   |
+----------+---------+--------+
```

## 📊 **WORKING**

Let's walk through the query with the sample input:

1.  **Join:** The `LEFT JOIN` combines `Users` and `Transactions` based on the `account` column.

    | account | name    | trans\_id | amount |
    | ------- | ------- | -------- | ------ |
    | 90001   | Alice   | 1        | 7000   |
    | 90001   | Alice   | 2        | 3000   |
    | 90001   | Alice   | 3        | 1000   |
    | 90002   | Bob     | 4        | 2000   |
    | 90003   | Charlie | 5        | 6000   |

2.  **Group By:** The `GROUP BY T.ACCOUNT` groups the joined table by account number.

3.  **Sum:** `SUM(T.AMOUNT)` calculates the total amount for each account.

    | account | name    | balance |
    | ------- | ------- | ------- |
    | 90001   | Alice   | 11000   |
    | 90002   | Bob     | 2000    |
    | 90003   | Charlie | 6000    |

4.  **Having:** The `HAVING BALANCE > 10000` filters the results, keeping only accounts with a balance greater than 10000.

    | account | name    | balance |
    | ------- | ------- | ------- |
    | 90001   | Alice   | 11000   |

5.  **Select:** `SELECT U.NAME, SUM(T.AMOUNT) AS "BALANCE"` selects the user's name and balance.

6.  **Order By:** `ORDER BY U.name` orders the results by user name.

Final Result:

| name    | balance |
| ------- | ------- |
| Alice   | 11000   |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the `JOIN`, `GROUP BY`, and `ORDER BY` operations.  In the worst case, it could be **O(N log N)**, where N is the number of rows in the joined table.
*   **Space Complexity:** The space complexity depends on the size of the intermediate results, especially the grouped table and the joined table. In the worst case, it could be **O(N)**.
    