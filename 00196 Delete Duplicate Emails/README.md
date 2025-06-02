# 00196 - Delete Duplicate Emails
    
**Language:** Mysql  
**Runtime:** 638 ms (Beats 80.37% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 196 | DELETE DUPLICATE EMAILS | [LeetCode Problem](https://leetcode.com/problems/delete-duplicate-emails/) |

---

## 💡 **Problem Explanation**

The task is to remove duplicate emails from a `Person` table while keeping the row with the smallest `id`. The `Person` table has the following structure:

| Column Name | Type    |
|-------------|---------|
| id          | int     |
| email       | varchar |

`id` is the primary key column for this table.  Each row of this table contains an email. The emails will not be case-sensitive.

**Example:**

Suppose the `Person` table contains the following data:

| id | email        |
|----|--------------|
| 1  | john@example.com |
| 2  | john@example.com |
| 3  | mary@example.com |

After running your SQL query, the table should look like this:

| id | email        |
|----|--------------|
| 1  | john@example.com |
| 3  | mary@example.com |

## 📊 **Algorithm**

*   Identify duplicate emails and their corresponding minimum IDs.
*   Delete rows where the ID is not among the minimum IDs for each email.

## 🔥 **Code Implementation**

```mysql
-- DELETE p1 FROM Person p1
-- JOIN Person p2 
-- ON p1.email = p2.email AND p1.id > p2.id;

WITH DUPLICATE_EMAIL_ID AS (
    SELECT MIN(ID) AS ID
    FROM PERSON
    GROUP BY EMAIL
)
DELETE FROM PERSON 
WHERE ID NOT IN (SELECT ID FROM DUPLICATE_EMAIL_ID);
```

## 📊 **ASCII Representation**

Here's a basic representation of the `Person` table:

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key for this table.
Each row of this table contains an email. The emails will not be case-sensitive.
```

## 📊 **WORKING**

Let's consider the sample input:

```
Person table:
+----+-----------------------+
| id | email               |
+----+-----------------------+
| 1  | john@example.com      |
| 2  | john@example.com      |
| 3  | mary@example.com      |
+----+-----------------------+
```

1.  **Subquery `DUPLICATE_EMAIL_ID`:**

    This subquery identifies the minimum `id` for each unique email.  It groups the `Person` table by `email` and selects the minimum `id` in each group.

    Result of the subquery:

    ```
    +----+
    | ID |
    +----+
    | 1  |
    | 3  |
    +----+
    ```

2.  **DELETE Statement:**

    The `DELETE` statement removes rows from the `Person` table where the `id` is not present in the result of the subquery `DUPLICATE_EMAIL_ID`.

    It essentially keeps only those rows whose `id` corresponds to the minimum `id` for each email.

    After deletion:

    ```
    +----+-----------------------+
    | id | email               |
    +----+-----------------------+
    | 1  | john@example.com      |
    | 3  | mary@example.com      |
    +----+-----------------------+
    ```

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the subquery and the `DELETE` operation. The subquery involves a `GROUP BY` operation which generally takes **O(N)** time, where N is the number of rows in the `Person` table. The `DELETE` operation, which involves checking against the result of the subquery, can take up to **O(N)** time as well.  Therefore, the overall time complexity is approximately **O(N)**.

*   **Space Complexity:** The space complexity is primarily determined by the subquery result, which stores the minimum `id` for each unique email. In the worst case, if all emails are unique, the space complexity would be **O(N)**. However, in cases with many duplicate emails, the space complexity would be less than **O(N)**, depending on the number of unique emails.
    