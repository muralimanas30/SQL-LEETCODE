# 00626 - Exchange Seats
    
**Language:** Mysql  
**Runtime:** 337 ms (Beats 81.74% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 💡 **Problem Explanation**

The "Exchange Seats" problem requires you to swap the seats of adjacent students in a table. If the number of students is odd, the last student's seat remains unchanged.

**Example:**

**Input:**

`Seat` table:

| id | student |
|----|---------|
| 1  | Abbot  |
| 2  | Doris  |
| 3  | Emerson |
| 4  | Green  |
| 5  | Jeames |

**Output:**

| id | student |
|----|---------|
| 1  | Doris  |
| 2  | Abbot  |
| 3  | Green  |
| 4  | Emerson |
| 5  | Jeames |

## 📊 **Algorithm**

*   The algorithm uses `CASE` statement along with window functions `LEAD` and `LAG` to swap the seats.
*   `LEAD(student) OVER (ORDER BY ID)` gets the next student's name.
*   `LAG(student) OVER (ORDER BY ID)` gets the previous student's name.
*   If the ID is odd, it checks if there's a next student using `COALESCE`. If there is, it swaps with the next student; otherwise, the student remains in their original seat.
*   If the ID is even, it swaps with the previous student.

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
Seat Table:

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key for this table.
Each row of this table indicates the name and the id of a student.
id is a continuous increment.
```

## 📊 **WORKING**

Let's walk through a sample execution with the given input:

**Input Seat Table:**

| id | student |
|----|---------|
| 1  | Abbot  |
| 2  | Doris  |
| 3  | Emerson |
| 4  | Green  |
| 5  | Jeames |

1.  **ID = 1 (Odd):**

    *   `LEAD(student) OVER (ORDER BY ID)` returns "Doris".
    *   `COALESCE(Doris, Abbot)` returns "Doris".
    *   So, the student becomes "Doris".

2.  **ID = 2 (Even):**

    *   `LAG(student) OVER (ORDER BY ID)` returns "Abbot".
    *   So, the student becomes "Abbot".

3.  **ID = 3 (Odd):**

    *   `LEAD(student) OVER (ORDER BY ID)` returns "Green".
    *   `COALESCE(Green, Emerson)` returns "Green".
    *   So, the student becomes "Green".

4.  **ID = 4 (Even):**

    *   `LAG(student) OVER (ORDER BY ID)` returns "Emerson".
    *   So, the student becomes "Emerson".

5.  **ID = 5 (Odd):**

    *   `LEAD(student) OVER (ORDER BY ID)` returns NULL (because it's the last row).
    *   `COALESCE(NULL, Jeames)` returns "Jeames".
    *   So, the student remains "Jeames".

**Result Table:**

| id | student |
|----|---------|
| 1  | Doris  |
| 2  | Abbot  |
| 3  | Green  |
| 4  | Emerson |
| 5  | Jeames |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** **O(N)**, where N is the number of rows in the `Seat` table, because the window functions iterate through the table once.
*   **Space Complexity:** **O(1)**, as the query uses a constant amount of extra space, regardless of the input size.
    