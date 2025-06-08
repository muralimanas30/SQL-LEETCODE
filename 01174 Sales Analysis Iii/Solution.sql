SELECT DISTINCT P.product_id, P.product_name
FROM Product P
JOIN Sales S
  ON P.product_id = S.product_id
WHERE S.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
  AND P.product_id NOT IN (
    SELECT product_id
    FROM Sales
    WHERE sale_date < '2019-01-01' OR sale_date > '2019-03-31'
  );
