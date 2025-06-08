# 01683 - Invalid Tweets
    
**Language:** Mysql  
**Runtime:** 529 ms (Beats 99.10% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1683 | Invalid Tweets | [LeetCode Problem](https://leetcode.com/problems/invalid-tweets/) |

---

## 💡 **Problem Explanation**

The problem requires you to identify tweets from a `Tweets` table that exceed a certain length limit (15 characters). The goal is to return the `tweet_id` of all such invalid tweets.

**Example:**

**Tweets Table:**

| tweet_id | content             |
|----------|----------------------|
| 1        | This is an invalid tweet |
| 2        | Hello                |
| 3        | Another invalid tweet exceeding 15 characters |

**Expected Output:**

| tweet_id |
|----------|
| 1        |
| 3        |

Tweets with `tweet_id` 1 and 3 are considered invalid since their content length is greater than 15.

## 📊 **Algorithm**

*   Select the `tweet_id` from the `Tweets` table.
*   Filter the tweets where the length of the `content` is greater than 15.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
select tweet_id from Tweets where length(content)>15;
```

## 📊 **ASCII Representation**

The `Tweets` table can be visualized as follows:

```
Tweets Table:

+-----------+----------------------------------+
| tweet_id  | content                          |
+-----------+----------------------------------+
| 1         | This is an invalid tweet       |
| 2         | Hello                            |
| 3         | Another invalid tweet exceeding |
|           | 15 characters                  |
+-----------+----------------------------------+
```

## 📊 **WORKING**

Let's trace the execution with the following `Tweets` table:

```
Tweets Table:

+-----------+----------------------------------+
| tweet_id  | content                          |
+-----------+----------------------------------+
| 1         | This is an invalid tweet       |
| 2         | Hello                            |
| 3         | Another invalid tweet exceeding |
|           | 15 characters                  |
+-----------+----------------------------------+
```

1.  The query `SELECT tweet_id FROM Tweets WHERE length(content) > 15` is executed.
2.  The `length(content)` function calculates the length of the `content` for each row.
3.  The `WHERE` clause filters the rows where the length is greater than 15:
    *   For `tweet_id = 1`, `length('This is an invalid tweet')` is 24, which is greater than 15.  The row is selected.
    *   For `tweet_id = 2`, `length('Hello')` is 5, which is not greater than 15.  The row is discarded.
    *   For `tweet_id = 3`, `length('Another invalid tweet exceeding 15 characters')` is 43, which is greater than 15. The row is selected.
4.  The query returns the `tweet_id` of the selected rows, which are 1 and 3.

Output:

```
+-----------+
| tweet_id  |
+-----------+
| 1         |
| 3         |
+-----------+
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N)**, where N is the number of rows in the `Tweets` table, because the query iterates through each row to check the length of the content.
*   **Space Complexity:** The space complexity is **O(M)**, where M is the number of tweets that satisfy the condition `length(content) > 15`. In the worst case, if all tweets are invalid, the space complexity would be O(N), where N is the number of rows in the `Tweets` table.
    