# 00178 - Rank Scores
    
**Language:** Mysql  
**Runtime:** 586 ms (Beats 12.80% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 178 | Rank Scores | [LeetCode Problem](https://leetcode.com/problems/rank-scores/) |

---

## 💡 **Problem Explanation**

The problem asks us to rank scores from a table named `Scores`. The ranking should be based on the score values, with higher scores receiving higher ranks. If two or more scores are the same, they should receive the same rank.  The rank numbers should be consecutive; in other words, there should be no gaps in the ranking sequence.

For example, consider the following `Scores` table:

```
+----+-------+
| id | score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
```

The expected output would be:

```
+-------+------+
| score | rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+
```

---

## 📊 **Algorithm**

*   Select the score from the `Scores` table.
*   Calculate the rank for each score. The rank is determined by counting the number of distinct scores that are higher than the current score and adding 1.
*   Group the results by score ID.
*   Order the results in descending order of score.

## 🔥 **Code Implementation**

```mysql
SELECT S1.SCORE ,
    count(distinct(S2.SCORE))+1 as "rank"
FROM SCORES S1
LEFT JOIN SCORES S2
ON S1.SCORE < S2.SCORE
GROUP  BY S1.ID
ORDER BY S1.SCORE DESC
```

## 📊 **ASCII Representation**

Here's a simplified representation of the `Scores` table structure:

```
Scores Table
+-------------+---------+
| Column Name |  Type   |
+-------------+---------+
| id          | INTEGER |
| score       | DECIMAL |
+-------------+---------+
```

## 📊 **WORKING**

Let's trace the execution with the following `Scores` table:

```
+----+-------+
| id | score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
```

1.  **JOIN and Rank Calculation**: For each score in `S1`, the query counts distinct scores in `S2` that are higher.

    *   For `S1.score = 3.50`, there are 4 distinct scores in `S2` greater than 3.50 (3.65, 3.85, 4.00).  The rank becomes 4 + 1 = 5.
    *   For `S1.score = 3.65`, there are 2 distinct scores in `S2` greater than 3.65 (3.85, 4.00). The rank becomes 2 + 1 = 3.
    *   For `S1.score = 4.00`, there are 0 distinct scores in `S2` greater than 4.00. The rank becomes 0 + 1 = 1.
    *   For `S1.score = 3.85`, there is 1 distinct score in `S2` greater than 3.85 (4.00). The rank becomes 1 + 1 = 2.

2.  **GROUP BY**: The `GROUP BY S1.ID` clause is essential because without it each row will not have its rank calculated appropriately. Because each ID is distinct, effectively you are calculating the rank for each unique ID.

3.  **ORDER BY**: Finally, results are ordered by `S1.SCORE DESC`, resulting in the ranked output as shown earlier.

## 🚀 **Time & Space Complexity**

*   **Time Complexity**: The time complexity is primarily determined by the join operation between the `Scores` table and itself, as well as the aggregation. Therefore, the time complexity is **O(N^2)**, where N is the number of rows in the `Scores` table because we compare each score with every other score to determine its rank. The distinct count also contribute to the time complexity.
*   **Space Complexity**: The space complexity is **O(N)** because we are storing the intermediate results of the join and aggregation, where N is the number of rows in the `Scores` table. Specifically, the rank for each row is stored.
    