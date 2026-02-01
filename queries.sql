-- KPI Quries
-- Total Customers 
SELECT COUNT(*) AS total_customers
FROM customers;

-- Churn Rate
SELECT ROUND(SUM(Churn='Yes')*100/COUNT(*),2) AS churn_rate_percent
FROM customers;

-- Active VS Churned
SELECT Churn, COUNT(*) AS count
FROM customers
GROUP BY Churn;

-- BUSINESS ANALYSIS

-- Churn by contract type
SELECT Contract, COUNT(*) AS total,
SUM(Churn='Yes') AS churned,
ROUND(SUM(Churn='Yes')*100/COUNT(*),2) AS churn_rate
FROM customers
GROUP BY Contract
ORDER BY churn_rate DESC;

-- Churn by payment method
SELECT PaymentMethod, ROUND(SUM(Churn='Yes')*100/COUNT(*),2) AS churn_rate
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- Avg tenure of churned customers
SELECT 
AVG(tenure) AS avg_tenure_churned
FROM customers
WHERE Churn='Yes';

-- Revenue loss from churn
SELECT 
ROUND(SUM(MonthlyCharges),2) AS monthly_revenue_loss
FROM customers
WHERE Churn='Yes';

-- High risk customers (< 6 months)
SELECT customerID, tenure, MonthlyCharges
FROM customers
WHERE tenure < 6 AND Churn='Yes';

-- CTE example
WITH churned AS (
    SELECT * FROM customers WHERE Churn='Yes'
)
SELECT AVG(MonthlyCharges) FROM churned;

-- Window function
SELECT 
customerID,
MonthlyCharges,
RANK() OVER (ORDER BY MonthlyCharges DESC) AS charge_rank
FROM customers;
