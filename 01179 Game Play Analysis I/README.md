# 01179 - Game Play Analysis I
    
**Language:** Mysql  
**Runtime:** 497 ms (Beats 58.96% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 511 | Game Play Analysis I | [LeetCode Problem](https://leetcode.com/problems/game-play-analysis-i/) |

---

## 💡 **Problem Explanation**

The problem asks us to find the first login date for each player. Given a table `Activity` with `player_id` and `event_date`, we need to determine the earliest `event_date` for each `player_id`.

**Example:**

**Input:**

```
Activity table:
+-----------+-----------+------------+
| player_id | device_id | event_date |
+-----------+-----------+------------+
| 1         | 2         | 2016-03-01 |
| 1         | 2         | 2016-05-02 |
| 2         | 3         | 2017-06-25 |
| 3         | 1         | 2016-03-02 |
| 3         | 4         | 2018-07-03 |
+-----------+-----------+------------+
```

**Output:**

```
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
```

---

## 📊 **Algorithm**

*   **Group by Player:** Group all records by `player_id`.
*   **Find Minimum Date:** For each group, find the minimum (earliest) `event_date`.
*   **Select Results:** Select the `player_id` and the minimum `event_date` (aliased as `first_login`).
*   **Order Results:** Order the results by `player_id` for easier readability (though not strictly required by the problem).

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT player_id,min(event_date) as first_login
FROM ACTIVITY
GROUP BY PLAYER_ID
ORDER BY PLAYER_ID
```

## 📊 **ASCII Representation**

Here's a simple representation of the `Activity` table:

```
Activity Table:

+-----------+-----------+------------+
| player_id | device_id | event_date |
+-----------+-----------+------------+
|     1     |     2     | 2016-03-01 |
|     1     |     2     | 2016-05-02 |
|     2     |     3     | 2017-06-25 |
|     3     |     1     | 2016-03-02 |
|     3     |     4     | 2018-07-03 |
+-----------+-----------+------------+
```

## 📊 **WORKING**

Let's walk through how the query processes the sample input:

1.  **Original Table:**

```
+-----------+-----------+------------+
| player_id | device_id | event_date |
+-----------+-----------+------------+
| 1         | 2         | 2016-03-01 |
| 1         | 2         | 2016-05-02 |
| 2         | 3         | 2017-06-25 |
| 3         | 1         | 2016-03-02 |
| 3         | 4         | 2018-07-03 |
+-----------+-----------+------------+
```

2.  **Grouping by `player_id`:**

    The data is grouped into three groups: `player_id` 1, 2, and 3.

3.  **Finding Minimum `event_date` for each group:**

    *   For `player_id` 1, the minimum `event_date` is '2016-03-01'.
    *   For `player_id` 2, the minimum `event_date` is '2017-06-25'.
    *   For `player_id` 3, the minimum `event_date` is '2016-03-02'.

4.  **Final Result:**

```
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N)**, where N is the number of rows in the `Activity` table. This is because we need to scan the entire table to group by `player_id` and find the minimum date for each player.  The `ORDER BY` clause also contributes O(K log K) where K is the number of unique players.

*   **Space Complexity:** The space complexity is **O(K)**, where K is the number of unique players. This is because we store the minimum date for each player in memory while grouping. In the worst case, if each row has a unique `player_id`, the space complexity would be O(N).
    