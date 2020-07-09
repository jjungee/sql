SELECT *
FROM burgerstore;

SELECT sido, sigungu, storecategory, count(storecategory) cnt
FROM burgerstore
WHERE storecategory IN('BURGER KING', 'LOTTERIA', 'KFC')
GROUP BY sido, sigungu, storecategory;