# 00178 - Rank Scores
    
**Language:** Mysql  
**Runtime:** 586 ms (Beats 12.62% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The task is to rank scores from a table of `Scores`. The ranking should adhere to the following rules:

1.  The score with the highest value gets rank 1.
2.  After a tie, the next rank assigned should be the subsequent number (i.e., no skipping of ranks).

Let's illustrate with an example:

**Scores Table:**

| id  | score |
| --- | ----- |
| 1   | 3.5   |
| 2   | 4.0   |
| 3   | 3.65  |
| 4   | 4.0   |
| 5   | 3.85  |
| 6   | 4.0   |

**Expected Output:**

| score | rank |
| ----- | ---- |
| 4.00  | 1    |
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 4    |
| 3.65  | 5    |
| 3.50  | 6    |

## 📊 **Algorithm**

*   Join the `Scores` table to itself such that we can compare each score with all other scores.
*   Count the distinct scores that are greater than the current score to determine the rank.
*   Use `GROUP BY` to group the result by `id` so that ranking applies to each individual score entry.
*   Order the result by score in descending order.

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

## 🚀 **Time & Space Complexity**

The **time complexity** is primarily determined by the `LEFT JOIN` operation and the `GROUP BY` clause. In the worst case scenario, the `LEFT JOIN` could result in a cartesian product before filtering based on the `ON` condition. However, due to the `GROUP BY` clause, the final time complexity becomes **O(N log N)**, where N is the number of rows in the `Scores` table. This is because grouping and ordering typically take O(N log N) time.

The **space complexity** is mainly influenced by the temporary table created by the `JOIN` operation and the `GROUP BY` clause. In the worst case, the space complexity would be **O(N)** as it needs to store distinct scores for ranking purposes.
    