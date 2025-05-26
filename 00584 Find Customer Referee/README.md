# 00584 - Find Customer Referee
    
**Language:** Mysql  
**Runtime:** 528 ms (Beats 27.29% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 584 | Find Customer Referee | [LeetCode Problem](https://leetcode.com/problems/find-customer-referee/) |

---

## 💡 **Problem Explanation**

The problem requires you to find all customers who are not referred by customer with ID `2`. In other words, you need to select the names of customers from the `CUSTOMER` table where the `REFEREE_ID` is either `NULL` or not equal to `2`.

**Sample Input:**

Consider a table named `CUSTOMER`:

| ID  | Name    | Referee_ID |
|-----|---------|------------|
| 1   | Will    | NULL       |
| 2   | Jane    | NULL       |
| 3   | Mark    | 2          |
| 4   | Bill    | NULL       |
| 5   | Zack    | 1          |
| 6   | Sam     | NULL       |

**Expected Output:**

| Name    |
|---------|
| Will    |
| Jane    |
| Bill    |
| Sam     |

Customers Mark and Zack are excluded because Mark's `REFEREE_ID` is `2`, and Zack's `REFEREE_ID` is `1`.

## 📊 **Algorithm**

*   Select the `NAME` column from the `CUSTOMER` table.
*   Filter the rows based on the condition that `REFEREE_ID` is either `NULL` or not equal to `2`.
*   Return the filtered names.

## 🔥 **Code Implementation**

```mysql
SELECT NAME AS name
from CUSTOMER
WHERE REFEREE_ID IS NULL OR NOT REFEREE_ID = 2;
```

## 📊 **ASCII Representation**

Since this is a database query problem, an ASCII representation doesn't directly apply. However, we can represent the table structure for better understanding.

```
CUSTOMER Table:

+-------------+---------------+
| Column Name | Data Type     |
+-------------+---------------+
| id          | int           |
| name        | varchar       |
| referee_id  | int (nullable)|
+-------------+---------------+
```

## 📊 **WORKING**

Let's walk through the sample input:

| ID  | Name    | Referee_ID | Condition: REFEREE_ID IS NULL OR NOT REFEREE_ID = 2 | Result     |
|-----|---------|------------|-------------------------------------------------------|------------|
| 1   | Will    | NULL       | TRUE                                                  | Include    |
| 2   | Jane    | NULL       | TRUE                                                  | Include    |
| 3   | Mark    | 2          | FALSE                                                 | Exclude    |
| 4   | Bill    | NULL       | TRUE                                                  | Include    |
| 5   | Zack    | 1          | TRUE                                                  | Include    |
| 6   | Sam     | NULL       | TRUE                                                  | Include    |

As a result, Will, Jane, Bill, and Sam will be in the output, matching the expected output.  Zack will be included since REFEREE_ID is not equal to 2.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is **O(n)**, where n is the number of rows in the `CUSTOMER` table, as we need to scan all rows.
*   **Space Complexity:** The space complexity is **O(1)**, as we are not using any extra space that scales with the input size. The space used is constant.
    