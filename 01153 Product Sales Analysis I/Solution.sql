
SELECT p.product_name,a.year,a.price
from sales a
join product p
on a.product_id = p.product_id