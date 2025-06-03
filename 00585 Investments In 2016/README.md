# 00585 - Investments In 2016
    
**Language:** Mysql  
**Runtime:** 534 ms (Beats 62.71% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title             | 🔗 Link                                                        |
|------------------|----------------------|----------------------------------------------------------------|
| 585              | Investments in 2016 | [LeetCode Problem](https://leetcode.com/problems/investments-in-2016/) |

---

## 💡 **Problem Explanation**

The problem asks us to find the total investment value in 2016 (TIV_2016) for all records in the `INSURANCE` table that satisfy two conditions:

1.  The location (LAT, LON) is unique, meaning no other record has the exact same latitude and longitude.
2.  The investment value in 2015 (TIV_2015) is not unique, meaning at least one other record has the same TIV_2015 value.

Let's consider a sample table:

**Input Table: `INSURANCE`**

| PID | TIV_2015 | TIV_2016 | LAT | LON |
|-----|----------|----------|-----|-----|
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 10       | 20  | 20  |
| 3   | 10       | 20       | 10  | 10  |
| 4   | 10       | 30       | 30  | 30  |
| 5   | 20       | 40       | 40  | 40  |

Based on this input:

*   (LAT, LON) = (10, 10) appears twice, so PIDs 1 and 3 do not meet the first condition.  All other (LAT,LON) meet the first condition
*   TIV\_2015 = 10 appears three times and TIV\_2015 = 20 appears twice, so PIDs 1, 2, 3, 4, 5 meet the second condition.

Records 2, 4 and 5 are the only ones which meet both conditions.

The TIV\_2016 values for these records are 10, 30, and 40.  The sum is 80.

**Output:**

```
TIV_2016
80.00
```

---

## 📊 **Algorithm**

*   **Step 1: Find Unique Locations:** Identify all records where the combination of `LAT` and `LON` appears only once in the `INSURANCE` table.
*   **Step 2: Find Non-Unique TIV_2015 Values:** Identify all records where the `TIV_2015` value appears more than once in the `INSURANCE` table.
*   **Step 3: Combine Conditions:** Select records that satisfy both the unique location condition (Step 1) and the non-unique `TIV_2015` condition (Step 2).
*   **Step 4: Calculate Sum:** Calculate the sum of the `TIV_2016` values for the selected records.
*   **Step 5: Round Result:** Round the sum to two decimal places.

---

## 🔥 **Code Implementation**

```mysql
SELECT 
    ROUND(SUM(TIV_2016), 2) AS TIV_2016
FROM INSURANCE
WHERE (LAT, LON) IN (
    SELECT LAT, LON
    FROM INSURANCE
    GROUP BY LAT, LON
    HAVING COUNT(*) = 1
) AND TIV_2015 IN (
    SELECT TIV_2015
    FROM INSURANCE
    GROUP BY TIV_2015
    HAVING COUNT(*)>1
)
```

---

## 📊 **ASCII Representation**

Here's a simplified representation of the INSURANCE table:

```
+---------+----------+----------+-----+-----+
|   PID   | TIV_2015 | TIV_2016 | LAT | LON |
+---------+----------+----------+-----+-----+
|   ...   |   ...    |   ...    | ... | ... |
+---------+----------+----------+-----+-----+
```

The query works by:

1.  Filtering based on LAT/LON uniqueness.
2.  Filtering based on TIV\_2015 non-uniqueness.
3.  Summing the `TIV_2016` values of the remaining rows.

---

## 📊 **WORKING**

Let's walk through how the query operates with the sample data provided earlier:

**Input Table: `INSURANCE`**

| PID | TIV_2015 | TIV_2016 | LAT | LON |
|-----|----------|----------|-----|-----|
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 10       | 20  | 20  |
| 3   | 10       | 20       | 10  | 10  |
| 4   | 10       | 30       | 30  | 30  |
| 5   | 20       | 40       | 40  | 40  |

**1. Subquery to Find Unique Locations:**

```sql
SELECT LAT, LON
FROM INSURANCE
GROUP BY LAT, LON
HAVING COUNT(*) = 1
```

This subquery returns the following (LAT, LON) combinations:

| LAT | LON |
|-----|-----|
| 20  | 20  |
| 30  | 30  |
| 40  | 40  |

**2. Subquery to Find Non-Unique TIV\_2015 Values:**

```sql
SELECT TIV_2015
FROM INSURANCE
GROUP BY TIV_2015
HAVING COUNT(*) > 1
```

This subquery returns the following `TIV_2015` values:

| TIV\_2015 |
|-----------|
| 10        |
| 20        |

**3. Applying the `WHERE` Clause:**

The `WHERE` clause combines the results of these subqueries:

```sql
WHERE (LAT, LON) IN (...) AND TIV_2015 IN (...)
```

It filters the `INSURANCE` table, keeping only the rows where:

*   `(LAT, LON)` is one of (20, 20), (30, 30), or (40, 40).
*   `TIV_2015` is either 10 or 20.

This leaves us with rows 2, 4, and 5.

**4. Calculating the Sum of `TIV_2016`:**

The `SUM(TIV_2016)` function calculates the sum of the `TIV_2016` values for the remaining rows (2, 4, and 5):  10 + 30 + 40 = 80.

**5. Rounding:**

The `ROUND(..., 2)` function rounds the result to two decimal places, yielding 80.00.

Therefore, the query returns:

```
TIV_2016
80.00
```

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The query involves two subqueries, each grouping by columns and potentially scanning the entire table. Therefore, the overall time complexity is approximately **O(n)**, where n is the number of rows in the `INSURANCE` table, assuming the database system is optimized.
*   **Space Complexity:** The space complexity depends on the size of the intermediate results of the subqueries. In the worst case, the subqueries might need to store a significant portion of the table data in memory.  Therefore, the space complexity is approximately **O(n)** in the worst case.
    