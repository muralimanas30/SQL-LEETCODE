# 00619 - Biggest Single Number
    
**Language:** Mysql  
**Runtime:** 434 ms (Beats 57.06% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 619 | BIGGEST SINGLE NUMBER | [LeetCode Problem](https://leetcode.com/problems/biggest-single-number/) |

---

## 💡 **Problem Explanation**

The problem asks us to find the largest number that appears only once in a table named `MyNumbers`. If no such number exists, we should return `NULL`.

**Example:**

Consider the following `MyNumbers` table:

| num |
|-----|
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |

The numbers 1, 4, 5 and 6 appear only once. The largest of these numbers is 6. Thus, the output should be:

| num |
|-----|
| 6   |

If the table was:

| num |
|-----|
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |

No number appears only once. Thus, the output should be:

| num |
|-----|
| NULL |

## 📊 **Algorithm**
*   Group the numbers in `MyNumbers` table.
*   Count the occurrences of each number.
*   Filter out numbers that appear more than once, keeping only single occurrences.
*   Order the remaining numbers in descending order.
*   Select the largest number from the ordered list, using `LIMIT 1` to retrieve only one result.
*   If no number appears only once, the subquery will return an empty result set, which MySQL handles by returning `NULL` due to the outer `SELECT`.

## 🔥 **Code Implementation**

```mysql
SELECT (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
    ORDER BY num DESC
    LIMIT 1
) AS num;
```

## 📊 **ASCII Representation**

Since this problem is about SQL queries on a table and does not involve grids or trees, an ASCII representation is not applicable.

## 📊 **WORKING**

Let's trace the query with the following `MyNumbers` table:

| num |
|-----|
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |

1.  **`GROUP BY num`**: Groups identical numbers together.

2.  **`HAVING COUNT(*) = 1`**: Filters groups, keeping only numbers that appear exactly once.  The intermediate table would look conceptually like this (though it's not actually materialized this way):

    | num | count(*) |
    |-----|----------|
    | 1   | 1        |
    | 4   | 1        |
    | 5   | 1        |
    | 6   | 1        |

3.  **`ORDER BY num DESC`**: Orders the remaining numbers in descending order. The intermediate table will now be conceptually:

    | num | count(*) |
    |-----|----------|
    | 6   | 1        |
    | 5   | 1        |
    | 4   | 1        |
    | 1   | 1        |

4.  **`LIMIT 1`**: Selects only the first row, which contains the largest number.

5.  The outer `SELECT` then returns this largest number as `num`.

    | num |
    |-----|
    | 6   |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the `GROUP BY`, `HAVING`, and `ORDER BY` operations.  In the worst case, where all numbers are distinct, these operations take **O(n log n)** time, where n is the number of rows in `MyNumbers`.

*   **Space Complexity:** The space complexity is primarily determined by the storage required for the intermediate results of the `GROUP BY` operation. In the worst case, where all numbers are distinct, the space complexity is **O(n)**.
    