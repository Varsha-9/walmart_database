USE walmart_database;

-- 1️⃣ Count distinct branches
SELECT COUNT(DISTINCT Branch) AS total_branches
FROM walmart;

-- 2️⃣ Number of items sold for each payment method
SELECT payment_method,
       COUNT(*) AS no_of_payments,
       SUM(quantity) AS no_of_items_sold
FROM walmart
GROUP BY payment_method;

-- 3️⃣ Highest-rated category in every branch (with average rating)
-- Approach 1: Simple aggregation
SELECT DISTINCT branch, category,
       MAX(rating) AS max_rating,
       AVG(rating) AS avg_rating
FROM walmart
GROUP BY branch, category
ORDER BY branch, avg_rating DESC;

-- Approach 2: Using RANK for precise ranking
SELECT branch,
       RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS ranking,
       category,
       AVG(rating) AS avg_rating
FROM walmart
GROUP BY branch, category
ORDER BY branch;

-- 4️⃣ Identify busiest day for each branch (based on number of transactions)
SELECT *
FROM (
    SELECT branch, 
           DAYNAME(date) AS day_name,
           COUNT(*) AS no_of_transactions,
           RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS ranking
    FROM walmart
    GROUP BY branch, day_name
    ORDER BY branch, DAYOFWEEK(date)
) AS busiest_days
WHERE ranking = 1;

-- 5️⃣ Average, minimum, and maximum ratings of products for each city and category
SELECT city, category,
       AVG(rating) AS avg_rating,
       MIN(rating) AS min_rating,
       MAX(rating) AS max_rating
FROM walmart
GROUP BY city, category;

-- 6️⃣ Total profit per category 
-- Formula: total_profit = total * profit_margin
SELECT category,
       SUM(total * profit_margin) AS total_price
FROM walmart
GROUP BY category
ORDER BY total_price DESC;

-- 7️⃣ Most common payment method for each branch
SELECT *
FROM (
    SELECT branch, payment_method,
           COUNT(*) AS total_trans,
           RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS ranking
    FROM walmart
    GROUP BY branch, payment_method
) AS t
WHERE ranking = 1;

-- 8️⃣ Categorize sales into Morning, Afternoon, and Evening shifts
SELECT CASE 
           WHEN HOUR(time) < 12 THEN 'Morning'
           WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS time_day,
       COUNT(*) AS no_of_invoices
FROM walmart
GROUP BY time_day;

-- 9️⃣ Total profit per branch
SELECT branch,
       SUM(total_profit) AS total_profit
FROM walmart
GROUP BY branch
ORDER BY total_profit DESC;

-- 🔟 Top 5 categories by total profit in each branch
SELECT branch, category,
       SUM(total_profit) AS total_profit
FROM walmart
GROUP BY branch, category
ORDER BY branch, total_profit DESC
LIMIT 5;

-- 1️⃣1️⃣ Cumulative profit trend by date
SELECT date,
       SUM(total_profit) OVER (ORDER BY date) AS cumulative_profit
FROM walmart
ORDER BY date;

-- 1️⃣2️⃣ Day of the week with the highest average profit per branch
SELECT branch,
       DAYNAME(date) AS day_name,
       AVG(total_profit) AS avg_profit
FROM walmart
GROUP BY branch, day_name
ORDER BY branch, avg_profit DESC;
-- 1️⃣3️⃣ Profit category distribution
SELECT profit_category,
       COUNT(*) AS transaction_count,
       SUM(total_profit) AS total_profit
FROM walmart
GROUP BY profit_category
ORDER BY total_profit DESC;

