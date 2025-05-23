# 00175 - Combine Two Tables
    
**Language:** Mysql  
**Runtime:** 349 ms (Beats 99.91% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The problem requires us to combine data from two tables, `Person` and `Address`, based on the `personId`. Specifically, we need to retrieve the first name, last name from the `Person` table, and the city and state from the `Address` table. If a person doesn't have an address, the city and state should be `NULL`.

**Sample Input:**

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

## 📊 **Algorithm**

*   Use a `LEFT JOIN` to combine the `Person` and `Address` tables.
*   The `LEFT JOIN` ensures that all rows from the `Person` table are included, even if there's no matching `personId` in the `Address` table.
*   Select the `firstName` and `lastName` from the `Person` table and `city` and `state` from the `Address` table.
*   Join the tables on the `personId` column.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT p.firstName, p.lastName, a.city, a.state FROM Person p LEFT JOIN Address a 
ON p.personId = a.personId;
```

## 📊 **ASCII Representation**

N/A - This problem does not involve grids or trees. It's a database query problem.

## 📊 **WORKING**

Let's illustrate how the query works with the sample input:

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

1.  The `LEFT JOIN` starts with the `Person` table.
2.  For the first row in `Person` (personId = 1, firstName = Allen, lastName = Wang), it tries to find a matching `personId` in the `Address` table.
3.  It finds no match, so it includes Allen Wang and `NULL` for city and state.
4.  For the second row in `Person` (personId = 2, firstName = Bob, lastName = Alice), it finds a matching `personId = 2` in the `Address` table.
5.  It includes Bob Alice along with New York City and New York from the `Address` table.

**Final Result:**

| firstName | lastName | city | state |
|---|---|---|---|
| Allen | Wang | NULL | NULL |
| Bob | Alice | New York City | New York |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N + M)**, where N is the number of rows in the `Person` table and M is the number of rows in the `Address` table.  This is due to the `LEFT JOIN` operation, which needs to iterate through both tables. The database system optimizes the join operation, so the practical performance might be better depending on indexing.
*   **Space Complexity:** The space complexity depends on the size of the result set. In the worst-case scenario, where every person has an address, the space complexity is **O(N)**, where N is the number of rows in the `Person` table, as we are storing the combined data for each person.
    