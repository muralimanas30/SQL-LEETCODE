# 00608 - Tree Node
    
**Language:** Mysql  
**Runtime:** 463 ms (Beats 80.55% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title    | 🔗 Link                                    |
| ------------------ | ------------- | ------------------------------------------ |
| 608                | Tree Node   | [LeetCode Problem](https://leetcode.com/problems/tree-node/) |

---

## 💡 **Problem Explanation**

The problem requires you to classify each node in a binary tree as either a 'Root', an 'Inner' node, or a 'Leaf' node based on its presence and relationships in the `TREE` table.

*   **Root:** A node that is the root of the tree (has no parent).
*   **Inner:** A node that has a parent and also has children (appears as a parent to other nodes).
*   **Leaf:** A node that has a parent but does not have any children (does not appear as a parent to any other node).

**Sample Input:**

```
TREE Table:
+----+------+
| id | p_id |
+----+------+
| 1  | null |
| 2  | 1    |
| 3  | 1    |
| 4  | 2    |
| 5  | 2    |
+----+------+
```

**Expected Output:**

```
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Leaf  |
| 5  | Leaf  |
+----+-------+
```

---

## 📊 **Algorithm**

*   For each node in the `TREE` table:
    *   If `p_id` is `NULL`, the node is a 'Root'.
    *   If the `id` appears as a `p_id` in any row of the `TREE` table, the node is an 'Inner' node.
    *   Otherwise, the node is a 'Leaf'.

---

## 🔥 **Code Implementation**

```mysql
# Write your MySQL query statement below

SELECT ID,
    (
        CASE WHEN P_ID IS NULL THEN "Root"
            WHEN ID IN (SELECT P_ID FROM TREE WHERE P_ID IS NOT NULL) THEN "Inner"
            ELSE "Leaf"
        END
    ) as type
FROM TREE;
```

---

## 📊 **ASCII Representation**

```
TREE Table:

+-------+-------+
| ID    | P_ID  |
+-------+-------+
| 1     | NULL  |
| 2     | 1     |
| 3     | 1     |
| 4     | 2     |
| 5     | 2     |
+-------+-------+
```

---

## 📊 **WORKING**

Let's trace the query with the sample input.

1.  **Outer Query:**  The main query iterates through each row of the `TREE` table.

2.  **`CASE` Statement:**  For each row, the `CASE` statement determines the node type.

    *   **Row 1: ID = 1, P_ID = NULL**
        *   `P_ID IS NULL` is true.
        *   Node type is "Root".

    *   **Row 2: ID = 2, P_ID = 1**
        *   `P_ID IS NULL` is false.
        *   The subquery `(SELECT P_ID FROM TREE WHERE P_ID IS NOT NULL)` returns `1, 1, 2, 2`.
        *   `ID IN (1, 1, 2, 2)` is true (2 is in the result).
        *   Node type is "Inner".

    *   **Row 3: ID = 3, P_ID = 1**
        *   `P_ID IS NULL` is false.
        *   The subquery `(SELECT P_ID FROM TREE WHERE P_ID IS NOT NULL)` returns `1, 1, 2, 2`.
        *   `ID IN (1, 1, 2, 2)` is false (3 is not in the result).
        *   Node type is "Leaf".

    *   **Row 4: ID = 4, P_ID = 2**
        *   `P_ID IS NULL` is false.
        *   The subquery `(SELECT P_ID FROM TREE WHERE P_ID IS NOT NULL)` returns `1, 1, 2, 2`.
        *   `ID IN (1, 1, 2, 2)` is false (4 is not in the result).
        *   Node type is "Leaf".

    *   **Row 5: ID = 5, P_ID = 2**
        *   `P_ID IS NULL` is false.
        *   The subquery `(SELECT P_ID FROM TREE WHERE P_ID IS NOT NULL)` returns `1, 1, 2, 2`.
        *   `ID IN (1, 1, 2, 2)` is false (5 is not in the result).
        *   Node type is "Leaf".

3.  **Final Result:** The query returns the `ID` and the determined `type` for each node.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the subquery, which iterates through the `TREE` table for each row in the outer query. This results in a time complexity of **O(N^2)**, where N is the number of nodes in the tree.

*   **Space Complexity:** The space complexity is **O(N)**, mainly due to the space required to store the result of the subquery in the `IN` clause in the worst-case scenario, where all `P_ID` values are stored.
    