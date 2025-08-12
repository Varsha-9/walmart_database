select * from walmart;
select count(*) from walmart;
select count(distinct(Branch)) from walmart;
-- no of items sold for each payment method
select payment_method,
count(*) as no_of_payments,
sum(quantity) as no_of_items_sold
 from walmart
group by payment_method;
-- identify higest rated category in every branch and dispaly branch, category and also avg rating 
select distinct(branch),category,
max(rating) as max_rating,
avg(rating) as avg_rating
from walmart
group by branch, category
order by branch, avg_rating desc;
-- take 2
select branch,
rank() over(partition by branch order by avg(rating) desc) as ranking,
category,
avg(rating) as avg_rating
from walmart
group by branch, category
order by branch;
-- identify the busiest day for each branch based on the number of transactions
select *
from
(
select branch, 
dayname(date) as day_name,
count(*) as no_of_transactions,
rank() over(partition by branch order by count(*) desc) as ranking
from walmart
group by branch , day_name
order by Branch, dayofweek(date)
)
where ranking = 1;
-- calculate the total quantity of items sold per payment method. list payment method and total quantity

-- calculate the average, maximum, minimum ratings of products for each city and list city, avg_rating, max_rating, Min_rating
select city, category,
avg(rating) as avg_rating,
min(rating) as min_rating,
max(rating) as max_rating
from walmart
group by city,category;
-- calculate the total profit for each category considering total_profit as (unit_price* quantity * profit_margin)
-- list category, total price ordered by highest to lowest
select category,
sum(total * profit_margin) as total_price
from walmart
group by category;
-- determine the most common payment method for each branch. display branch and the preferred _payment_method
select * from
(select branch, PAYMENT_METHOD,
count(*) as tota_trans,
rank() over(partition by Branch order by count(*) desc) as ranking
from walmart
group by Branch,payment_method
) as t
where ranking = 1;
-- categorize sales into 3 groups morning, afternoon, evening
-- find out each of the shift and number of invoices
select 
case 
when hour(time) <12 
then 'Morning'
when hour(time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as time_day
from walmart
group by time;