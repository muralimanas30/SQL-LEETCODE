# 00262 - Trips And Users

**Language:** MySQL  
**Runtime:** 493 ms (Beats 97.01% of users)  
**Memory:** 0B (Beats 100.00% of users)  

---

## 📝 LeetCode Problem

| 🔢 Problem Number | 📌 Title         | 🔗 Link                                                                 |
|------------------|------------------|------------------------------------------------------------------------|
| 262              | Trips and Users  | [LeetCode Problem](https://leetcode.com/problems/trips-and-users/)     |

---

## 💡 Problem Statement

Given two tables, `Trips` and `Users`, calculate the **cancellation rate** for each day between `'2013-10-01'` and `'2013-10-03'`. The cancellation rate is the number of cancelled trips divided by the total number of trips for each day. **Exclude** trips where either the client or the driver is a banned user.

---

## 🗃️ Table Schemas & Sample Data

### Trips

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

### Users

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

### Expected Output

| Day        | Cancellation Rate |
|------------|-------------------|
| 2013-10-01 | 0.33              |
| 2013-10-02 | 0.00              |
| 2013-10-03 | 0.50              |

---

## 🧭 SQL Approach Overview

- **Filtering:** Only trips between the specified dates and with non-banned users are considered.
- **Cancelled Trips:** Count trips where the status starts with `'cancelled_by_'`.
- **Total Trips:** Count all valid trips per day.
- **Cancellation Rate:** Divide cancelled by total trips, rounding to two decimals.
- **Why this approach?**  
  Using CTEs (Common Table Expressions) makes the logic modular and readable, and allows for easy aggregation and joining.

---

## 🗂️ Table & Query Structure

| Table         | Columns                                                                 |
|---------------|------------------------------------------------------------------------|
| Trips         | Id, Client_Id, Driver_Id, City_Id, Status, Request_at                   |
| Users         | Users_Id, Banned, Role                                                  |
| COUNT_OF_CANCEL (CTE) | DAY, CANCELLED (cancelled trips per day)                        |
| COUNT_OF_TOTAL (CTE)  | DAY, TOTAL_TRIPS (total trips per day)                          |

---

## 🪜 Step-by-Step Solution Breakdown

1. **COUNT_OF_CANCEL:**  
   - Join `Trips` with `Users` (clients and drivers).
   - Filter for non-banned users and status like `'cancelled_by_%'`.
   - Group by day and count cancelled trips.

2. **COUNT_OF_TOTAL:**  
   - Join `Trips` with `Users` (clients and drivers).
   - Filter for non-banned users.
   - Group by day and count total trips.

3. **Final SELECT:**  
   - Left join total trips with cancelled trips by day.
   - Calculate cancellation rate using `IFNULL` to handle days with zero cancellations.
   - Round the result to two decimal places.

---

## 🔄 Visual Query Flow (ASCII)

```
+-------------------+      +-------------------+
|   COUNT_OF_TOTAL  |<-----|      Trips        |
+-------------------+      +-------------------+
         |                          |
         |                          |
         v                          v
+-------------------+      +-------------------+
|  COUNT_OF_CANCEL  |      |      Users        |
+-------------------+      +-------------------+
         |                          |
         +-----------+--------------+
                     |
                     v
             +----------------------+
             |   Final SELECT JOIN  |
             +----------------------+
```

---

## 🧮 Walkthrough on Sample Input

### 1. COUNT_OF_CANCEL

| DAY        | CANCELLED |
|------------|-----------|
| 2013-10-01 | 1         |
| 2013-10-03 | 1         |

### 2. COUNT_OF_TOTAL

| DAY        | TOTAL_TRIPS |
|------------|-------------|
| 2013-10-01 | 3           |
| 2013-10-02 | 2           |
| 2013-10-03 | 3           |

### 3. Final Output

| C_TOTAL.DAY | C_CANCEL.CANCELLED | C_TOTAL.TOTAL_TRIPS | Cancellation Rate Calculation           | Cancellation Rate |
|-------------|--------------------|---------------------|-----------------------------------------|-------------------|
| 2013-10-01  | 1                  | 3                   | ROUND(1 / 3, 2)                         | 0.33              |
| 2013-10-02  | NULL               | 2                   | ROUND(IFNULL(NULL, 0) / 2, 2)           | 0.00              |
| 2013-10-03  | 1                  | 3                   | ROUND(1 / 3, 2)                         | 0.33              |

---

## 💻 MySQL Code Implementation

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

---

## 🛠️ Programming Workflow

### Numbered Steps

1. Filter out banned users from both clients and drivers.
2. Count cancelled trips per day (`COUNT_OF_CANCEL`).
3. Count total trips per day (`COUNT_OF_TOTAL`).
4. Left join total trips with cancelled trips by day.
5. Calculate and round the cancellation rate.

### Flowchart (ASCII)

```
[Start]
   |
   v
[Filter banned users]
   |
   v
[Count cancelled trips] ----+
   |                        |
   v                        v
[Count total trips]         |
   |                        |
   +-----------+------------+
               |
               v
      [Join & Calculate Rate]
               |
               v
            [End]
```

---

## 🚀 Time & Space Complexity

- **Time Complexity:** The time complexity is dominated by the joins and group by operations. Assuming the size of the `Trips` table is *T* and the size of the `Users` table is *U*, the joins will take O(T \* U) in the worst case, but with indexes on `USERS_ID`, the lookups would be faster. The `GROUP BY` operation would be approximately O(T log T). Therefore, the overall time complexity would be roughly **O(T log T)**, considering indexes.
- **Space Complexity:** The space complexity is determined by the size of the intermediate tables created by the CTEs (`COUNT_OF_CANCEL` and `COUNT_OF_TOTAL`). In the worst case, these tables could have a size proportional to the number of distinct days in the `Trips` table, leading to **O(D)** where D is the number of distinct days within the specified range (in this case, a maximum of 3).

---

## 📚 References

- [LeetCode Problem 262 - Trips and Users](https://leetcode.com/problems/trips-and-users/)
- [MySQL CTE Documentation](https://dev.mysql.com/doc/refman/8.0/en/with.html)
- [SQL JOINs Explained](https://www.sqlshack.com/sql-join-types-with-examples/)