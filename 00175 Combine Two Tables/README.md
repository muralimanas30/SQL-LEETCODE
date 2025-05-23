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

The problem asks us to combine data from two tables, `Person` and `Address`, based on the `personId`. Specifically, we want to retrieve the `firstName`, `lastName` from the `Person` table along with the `city` and `state` from the `Address` table. The catch is that not every person might have an address listed in the `Address` table, so we need to ensure we include all people, even those without address information.  If a `personId` in `Person` does not have corresponding `personId` in `Address`, display NULL.

**Example:**

**Person Table:**

| personId | lastName | firstName |
|----------|----------|-----------|
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |

**Address Table:**

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

*   Use a `LEFT JOIN` to include all rows from the `Person` table, regardless of whether there is a matching entry in the `Address` table.
*   Specify the join condition as `p.personId = a.personId`, where `p` is an alias for the `Person` table and `a` is an alias for the `Address` table.
*   Select the desired columns: `firstName`, `lastName` from `Person` and `city`, `state` from `Address`.
*   If a person doesn't have an address, the `city` and `state` columns will be `NULL` in the result.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT p.firstName, p.lastName, a.city, a.state FROM Person p LEFT JOIN Address a 
ON p.personId = a.personId;
```

---

## 📊 **ASCII Representation**

Since this problem involves tables and not grids or movements, an ASCII representation of the data relationship can be visualized as follows:

```
Person Table           Address Table
+----------+        +----------+
| personId |------->| personId |
+----------+        +----------+
| firstName|        | city     |
+----------+        +----------+
| lastName |        | state    |
+----------+        +----------+
```

---

## 📊 **WORKING

Given the sample inputs, here's how the query works step-by-step:

1.  **Initial Tables:**  We start with the `Person` and `Address` tables as described in the Problem Explanation.

2.  **LEFT JOIN:**  The `LEFT JOIN` ensures that every row from the `Person` table is included in the result.

3.  **Join Condition:** The `ON p.personId = a.personId` condition links the tables based on matching `personId` values.

4.  **Result Generation:**

    *   For `personId = 1` (Allen Wang), there is no matching entry in the `Address` table. Therefore, the `city` and `state` will be `NULL`.

    *   For `personId = 2` (Bob Alice), there is a matching entry in the `Address` table. Therefore, the `city` and `state` will be 'New York' and 'New York' respectively.

5.  **Final Output:** The query returns the combined data as specified in the problem description.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N + M)**, where N is the number of rows in the `Person` table and M is the number of rows in the `Address` table. This is because, in the worst case, the database might need to scan both tables.  The performance heavily depends on indexing. If `personId` is indexed in both tables, the join operation can be significantly faster.

*   **Space Complexity:** The space complexity is **O(K)**, where K is the number of rows in the output.  In the worst-case scenario, where every person has an address, K would be equal to the number of people (N). The space is used to store the result set.
    