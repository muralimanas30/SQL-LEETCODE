# Write your MySQL query statement below
SELECT v.customer_id
,COUNT(IFNULL(T.transaction_id,0)) AS count_no_trans
FROM VISITS V
LEFT JOIN TRANSACTIONS T
ON V.VISIT_ID = T.VISIT_ID
WHERE T.transaction_id IS NULL
GROUP BY v.CUSTOMER_ID
