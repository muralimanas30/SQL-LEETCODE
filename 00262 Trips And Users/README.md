# 00262 - Trips And Users
    
**Language:** Mysql  
**Runtime:** 493 ms (Beats 97.01% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 262 | Trips and Users | [LeetCode Problem](https://leetcode.com/problems/trips-and-users/) |

---

## 💡 **Problem Explanation**

The problem requires calculating the cancellation rate for each day between '2013-10-01' and '2013-10-03'.  The cancellation rate is defined as the number of cancelled trips divided by the total number of trips for each day.  Trips involving banned users (either as clients or drivers) are excluded from the calculation.

**Example:**

**Trips Table:**

| Id | Client_Id | Driver_Id | City_Id | Status              | Request_at |
|----|-----------|-----------|---------|---------------------|------------|
| 1  | 1         | 10        | 1       | completed           | 2013-10-01 |
| 2  | 2         | 11        | 1       | cancelled_by_client | 2013-10-01 |
| 3  | 3         | 12        | 6       | completed           | 2013-10-01 |
| 4  | 4         | 13        | 6       | cancelled_by_driver | 2013-10-01 |
| 5  | 1         | 10        | 1       | completed           | 2013-10-02 |
| 6  | 2         | 11        | 6       | completed           | 2013-10-02 |
| 7  | 3         | 12        | 6       | completed           | 2013-10-02 |
| 8  | 2         | 12        | 12      | completed           | 2013-10-03 |
| 9  | 3         | 10        | 12      | completed           | 2013-10-03 |
| 10 | 4         | 13        | 12      | cancelled_by_client | 2013-10-03 |

**Users Table:**

| Users_Id | Banned | Role   |
|----------|--------|--------|
| 1        | No     | client |
| 2        | Yes    | client |
| 3        | No     | client |
| 4        | No     | client |
| 10       | No     | driver |
| 11       | No     | driver |
| 12       | No     | driver |
| 13       | No     | driver |

**Expected Output:**

| Day        | Cancellation Rate |
|------------|-------------------|
| 2013-10-01 | 0.33              |
| 2013-10-02 | 0.00              |
| 2013-10-03 | 0.50              |

## 📊 **Algorithm**

*   **Filter Trips:** Filter out trips that occurred between '2013-10-01' and '2013-10-03'. Also, exclude trips where either the client or the driver is banned.
*   **Calculate Cancelled Trips:** Count the number of cancelled trips for each day.  A trip is considered cancelled if the status starts with 'cancelled_by\_'.
*   **Calculate Total Trips:** Count the total number of trips for each day.
*   **Calculate Cancellation Rate:** Divide the number of cancelled trips by the total number of trips for each day. Handle cases where there are no trips to avoid division by zero.
*   **Format Output:** Round the cancellation rate to two decimal places.

## 🔥 **Code Implementation**

```mysql
WITH COUNT_OF_CANCEL AS (
    SELECT 
        T.REQUEST_AT AS DAY,
        COUNT(*) AS CANCELLED
    FROM TRIPS T
    JOIN USERS U1 ON T.CLIENT_ID = U1.USERS_ID
    JOIN USERS U2 ON T.DRIVER_ID = U2.USERS_ID
    WHERE T.STATUS LIKE 'cancelled_by_%'
      AND U1.BANNED = 'No'
      AND U2.BANNED = 'No'
      AND T.REQUEST_AT BETWEEN '2013-10-01' AND '2013-10-03'
    GROUP BY T.REQUEST_AT
),
COUNT_OF_TOTAL AS (
    SELECT 
        T.REQUEST_AT AS DAY,
        COUNT(*) AS TOTAL_TRIPS
    FROM TRIPS T
    JOIN USERS U1 ON T.CLIENT_ID = U1.USERS_ID
    JOIN USERS U2 ON T.DRIVER_ID = U2.USERS_ID
    WHERE U1.BANNED = 'No'
      AND U2.BANNED = 'No'
      AND T.REQUEST_AT BETWEEN '2013-10-01' AND '2013-10-03'
    GROUP BY T.REQUEST_AT
)
SELECT 
    C_TOTAL.DAY AS Day,
    ROUND(
        IFNULL(C_CANCEL.CANCELLED,0) /
        IFNULL(C_TOTAL.TOTAL_TRIPS,0), 2)
        AS 'Cancellation Rate'
FROM COUNT_OF_TOTAL C_TOTAL
LEFT JOIN COUNT_OF_CANCEL C_CANCEL ON C_TOTAL.DAY = C_CANCEL.DAY;
```

## 📊 **ASCII Representation**

```
+------------+-------------+-------------+---------+---------------------+------------+
|     Id     |  Client_Id  |  Driver_Id  | City_Id |       Status        | Request_at |
+------------+-------------+-------------+---------+---------------------+------------+
|      1     |      1      |     10      |    1    |      completed      | 2013-10-01 |
|      2     |      2      |     11      |    1    | cancelled_by_client | 2013-10-01 |
|      3     |      3      |     12      |    6    |      completed      | 2013-10-01 |
|      4     |      4      |     13      |    6    | cancelled_by_driver | 2013-10-01 |
|      5     |      1      |     10      |    1    |      completed      | 2013-10-02 |
|      6     |      2      |     11      |    6    |      completed      | 2013-10-02 |
|      7     |      3      |     12      |    6    |      completed      | 2013-10-02 |
|      8     |      2      |     12      |   12    |      completed      | 2013-10-03 |
|      9     |      3      |     10      |   12    |      completed      | 2013-10-03 |
|     10     |      4      |     13      |   12    | cancelled_by_client | 2013-10-03 |
+------------+-------------+-------------+---------+---------------------+------------+

+----------+--------+--------+
| Users_Id | Banned |  Role  |
+----------+--------+--------+
|     1    |   No   | client |
|     2    |  Yes   | client |
|     3    |   No   | client |
|     4    |   No   | client |
|    10    |   No   | driver |
|    11    |   No   | driver |
|    12    |   No   | driver |
|    13    |   No   | driver |
+----------+--------+--------+
```

## 📊 **WORKING**

Let's trace the query execution with the sample input:

1.  **COUNT_OF_CANCEL Subquery:**

    *   Filters `Trips` table to include only the rows where the status starts with `cancelled_by_` and the `Request_at` date falls between `2013-10-01` and `2013-10-03`, excluding banned users.
    *   For `2013-10-01`:  Trips with ID 2 (Client ID 2 is banned, so this trip is excluded), and ID 4 (Client ID 4 is not banned). Therefore, the count is 1.
    *   For `2013-10-02`: No trips are cancelled.  Therefore, the count is 0.
    *   For `2013-10-03`: Trip with ID 10 (Client ID 4 is not banned). Therefore, the count is 1.

    Result:

    | DAY        | CANCELLED |
    |------------|-----------|
    | 2013-10-01 | 1         |
    | 2013-10-03 | 1         |

2.  **COUNT_OF_TOTAL Subquery:**

    *   Filters the `Trips` table for trips between '2013-10-01' and '2013-10-03', excluding banned users.
    *   For `2013-10-01`:  Trips with IDs 1, 2(excluded), 3, 4.  The count is 3.
    *   For `2013-10-02`:  Trips with IDs 5, 6(excluded), 7. The count is 2.
    *   For `2013-10-03`:  Trips with IDs 8, 9, 10. The count is 3.

    Result:

    | DAY        | TOTAL\_TRIPS |
    |------------|--------------|
    | 2013-10-01 | 3            |
    | 2013-10-02 | 2            |
    | 2013-10-03 | 3            |

3.  **Final SELECT Statement:**

    *   `LEFT JOIN` the results of `COUNT_OF_TOTAL` (aliased as `C_TOTAL`) with `COUNT_OF_CANCEL` (aliased as `C_CANCEL`) on the `DAY` column.
    *   Calculates the cancellation rate using `IFNULL(C_CANCEL.CANCELLED, 0) / IFNULL(C_TOTAL.TOTAL_TRIPS, 0)`. The `IFNULL` function handles cases where either the number of cancelled trips or the total number of trips is zero, preventing division by zero errors.
    *   Rounds the cancellation rate to two decimal places using `ROUND(..., 2)`.

| C_TOTAL.DAY | C_CANCEL.CANCELLED | C_TOTAL.TOTAL\_TRIPS | Cancellation Rate Calculation           | Cancellation Rate |
|-------------|--------------------|----------------------|-----------------------------------------|-------------------|
| 2013-10-01  | 1                  | 3                    | ROUND(1 / 3, 2)                         | 0.33              |
| 2013-10-02  | NULL               | 2                    | ROUND(IFNULL(NULL, 0) / 2, 2)           | 0.00              |
| 2013-10-03  | 1                  | 3                    | ROUND(1 / 3, 2)                         | 0.33       |

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity is dominated by the joins and group by operations. Assuming the size of the `Trips` table is *T* and the size of the `Users` table is *U*, the joins will take O(T \* U) in the worst case, but with indexes on `USERS_ID`, the lookups would be faster. The `GROUP BY` operation would be approximately O(T log T). Therefore, the overall time complexity would be roughly **O(T log T)**, considering indexes.
*   **Space Complexity:** The space complexity is determined by the size of the intermediate tables created by the CTEs (`COUNT_OF_CANCEL` and `COUNT_OF_TOTAL`). In the worst case, these tables could have a size proportional to the number of distinct days in the `Trips` table, leading to **O(D)** where D is the number of distinct days within the specified range (in this case, a maximum of 3).
    