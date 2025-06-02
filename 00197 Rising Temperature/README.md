# 00197 - Rising Temperature
    
**Language:** Mysql  
**Runtime:** 964 ms (Beats 5.99% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 197 | Rising Temperature | [LeetCode Problem](https://leetcode.com/problems/rising-temperature/) |

---

## 💡 **Problem Explanation**

The "Rising Temperature" problem requires you to find all dates where the temperature was higher than the previous day's temperature. You're given a `Weather` table with `id` (integer), `recordDate` (date), and `temperature` (integer) columns. The goal is to return the `id` of the rows where the temperature is strictly greater than the temperature of the immediately preceding date.

**Example:**

**Weather Table:**

| id  | recordDate  | temperature |
|-----|-------------|-------------|
| 1   | 2015-01-01  | 10          |
| 2   | 2015-01-02  | 25          |
| 3   | 2015-01-03  | 20          |
| 4   | 2015-01-04  | 30          |

**Output:**

| id  |
|-----|
| 2   |
| 4   |

On 2015-01-02, the temperature (25) was higher than 2015-01-01's temperature (10).  Similarly, on 2015-01-04, the temperature (30) was higher than 2015-01-03's temperature (20).

## 📊 **Algorithm**

*   Join the `Weather` table to itself using a `DATEDIFF` function to compare consecutive dates.
*   Filter the result based on the temperature difference, selecting only those `id`s where the current day's temperature is higher than the previous day's.
*   Return the `id` of the matching rows.

## 🔥 **Code Implementation**

```mysql
SELECT w1.id
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;
```

## 📊 **ASCII Representation**

```
Weather Table:

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| recordDate  | date    |
| temperature | int     |
+-------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
```

## 📊 **WORKING**

Let's walk through the given query with the sample data:

**Weather Table:**

| id  | recordDate  | temperature |
|-----|-------------|-------------|
| 1   | 2015-01-01  | 10          |
| 2   | 2015-01-02  | 25          |
| 3   | 2015-01-03  | 20          |
| 4   | 2015-01-04  | 30          |

1.  **JOIN Operation:** The query joins the `Weather` table (aliased as `w1`) with itself (aliased as `w2`) based on the condition `DATEDIFF(w1.recordDate, w2.recordDate) = 1`. This condition effectively links each day with its preceding day.

2.  **Filtering (WHERE clause):**
    *   For `w1.id = 2` (2015-01-02, temp: 25), it checks `w1.temperature > w2.temperature`. Here, `w2` corresponds to `w2.id = 1` (2015-01-01, temp: 10).  Since 25 > 10, `w1.id = 2` is selected.
    *   For `w1.id = 3` (2015-01-03, temp: 20), `w2` corresponds to `w2.id = 2` (2015-01-02, temp: 25).  Since 20 > 25 is false, `w1.id = 3` is not selected.
    *   For `w1.id = 4` (2015-01-04, temp: 30), `w2` corresponds to `w2.id = 3` (2015-01-03, temp: 20). Since 30 > 20, `w1.id = 4` is selected.

3.  **Result:** The query returns `id = 2` and `id = 4`.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(N)**, where N is the number of rows in the `Weather` table. This is because the join operation effectively iterates through each row to find its preceding date.

*   **Space Complexity:** The space complexity is **O(1)**, because the query uses a constant amount of extra space, irrespective of the input size.  The join is performed within the query processing engine and doesn't create significant additional storage relative to the input size.
    