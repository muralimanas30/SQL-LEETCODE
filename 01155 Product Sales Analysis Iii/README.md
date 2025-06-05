# 01155 - Product Sales Analysis Iii
    
**Language:** Mysql  
**Runtime:** 664 ms (Beats 99.10% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1155 | Product Sales Analysis III | [LeetCode Problem](https://leetcode.com/problems/product-sales-analysis-iii/) |

---

## 💡 **Problem Explanation**

The problem asks us to find the `product_id`, `first_year`, `quantity`, and `price` for each product's first sale year. In simpler terms, for every product, we need to determine the earliest year it was sold and then retrieve the sales details for that specific year.

**Sample Input:**

`Sales` table:

| sale_id | product_id | year | quantity | price |
|---------|------------|------|----------|-------|
| 1       | 100        | 2008 | 10       | 3000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 100        | 2010 | 15       | 7000  |
| 4       | 100        | 2007 | 11       | 4000  |
| 5       | 200        | 2010 | 10       | 4000  |
| 6       | 200        | 2009 | 10       | 3000  |

**Expected Output:**

| product_id | first_year | quantity | price |
|------------|------------|----------|-------|
| 100        | 2007       | 11       | 4000  |
| 200        | 2009       | 10       | 3000  |

---

## 📊 **Algorithm**

*   Find the minimum `year` for each `product_id` using a subquery.
*   Select `product_id`, `year`, `quantity`, and `price` from the `Sales` table where the `(product_id, year)` combination exists in the result of the subquery.

---

## 🔥 **Code Implementation**

```mysql
select product_id,year as first_year,quantity,price
from sales where (product_id,year) in
(
    select product_id,min(year)
    from sales
    group by product_id
)
```

---

## 📊 **ASCII Representation**

```
Table: Sales

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| sale_id     | int     |
| product_id  | int     |
| year        | int     |
| quantity    | int     |
| price       | int     |
+-------------+---------+
```

---

## 📊 **WORKING**

Let's trace the query with the sample input.

1.  **Subquery:**

    ```sql
    select product_id,min(year)
    from sales
    group by product_id
    ```

    This subquery groups the `Sales` table by `product_id` and finds the minimum `year` for each product.

    Result:

    | product_id | min(year) |
    |------------|-----------|
    | 100        | 2007      |
    | 200        | 2009      |

2.  **Main Query:**

    ```sql
    select product_id,year as first_year,quantity,price
    from sales where (product_id,year) in
    (
        select product_id,min(year)
        from sales
        group by product_id
    )
    ```

    The main query selects rows from the `Sales` table where the `(product_id, year)` combination exists in the subquery result.

    -   For `product_id = 100`, it checks `(100, 2008)`, `(100, 2009)`, `(100, 2010)`, `(100, 2007)`. Only `(100, 2007)` exists in the subquery result.
    -   For `product_id = 200`, it checks `(200, 2010)`, `(200, 2009)`. Only `(200, 2009)` exists in the subquery result.

    Final Result:

    | product_id | first_year | quantity | price |
    |------------|------------|----------|-------|
    | 100        | 2007       | 11       | 4000  |
    | 200        | 2009       | 10       | 3000  |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The subquery takes O(N) time, where N is the number of rows in the Sales table, due to the `GROUP BY` operation. The main query also takes O(N) time in the worst case to iterate through the Sales table and compare the `(product_id, year)` pairs. Therefore, the overall time complexity is **O(N)**.

*   **Space Complexity:** The space complexity is mainly determined by the space required to store the intermediate results of the subquery. In the worst case, the subquery might return one row for each `product_id`, so the space complexity is **O(P)**, where P is the number of distinct products.
    