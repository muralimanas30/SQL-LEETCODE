select stock_name,
    SUM(
        IF(OPERATION="BUY",-1*price,price)
    ) as capital_gain_loss
FROM STOCKS
GROUP BY STOCK_NAME
