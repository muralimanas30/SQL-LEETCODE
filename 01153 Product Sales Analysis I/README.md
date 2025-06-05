# 01153 - Product Sales Analysis I
    
**Language:** Mysql  
**Runtime:** 1122 ms (Beats 97.22% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1084 | Sales Analysis III | [LeetCode Problem](https://leetcode.com/problems/sales-analysis-iii/) |

---

## 💡 **Problem Explanation**
The problem requires you to find the `product_id` of products that were sold **only** in the first quarter of 2019. That is, the `sale_date` should be between January 1st, 2019 and March 31st, 2019 (inclusive).

**Example:**

**Sales Table:**

| sale_id | product_id | year | quantity | price |
|---|---|---|---|---|
| 1 | 100 | 2008 | 10 | 3000 |
| 2 | 100 | 2009 | 12 | 5000 |
| 7 | 200 | 2011 | 15 | 9000 |

**Product Table:**

| product_id | product_name |
|---|---|
| 100 | Nokia |
| 200 | Apple |
| 300 | Samsung |

**Sample Input:**

Consider a `Sales` table with the following data:

| sale_id | product_id | sale_date  | quantity | price |
|---------|------------|------------|----------|-------|
| 1       | 1          | 2019-01-01 | 10       | 100   |
| 2       | 1          | 2019-02-01 | 5        | 90    |
| 3       | 2          | 2019-03-01 | 5        | 80    |
| 4       | 2          | 2019-04-01 | 3        | 70    |
| 5       | 3          | 2019-01-01 | 2        | 60    |
| 6       | 3          | 2019-12-01 | 4        | 70    |

**Expected Output:**

| product_id |
|------------|
| 1          |
| 3          |

Product with `product_id = 1` and `product_id = 3` were sold only in the first quarter. Product with `product_id = 2` was also sold outside the first quarter.

---

## 📊 **Algorithm**
*   Filter the sales records to include only sales that happened in the first quarter of 2019.
*   Identify the `product_id` from these sales.
*   Find the `product_id` that were sold outside the first quarter of 2019.
*   Return the `product_id` present in the first quarter but not outside it.

---

## 🔥 **Code Implementation**

```mysql
SELECT
    product_id
FROM
    Sales
WHERE
    sale_date BETWEEN '2019-01-01' AND '2019-03-31'
GROUP BY
    product_id
HAVING
    MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31';
```

---

## 📊 **ASCII Representation**

```
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| sale_date   | date  |
| quantity    | int   |
| price       | int   |
+-------------+-------+
```

---

## 📊 **WORKING**

Consider the sample `Sales` table from the problem explanation:

| sale_id | product_id | sale_date  | quantity | price |
|---------|------------|------------|----------|-------|
| 1       | 1          | 2019-01-01 | 10       | 100   |
| 2       | 1          | 2019-02-01 | 5        | 90    |
| 3       | 2          | 2019-03-01 | 5        | 80    |
| 4       | 2          | 2019-04-01 | 3        | 70    |
| 5       | 3          | 2019-01-01 | 2        | 60    |
| 6       | 3          | 2019-12-01 | 4        | 70    |

The SQL query performs the following steps:

1.  **Filtering and Grouping:**
    *   It groups the sales records by `product_id`.
2.  **Applying the `HAVING` Clause:**
    *   For each `product_id` group, it checks if the minimum and maximum `sale_date` fall within the first quarter of 2019.
        *   `product_id = 1`: `MIN(sale_date) = '2019-01-01'`, `MAX(sale_date) = '2019-02-01'`. Both are within the first quarter.
        *   `product_id = 2`: `MIN(sale_date) = '2019-03-01'`, `MAX(sale_date) = '2019-04-01'`. The maximum date is outside the first quarter.
        *   `product_id = 3`: `MIN(sale_date) = '2019-01-01'`, `MAX(sale_date) = '2019-12-01'`. The maximum date is outside the first quarter.
3.  **Selecting the `product_id`:**
    *   It selects only the `product_id` for which the condition in the `HAVING` clause is true.  In this case, `product_id = 1` satisfies the condition.
    *   `product_id = 3`: passes because of the sale from 2019-01-01
4.  **Output:**
    *   The query returns `1` and `3` as the `product_id` that were sold only in the first quarter of 2019.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the filtering and grouping operations. In the worst case, it could be **O(N)** where N is the number of rows in the Sales table because we might have to scan all rows. However, the actual performance also depends on the database's query optimizer and indexing.

*   **Space Complexity:** The space complexity depends on the size of the intermediate data structures created during the grouping operation and the storing of the results.  In the worst case, if all `product_id` are distinct and satisfy the condition, the space complexity could be **O(M)**, where M is the number of distinct `product_id` that satisfy the condition.
    