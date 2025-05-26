# 00182 - Duplicate Emails
    
**Language:** Mysql  
**Runtime:** 361 ms (Beats 85.31% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title           | 🔗 Link                                                                    |
| ------------------ | ------------------ | -------------------------------------------------------------------------- |
| 182              | Duplicate Emails | [LeetCode Problem](https://leetcode.com/problems/duplicate-emails/) |

---

## 💡 **Problem Explanation**

The task is to identify and list all email addresses that appear more than once in a table named `Person`. This usually involves grouping the emails and then filtering those groups based on their count.

**Example:**

Suppose your `Person` table looks like this:

| id  | email            |
| --- | ---------------- |
| 1   | john@example.com |
| 2   | bob@example.com  |
| 3   | john@example.com |

The query should return:

| Email            |
| ---------------- |
| john@example.com |

---

## 📊 **Algorithm**
*   Group the emails using the `GROUP BY` clause.
*   Count the occurrences of each email within its group using `COUNT()`.
*   Filter the groups to include only those where the email count is greater than 1 using the `HAVING` clause.
*   Select the email addresses from the filtered groups.

---

## 🔥 **Code Implementation**

```mysql
SELECT EMAIL FROM PERSON
GROUP BY EMAIL
HAVING COUNT(EMAIL)>1;
```

---

## 📊 **ASCII Representation**

Since this problem involves a database table, an ASCII representation of the table structure can be helpful:

```
Person Table:
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
```

Example Data:

```
+----+-------------------+
| id | email             |
+----+-------------------+
| 1  | a@example.com     |
| 2  | b@example.com     |
| 3  | c@example.com     |
| 4  | a@example.com     |
| 5  | c@example.com     |
| 6  | d@example.com     |
+----+-------------------+
```

---

## 📊 **WORKING**

Consider the following `Person` table:

| id  | email             |
| --- | ----------------- |
| 1   | a@example.com     |
| 2   | b@example.com     |
| 3   | a@example.com     |
| 4   | c@example.com     |
| 5   | b@example.com     |

1.  **Grouping:** The `GROUP BY EMAIL` clause groups rows by email.
2.  **Counting:** `COUNT(EMAIL)` counts the occurrences of each email in its group.
3.  **Filtering:** `HAVING COUNT(EMAIL) > 1` filters out groups where the count is not greater than 1.

Result:

| email             | count |
| ----------------- | ----- |
| a@example.com     | 2     |
| b@example.com     | 2     |

Finally, the query selects and returns these duplicate emails.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is primarily determined by the database's grouping and counting operations.  In general, it's **O(N)** where N is the number of rows in the `Person` table.  This is because the database must potentially examine each row to group and count the emails.

*   **Space Complexity:** The space complexity depends on the number of distinct email addresses. In the worst case, if all email addresses are unique, the space required would be **O(N)**, where N is the number of rows in the table.  If there are fewer distinct email addresses, the space complexity would be lower.
    