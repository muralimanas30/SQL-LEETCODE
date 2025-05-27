# 01734 - Bank Account Summary Ii
    
**Language:** Mysql  
**Runtime:** 880 ms (Beats 31.69% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title                   | 🔗 Link                                                                 |
| ------------------ | -------------------------- | ---------------------------------------------------------------------- |
| 1734               | Bank Account Summary II | [LeetCode Problem](https://leetcode.com/problems/bank-account-summary-ii/) |

---

## 💡 **Problem Explanation**

The problem requires us to summarize the balance of each user's account by summing up all transaction amounts for each account. We need to filter out users whose balance is not greater than 10000 and return the name and balance of the remaining users, sorted by name.

**Example:**

Suppose we have the following `Users` and `Transactions` tables:

**Users Table:**

| name  | account |
|-------|---------|
| Alice | 101     |
| Bob   | 102     |
| Mark  | 103     |

**Transactions Table:**

| trans_id | account | amount |
|----------|---------|--------|
| 1        | 101     | 5000   |
| 2        | 101     | -2000  |
| 3        | 102     | 10000  |
| 4        | 103     | 20000  |
| 5        | 103     | -3000  |

The expected output is:

| name  | balance |
|-------|---------|
| Mark  | 17000   |

Alice's balance is 5000 - 2000 = 3000, Bob's balance is 10000, and Mark's balance is 20000 - 3000 = 17000. Only Mark has a balance greater than 10000, so he is the only user returned.

---

## 📊 **Algorithm**
*   Join the `Users` and `Transactions` tables on the `account` column.
*   Group the joined table by account and calculate the sum of transaction amounts for each account.
*   Filter the groups to include only those with a total balance greater than 10000.
*   Select the user's name and the calculated balance.
*   Order the result by the user's name.

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

Since this is a SQL problem, an ASCII representation of tables and relationships will be helpful.

```
Users Table:
+-------+---------+
| name  | account |
+-------+---------+
| Alice | 101     |
| Bob   | 102     |
| Mark  | 103     |
+-------+---------+

Transactions Table:
+----------+---------+--------+
| trans_id | account | amount |
+----------+---------+--------+
| 1        | 101     | 5000   |
| 2        | 101     | -2000  |
| 3        | 102     | 10000  |
| 4        | 103     | 20000  |
| 5        | 103     | -3000  |
+----------+---------+--------+

Relationship:
Users.account <-----> Transactions.account
```

## 📊 **WORKING**

Let's trace the execution with the example data:

1.  **Join Users and Transactions:**
    The tables are joined on the `account` column.

2.  **Group by account:**
    We group the result by `account`, so we can sum the amounts for each account.

3.  **Calculate Balance:**
    For account 101, the balance is 5000 - 2000 = 3000.
    For account 102, the balance is 10000.
    For account 103, the balance is 20000 - 3000 = 17000.

4.  **Filter by Balance > 10000:**
    Only account 103 (Mark) has a balance greater than 10000.

5.  **Select Name and Balance:**
    We select Mark's name and his balance, which is 17000.

6.  **Order by Name:**
    Since there is only one user remaining (Mark), no ordering is necessary.

The final result is:

| name  | balance |
|-------|---------|
| Mark  | 17000   |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N log N)** due to the sorting operation, where N is the number of rows after the join and grouping. The `GROUP BY` operation can also have a time complexity depending on the number of groups.

*   **Space Complexity:** The space complexity is **O(N)**, where N represents the size of the intermediate table created after the join operation, which depends on the number of transactions and users involved. The space required for sorting also contributes to the space complexity.
    