# 01211 - Queries Quality And Percentage
    
**Language:** Mysql  
**Runtime:** 400 ms (Beats 26.66% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                             | 🔗 Link                                                                 |
| ------------------ | ------------------------------------ | ----------------------------------------------------------------------- |
| 1211               | Queries Quality and Percentage        | [LeetCode Problem](https://leetcode.com/problems/queries-quality-and-percentage/) |

---

## 💡 **Problem Explanation**

The problem asks us to calculate the 'quality' and 'poor_query_percentage' for each query in the `Queries` table.

*   **Quality**: Defined as the average ratio of `rating` to `position`.
*   **Poor Query Percentage**: Defined as the percentage of queries with a `rating` less than 3.

We need to group the queries by `query_name` and then compute these metrics. The result should include `query_name`, `quality` (rounded to two decimal places), and `poor_query_percentage` (rounded to two decimal places).

**Sample Input:**

```
Queries table:
+------------+-------------------+----------+---------+
| query_name | result            | position | rating  |
+------------+-------------------+----------+---------+
| dog        | Golden Retriever  | 1        | 5       |
| dog        | German Shepherd   | 2        | 5       |
| dog        | Rottweiler        | 3        | 4       |
| cat        | Siamese           | 5        | 3       |
| cat        | Persian           | 5        | 2       |
| cat        | Bengal            | 6        | 4       |
+------------+-------------------+----------+---------+
```

**Expected Output:**

```
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| cat        | 0.66    | 33.33                 |
| dog        | 1.33    | 0.00                  |
+------------+---------+-----------------------+
```

---

## 📊 **Algorithm**

*   Group the rows of the `Queries` table by `query_name`.
*   Calculate the `quality` for each group by averaging the `rating/position` ratio.  Round to two decimal places.
*   Calculate the `poor_query_percentage` for each group. This is done by calculating the sum of queries where `rating` is less than 3, dividing it by the total number of queries in the group and multiplying by 100. Round to two decimal places.
*   Return the `query_name`, `quality`, and `poor_query_percentage` for each group.

## 🔥 **Code Implementation**

```mysql
SELECT query_name,
    ROUND(AVG(RATING/POSITION),2) AS quality,
    ROUND(100*SUM(RATING<3)/COUNT(*),2) AS poor_query_percentage
FROM QUERIES
GROUP BY QUERY_NAME;
```

## 📊 **ASCII Representation**

```
Queries Table:

+------------+-------------------+----------+---------+
| query_name | result            | position | rating  |
+------------+-------------------+----------+---------+
| dog        | Golden Retriever  | 1        | 5       |
| dog        | German Shepherd   | 2        | 5       |
| dog        | Rottweiler        | 3        | 4       |
| cat        | Siamese           | 5        | 3       |
| cat        | Persian           | 5        | 2       |
| cat        | Bengal            | 6        | 4       |
+------------+-------------------+----------+---------+
```

## 📊 **WORKING**

Let's trace the execution with the given sample input.

1.  **Grouping by `query_name`:**

    The query first groups the rows by `query_name`. This results in two groups: `dog` and `cat`.

2.  **Calculations for `dog` group:**

    *   `quality`:
        *   (5/1 + 5/2 + 4/3) / 3 = (5 + 2.5 + 1.33) / 3 = 8.83 / 3 = 2.9433. Rounded to two decimal places, this becomes 2.94.
    *   `poor_query_percentage`:
        *   SUM(rating < 3) = 0 (since none of the ratings are less than 3)
        *   COUNT(\*) = 3
        *   (100 \* 0) / 3 = 0. Rounded to two decimal places, this is 0.00.

3.  **Calculations for `cat` group:**

    *   `quality`:
        *   (3/5 + 2/5 + 4/6) / 3 = (0.6 + 0.4 + 0.6667) / 3 = 1.6667 / 3 = 0.5556. Rounded to two decimal places, this becomes 0.56.
    *   `poor_query_percentage`:
        *   SUM(rating < 3) = 1 (Persian cat has a rating of 2)
        *   COUNT(\*) = 3
        *   (100 \* 1) / 3 = 33.33.

4.  **Final Result:**

    The query returns the following table:

    ```
    +------------+---------+-----------------------+
    | query_name | quality | poor_query_percentage |
    +------------+---------+-----------------------+
    | cat        | 0.56    | 33.33                 |
    | dog        | 2.94    | 0.00                  |
    +------------+---------+-----------------------+
    ```

## 🚀 **Time & Space Complexity**

*   **Time Complexity: O(N)**, where N is the number of rows in the `Queries` table. This is because we need to iterate through all rows to group them and calculate the aggregate functions.
*   **Space Complexity: O(M)**, where M is the number of distinct `query_name` values. This is because we need to store the intermediate results for each group in memory. The space required grows with the number of distinct query names.
    