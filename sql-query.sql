--1. What are the top 5 brands by receipts scanned for most recent month?
SELECT B.name AS brand_name,
COUNT(*) AS receipts_scanned
FROM Receipts R
JOIN Transaction T ON R.receipt_id = T.receipt_id
JOIN Brand B ON T.brand_id = B.brand_id
WHERE YEAR(R.dateScanned) = YEAR(CURRENT_DATE) AND MONTH(R.dateScanned) = MONTH(CURRENT_DATE)
GROUP BY B.name
ORDER BY receipts_scanned DESC
LIMIT 5;

--2.  How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month? Query for Most Recent Month: This query retrieves the top 5 brands by receipts scanned for the most recent month
SELECT B.name AS brand_name, COUNT(*) AS receipts_scanned
FROM Receipts R
JOIN Transaction T ON R.receipt_id = T.receipt_id
JOIN Brand B ON T.brand_id = B.brand_id
WHERE YEAR(R.dateScanned) = YEAR(CURRENT_DATE) AND MONTH(R.dateScanned) = MONTH(CURRENT_DATE)
GROUP BY B.name
ORDER BY receipts_scanned DESC
LIMIT 5;

--Query for Previous Month: This query retrieves the top 5 brands by receipts scanned for the previous month:

SELECT B.name AS brand_name,
COUNT(*) AS receipts_scanned
FROM Receipts R
JOIN Transaction T ON R.receipt_id = T.receipt_id
JOIN Brand B ON T.brand_id = B.brand_id
WHERE YEAR(R.dateScanned) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND MONTH(R.dateScanned) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))
GROUP BY B.name
ORDER BY receipts_scanned DESC
LIMIT 5;

--3. When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
SELECT rewardsReceiptStatus,
AVG(totalSpent) AS average_spend
FROM Receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY rewardsReceiptStatus;

--4. When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
SELECT rewardsReceiptStatus,
SUM(purchasedItemCount) AS total_items_purchased
FROM Receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY rewardsReceiptStatus;

--5. Which brand has the most spend among users who were created within the past 6 months?
SELECT B.name AS brand_name, SUM(R.totalSpent) AS total_spend
FROM Receipts R
JOIN Transaction T ON R.receipt_id = T.receipt_id
JOIN Brand B ON T.brand_id = B.brand_id
JOIN Users U ON R.user_id = U.user_id
WHERE U.createdDate >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY B.name
ORDER BY total_spend DESC
LIMIT 1;

--6. Which brand has the most transactions among users who were created within the past 6 months?
SELECT B.name AS brand_name, COUNT(*) AS transactions_count
FROM Transaction T
JOIN Receipts R ON T.receipt_id = R.receipt_id
JOIN Brand B ON T.brand_id = B.brand_id
JOIN Users U ON R.user_id = U.user_id
WHERE U.createdDate >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY B.name
ORDER BY transactions_count DESC
LIMIT 1;