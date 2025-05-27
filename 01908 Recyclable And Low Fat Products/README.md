# 01908 - Recyclable And Low Fat Products
    
**Language:** Mysql  
**Runtime:** 1172 ms (Beats 5.01% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1908 | Recyclable and Low Fat Products | [LeetCode Problem](https://leetcode.com/problems/recyclable-and-low-fat-products/) |

---

## 💡 **Problem Explanation**

The problem requires you to identify products from a `Products` table that are both low fat and recyclable.  Essentially, you need to filter the table based on two conditions: the `low_fats` column should have a value of 'Y', and the `recyclable` column should also have a value of 'Y'. The output should be a list of `product_id`s that meet these criteria.

**Example:**

Assume we have the following `Products` table:

| product_id | low_fats | recyclable |
|------------|----------|------------|
| 0          | Y        | N          |
| 1          | Y        | Y          |
| 2          | N        | Y          |
| 3          | Y        | Y          |
| 4          | N        | N          |

The query should return `product_id`s 1 and 3 because these are the only products that are both low fat ('Y') and recyclable ('Y').

## 📊 **Algorithm**

*   Select the `product_id` column.
*   Filter the `Products` table.
*   Apply the conditions: `low_fats = 'Y'` and `recyclable = 'Y'`.

## 🔥 **Code Implementation**

```mysql
SELECT product_id
FROM Products
WHERE low_fats='Y' AND recyclable='Y';
```

## 📊 **WORKING**

Let's trace the query execution with the sample data:

| product_id | low_fats | recyclable | Condition (low_fats='Y' AND recyclable='Y') | Result |
|------------|----------|------------|-------------------------------------------------|--------|
| 0          | Y        | N          | Y AND N = N                                     | Excluded |
| 1          | Y        | Y          | Y AND Y = Y                                     | Included |
| 2          | N        | Y          | N AND Y = N                                     | Excluded |
| 3          | Y        | Y          | Y AND Y = Y                                     | Included |
| 4          | N        | N          | N AND N = N                                     | Excluded |

The query filters the table, keeping only rows where both `low_fats` and `recyclable` are 'Y'.  Therefore, `product_id`s 1 and 3 are returned.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(n)**, where n is the number of rows in the `Products` table. This is because the query needs to scan each row to check the conditions.
*   **Space Complexity:** The space complexity is **O(1)**, as the query uses a constant amount of extra space, regardless of the size of the input table. The space required is for storing the result set, which in the worst case can be proportional to the input size, but the core filtering operation uses constant space.
    