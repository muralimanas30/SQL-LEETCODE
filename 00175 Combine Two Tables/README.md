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

This problem requires you to combine data from two tables, `Person` and `Address`, based on a common column `personId`. The goal is to retrieve the first name, last name (from the `Person` table), city, and state (from the `Address` table) for each person. If a person does not have an address, the city and state should still be included in the result, but with `NULL` values.

**Sample Input:**

`Person` table:

| personId | lastName | firstName |
|----------|----------|-----------|
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |

`Address` table:

| addressId | personId | city      | state     |
|-----------|----------|-----------|-----------|
| 1         | 2        | New York  | New York  |
| 2         | 3        | Leetcode  | California|

**Expected Output:**

| firstName | lastName | city      | state     |
|-----------|----------|-----------|-----------|
| Allen     | Wang     | NULL      | NULL      |
| Bob       | Alice    | New York  | New York  |

---

## 📊 **Algorithm**

*   Select the `firstName` and `lastName` from the `Person` table.
*   Select the `city` and `state` from the `Address` table.
*   Perform a `LEFT JOIN` between the `Person` and `Address` tables using the `personId` as the join key.
*   This ensures that all rows from the `Person` table are included in the result, even if there's no corresponding entry in the `Address` table. In such cases, the `city` and `state` will be `NULL`.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT p.firstName, p.lastName, a.city, a.state FROM Person p LEFT JOIN Address a 
ON p.personId = a.personId;
```

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N)**, where N is the number of rows in the `Person` table.  This is due to the left join operation.
*   **Space Complexity:** The space complexity is **O(M)**, where M is the number of rows in the resulting table, which depends on the size of both tables and the number of matching `personId` values.
    