# 00601 - Human Traffic of Stadium

**Language:** MySQL  
**Runtime:** 329 ms (Beats 98.20% of users)  
**Memory:** 0B (Beats 100.00% of users)  

---

## 📝 LeetCode Problem

| 🔢 Problem Number | 📌 Title                  | 🔗 Link                                                                 |
|------------------|--------------------------|------------------------------------------------------------------------|
| 601              | Human Traffic of Stadium | [LeetCode Problem](https://leetcode.com/problems/human-traffic-of-stadium/) |

---

## 💡 Problem Statement

Given a table `Stadium`, return the records for all days where the number of people present was **100 or more for three or more consecutive days**. The output should include the `id`, `visit_date`, and `people` columns for these days, ordered by `visit_date` in ascending order.

---

## 🗃️ Table Schema & Sample Data

### Stadium

| id | visit_date | people |
|----|------------|--------|
| 1  | 2017-01-01 | 10     |
| 2  | 2017-01-02 | 109    |
| 3  | 2017-01-03 | 150    |
| 4  | 2017-01-04 | 99     |
| 5  | 2017-01-05 | 145    |
| 6  | 2017-01-06 | 1455   |
| 7  | 2017-01-07 | 199    |
| 8  | 2017-01-08 | 188    |

### Expected Output

| id | visit_date | people |
|----|------------|--------|
| 5  | 2017-01-05 | 145    |
| 6  | 2017-01-06 | 1455   |
| 7  | 2017-01-07 | 199    |
| 8  | 2017-01-08 | 188    |

---

## 🧭 SQL Approach Overview

- **Filtering:** Only consider days where `people >= 100`.
- **Grouping:** Identify consecutive days by assigning a group ID based on the difference between `id` and the row number.
- **Validation:** Select groups with at least three consecutive days.
- **Why this approach?**  
  Using window functions and group IDs efficiently identifies consecutive sequences, making the solution concise and performant.

---

## 🗂️ Table & Query Structure

| Table/CTE                | Columns                                  | Description                                             |
|--------------------------|------------------------------------------|---------------------------------------------------------|
| Stadium                  | id, visit_date, people                   | Original input table                                   |
| Filtered_Visits (CTE)    | id, visit_date, people                   | Only rows with people >= 100                           |
| Visits_With_Row_Numbers  | id, visit_date, people, Group_ID         | Adds group ID for consecutive days                     |
| Valid_Groups (CTE)       | Group_ID                                 | Groups with at least 3 consecutive days                |

---

## 🪜 Step-by-Step Solution Breakdown

1. **Filter Visits:**  
   Select only rows where `people >= 100`.

2. **Assign Group IDs:**  
   Calculate `Group_ID` as `id - ROW_NUMBER() OVER (ORDER BY id)` to group consecutive days.

3. **Identify Valid Groups:**  
   Group by `Group_ID` and keep only those with at least 3 rows.

4. **Retrieve Results:**  
   Select all records from valid groups and order by `visit_date`.

---

## 🔄 Visual Query Flow (ASCII)

```
[Stadium]
    |
    v
[Filter: people >= 100]
    |
    v
[Assign Group_ID by id - row_number()]
    |
    v
[Group by Group_ID, HAVING count >= 3]
    |
    v
[Select id, visit_date, people]
    |
    v
[Order by visit_date]
```

---

## 🧮 Walkthrough on Sample Input

### 1. Filtered_Visits

| id | visit_date | people |
|----|------------|--------|
| 2  | 2017-01-02 | 109    |
| 3  | 2017-01-03 | 150    |
| 5  | 2017-01-05 | 145    |
| 6  | 2017-01-06 | 1455   |
| 7  | 2017-01-07 | 199    |
| 8  | 2017-01-08 | 188    |

### 2. Visits_With_Row_Numbers (with Group_ID)

| id | visit_date | people | Group_ID |
|----|------------|--------|----------|
| 2  | 2017-01-02 | 109    | 1        |
| 3  | 2017-01-03 | 150    | 1        |
| 5  | 2017-01-05 | 145    | 2        |
| 6  | 2017-01-06 | 1455   | 2        |
| 7  | 2017-01-07 | 199    | 2        |
| 8  | 2017-01-08 | 188    | 2        |

### 3. Valid_Groups

| Group_ID |
|----------|
| 2        |

### 4. Final Output

| id | visit_date | people |
|----|------------|--------|
| 5  | 2017-01-05 | 145    |
| 6  | 2017-01-06 | 1455   |
| 7  | 2017-01-07 | 199    |
| 8  | 2017-01-08 | 188    |

---

## 💻 MySQL Code Implementation

```mysql
WITH Filtered_Visits AS (
    SELECT *
    FROM Stadium
    WHERE People >= 100
),

Visits_With_Row_Numbers AS (
    SELECT 
        *,
        ID - ROW_NUMBER() OVER (ORDER BY ID) AS Group_ID
    FROM Filtered_Visits
),

Valid_Groups AS (
    SELECT Group_ID
    FROM Visits_With_Row_Numbers
    GROUP BY Group_ID
    HAVING COUNT(*) >= 3
)

SELECT id, visit_date, people
FROM Visits_With_Row_Numbers
WHERE Group_ID IN (SELECT Group_ID FROM Valid_Groups)
ORDER BY Visit_Date;
```

---

## 🛠️ Programming Workflow

### Numbered Steps

1. Filter the Stadium table for rows with `people >= 100`.
2. Assign a group ID to each row based on `id - row_number()`.
3. Group by `Group_ID` and keep only those with at least 3 rows.
4. Select all records from valid groups.
5. Order the results by `visit_date`.

### Flowchart (ASCII)

```
[Start]
   |
   v
[Filter people >= 100]
   |
   v
[Assign Group_ID]
   |
   v
[Group & Filter (>=3)]
   |
   v
[Select & Order]
   |
   v
[End]
```

---

## 🚀 Complexity Analysis

- **Time Complexity:**  
  - The main cost is from the window function (`ROW_NUMBER()`) and the `GROUP BY` operation, both of which are approximately **O(n log n)**, where n is the number of filtered rows.
- **Space Complexity:**  
  - The CTEs may store up to O(n) rows, where n is the number of rows after filtering.

---

## 📚 References

- [LeetCode Problem 601 - Human Traffic of Stadium](https://leetcode.com/problems/human-traffic-of-stadium/)
- [MySQL Window Functions](https://dev.mysql.com/doc/refman/8.0/en/window-functions.html)
- [SQL GROUP BY Documentation](https://dev.mysql.com/doc/refman/8.0/en/group-by-handling.html)