# 01338 - Queries Quality And Percentage
    
**Language:** Mysql  
**Runtime:** 400 ms (Beats 25.69% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1338 | QUERIES QUALITY AND PERCENTAGE | [LeetCode Problem](https://leetcode.com/problems/queries-quality-and-percentage/) |

---

## 💡 **Problem Explanation**

The problem asks you to calculate the 'quality' and 'poor_query_percentage' for each unique query name in a `QUERIES` table.

*   **Quality**: Defined as the average ratio of `rating` to `position`.  It reflects how well a query performs in search results.  Higher ratings at lower positions (closer to the top) yield a better quality score.
*   **Poor Query Percentage**: The percentage of queries with a rating less than 3.  This helps identify poorly performing queries.

**Example:**

Let's say we have the following data in the `QUERIES` table:

| query_name | result | position | rating |
|------------|--------|----------|--------|
| dog        | Golden Retriever | 1        | 5      |
| dog        | German Shepherd | 2        | 5      |
| dog        | Poodle | 3        | 4      |
| cat        | Persian | 1        | 2      |
| cat        | Siamese | 2        | 3      |

The expected output would be:

| query_name | quality | poor_query_percentage |
|------------|---------|-----------------------|
| cat        | 1.25    | 50.00                 |
| dog        | 1.67    | 0.00                  |

For `dog`:

*   Quality = (5/1 + 5/2 + 4/3) / 3 = (5 + 2.5 + 1.33) / 3 = 8.83 / 3 = 2.94 (approximately)
*   There are no ratings less than 3. Therefore, the poor\_query\_percentage is 0%.

For `cat`:

*   Quality = (2/1 + 3/2) / 2 = (2 + 1.5) / 2 = 3.5 / 2 = 1.75
*   One rating is less than 3 (the first one which is 2). Therefore, the poor\_query\_percentage is 50%.
    I have re-evaluated cat again:
    Quality = (2/1 + 3/2) / 2 = (2 + 1.5) / 2 = 3.5/2 = 1.75
    poor_query_percentage = 1/2 * 100 = 50.00

---

## 📊 **Algorithm**

*   **Group by `query_name`**:  This allows us to perform calculations for each unique query.
*   **Calculate Quality**: Compute the average of `rating / position` for each `query_name`, rounded to two decimal places.
*   **Calculate Poor Query Percentage**: Compute the percentage of ratings less than 3 for each `query_name`, rounded to two decimal places.  This involves summing the number of ratings less than 3 and dividing by the total count of ratings.
*   **Return the Results**: Return the `query_name`, calculated `quality`, and calculated `poor_query_percentage`.

---

## 🔥 **Code Implementation**

```mysql
SELECT query_name,
    ROUND(AVG(RATING/POSITION),2) AS quality,
    ROUND(100*SUM(RATING<3)/COUNT(*),2) AS poor_query_percentage
FROM QUERIES
GROUP BY QUERY_NAME;
```

---

## 📊 **ASCII Representation**

N/A - This problem does not involve grids or movements. It's a database query problem.

```
QUERIES Table Structure:

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
```

---

## 📊 **WORKING**

Let's walk through the example provided in the Problem Explanation:

**Initial `QUERIES` Table:**

| query_name | result           | position | rating |
|------------|------------------|----------|--------|
| dog        | Golden Retriever | 1        | 5      |
| dog        | German Shepherd  | 2        | 5      |
| dog        | Poodle           | 3        | 4      |
| cat        | Persian          | 1        | 2      |
| cat        | Siamese          | 2        | 3      |

**Step 1: Group by `query_name`**

We now have two groups: `dog` and `cat`.

**Step 2: Calculate Quality for `dog`**

*   (5/1 + 5/2 + 4/3) / 3 = (5 + 2.5 + 1.33) / 3 = 8.83 / 3 = 2.94 (rounded to 2 decimal places)

**Step 3: Calculate Poor Query Percentage for `dog`**

*   Ratings less than 3: None.
*   Count of ratings: 3
*   Poor Query Percentage: (0 / 3) * 100 = 0.00

**Step 4: Calculate Quality for `cat`**

*   (2/1 + 3/2) / 2 = (2 + 1.5) / 2 = 3.5 / 2 = 1.75 (rounded to 2 decimal places)

**Step 5: Calculate Poor Query Percentage for `cat`**

*   Ratings less than 3: One (rating = 2)
*   Count of ratings: 2
*   Poor Query Percentage: (1 / 2) * 100 = 50.00

**Final Result:**

| query_name | quality | poor_query_percentage |
|------------|---------|-----------------------|
| cat        | 1.75    | 50.00                 |
| dog        | 2.94    | 0.00                  |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity: O(N)** where N is the number of rows in the `QUERIES` table.  This is because we iterate through all the rows once to calculate the aggregates (AVG, SUM, COUNT) for each group. The `GROUP BY` operation usually has a time complexity of O(N log N) in the worst case, but in many database systems it's optimized and can behave closer to O(N) when there are indexes or other optimizations in place.
*   **Space Complexity: O(M)** where M is the number of distinct `query_name` values.  This is because we need to store the intermediate results for each group while calculating the aggregates.  In the worst case, where all query names are distinct, M could be equal to N.
    