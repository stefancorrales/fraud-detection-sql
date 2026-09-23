-- =============================================
-- Credit Card Fraud Detection Analysis
-- Dataset: Kaggle Credit Card Fraud Detection
-- 284,807 transactions | 492 fraud cases
-- =============================================

-- Query 1: Dataset overview - fraud vs legitimate
SELECT 
    class,
    COUNT(*) as total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 4) as percentage
FROM transactions
GROUP BY class
ORDER BY class;

-- Query 2: Amount analysis by class
SELECT 
    class,
    ROUND(AVG(amount)::numeric, 2) as avg_amount,
    ROUND(MIN(amount)::numeric, 2) as min_amount,
    ROUND(MAX(amount)::numeric, 2) as max_amount,
    ROUND(SUM(amount)::numeric, 2) as total_amount
FROM transactions
GROUP BY class
ORDER BY class;

-- Query 3: Fraud rate by amount range
SELECT 
    CASE 
        WHEN amount < 10 THEN '0-10'
        WHEN amount < 50 THEN '10-50'
        WHEN amount < 100 THEN '50-100'
        WHEN amount < 500 THEN '100-500'
        WHEN amount < 1000 THEN '500-1000'
        ELSE '1000+'
    END as amount_range,
    SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) as fraud_count,
    SUM(CASE WHEN class = 0 THEN 1 ELSE 0 END) as legitimate_count,
    ROUND(SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as fraud_rate
FROM transactions
GROUP BY amount_range
ORDER BY fraud_rate DESC;

-- Query 4: Fraud patterns by hour of day
SELECT 
    FLOOR(time / 3600) as hour_of_day,
    SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) as fraud_count,
    SUM(CASE WHEN class = 0 THEN 1 ELSE 0 END) as legitimate_count,
    ROUND(SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 3) as fraud_rate
FROM transactions
WHERE time < 86400
GROUP BY hour_of_day
ORDER BY fraud_rate DESC
LIMIT 10;