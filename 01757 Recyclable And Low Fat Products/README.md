# 01757 - Recyclable And Low Fat Products
    
**Language:** Mysql  
**Runtime:** 1172 ms (Beats 5.00% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The problem requires us to identify products that are both low fat and recyclable from a given product table. We need to select the `product_id` of these products.

**Example:**

Consider a `Products` table:

| product_id | low_fats | recyclable |
|------------|----------|------------|
| 0          | Y        | N          |
| 1          | Y        | Y          |
| 2          | N        | Y          |
| 3          | Y        | Y          |
| 4          | N        | N          |

The query should return:

| product_id |
|------------|
| 1          |
| 3          |

## 📊 **Algorithm**

*   Select the `product_id` from the `Products` table.
*   Filter the results to include only products where `low_fats` is 'Y' and `recyclable` is 'Y'.

## 🔥 **Code Implementation**

```mysql
SELECT product_id
FROM Products
WHERE low_fats='Y' AND recyclable='Y';
```

## 📊 **ASCII Representation**

Here's an ASCII representation of the `Products` table:

```
+------------+----------+------------+
| product_id | low_fats | recyclable |
+------------+----------+------------+
| 0          | Y        | N          |
| 1          | Y        | Y          |
| 2          | N        | Y          |
| 3          | Y        | Y          |
| 4          | N        | N          |
+------------+----------+------------+
```

## 📊 **WORKING**

Let's trace the query with the sample data:

1.  **Initial Table:**

    ```
    +------------+----------+------------+
    | product_id | low_fats | recyclable |
    +------------+----------+------------+
    | 0          | Y        | N          |
    | 1          | Y        | Y          |
    | 2          | N        | Y          |
    | 3          | Y        | Y          |
    | 4          | N        | N          |
    +------------+----------+------------+
    ```

2.  **Filtering:**

    The `WHERE` clause filters the table based on two conditions: `low_fats='Y'` and `recyclable='Y'`.

    *   Row 0: `low_fats='Y'` is true, but `recyclable='N'` is false. The row is excluded.
    *   Row 1: `low_fats='Y'` is true, and `recyclable='Y'` is true. The row is included.
    *   Row 2: `low_fats='N'` is false, so the row is excluded.
    *   Row 3: `low_fats='Y'` is true, and `recyclable='Y'` is true. The row is included.
    *   Row 4: `low_fats='N'` is false, so the row is excluded.

3.  **Final Result:**

    The query selects the `product_id` of the included rows.

    ```
    +------------+
    | product_id |
    +------------+
    | 1          |
    | 3          |
    +------------+
    ```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(n)**, where n is the number of rows in the `Products` table, as the query needs to scan each row to check the conditions.
*   **Space Complexity:** The space complexity is **O(m)**, where m is the number of products that satisfy both conditions (`low_fats='Y'` and `recyclable='Y'`). In the worst-case scenario (where all products satisfy the conditions), the space complexity would be **O(n)**.
    