# 00610 - Triangle Judgement
    
**Language:** Mysql  
**Runtime:** 268 ms (Beats 70.13% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 610 | Triangle Judgement | [LeetCode Problem](https://leetcode.com/problems/triangle-judgement/) |

---

## 💡 **Problem Explanation**

The task is to determine whether three given side lengths (X, Y, and Z) can form a valid triangle. A valid triangle must satisfy the triangle inequality theorem, which states that the sum of any two sides must be greater than the third side.

**Sample Input:**

```
+----+----+----+
| X  | Y  | Z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
```

**Sample Output:**

```
+----+----+----+----------+
| X  | Y  | Z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+
```

---

## 📊 **Algorithm**

*   Select all columns from the `TRIANGLE` table.
*   Use the `IF` function to check the triangle inequality theorem:
    *   `X + Y > Z`
    *   `Y + Z > X`
    *   `Z + X > Y`
*   If all three conditions are true, return "Yes"; otherwise, return "No".
*   Alias the result as "triangle".

---

## 🔥 **Code Implementation**

```mysql
SELECT *,
    (
    IF(X+Y>Z AND Y+Z>X AND Z+X>Y ,"Yes","No")
    ) as "triangle"
 FROM TRIANGLE;
```

---

## 📊 **ASCII Representation**

N/A - This problem does not involve grids or trees.

---

## 📊 **WORKING**

Let's walk through the sample input provided earlier:

**Input Table: TRIANGLE**

```
+----+----+----+
| X  | Y  | Z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
```

**Row 1: X = 13, Y = 15, Z = 30**

*   `X + Y > Z`  =>  `13 + 15 > 30`  =>  `28 > 30` (False)
*   Since one condition is false, the triangle inequality theorem is not satisfied.  The `IF` function returns "No".

**Row 2: X = 10, Y = 20, Z = 15**

*   `X + Y > Z`  =>  `10 + 20 > 15`  =>  `30 > 15` (True)
*   `Y + Z > X`  =>  `20 + 15 > 10`  =>  `35 > 10` (True)
*   `Z + X > Y`  =>  `15 + 10 > 20`  =>  `25 > 20` (True)
*   All three conditions are true. The `IF` function returns "Yes".

**Output Table:**

```
+----+----+----+----------+
| X  | Y  | Z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+
```

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity: O(N)** - where N is the number of rows in the `TRIANGLE` table. We iterate through each row once.
*   **Space Complexity: O(1)** - We only use a constant amount of extra space for the `triangle` column in the output.
    