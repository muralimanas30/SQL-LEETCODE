# 01837 - Daily Leads And Partners
    
**Language:** Mysql  
**Runtime:** 545 ms (Beats 61.86% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 1837 | Daily Leads and Partners | [LeetCode Problem](https://leetcode.com/problems/daily-leads-and-partners/) |

---

## 💡 **Problem Explanation**

The problem requires us to find the number of unique leads and partners for each date and make name combination in the `DailySales` table.  Essentially, we need to group the data by `date_id` and `make_name` and then count the distinct `lead_id` and `partner_id` values within each group.

**Example:**

Let's say our `DailySales` table looks like this:

| date_id    | make_name | lead_id | partner_id |
|------------|-----------|---------|------------|
| 2020-12-08 | toyota    | 0       | 1          |
| 2020-12-08 | toyota    | 0       | 2          |
| 2020-12-08 | toyota    | 1       | 2          |
| 2020-12-07 | toyota    | 0       | 2          |
| 2020-12-07 | toyota    | 1       | 2          |
| 2020-12-08 | honda     | 0       | 1          |
| 2020-12-08 | honda     | 1       | 2          |
| 2020-12-07 | honda     | 0       | 1          |
| 2020-12-07 | honda     | 1       | 2          |
| 2020-12-07 | honda     | 2       | 1          |

The desired output would be:

| date_id    | make_name | unique_leads | unique_partners |
|------------|-----------|--------------|-----------------|
| 2020-12-07 | honda     | 3            | 2               |
| 2020-12-07 | toyota    | 2            | 1               |
| 2020-12-08 | honda     | 2            | 2               |
| 2020-12-08 | toyota    | 2            | 2               |

---

## 📊 **Algorithm**
*  Group the `DailySales` table by `date_id` and `make_name`.
*  For each group, count the distinct `lead_id` values. This gives us `unique_leads`.
*  For each group, count the distinct `partner_id` values. This gives us `unique_partners`.
*  Select the `date_id`, `make_name`, `unique_leads`, and `unique_partners` for the final result.

---

## 🔥 **Code Implementation**
```mysql
SELECT date_id,make_name,
    COUNT(DISTINCT(LEAD_ID)) AS unique_leads,
    COUNT(DISTINCT(PARTNER_ID)) AS unique_partners
FROM DAILYSALES
GROUP BY DATE_ID,MAKE_NAME

```

---

## 📊 **ASCII Representation**

This problem doesn't inherently involve grids or trees, so an ASCII representation isn't directly applicable. However, we can represent the conceptual grouping process with a simple diagram:

```
DailySales Table:
+----------+-----------+---------+------------+
| date_id  | make_name | lead_id | partner_id |
+----------+-----------+---------+------------+
| ...      | ...       | ...     | ...        |
+----------+-----------+---------+------------+

   ||
   ||  Group by date_id, make_name
   \/

Groups:
+----------+-----------+---------------------------+
| date_id  | make_name | (lead_id, partner_id) sets |
+----------+-----------+---------------------------+
| ...      | ...       | {(...), (...), ...}       |
+----------+-----------+---------------------------+

   ||
   ||  Count distinct lead_id & partner_id in each group
   \/

Result Table:
+----------+-----------+--------------+-----------------+
| date_id  | make_name | unique_leads | unique_partners |
+----------+-----------+--------------+-----------------+
| ...      | ...       | ...          | ...             |
+----------+-----------+--------------+-----------------+

```

---

## 📊 **WORKING**

Let's trace the execution with the example data provided earlier:

**DailySales Table:**

| date_id    | make_name | lead_id | partner_id |
|------------|-----------|---------|------------|
| 2020-12-08 | toyota    | 0       | 1          |
| 2020-12-08 | toyota    | 0       | 2          |
| 2020-12-08 | toyota    | 1       | 2          |
| 2020-12-07 | toyota    | 0       | 2          |
| 2020-12-07 | toyota    | 1       | 2          |
| 2020-12-08 | honda     | 0       | 1          |
| 2020-12-08 | honda     | 1       | 2          |
| 2020-12-07 | honda     | 0       | 1          |
| 2020-12-07 | honda     | 1       | 2          |
| 2020-12-07 | honda     | 2       | 1          |

**1. Grouping by `date_id` and `make_name`:**

We get four groups:

*   `date_id` = '2020-12-08', `make_name` = 'toyota': (lead_id: 0, partner_id: 1), (lead_id: 0, partner_id: 2), (lead_id: 1, partner_id: 2)
*   `date_id` = '2020-12-07', `make_name` = 'toyota': (lead_id: 0, partner_id: 2), (lead_id: 1, partner_id: 2)
*   `date_id` = '2020-12-08', `make_name` = 'honda': (lead_id: 0, partner_id: 1), (lead_id: 1, partner_id: 2)
*   `date_id` = '2020-12-07', `make_name` = 'honda': (lead_id: 0, partner_id: 1), (lead_id: 1, partner_id: 2), (lead_id: 2, partner_id: 1)

**2. Counting Distinct Leads and Partners:**

*   '2020-12-08', 'toyota':  `unique_leads` = 2 (0, 1), `unique_partners` = 2 (1, 2)
*   '2020-12-07', 'toyota': `unique_leads` = 2 (0, 1), `unique_partners` = 1 (2)
*   '2020-12-08', 'honda': `unique_leads` = 2 (0, 1), `unique_partners` = 2 (1, 2)
*   '2020-12-07', 'honda': `unique_leads` = 3 (0, 1, 2), `unique_partners` = 2 (1, 2)

**3. Final Result:**

| date_id    | make_name | unique_leads | unique_partners |
|------------|-----------|--------------|-----------------|
| 2020-12-07 | honda     | 3            | 2               |
| 2020-12-07 | toyota    | 2            | 1               |
| 2020-12-08 | honda     | 2            | 2               |
| 2020-12-08 | toyota    | 2            | 2               |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the `GROUP BY` operation.  In most database systems, this operation has a time complexity of **O(N log N)** in the average case, where N is the number of rows in the `DailySales` table. In the worst case (e.g., all rows have the same `date_id` and `make_name`), the complexity can approach **O(N)** if the database is optimized.
*   **Space Complexity:** The space complexity depends on the number of distinct groups (combinations of `date_id` and `make_name`). In the worst case (a large number of distinct groups), the space complexity can be **O(G)**, where G is the number of groups. This is due to the space required to store intermediate group results.
    