# 00595 - Big Countries
    
**Language:** Mysql  
**Runtime:** 296 ms (Beats 27.41% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title       | 🔗 Link                                                        |
| ------------------ | --------------- | ------------------------------------------------------------- |
| 595                | Big Countries | [LeetCode Problem](https://leetcode.com/problems/big-countries/) |

---

## 💡 **Problem Explanation**

The "Big Countries" problem asks us to identify countries from a `WORLD` table that are considered "big" based on two criteria:

1.  Having an area of at least 3 million square kilometers.
2.  Having a population of at least 25 million.

We need to write a SQL query that returns the `name`, `population`, and `area` for these big countries.

**Example:**

Let's say our `WORLD` table looks like this:

| name        | continent   | area      | population | gdp       |
| ----------- | ----------- | --------- | ---------- | --------- |
| Afghanistan | Asia        | 652230    | 32566000   | 59430000  |
| Albania     | Europe      | 28748     | 2831000    | 12960000  |
| Algeria     | Africa      | 2381741   | 39208000   | 127600000 |
| Andorra     | Europe      | 468       | 78000      | 3712000   |
| Angola      | Africa      | 1246700   | 21472000   | 103000000 |

The expected output would be:

| name        | population | area      |
| ----------- | ---------- | --------- |
| Afghanistan | 32566000   | 652230    |
| Algeria     | 39208000   | 2381741   |

Because Afghanistan's population is >= 25 million and Algeria's population is >= 25 million.

## 📊 **Algorithm**

*   Select the `name`, `population`, and `area` columns.
*   Filter the rows from the `WORLD` table based on the condition: `AREA >= 3000000 OR POPULATION >= 25000000`.

## 🔥 **Code Implementation**

```mysql
SELECT name,population,area
FROM WORLD
WHERE AREA>=3000000 OR POPULATION>=25000000;
```

## 📊 **ASCII Representation**

Since this is a database query, there's no direct grid-based representation.  However, we can visualize the WORLD table structure like this:

```
+-------------+-----------+----------+------------+----------+
| name        | continent | area     | population | gdp      |
+-------------+-----------+----------+------------+----------+
| Afghanistan | Asia      | 652230   | 32566000   | 59430000 |
| Albania     | Europe    | 28748    | 2831000    | 12960000 |
| Algeria     | Africa    | 2381741  | 39208000   | 127600000|
| ...         | ...       | ...      | ...        | ...      |
+-------------+-----------+----------+------------+----------+
```

## 📊 **WORKING**

Let's trace the execution of our SQL query against the sample `WORLD` table:

1.  **`SELECT name, population, area`**:  We specify that we only want these columns in our result.
2.  **`FROM WORLD`**:  We're querying the `WORLD` table.
3.  **`WHERE AREA >= 3000000 OR POPULATION >= 25000000`**:
    *   For Afghanistan:  `area = 652230`, `population = 32566000`.
        *   `652230 >= 3000000` is FALSE.
        *   `32566000 >= 25000000` is TRUE.
        *   Since `FALSE OR TRUE` is TRUE, Afghanistan is included.
    *   For Albania: `area = 28748`, `population = 2831000`.
        *   `28748 >= 3000000` is FALSE.
        *   `2831000 >= 25000000` is FALSE.
        *   Since `FALSE OR FALSE` is FALSE, Albania is excluded.
    *   For Algeria: `area = 2381741`, `population = 39208000`.
        *   `2381741 >= 3000000` is FALSE.
        *   `39208000 >= 25000000` is TRUE.
        *   Since `FALSE OR TRUE` is TRUE, Algeria is included.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N)**, where N is the number of rows in the `WORLD` table. This is because the `WHERE` clause potentially needs to examine each row.
*   **Space Complexity:** The space complexity is **O(M)**, where M is the number of "big countries" that satisfy the condition.  This is the space required to store the result set. In the worst case (if all countries are big), M could be equal to N.
    