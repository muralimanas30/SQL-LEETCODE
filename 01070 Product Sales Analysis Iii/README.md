# 01070 - Product Sales Analysis Iii
    
**Language:** Mysql  
**Runtime:** 664 ms (Beats 98.62% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The problem requires us to find the year in which each product was sold for the first time, along with the quantity and price of that sale. We need to output the `product_id`, the year as `first_year`, `quantity`, and `price` for each product's first sale year.

**Sample Input:**

`Sales` table:

| sale_id | product_id | year | quantity | price |
|---------|------------|------|----------|-------|
| 1       | 100        | 2008 | 10       | 3000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 3       | 200        | 2010 | 20       | 1000  |
| 4       | 200        | 2009 | 15       | 9000  |
| 5       | 300        | 2018 | 11       | 5000  |

**Sample Output:**

| product_id | first_year | quantity | price |
|------------|------------|----------|-------|
| 100        | 2008       | 10       | 3000  |
| 200        | 2009       | 15       | 9000  |
| 300        | 2018       | 11       | 5000  |

## 📊 **Algorithm**

*   The main idea is to select `product_id`, `year`, `quantity`, and `price` from the `Sales` table.
*   A subquery is used to determine the minimum (first) year for each `product_id`.
*   The `WHERE` clause filters the `Sales` table to include only the rows where the `(product_id, year)` combination matches the `(product_id, minimum year)` combination found in the subquery.
*   The result is aliased and selected to get the desired output.

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

## 📊 **ASCII Representation**

```
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

## 📊 **WORKING**

Let's walk through the execution with the sample input.

**1. Subquery Execution:**

```sql
select product_id,min(year)
from sales
group by product_id
```

This subquery groups the `Sales` table by `product_id` and finds the minimum year for each product.

| product_id | min(year) |
|------------|-----------|
| 100        | 2008      |
| 200        | 2009      |
| 300        | 2018      |

**2. Main Query Execution:**

```sql
select product_id,year as first_year,quantity,price
from sales
where (product_id,year) in
(
    select product_id,min(year)
    from sales
    group by product_id
)
```

The main query selects rows from the `Sales` table where the `(product_id, year)` combination exists in the result of the subquery.

*   For `product_id = 100`, it checks `(100, 2008)`, `(100, 2009)`.  Only `(100, 2008)` is in the subquery result.
*   For `product_id = 200`, it checks `(200, 2010)`, `(200, 2009)`.  Only `(200, 2009)` is in the subquery result.
*   For `product_id = 300`, it checks `(300, 2018)`.  `(300, 2018)` is in the subquery result.

Finally, it selects the desired columns to produce the final output.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The subquery iterates through the `Sales` table once to find the minimum year for each product which is O(N). The outer query iterates through the `Sales` table again but filters based on the subquery result O(N). Thus overall complexity becomes **O(N)**, where N is the number of rows in the `Sales` table.

*   **Space Complexity:** The subquery creates a temporary table to store the minimum year for each product. In the worst-case scenario, where each row has a distinct `product_id`, the space complexity of the temporary table would be O(N). The outer query doesn't introduce significant additional space complexity. Therefore, the overall space complexity is **O(N)**.
    