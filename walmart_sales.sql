select * from walmart_sales;

-- checking for null values
select * from walmart_sales
where store is null
or `date` is null
or Weekly_Sales is null
or Holiday_Flag is null
or Temperature is null
or Fuel_Price is null
or cpi is null
or Unemployment is null;

-- updating date column to date type
select `date`, str_to_date(`date`, '%d-%m-%Y') as updated_date
from walmart_sales;

update walmart_sales
set `date` = str_to_date(`date`, '%d-%m-%Y');

alter table walmart_sales
modify column `date` date;

-- Which year had the highest sales?

select year(`date`) `year`, sum(weekly_sales)
from walmart_sales
group by `year`;

with max_sales as 
(select year(`date`) `year`, sum(weekly_sales) as sales
from walmart_sales
group by `year`
)
select `year`, sales
from max_sales
order by sales desc;

-- Total sales per store.

select store, sum(weekly_sales) as total_sales
from walmart_sales
group by store;


-- Top 5 weeks with the highest sales

select `date`, sum(weekly_sales) total_sales
from walmart_sales
group by `date`
order by total_sales desc
limit 5;

-- All holidays with their total sales.

select `date`, sum(weekly_sales) total_sales
from walmart_sales
group by `date`, Holiday_Flag
having holiday_flag = 1;

-- Average weekly sales across all stores.

select store, avg(weekly_sales)
from walmart_sales
group by store;

-- Show the total sales for holiday vs non-holiday.

select holiday_flag holiday, sum(weekly_sales) total_sales
from walmart_sales
group by Holiday_Flag
order by total_sales desc;

-- Show the average sales for holiday vs non-holiday.
select holiday_flag holiday, avg(weekly_sales) avg_sales
from walmart_sales
group by Holiday_Flag
order by avg_sales desc;

-- Find the minimum and maximum temperatures recorded.

select max(temperature), min(temperature)
from walmart_sales;

-- Top 5 stores which had the highest average sales on holidays.

select store, avg(weekly_sales) avg_sales_on_holidays
from walmart_sales
group by store, Holiday_Flag
having Holiday_Flag = 1
order by avg_sales_on_holidays desc
limit 5;

-- Rank stores by their total sales in descending order.

select store, sum(weekly_sales) total_sales
from walmart_sales
group by store
order by total_sales desc;

-- Find the average fuel price per month.

select substring(`date`,1, 7) months, avg(fuel_price)
from walmart_sales
group by months
order by months;

SELECT DATE_FORMAT(`Date`, '%Y-%m-01') AS months, avg(Fuel_Price)
FROM walmart_sales
group by months
order by months;

-- List stores where sales were above average and fuel prices were below average in the same week.

select store, avg(weekly_sales) as avg_sales, avg(fuel_price) as avg_fuel_price
from walmart_sales
group by store
having avg_sales > (select avg(weekly_sales) from walmart_sales)
and avg_fuel_price > (select avg(fuel_price) from walmart_sales);















