SELECT *,
    (
    IF(X+Y>Z AND Y+Z>X AND Z+X>Y ,"Yes","No")
    ) as "triangle"
 FROM TRIANGLE;

