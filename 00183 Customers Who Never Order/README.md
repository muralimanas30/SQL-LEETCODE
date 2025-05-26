# 00183 - Customers Who Never Order
    
**Language:** Mysql  
**Runtime:** 557 ms (Beats 65.50% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                         | 🔗 Link                                                                 |
|------------------|---------------------------------|-------------------------------------------------------------------------|
| 183              | Customers Who Never Order         | [LeetCode Problem](https://leetcode.com/problems/customers-who-never-order/) |

---

## 💡 **Problem Explanation**

The problem requires us to find all customers who have never placed an order. We are given two tables: `Customers` and `Orders`. The `Customers` table contains information about customers, including their ID and name. The `Orders` table contains information about orders, including the customer ID who placed the order.  Our goal is to return a list of customer names who do not appear in the `Orders` table.

**Example:**

**Customers Table:**

| Id | Name   |
|----|--------|
| 1  | Joe    |
| 2  | Henry  |
| 3  | Sam    |
| 4  | Max    |

**Orders Table:**

| Id | CustomerId |
|----|------------|
| 1  | 3          |
| 2  | 1          |

**Expected Output:**

| Customers |
|-----------|
| Henry     |
| Max       |

---

## 📊 **Algorithm**

*   Select the customer's name from the `Customers` table.
*   Use a `LEFT JOIN` to combine `Customers` and `Orders` tables based on the customer ID.
*   Filter out the customers whose IDs exist in the `Orders` table. This is achieved by checking if the `CUSTOMERID` in the `Orders` table is `NULL`.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT C.name as Customers FROM CUSTOMERS AS C
LEFT JOIN ORDERS AS O
ON C.ID = O.CUSTOMERID
WHERE O.CUSTOMERID IS NULL;
```

---

## 📊 **ASCII Representation**

This problem doesn't directly involve grids or trees, but we can visualize the database structure for better understanding:

```
Customers Table
+----+-------+
| Id | Name  |
+----+-------+
|  1 | Joe   |
|  2 | Henry |
|  3 | Sam   |
|  4 | Max   |
+----+-------+

Orders Table
+----+------------+
| Id | CustomerId |
+----+------------+
|  1 |     3      |
|  2 |     1      |
+----+------------+
```

---

## 📊 **WORKING**

Let's trace the execution with the example data:

1.  **`SELECT C.name as Customers FROM CUSTOMERS AS C`**:  We start by selecting all customers' names.

2.  **`LEFT JOIN ORDERS AS O ON C.ID = O.CUSTOMERID`**: This joins `Customers` and `Orders` tables.  The `LEFT JOIN` ensures that all customers are included, even if they haven't placed an order.

    *   Joe (ID 1) joins with Order ID 2.
    *   Henry (ID 2) has no matching order.
    *   Sam (ID 3) joins with Order ID 1.
    *   Max (ID 4) has no matching order.

3.  **`WHERE O.CUSTOMERID IS NULL`**: This filters the result to include only customers for whom `O.CUSTOMERID` is `NULL`. This means those customers do not have a corresponding entry in the `Orders` table.

    *   Henry's `O.CUSTOMERID` is `NULL`.
    *   Max's `O.CUSTOMERID` is `NULL`.

Therefore, the query returns "Henry" and "Max".

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N + M)**, where N is the number of rows in the `Customers` table and M is the number of rows in the `Orders` table. This is due to the `LEFT JOIN` operation.

*   **Space Complexity:** The space complexity is also **O(N + M)** in the worst case, as we might need to store all rows from both tables in memory during the join operation.
    