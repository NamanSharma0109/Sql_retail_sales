create database p1;
use p1;
drop table if exists Retail_sales;
CREATE TABLE Retail_sales 
          (
			  transactions_id int ,
			  sale_date DATE,	
              sale_time time,
			  customer_id INT,
			  gender VARCHAR(15),
			  age INT DEFAULT NULL,
			  category VARCHAR(15),
			  quantity int DEFAULT NULL,
			  price_per_unit Float DEFAULT NULL,
			  cogs Float DEFAULT NULL,
			  total_sale Float DEFAULT NULL
         );
select * from Retail_sales;
select count(*) from Retail_sales;
select * from retail_sales 
where sale_date is null
or
transactions_id is null
or
sale_time is null 
or
customer_id is null
or
gender is null 
or
category is null
or 
quantity is null 
or
price_per_unit is null
or 
cogs is null
or
total_sale is null;
SET SQL_SAFE_UPDATES = 0;

delete from retail_sales
where sale_date is null
or
transactions_id is null
or
sale_time is null 
or
customer_id is null
or
gender is null 
or
category is null
or 
quantity is null 
or
price_per_unit is null
or 
cogs is null
or
total_sale is null;


-- data exploration
-- how many sales we have
select count(*) as  total_sales from retail_sales;

-- how manyunique coustomers r there
select count(distinct customer_id) as  total_customers from retail_sales;

-- HOW MANY UNOQUE CATEGORIES WE HAVE
select distinct CATEGORY as  catogory from retail_sales;

-- Data analisys and business key problem and answers

select * from retail_sales where sale_date='2022-11-05';
select *
from retail_sales where category='clothing'
and date_format(sale_date,'%Y-%m')='2022-11'
and quantity >=4;

select category,sum(total_sale) as net_sale, count(*) as total_orders from retail_sales
group by category;

select round(avg(age),0) as avg from retail_sales
where category= 'beauty';

select * from retail_sales 
where total_sale>10000;

select category,count(transactions_id) as total_transactions,gender from retail_sales
group by gender,category
order by category;

select * from(
select 
Year(sale_date) as year,
Month(sale_date) as month,
round(avg(total_sale),2) as avg_sale ,
rank() over(partition by Year(sale_date) order by round(avg(total_sale),2) desc) as rk
from retail_sales
group by year,month) as t1
where rk = 1 ;
-- order by 1,3 desc

select customer_id,sum(total_sale) as total_sales from retail_sales
group by customer_id
order by total_sales desc
limit 5;

select category,count(distinct customer_id) from retail_sales
group by category;


with hourly_sales as(
select *,
	case
		when extract(hour from sale_time) < 12 then 'morning'
        when extract(hour from sale_time) between 12 and 17 then 'afternoon'
        else 'evening'
	end as shift
from retail_sales
)
select shift,count(*) as total_orders from hourly_sales
group by shift;

-- End of project

