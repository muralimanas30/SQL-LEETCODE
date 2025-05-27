# 01415 - Students And Examinations
    
**Language:** Mysql  
**Runtime:** 1099 ms (Beats 19.57% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title                      | 🔗 Link                                                                 |
|------------------|-------------------------------|------------------------------------------------------------------------|
| 1415             | Students and Examinations | [LeetCode Problem](https://leetcode.com/problems/students-and-examinations/) |

---

## 💡 **Problem Explanation**

The problem requires you to generate a report of students and the subjects they attended for examinations.  If a student didn't attend an exam for a specific subject, it should still be listed with an attendance count of 0. The report must include the student's ID, student's name, subject's name, and the number of exams attended for that subject.

**Example:**

Suppose we have the following `Students`, `Subjects`, and `Examinations` tables:

**Students Table:**

| student_id | student_name |
|------------|--------------|
| 1          | Alice        |
| 2          | Bob          |
| 3          | Charlie      |

**Subjects Table:**

| subject_name |
|--------------|
| Math         |
| English      |
| Science      |

**Examinations Table:**

| student_id | subject_name |
|------------|--------------|
| 1          | Math         |
| 1          | English      |
| 2          | English      |
| 2          | Science      |

The expected output would be:

| student_id | student_name | subject_name | attended_exams |
|------------|--------------|--------------|----------------|
| 1          | Alice        | Math         | 1              |
| 1          | Alice        | English      | 1              |
| 1          | Alice        | Science      | 0              |
| 2          | Bob          | Math         | 0              |
| 2          | Bob          | English      | 1              |
| 2          | Bob          | Science      | 1              |
| 3          | Charlie      | Math         | 0              |
| 3          | Charlie      | English      | 0              |
| 3          | Charlie      | Science      | 0              |

---

## 💡 **Algorithm**

Here's the breakdown of the algorithm to solve this problem:

*   Perform a `CROSS JOIN` between the `Students` and `Subjects` tables. This generates all possible combinations of students and subjects.
*   Perform a `LEFT JOIN` with the `Examinations` table. This allows including all student-subject combinations, even if a student hasn't taken a specific subject.
*   Use `COUNT(E.subject_name)` to count the number of exams attended for each student-subject combination. If a student hasn't attended an exam for a subject, the count will be 0 due to the `LEFT JOIN`.
*   Group the results by `student_id` and `subject_name` to aggregate the counts correctly.
*   Order the results by `student_id`.

## 🔥 **Code Implementation**

```mysql
SELECT S.STUDENT_ID,S.STUDENT_NAME,SUB.SUBJECT_NAME,
COUNT(E.SUBJECT_NAME) AS "attended_exams"
FROM STUDENTS AS S
CROSS JOIN SUBJECTS AS SUB
LEFT JOIN EXAMINATIONS E
ON S.STUDENT_ID = E.STUDENT_ID AND SUB.SUBJECT_NAME = E.SUBJECT_NAME
GROUP BY S.STUDENT_ID,SUB.SUBJECT_NAME
ORDER BY STUDENT_ID
```

## 📊 **ASCII Representation**

Since this problem involves tables and relationships between them, visualizing it with an ASCII diagram of a database schema can be helpful:

```
+------------+      +--------------+      +---------------+
|  Students  |      |   Subjects   |      | Examinations  |
+------------+      +--------------+      +---------------+
| student_id |----->| subject_name |<-----| student_id    |
| student_name|      +--------------+      | subject_name  |
+------------+                            +---------------+
```

## 📊 **WORKING**

Let's take the sample input from the Problem Explanation and trace how the query works.

1.  **CROSS JOIN:**

    The `CROSS JOIN` between `Students` and `Subjects` generates all possible pairs:

    | student_id | student_name | subject_name |
    |------------|--------------|--------------|
    | 1          | Alice        | Math         |
    | 1          | Alice        | English      |
    | 1          | Alice        | Science      |
    | 2          | Bob          | Math         |
    | 2          | Bob          | English      |
    | 2          | Bob          | Science      |
    | 3          | Charlie      | Math         |
    | 3          | Charlie      | English      |
    | 3          | Charlie      | Science      |

2.  **LEFT JOIN:**

    The `LEFT JOIN` with `Examinations` adds the attendance information:

    | student_id | student_name | subject_name | E.subject_name |
    |------------|--------------|--------------|----------------|
    | 1          | Alice        | Math         | Math           |
    | 1          | Alice        | English      | English        |
    | 1          | Alice        | Science      | NULL           |
    | 2          | Bob          | Math         | NULL           |
    | 2          | Bob          | English      | English        |
    | 2          | Bob          | Science      | Science        |
    | 3          | Charlie      | Math         | NULL           |
    | 3          | Charlie      | English      | NULL           |
    | 3          | Charlie      | Science      | NULL           |

3.  **COUNT and GROUP BY:**

    The `COUNT(E.subject_name)` and `GROUP BY` give the final result:

    | student_id | student_name | subject_name | attended_exams |
    |------------|--------------|--------------|----------------|
    | 1          | Alice        | Math         | 1              |
    | 1          | Alice        | English      | 1              |
    | 1          | Alice        | Science      | 0              |
    | 2          | Bob          | Math         | 0              |
    | 2          | Bob          | English      | 1              |
    | 2          | Bob          | Science      | 1              |
    | 3          | Charlie      | Math         | 0              |
    | 3          | Charlie      | English      | 0              |
    | 3          | Charlie      | Science      | 0              |

4.  **ORDER BY:**

    The result is then ordered by `student_id`.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The `CROSS JOIN` between `Students` (S) and `Subjects` (SUB) results in S x SUB rows. The `LEFT JOIN` with `Examinations` (E) and the subsequent `GROUP BY` operation contribute to the overall complexity, but the dominant factor is usually the `CROSS JOIN`. Hence the overall time complexity is approximately  **O(S \* SUB)**.
*   **Space Complexity:** The space complexity is primarily determined by the size of the intermediate result from the `CROSS JOIN` which is **O(S \* SUB)**. The final result set's size depends on the number of rows returned, but the dominant factor for space usage remains the cross-product.
    