# 00175 - Combine Two Tables
    
**Language:** Mysql  
**Runtime:** 349 ms (Beats 99.91% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The problem requires us to combine data from two tables, `Person` and `Address`, based on the `personId`. We need to retrieve the `firstName` and `lastName` from the `Person` table and the `city` and `state` from the `Address` table.  If a person does not have an address, the corresponding `city` and `state` should be `NULL`.

**Example:**

**Person Table:**

| personId | lastName | firstName |
|---|---|---|
| 1 | Allen | Alice |
| 2 | Bob | Bob |

**Address Table:**

| addressId | personId | city | state |
|---|---|---|---|
| 1 | 2 | New York City | New York |
| 2 | 3 | Leetcode | California |

**Expected Output:**

| firstName | lastName | city | state |
|---|---|---|---|
| Alice | Allen | NULL | NULL |
| Bob | Bob | New York City | New York |

## 📊 **Algorithm**

*   Use a `LEFT JOIN` to combine the `Person` and `Address` tables.
*   The `LEFT JOIN` ensures that all rows from the `Person` table are included in the result, even if there is no matching `personId` in the `Address` table.
*   Select the desired columns: `firstName`, `lastName`, `city`, and `state`.
*   Specify the join condition as `p.personId = a.personId`, where `p` is an alias for the `Person` table and `a` is an alias for the `Address` table.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT p.firstName, p.lastName, a.city, a.state FROM Person p LEFT JOIN Address a 
ON p.personId = a.personId;
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N + M)**, where N is the number of rows in the `Person` table and M is the number of rows in the `Address` table. This is due to the join operation.
*   **Space Complexity:** The space complexity depends on the size of the result set. In the worst case, it could be **O(N + M)** if all rows from both tables are included in the output.
    