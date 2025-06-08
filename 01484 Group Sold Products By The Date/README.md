# 01484 - Group Sold Products By The Date
    
**Language:** Mysql  
**Runtime:** 540 ms (Beats 13.68% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The problem requires us to group sold products by the date they were sold. For each date, we need to find the number of distinct products sold and list those products in lexicographical order, separated by commas.

**Example:**

**Input:**

`Activities` table:

| sell_date  | product |
|------------|---------|
| 2020-05-30 | Headphone |
| 2020-06-01 | Pencil |
| 2020-06-02 | Mask |
| 2020-05-30 | Basketball |
| 2020-06-01 | Pen |
| 2020-05-30 | Headphone |

**Output:**

| sell_date  | num_sold | products           |
|------------|----------|--------------------|
| 2020-05-30 | 2        | Basketball,Headphone |
| 2020-06-01 | 2        | Pen,Pencil         |
| 2020-06-02 | 1        | Mask               |

## 📊 **Algorithm**

*   Group the `Activities` table by `sell_date`.
*   For each `sell_date`, count the distinct products sold.
*   For each `sell_date`, concatenate the distinct products in lexicographical order, separated by commas.
*   Order the result by `sell_date`.

## 🔥 **Code Implementation**

```mysql
SELECT sell_date,
    COUNT(DISTINCT(PRODUCT)) AS "num_sold",
    GROUP_CONCAT(
        -- U DONT NEED TO MENTION 'SELECT'
        DISTINCT PRODUCT
        ORDER BY PRODUCT
        SEPARATOR ",") AS "products"
FROM ACTIVITIES
GROUP BY SELL_DATE
ORDER BY SELL_DATE
```

## 📊 **ASCII Representation**

```
Activities Table:

+------------+-----------+
| sell_date  | product   |
+------------+-----------+
| 2020-05-30 | Headphone |
| 2020-06-01 | Pencil    |
| 2020-06-02 | Mask      |
| 2020-05-30 | Basketball|
| 2020-06-01 | Pen       |
| 2020-05-30 | Headphone |
+------------+-----------+
```

## 📊 **WORKING**

Let's trace the execution of the SQL query on the provided sample input.

1.  **Initial Table:**

    ```
    Activities Table:
    +------------+-----------+
    | sell_date  | product   |
    +------------+-----------+
    | 2020-05-30 | Headphone |
    | 2020-06-01 | Pencil    |
    | 2020-06-02 | Mask      |
    | 2020-05-30 | Basketball|
    | 2020-06-01 | Pen       |
    | 2020-05-30 | Headphone |
    +------------+-----------+
    ```

2.  **Grouping by `sell_date`:**

    The `GROUP BY SELL_DATE` clause groups the rows based on the `sell_date`.

3.  **Calculating `num_sold` and `products`:**

    For each group, the following operations are performed:
    *   `COUNT(DISTINCT(PRODUCT))` calculates the number of distinct products.
    *   `GROUP_CONCAT(DISTINCT PRODUCT ORDER BY PRODUCT SEPARATOR ",")` concatenates the distinct products, ordered lexicographically, separated by commas.

4.  **Result for `2020-05-30`:**
    *   Distinct products: "Headphone", "Basketball"
    *   `num_sold`: 2
    *   `products`: "Basketball,Headphone"

5.  **Result for `2020-06-01`:**
    *   Distinct products: "Pencil", "Pen"
    *   `num_sold`: 2
    *   `products`: "Pen,Pencil"

6.  **Result for `2020-06-02`:**
    *   Distinct products: "Mask"
    *   `num_sold`: 1
    *   `products`: "Mask"

7.  **Ordering by `sell_date`:**

    The final result is ordered by `sell_date`.

8.  **Final Result Table:**

    ```
    +------------+----------+--------------------+
    | sell_date  | num_sold | products           |
    +------------+----------+--------------------+
    | 2020-05-30 | 2        | Basketball,Headphone |
    | 2020-06-01 | 2        | Pen,Pencil         |
    | 2020-06-02 | 1        | Mask               |
    +------------+----------+--------------------+
    ```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the grouping and sorting operations.  In the worst case, if all rows have different `sell_date` values, the `GROUP BY` operation will take **O(N log N)** time, where N is the number of rows in the `Activities` table, mainly due to sorting or hash table operations during grouping.  The `GROUP_CONCAT` operation also contributes to the time complexity, especially the `ORDER BY` clause within it, which can take **O(M log M)** time for each group, where M is the number of distinct products for that `sell_date`. The ordering of the final result by `sell_date` also contributes **O(K log K)**, where K is the number of distinct `sell_date`. Combining these, the overall time complexity is approximately **O(N log N + K * (M log M))**, where K is the number of distinct `sell_date`, and M is the maximum number of distinct products sold on a single day.

*   **Space Complexity:** The space complexity mainly depends on the size of the intermediate data structures used for grouping and concatenation. The distinct products for each date are stored, leading to a space complexity of **O(N)** in the worst-case scenario where there are a large number of distinct products. Additionally, the temporary space used for sorting during `GROUP BY` and `GROUP_CONCAT` contributes to the space complexity. Thus, the overall space complexity is **O(N)**.
    