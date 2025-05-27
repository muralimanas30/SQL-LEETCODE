# 01892 - Find Total Time Spent By Each Employee
    
**Language:** Mysql  
**Runtime:** 523 ms (Beats 69.03% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1729 | Find Followers Count | [LeetCode Problem](https://leetcode.com/problems/find-followers-count/) |

---

## 💡 **Problem Explanation**
The problem asks us to write a SQL query that reports the number of followers each user has. The table contains user IDs (`user_id`) of those who are following someone.  We need to group the entries by the `user_id` and count how many times each `user_id` appears as a follower. The result should be ordered by `user_id` in ascending order.

For example, consider the following `Followers` table:

| followee | follower |
|---|---|
| 1 | 2 |
| 1 | 3 |
| 2 | 3 |

The query should return:

| followee | num |
|---|---|
| 1 | 2 |
| 2 | 1 |

---

## 📊 **Algorithm**
*   Group the records in the `Followers` table by the `followee` column.
*   Count the number of followers (distinct `follower` values) for each `followee`.
*   Rename the count column to `num`.
*   Order the result by `followee` in ascending order.

## 🔥 **Code Implementation**

```sql
SELECT followee, COUNT(follower) AS num
FROM Followers
GROUP BY followee
ORDER BY followee;
```

---

## 📊 **WORKING**
Consider this `Followers` table:

| followee | follower |
|---|---|
| 1 | 2 |
| 1 | 3 |
| 2 | 3 |
| 2 | 4 |
| 3 | 5 |

1.  **Grouping by `followee`:**  We group the rows based on the `followee` column. This results in three groups: `followee = 1`, `followee = 2`, and `followee = 3`.

2.  **Counting followers:**
    *   For `followee = 1`, the followers are 2 and 3, so the count is 2.
    *   For `followee = 2`, the followers are 3 and 4, so the count is 2.
    *   For `followee = 3`, the follower is 5, so the count is 1.

3.  **Renaming and Ordering:** The `COUNT(follower)` is aliased as `num`, and the final result is ordered by `followee`.

Result:

| followee | num |
|---|---|
| 1 | 2 |
| 2 | 2 |
| 3 | 1 |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the grouping and sorting operations. In most database systems, the grouping operation has a time complexity of **O(N)** where N is number of rows in the `Followers` table, and the sorting has a time complexity of **O(M log M)**, where M is the number of unique followee values.

*   **Space Complexity:** The space complexity depends on the number of unique `followee` values because we store the intermediate group results. Hence, the space complexity can be considered **O(M)** where M is the number of unique followee values.
    