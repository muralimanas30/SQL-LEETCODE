# 00175 - Combine Two Tables
    
**Language:** Mysql  
**Runtime:** 417 ms (Beats 57.95% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**

| 🔢 Problem Number | 📌 Title            | 🔗 Link                                                       |
| ------------------ | ------------------ | ------------------------------------------------------------ |
| 175                | Combine Two Tables | [LeetCode Problem](https://leetcode.com/problems/combine-two-tables/) |

---

## 💡 **Problem Explanation**

The problem requires you to write a SQL query to report the first name, last name, city, and state for each person in the `Person` table. However, the address information (city and state) is stored in the `Address` table and is linked to the `Person` table via the `PersonId`. If an address is not available for a person, you should still display the person's name, but the city and state columns should contain `NULL` values.

**Example:**

**Person Table:**

| PersonId | FirstName | LastName |
| -------- | --------- | -------- |
| 1        | John      | Doe      |
| 2        | Jane      | Smith    |

**Address Table:**

| AddressId | PersonId | City        | State     |
| --------- | -------- | ----------- | --------- |
| 1         | 2        | New York    | New York  |

**Expected Output:**

| FirstName | LastName | City     | State    |
| --------- | -------- | -------- | -------- |
| John      | Doe      | NULL     | NULL     |
| Jane      | Smith    | New York | New York |

---

## 📊 **Algorithm**

*   Select `FirstName`, `LastName` from the `Person` table.
*   Select `City`, `State` from the `Address` table.
*   Perform a left join between the `Person` table and the `Address` table using `PersonId` as the joining key.
*   This will ensure that all rows from the `Person` table are included in the result, and if there is a matching row in the `Address` table, the corresponding `City` and `State` values are included. If there is no matching row in the `Address` table, the `City` and `State` values will be `NULL`.

---

## 🔥 **Code Implementation**

```mysql
SELECT P.FIRSTNAME,P.LASTNAME,A.CITY,A.STATE
FROM PERSON P
LEFT JOIN ADDRESS A
ON P.PERSONID = A.PERSONID;
```

---

## 📊 **ASCII Representation**

```
Person Table
+------------+--------------+-------------+
| PersonId   | FirstName    | LastName    |
+------------+--------------+-------------+
| 1          | John         | Doe         |
| 2          | Jane         | Smith       |
+------------+--------------+-------------+

Address Table
+------------+--------------+-------------+-----------+
| AddressId  | PersonId   | City        | State     |
+------------+--------------+-------------+-----------+
| 1          | 2          | New York    | New York  |
+------------+--------------+-------------+-----------+

Result Table (after LEFT JOIN)
+------------+--------------+-------------+-------------+-----------+
| FirstName  | LastName    | City        | State     |
+------------+--------------+-------------+-----------+
| John       | Doe         | NULL        | NULL      |
| Jane       | Smith       | New York    | New York  |
+------------+--------------+-------------+-----------+
```

---

## 📊 **WORKING**

Let's trace the SQL query with the given sample input.

1.  **`FROM PERSON P`**:  The query starts by selecting from the `PERSON` table, aliased as `P`.
2.  **`LEFT JOIN ADDRESS A ON P.PERSONID = A.PERSONID`**: A left join is performed with the `ADDRESS` table (aliased as `A`) based on the condition `P.PERSONID = A.PERSONID`.  This means all rows from the `PERSON` table will be included, even if there's no matching `PERSONID` in the `ADDRESS` table.
3.  **First Row (John Doe):**
    *   The first row in the `PERSON` table is `PersonId = 1, FirstName = John, LastName = Doe`.
    *   The query searches for `PersonId = 1` in the `ADDRESS` table. It finds no match.
    *   Since it's a left join, the row is included in the result, and the `City` and `State` values from the `ADDRESS` table are set to `NULL`.
    *   Result row: `FirstName = John, LastName = Doe, City = NULL, State = NULL`.
4.  **Second Row (Jane Smith):**
    *   The second row in the `PERSON` table is `PersonId = 2, FirstName = Jane, LastName = Smith`.
    *   The query searches for `PersonId = 2` in the `ADDRESS` table. It finds a match: `AddressId = 1, PersonId = 2, City = New York, State = New York`.
    *   The row is included in the result, and the `City` and `State` values from the `ADDRESS` table are used.
    *   Result row: `FirstName = Jane, LastName = Smith, City = New York, State = New York`.
5.  **`SELECT P.FIRSTNAME, P.LASTNAME, A.CITY, A.STATE`**: Finally, the query selects the specified columns, producing the final result.

---

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** The time complexity of this query is **O(n + m)**, where n is the number of rows in the `Person` table and m is the number of rows in the `Address` table. This is because the `LEFT JOIN` operation might need to compare each row in the `Person` table with each row in the `Address` table in the worst-case scenario (although optimized join implementations can improve this). However, the actual time complexity also depends on database indexing and optimization.

*   **Space Complexity:** The space complexity is **O(k)**, where k is the number of rows in the output result. In the worst case, if there's a one-to-one relationship between `Person` and `Address`, `k` could be equal to the number of rows in the `Person` table.
    