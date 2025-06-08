# 01280 - Students And Examinations
    
**Language:** Mysql  
**Runtime:** 1099 ms (Beats 20.00% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1280 | Students and Examinations | [LeetCode Problem](https://leetcode.com/problems/students-and-examinations/) |

---

## 💡 **Problem Explanation**

The problem requires us to generate a report of each student and the subjects they attended, along with the count of examinations they attended for each subject.  We have three tables: `Students`, `Subjects`, and `Examinations`. We need to output the student ID, student name, subject name, and the number of attended exams, sorted by student ID and subject name. If a student didn't attend a particular subject, the attended exams count should be 0.

**Example:**

**Students Table:**

| student_id | student_name |
|------------|--------------|
| 1          | Alice        |
| 2          | Bob          |
| 3          | Alex         |

**Subjects Table:**

| subject_name |
|--------------|
| Math         |
| Physics      |
| Chemistry    |

**Examinations Table:**

| student_id | subject_name |
|------------|--------------|
| 1          | Math         |
| 1          | Physics      |
| 2          | Chemistry    |
| 1          | Physics      |
| 3          | Math         |

**Expected Output:**

| student_id | student_name | subject_name | attended_exams |
|------------|--------------|--------------|----------------|
| 1          | Alice        | Math         | 1              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Chemistry    | 0              |
| 2          | Bob          | Math         | 0              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Chemistry    | 1              |
| 3          | Alex         | Math         | 1              |
| 3          | Alex         | Physics      | 0              |
| 3          | Alex         | Chemistry    | 0              |

---

## 📊 **Algorithm**

*   Create a cross join between the `Students` and `Subjects` tables to get all possible combinations of students and subjects.
*   Perform a left join with the `Examinations` table on both `student_id` and `subject_name` to find the count of exams attended by each student for each subject.
*   Group the results by `student_id` and `subject_name`.
*   Count the number of attended exams using `COUNT(E.SUBJECT_NAME)`. If a student didn't attend a specific subject, the count will be 0 due to the left join.
*   Order the results by `student_id`.

---

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

---

## 📊 **ASCII Representation**

```
+------------+----------------+     +--------------+        +------------+--------------+
| student_id | student_name   |     | subject_name |        | student_id | subject_name |
+------------+----------------+     +--------------+        +------------+--------------+
|     1      | Alice          |     | Math         |        |     1      | Math         |
|     2      | Bob            |     | Physics      |        |     1      | Physics      |
|     3      | Alex           |     | Chemistry    |        |     2      | Chemistry    |
+------------+----------------+     +--------------+        +------------+--------------+
     STUDENTS                     SUBJECTS                    EXAMINATIONS
```

## 📊 **WORKING**

Let's walk through the query execution with sample data:

**1. CROSS JOIN:**

The cross join between `Students` and `Subjects` creates all combinations:

| student_id | student_name | subject_name |
|------------|--------------|--------------|
| 1          | Alice        | Math         |
| 1          | Alice        | Physics      |
| 1          | Alice        | Chemistry    |
| 2          | Bob          | Math         |
| 2          | Bob          | Physics      |
| 2          | Bob          | Chemistry    |
| 3          | Alex         | Math         |
| 3          | Alex         | Physics      |
| 3          | Alex         | Chemistry    |

**2. LEFT JOIN with Examinations:**

This joins the result of the cross join with the `Examinations` table. If a student hasn't taken a subject, the `examinations` fields will be `NULL`.

| student_id | student_name | subject_name | E.student_id | E.subject_name |
|------------|--------------|--------------|--------------|----------------|
| 1          | Alice        | Math         | 1            | Math           |
| 1          | Alice        | Physics      | 1            | Physics          |
| 1          | Alice        | Physics      | 1            | Physics          |
| 1          | Alice        | Chemistry    | NULL         | NULL           |
| 2          | Bob          | Math         | NULL         | NULL           |
| 2          | Bob          | Physics      | NULL         | NULL           |
| 2          | Bob          | Chemistry    | 2            | Chemistry        |
| 3          | Alex         | Math         | 3            | Math           |
| 3          | Alex         | Physics      | NULL         | NULL           |
| 3          | Alex         | Chemistry    | NULL         | NULL           |

**3. GROUP BY and COUNT:**

The `GROUP BY` clause groups the rows by `student_id` and `subject_name`, and the `COUNT(E.SUBJECT_NAME)` counts the non-null values of `E.SUBJECT_NAME` within each group.

| student_id | student_name | subject_name | attended_exams |
|------------|--------------|--------------|----------------|
| 1          | Alice        | Math         | 1              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Chemistry    | 0              |
| 2          | Bob          | Math         | 0              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Chemistry    | 1              |
| 3          | Alex         | Math         | 1              |
| 3          | Alex         | Physics      | 0              |
| 3          | Alex         | Chemistry    | 0              |

**4. ORDER BY:**

Finally, the result is ordered by `student_id`.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The `CROSS JOIN` operation can take **O(N\*M)** time where N is the number of students and M is the number of subjects. The `LEFT JOIN` takes **O(K)** where K is the number of rows in the `Examinations` table.  The `GROUP BY` operation takes **O(N\*M\*log(N\*M))** time.  Thus, the overall time complexity is dominated by the cross join and group by operations, making it roughly **O(N\*M\*log(N\*M))**.
*   **Space Complexity:** The `CROSS JOIN` creates a table with **N\*M** rows.  The joined table can have a size related to the number of rows in the `Examinations` table as well, but in the worst case, it's **O(N\*M)** to store the intermediate result of the cross join.
    