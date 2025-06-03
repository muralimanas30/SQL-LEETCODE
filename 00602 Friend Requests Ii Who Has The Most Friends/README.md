# 00602 - Friend Requests Ii Who Has The Most Friends
    
**Language:** Mysql  
**Runtime:** 291 ms (Beats 92.80% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 602 | FRIEND REQUESTS II WHO HAS THE MOST FRIENDS | [LeetCode Problem](https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/) |

---

## 💡 **Problem Explanation**

The problem asks us to find the person who has the most friends.  We are given a table `RequestAccepted` that contains `requester_id` and `accepter_id`, representing a friend request accepted between two people. We need to find the user ID that appears most frequently in either the `requester_id` or `accepter_id` columns.

**Example:**

**Input:**

`RequestAccepted` table:

| requester_id | accepter_id |
|--------------|-------------|
| 1            | 2           |
| 2            | 3           |
| 1            | 4           |

**Output:**

| id  | num |
|-----|-----|
| 1   | 2   |

**Explanation:**

- Person 1 has two friends (2 and 4).
- Person 2 has two friends (1 and 3).
- Person 3 has one friend (2).
- Person 4 has one friend (1).
Therefore, the person with the most friends is person 1, with 2 friends.
---

## 📊 **Algorithm**

*   Combine all `requester_id` and `accepter_id` into a single column.
*   Count the occurrences of each ID in the combined column.
*   Group by ID and order by the count in descending order.
*   Take the first entry (the ID with the highest count) as the result.

## 🔥 **Code Implementation**

```mysql
select id,count(*) as num
from (
select requester_id as id
from RequestAccepted

UNION ALL

select accepter_id as id
from RequestAccepted
) as friend_count
group by id
order by num desc
limit 1
```

## 📊 **ASCII Representation**

Let's visualize the table structure:

```
RequestAccepted Table:
+--------------+-------------+
| requester_id | accepter_id |
+--------------+-------------+
| INT          | INT         |
+--------------+-------------+
```

## 📊 **WORKING**

Let's trace the execution with the sample input:

`RequestAccepted` table:

| requester_id | accepter_id |
|--------------|-------------|
| 1            | 2           |
| 2            | 3           |
| 1            | 4           |

1.  **`UNION ALL` Subquery:**

    This combines `requester_id` and `accepter_id` into a single column named `id`.

    Result of the `UNION ALL`:

    | id  |
    |-----|
    | 1   |
    | 2   |
    | 1   |
    | 2   |
    | 3   |
    | 1   |

2.  **`GROUP BY` Clause:**

    Groups the combined IDs and counts occurrences of each ID.

    Result of `GROUP BY id`:

    | id  | count(*) |
    |-----|----------|
    | 1   | 2        |
    | 2   | 2        |
    | 3   | 1        |
    | 4   | 1        |

3.  **`ORDER BY` Clause:**

    Orders the results by the count in descending order.

    Result of `ORDER BY num DESC`:

    | id  | num |
    |-----|-----|
    | 1   | 2   |
    | 2   | 2   |
    | 3   | 1   |
    | 4   | 1   |

4.  **`LIMIT 1` Clause:**

    Selects the first row, which has the highest count.

    Final Result:

    | id  | num |
    |-----|-----|
    | 1   | 2   |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:**  The `UNION ALL` operation takes O(N) time, where N is the number of rows in `RequestAccepted`.  The `GROUP BY` operation can take O(N log N) in the worst case (for sorting). The `ORDER BY` clause also takes O(N log N). Finally, `LIMIT 1` is O(1).  Therefore, the overall time complexity is **O(N log N)**.

*   **Space Complexity:** The space complexity is **O(N)** due to storing the intermediate result of the `UNION ALL` operation and the counts for each ID during the `GROUP BY` operation.
    