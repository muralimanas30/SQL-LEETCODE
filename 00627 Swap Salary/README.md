# 00627 - Swap Salary
    
**Language:** Mysql  
**Runtime:** 279 ms (Beats 19.79% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title        | 🔗 Link                                          |
| ------------------ | ------------- | ------------------------------------------------- |
| 627                | Swap Salary   | [LeetCode Problem](https://leetcode.com/problems/swap-salary/) |

---

## 💡 **Problem Explanation**

The problem requires you to swap the gender (SEX column) of all employees in the `SALARY` table. If the gender is 'm', you should change it to 'f', and vice versa. This should be done directly in the table using an `UPDATE` statement.

**Example:**

**Input Table:** `SALARY`

| id  | name   | sex | salary |
| --- | ------ | --- | ------ |
| 1   | A      | m   | 2500   |
| 2   | B      | f   | 1500   |
| 3   | C      | m   | 5500   |
| 4   | D      | f   | 500    |

**Output Table:** `SALARY`

| id  | name   | sex | salary |
| --- | ------ | --- | ------ |
| 1   | A      | f   | 2500   |
| 2   | B      | m   | 1500   |
| 3   | C      | f   | 5500   |
| 4   | D      | m   | 500    |

---

## 📊 **Algorithm**
*   Use the `UPDATE` statement to modify the `SALARY` table.
*   Use the `IF` function to conditionally swap the gender. If the gender is 'm', change it to 'f'; otherwise, change it to 'm'.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
UPDATE SALARY
SET SEX = IF(SEX="m","f","m");
```

---

## 📊 **ASCII Representation**

This problem doesn't directly involve grids or trees, so an ASCII representation isn't applicable.

---

## 📊 **WORKING**

The query works by iterating over each row in the `SALARY` table.  For each row, it checks the value in the `SEX` column:

1.  **If `SEX` is 'm':** The `IF` function returns 'f', and the `SEX` column is updated to 'f'.

2.  **If `SEX` is 'f':** The `IF` function returns 'm', and the `SEX` column is updated to 'm'.

**Example:**

Let's walk through how the query would affect the example input table:

**Initial Table:**

| id  | name   | sex | salary |
| --- | ------ | --- | ------ |
| 1   | A      | m   | 2500   |
| 2   | B      | f   | 1500   |
| 3   | C      | m   | 5500   |
| 4   | D      | f   | 500    |

**Step-by-step execution:**

*   **Row 1 (id=1):** `SEX` is 'm', so it's updated to 'f'.
*   **Row 2 (id=2):** `SEX` is 'f', so it's updated to 'm'.
*   **Row 3 (id=3):** `SEX` is 'm', so it's updated to 'f'.
*   **Row 4 (id=4):** `SEX` is 'f', so it's updated to 'm'.

**Final Table:**

| id  | name   | sex | salary |
| --- | ------ | --- | ------ |
| 1   | A      | f   | 2500   |
| 2   | B      | m   | 1500   |
| 3   | C      | f   | 5500   |
| 4   | D      | m   | 500    |

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The `UPDATE` statement iterates through all rows of the `SALARY` table **once**. Therefore, the time complexity is **O(n)**, where `n` is the number of rows in the table.
*   **Space Complexity:** The `UPDATE` statement modifies the table in place. It doesn't use any significant extra space. Therefore, the space complexity is **O(1)**.
    