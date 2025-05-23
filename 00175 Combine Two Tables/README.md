# 00175 - Combine Two Tables
    
**Language:** Mysql  
**Runtime:** 349 ms (Beats 99.91% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 175 | Combine Two Tables | [LeetCode Problem](https://leetcode.com/problems/combine-two-tables/) |

---

## 💡 **Problem Explanation**

The problem asks you to combine information from two tables, `Person` and `Address`, based on their common field `personId`.  Specifically, you need to retrieve the `firstName`, `lastName` from the `Person` table, along with the `city` and `state` from the `Address` table. The catch is that not every person might have an address listed in the `Address` table.  In such cases, you should still display the person's name, but the address fields should be `NULL`.

**Example:**

**Person Table:**

| personId | lastName | firstName |
|---|---|---|
| 1 | Wang | Allen |
| 2 | Alice | Bob |

**Address Table:**

| addressId | personId | city | state |
|---|---|---|---|
| 1 | 2 | New York City | New York |
| 2 | 3 | Leetcode | California |

**Expected Output:**

| firstName | lastName | city | state |
|---|---|---|---|
| Allen | Wang | NULL | NULL |
| Bob | Alice | New York City | New York |

---

## 📊 **Algorithm**

*   Select the `firstName` and `lastName` columns from the `Person` table.
*   Select the `city` and `state` columns from the `Address` table.
*   Perform a `LEFT JOIN` between the `Person` and `Address` tables, using `personId` as the joining key.  A `LEFT JOIN` ensures that all rows from the `Person` table are included in the result, even if there isn't a matching row in the `Address` table. If there is no match in the Address table, the columns originating from Address will be `NULL`.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT p.firstName, p.lastName, a.city, a.state FROM Person p LEFT JOIN Address a 
ON p.personId = a.personId;
```

## 📊 **ASCII Representation**

Since this problem involves database tables, an ASCII representation helps visualize the join operation.

```
Person Table:

+----------+----------+-----------+
| personId | lastName | firstName |
+----------+----------+-----------+
|    1     |  Wang    |   Allen   |
|    2     |  Alice   |    Bob    |
+----------+----------+-----------+

Address Table:

+-----------+----------+---------------+------------+
| addressId | personId |      city     |   state    |
+-----------+----------+---------------+------------+
|    1      |    2     | New York City | New York   |
|    2      |    3     |   Leetcode    | California |
+-----------+----------+---------------+------------+

LEFT JOIN on Person.personId = Address.personId:

+-----------+----------+-----------+-----------+---------------+------------+
| firstName | lastName | personId  | addressId |      city     |   state    |
+-----------+----------+-----------+-----------+---------------+------------+
|   Allen   |   Wang   |     1     |    NULL   |      NULL     |    NULL    |
|    Bob    |  Alice   |     2     |     1     | New York City | New York   |
+-----------+----------+-----------+-----------+---------------+------------+
```

## 📊 **WORKING**

Let's walk through how the query would process the sample input.

1.  **`FROM Person p LEFT JOIN Address a ON p.personId = a.personId`**: The database starts with the `Person` table and attempts to find matching rows in the `Address` table based on `personId`.

2.  For the first row in `Person` (Allen Wang, `personId = 1`), there's no matching `personId` in the `Address` table.  Because it's a `LEFT JOIN`, the row from `Person` is still included, and the columns originating from `Address` (city and state) become `NULL`.

3.  For the second row in `Person` (Bob Alice, `personId = 2`), there's a match in the `Address` table (`addressId = 1`). The corresponding `city` and `state` are retrieved.

4.  **`SELECT p.firstName, p.lastName, a.city, a.state`**: Finally, the query selects the requested columns, resulting in the final output table.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity of a `LEFT JOIN` operation in SQL largely depends on the indexing.  In the best case, with proper indexes on the `personId` columns of both tables, the complexity can be close to **O(N + M)**, where N is the number of rows in `Person` and M is the number of rows in `Address`.  Without indexes, it could degrade to **O(N * M)**.

*   **Space Complexity:** The space complexity is primarily determined by the size of the resulting table. In the worst case, where every row in `Person` has a matching row in `Address`, the space complexity would be **O(N)**, where N is the number of rows in the resulting combined table.
    