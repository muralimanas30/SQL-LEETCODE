# 01148 - Article Views I
    
**Language:** Mysql  
**Runtime:** 362 ms (Beats 99.93% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1148 | Article Views I | [LeetCode Problem](https://leetcode.com/problems/article-views-i/) |

---

## 💡 **Problem Explanation**

This problem asks us to find all authors who have viewed their own articles. In other words, we need to identify the `author_id` from the `Views` table where the `author_id` is equal to the `viewer_id`. The final result should be a list of distinct `author_id` values, sorted in ascending order.

**Example:**

**Input:**

```
Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 2          | 3         | 6         | 2019-08-02 |
| 3          | 5         | 3         | 2019-08-03 |
| 4          | 5         | 5         | 2019-08-04 |
| 5          | 6         | 3         | 2019-08-04 |
| 6          | 6         | 6         | 2019-08-05 |
+------------+-----------+-----------+------------+
```

**Output:**

```
+------+
| id   |
+------+
| 5    |
| 6    |
+------+
```

In this example, authors with IDs 5 and 6 have viewed their own articles.

## 📊 **Algorithm**

1.  Select the distinct `author_id` from the `Views` table.
2.  Filter the results to include only rows where `author_id` is equal to `viewer_id`.
3.  Order the results in ascending order by `author_id`.
4.  Rename the `author_id` column to `id`.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
select distinct author_id as 'id' from Views where author_id = viewer_id order by author_id asc;
```

## 📊 **ASCII Representation**

Here's a simple representation of the `Views` table structure:

```
Views Table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| INT        | INT       | INT       | DATE       |
+------------+-----------+-----------+------------+
```

## 📊 **WORKING**

Let's trace the query with the sample input:

**Initial Table:**

```
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 2          | 3         | 6         | 2019-08-02 |
| 3          | 5         | 3         | 2019-08-03 |
| 4          | 5         | 5         | 2019-08-04 |
| 5          | 6         | 3         | 2019-08-04 |
| 6          | 6         | 6         | 2019-08-05 |
+------------+-----------+-----------+------------+
```

**1. `WHERE author_id = viewer_id`:**

This filters the table to:

```
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 4          | 5         | 5         | 2019-08-04 |
| 6          | 6         | 6         | 2019-08-05 |
+------------+-----------+-----------+------------+
```

**2. `SELECT DISTINCT author_id`:**

This selects only the unique `author_id` values:

```
+-----------+
| author_id |
+-----------+
| 5         |
| 6         |
+-----------+
```

**3. `ORDER BY author_id ASC`:**

The `author_id` is already in ascending order, so no change occurs.

**4. `AS 'id'`:**

Rename the author_id to id

**Final Result:**

```
+------+
| id   |
+------+
| 5    |
| 6    |
+------+
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** **O(N log N)** due to the sorting operation, where N is the number of rows in the `Views` table *after* the `WHERE` clause filters the table. If the number of results after the `WHERE` clause is small, the sorting might be considered closer to **O(1)**. But Generally it will be **O(N log N)**.
*   **Space Complexity:** **O(N)** in the worst case, to store the distinct `author_id` values.  This could reduce significantly if the number of distinct `author_id` values where `author_id = viewer_id` is small.
    