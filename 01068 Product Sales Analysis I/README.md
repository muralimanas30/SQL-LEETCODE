# 01068 - Product Sales Analysis I
    
**Language:** Mysql  
**Runtime:** 1122 ms (Beats 97.35% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1068 | Product Sales Analysis I | [LeetCode Problem](https://leetcode.com/problems/product-sales-analysis-i/) |

---

## 💡 **Problem Explanation**

The problem requires us to write an SQL query that reports the `product_name`, `year`, and `price` for each sale in the `Sales` table. We need to join the `Sales` table with the `Product` table to get the `product_name` using the `product_id`.

**Example:**

**Input:**

`Sales` table:
| sale_id | product_id | year | quantity | price |
|---------|------------|------|----------|-------|
| 1       | 100        | 2008 | 10       | 30    |
| 2       | 100        | 2009 | 12       | 34    |
| 7       | 200        | 2011 | 15       | 15    |

`Product` table:
| product_id | product_name |
|------------|--------------|
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |

**Output:**

| product_name | year | price |
|--------------|------|-------|
| Nokia        | 2008 | 30    |
| Nokia        | 2009 | 34    |
| Apple        | 2011 | 15    |

## 📊 **Algorithm**

*   Join the `Sales` table with the `Product` table using the `product_id` as the joining key.
*   Select the `product_name` from the `Product` table.
*   Select the `year` from the `Sales` table.
*   Select the `price` from the `Sales` table.

## 🔥 **Code Implementation**

```mysql
SELECT p.product_name,a.year,a.price
from sales a
join product p
on a.product_id = p.product_id
```

## 📊 **ASCII Representation**

```
+-------------+         +-----------+
| Sales       |         | Product   |
+-------------+         +-----------+
| sale_id     |         | product_id|
| product_id  |------>| product_name|
| year        |         +-----------+
| quantity    |
| price       |
+-------------+
```

## 📊 **WORKING**

Let's consider the sample input given in the Problem Explanation.

**Sales Table:**

| sale_id | product_id | year | quantity | price |
|---------|------------|------|----------|-------|
| 1       | 100        | 2008 | 10       | 30    |
| 2       | 100        | 2009 | 12       | 34    |
| 7       | 200        | 2011 | 15       | 15    |

**Product Table:**

| product_id | product_name |
|------------|--------------|
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |

1.  **Join Operation:**
    The SQL query joins the `Sales` and `Product` tables on the `product_id`.

2.  **Result of Join:**

| sale_id | product_id | year | quantity | price | product_name |
|---------|------------|------|----------|-------|--------------|
| 1       | 100        | 2008 | 10       | 30    | Nokia        |
| 2       | 100        | 2009 | 12       | 34    | Nokia        |
| 7       | 200        | 2011 | 15       | 15    | Apple        |

3.  **Selection:**
    The query selects `product_name`, `year`, and `price` from the joined table.

4.  **Output:**

| product_name | year | price |
|--------------|------|-------|
| Nokia        | 2008 | 30    |
| Nokia        | 2009 | 34    |
| Apple        | 2011 | 15    |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N + M)**, where N is the number of rows in the `Sales` table and M is the number of rows in the `Product` table. This is because the join operation generally has a time complexity dependent on the sizes of both tables being joined.
*   **Space Complexity:** The space complexity is **O(N + M)** in the worst-case scenario, as the joined table could potentially contain all rows from both tables.
    