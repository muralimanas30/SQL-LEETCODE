# 00626 - Exchange Seats
    
**Language:** Mysql  
**Runtime:** 337 ms (Beats 82.75% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 626 | Exchange Seats | [LeetCode Problem](https://leetcode.com/problems/exchange-seats/) |

---

## 💡 **Problem Explanation**

The problem requires you to swap the seat positions of students in a classroom. If the number of students is odd, the last student should remain in their original seat. The input is a table named `Seat` with columns `id` and `student`. The output should be the same table but with the student names swapped according to the rules.

**Example:**

**Input:**

```
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
```

**Output:**

```
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
```

## 📊 **Algorithm**

*   The algorithm involves using window functions to look at the next and previous student names based on their IDs.
*   We use `CASE` statement to determine whether to swap a student's name with the next or previous one.
*   If the ID is odd, we swap with the next student using `LEAD()`. If there is no next student (i.e., the last student and the number of students is odd), we keep the student's name as is using `COALESCE()`.
*   If the ID is even, we swap with the previous student using `LAG()`.
*   The results are ordered by ID.

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below

SELECT 
  ID,
  CASE
    WHEN ID % 2 = 1 THEN COALESCE(LEAD(student) OVER (ORDER BY ID), student)
    WHEN ID % 2 = 0 THEN LAG(student) OVER (ORDER BY ID)
  END AS student
FROM SEAT;
```

## 📊 **ASCII Representation**

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key for this table.
Each row of this table contains the id and the name of a student.
The id of each student is a contiguous integer starting from 1.
```

## 📊 **WORKING**

Let's trace the execution with the provided example:

**Input Table:**

```
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
```

1.  **ID = 1 (Odd):**
    *   `LEAD(student) OVER (ORDER BY ID)` gives 'Doris'.
    *   Since `LEAD()` is not NULL, `COALESCE()` returns 'Doris'.
    *   Result: `ID = 1, student = 'Doris'`

2.  **ID = 2 (Even):**
    *   `LAG(student) OVER (ORDER BY ID)` gives 'Abbot'.
    *   Result: `ID = 2, student = 'Abbot'`

3.  **ID = 3 (Odd):**
    *   `LEAD(student) OVER (ORDER BY ID)` gives 'Green'.
    *   Since `LEAD()` is not NULL, `COALESCE()` returns 'Green'.
    *   Result: `ID = 3, student = 'Green'`

4.  **ID = 4 (Even):**
    *   `LAG(student) OVER (ORDER BY ID)` gives 'Emerson'.
    *   Result: `ID = 4, student = 'Emerson'`

5.  **ID = 5 (Odd):**
    *   `LEAD(student) OVER (ORDER BY ID)` gives NULL (because there is no next row).
    *   `COALESCE(NULL, student)` returns 'Jeames'.
    *   Result: `ID = 5, student = 'Jeames'`

**Final Result:**

```
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** **O(N)** - where N is the number of rows in the `Seat` table. The `LEAD()` and `LAG()` window functions iterate through each row once.
*   **Space Complexity:** **O(N)** -  The window functions (`LEAD()` and `LAG()`) might require storing intermediate results proportional to the input size.
    