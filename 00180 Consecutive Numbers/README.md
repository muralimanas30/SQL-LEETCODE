# 00180 - Consecutive Numbers
    
**Language:** Mysql  
**Runtime:** 577 ms (Beats 48.03% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 180 | Consecutive Numbers | [LeetCode Problem](https://leetcode.com/problems/consecutive-numbers/) |

---

## 💡 **Problem Explanation**

The problem asks us to find all numbers that appear at least three times consecutively in the `Logs` table.  We need to return a sorted list of these distinct numbers.

**Example:**

Suppose we have the following `Logs` table:

| id | num |
|----|-----|
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |

The numbers `1` appear three times consecutively (IDs 1, 2, and 3). Thus, the output should be:

| ConsecutiveNums |
|-----------------|
| 1               |

---

## 📊 **Algorithm**

*   Join the `Logs` table with itself twice using aliases `L1`, `L2`, and `L3`.
*   The join conditions are `L2.id + 1 = L1.id` and `L3.id + 1 = L2.id` to check for consecutive IDs.
*   Filter the results where `L1.num = L2.num` and `L2.num = L3.num` to find consecutive occurrences of the same number.
*   Use `DISTINCT` to retrieve only unique numbers.
*   Select the `num` from `L1` as `"ConsecutiveNums"`.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below
SELECT
DISTINCT(L1.NUM) AS "ConsecutiveNums"
FROM LOGS L1
JOIN LOGS L2
ON L2.ID+1 = L1.ID
JOIN LOGS L3
ON L3.ID+1 = L2.ID
WHERE L1.NUM = L2.NUM AND L2.NUM = L3.NUM
```

---

## 📊 **ASCII Representation**

Since this is a database problem, there is no grid or tree to represent visually. However, we can represent the table structure:

```
Logs Table:
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.
Each row of this table contains an id and a number.
```

## 📊 **WORKING**

Let's trace the execution with the example table:

| id | num |
|----|-----|
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |

1.  **Join Operations**: The query joins `Logs` with itself based on consecutive IDs.
2.  **Filtering**: The `WHERE` clause ensures that `L1.num`, `L2.num`, and `L3.num` are equal.

    *   (L1.id=3, L2.id=2, L3.id=1) satisfies the join condition and `L1.num = L2.num = L3.num = 1`.
    *   (L1.id=7, L2.id=6, L3.id=5) satisfies the join condition , but `L1.num = 2` `L2.num = 2` `L3.num = 1` thus not taken into consideration.

3.  **DISTINCT**:  The `DISTINCT` keyword ensures that we only return unique numbers. In this case, `1` is the only number that appears consecutively three times.
4.  **Result**:  The query returns 1.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The time complexity is **O(N)** where N is the number of rows in the `Logs` table, due to the join operations which effectively iterate through the table.

*   **Space Complexity:** The space complexity is **O(1)** because we are using constant extra space for variables, regardless of the input size.  The size of the intermediate tables created during the join operation depends on the data, but it does not scale linearly with the input size in a way that affects the overall space complexity.
    