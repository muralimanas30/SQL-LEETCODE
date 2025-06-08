# 01174 - Sales Analysis Iii
    
**Language:** Mysql  
**Runtime:** 1005 ms (Beats 99.67% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1174 | Sales Analysis III | [LeetCode Problem](https://leetcode.com/problems/sales-analysis-iii/) |

---

## 💡 **Problem Explanation**

The problem requires us to find the product IDs and names of products that were sold only within the first quarter of 2019 (i.e., between January 1, 2019, and March 31, 2019). This means we need to identify products that had sales records within this date range but no sales records outside of it.

**Sample Input:**

`Product` table:

| product_id | product_name |
|------------|--------------|
| 1          | S8           |
| 2          | iPhone       |
| 3          | Samsung      |

`Sales` table:

| sale_id | product_id | sale_date  | quantity | price |
|---------|------------|------------|----------|-------|
| 1       | 1          | 2019-01-21 | 2        | 2000  |
| 2       | 1          | 2019-02-17 | 1        | 2000  |
| 3       | 2          | 2019-06-02 | 1        | 800   |
| 4       | 2          | 2019-05-30 | 2        | 700   |
| 5       | 3          | 2019-03-15 | 1        | 700   |

**Expected Output:**

| product_id | product_name |
|------------|--------------|
| 1          | S8           |
| 3          | Samsung      |

Product 'S8' (product_id 1) and 'Samsung' (product_id 3) were sold only during the first quarter of 2019. 'iPhone' (product_id 2) was sold outside this period, so it's excluded.

## 📊 **Algorithm**

*   **Step 1:** Select distinct `product_id` and `product_name` from the `Product` table.
*   **Step 2:** Join `Product` and `Sales` tables on `product_id`.
*   **Step 3:** Filter sales records to include only those within the first quarter of 2019 (`2019-01-01` to `2019-03-31`).
*   **Step 4:** Exclude `product_id` values that have sales records outside the first quarter of 2019 using a subquery. The subquery identifies all `product_id` values from `Sales` table where the `sale_date` is either before `2019-01-01` or after `2019-03-31`.

## 🔥 **Code Implementation**

```mysql
SELECT DISTINCT P.product_id, P.product_name
FROM Product P
JOIN Sales S
  ON P.product_id = S.product_id
WHERE S.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
  AND P.product_id NOT IN (
    SELECT product_id
    FROM Sales
    WHERE sale_date < '2019-01-01' OR sale_date > '2019-03-31'
  );
```

## 📊 **ASCII Representation**

```
Product Table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
|     1      |      S8      |
|     2      |    iPhone    |
|     3      |   Samsung    |
+------------+--------------+

Sales Table:
+---------+------------+------------+----------+-------+
| sale_id | product_id | sale_date  | quantity | price |
+---------+------------+------------+----------+-------+
|    1    |      1     | 2019-01-21 |     2    |  2000 |
|    2    |      1     | 2019-02-17 |     1    |  2000 |
|    3    |      2     | 2019-06-02 |     1    |   800 |
|    4    |      2     | 2019-05-30 |     2    |   700 |
|    5    |      3     | 2019-03-15 |     1    |   700 |
+---------+------------+------------+----------+-------+
```

## 📊 **WORKING**

Let's trace the execution with the provided sample input:

1.  **Subquery Evaluation:**

    *   The subquery `SELECT product_id FROM Sales WHERE sale_date < '2019-01-01' OR sale_date > '2019-03-31'` identifies `product_id` values with sales outside the first quarter of 2019.
    *   From the `Sales` table, `sale_id` 3 and 4 have `sale_date` values of `2019-06-02` and `2019-05-30`, respectively, which are outside the first quarter. Both correspond to `product_id` 2.
    *   Thus, the subquery returns `[2]`.

2.  **Main Query Evaluation:**

    *   The main query joins `Product` and `Sales` on `product_id`.
    *   It filters records where `sale_date` is between `'2019-01-01'` and `'2019-03-31'`.
    *   It further filters records where `product_id` is NOT IN the result of the subquery (i.e., not in `[2]`).
    *   The `JOIN` and `WHERE` clause yields the following intermediate result before applying the `NOT IN` condition:

        | product_id | product_name | sale_date  |
        |------------|--------------|------------|
        | 1          | S8           | 2019-01-21 |
        | 1          | S8           | 2019-02-17 |
        | 3          | Samsung      | 2019-03-15 |

    *   Applying the `NOT IN (2)` condition excludes any product with `product_id = 2`.  Since the subquery returned only `2`, this has the desired effect.
    *   Finally, `SELECT DISTINCT` ensures we get each `product_id` and `product_name` only once.
    *   The query returns:

        | product_id | product_name |
        |------------|--------------|
        | 1          | S8           |
        | 3          | Samsung      |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the join and the subquery. The join of `Product` and `Sales` tables has a complexity of **O(P\*S)**, where P and S are the sizes of `Product` and `Sales` tables, respectively.  The subquery iterates through the `Sales` table, giving it a complexity of **O(S)**. The overall time complexity is approximately **O(P\*S)**.

*   **Space Complexity:** The space complexity depends on the size of the intermediate result set produced by the join and subquery. In the worst case, it can be proportional to the size of the `Sales` table, resulting in **O(S)** space complexity. The space required for the subquery is also **O(S)** in the worst case where all `product_id` values need to be stored. The space complexity is therefore approximately **O(S)**.
    