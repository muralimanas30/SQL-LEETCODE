# 01050 - Actors And Directors Who Cooperated At Least Three Times
    
**Language:** Mysql  
**Runtime:** 475 ms (Beats 9.59% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                                                   | 🔗 Link                                                                                             |
| ------------------ | --------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| 1050               | Actors and Directors Who Cooperated At Least Three Times | [LeetCode Problem](https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/) |

---

## 💡 **Problem Explanation**

The problem requires us to identify pairs of `actor_id` and `director_id` who have collaborated on at least three movies together. The input is a table named `ActorDirector` with columns `actor_id` and `director_id`. The output should be a table with the distinct `actor_id` and `director_id` pairs that meet the specified criteria.

**Sample Input:**

```
ActorDirector table:
+-------------+-------------+-------------+
| actor_id    | director_id | timestamp   |
+-------------+-------------+-------------+
| 1           | 1           | 0           |
| 1           | 1           | 1           |
| 1           | 1           | 2           |
| 1           | 2           | 3           |
| 1           | 2           | 4           |
| 2           | 1           | 5           |
| 2           | 1           | 6           |
+-------------+-------------+-------------+
```

**Expected Output:**

```
+-------------+-------------+
| actor_id    | director_id |
+-------------+-------------+
| 1           | 1           |
+-------------+-------------+
```

## 📊 **Algorithm**

*   Group the table by `actor_id` and `director_id`.
*   Count the number of collaborations for each `actor_id`, `director_id` pair.
*   Filter out the pairs where the collaboration count is greater than 2.
*   Select `actor_id` and `director_id` for the final result.

## 🔥 **Code Implementation**

```mysql
SELECT actor_id , director_id 
FROM ACTORDIRECTOR
GROUP BY ACTOR_ID,DIRECTOR_ID
HAVING COUNT(*)>2;
```

## 📊 **ASCII Representation**

Let's represent the `ActorDirector` table structure:

```
ActorDirector Table:
+-------------+-------------+-------------+
| actor_id    | director_id | timestamp   |
| (INT)       | (INT)       | (INT)       |
+-------------+-------------+-------------+
```

## 📊 **WORKING**

Consider the sample input:

```
ActorDirector table:
+-------------+-------------+-------------+
| actor_id    | director_id | timestamp   |
+-------------+-------------+-------------+
| 1           | 1           | 0           |
| 1           | 1           | 1           |
| 1           | 1           | 2           |
| 1           | 2           | 3           |
| 1           | 2           | 4           |
| 2           | 1           | 5           |
| 2           | 1           | 6           |
+-------------+-------------+-------------+
```

1.  **Grouping:** The `GROUP BY ACTOR_ID, DIRECTOR_ID` clause groups the rows.

2.  **Counting:** `COUNT(*)` calculates the number of rows in each group.

    *   Group (1, 1) has a count of 3.
    *   Group (1, 2) has a count of 2.
    *   Group (2, 1) has a count of 2.

3.  **Filtering:** `HAVING COUNT(*) > 2` filters the groups where the count is greater than 2. Only group (1, 1) satisfies this condition.

4.  **Selecting:** The `SELECT actor_id, director_id` clause returns the `actor_id` and `director_id` from the filtered group.

Therefore, the final output is:

```
+-------------+-------------+
| actor_id    | director_id |
+-------------+-------------+
| 1           | 1           |
+-------------+-------------+
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N)**, where N is the number of rows in the `ActorDirector` table. This is because the `GROUP BY` operation and `COUNT(*)` aggregate function typically have a linear time complexity relative to the number of input rows.
*   **Space Complexity:** The space complexity is **O(M)**, where M is the number of distinct `(actor_id, director_id)` pairs.  This is due to the space required to store the intermediate grouped results. In the worst case, if all pairs are distinct, M could be close to N.
    