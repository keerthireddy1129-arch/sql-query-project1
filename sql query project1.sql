-- SQL Retail Sales Analysis - Keerthi1

CREATE DATABASE sql_project_p1;

--create table

drop table if exists retail_sales;
CREATE TABLE retail_sales
            (
              transactions_id	int primary key,
              sale_date	date,
              sale_time	time,
              customer_id int,
              gender varchar(20),
              age	int,
              category	varchar(20),
              quantiy	int,
			  price_per_unit float,
              cogs	float,
              total_sale float
            );
select * from retail_sales
limit 10;

select count(*) from retail_sales

select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_date is null


select * from retail_sales
where sale_time is null

---Data Cleaning


select * from retail_sales
where 
    transactions_id is null
	or
    sale_date is null
	or
    sale_time is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	price_per_unit is null

	---
 delete from retail_sales
 where
 transactions_id is null
	or
    sale_date is null
	or
    sale_time is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	price_per_unit is null


---Data Exploration

---How many sales we have?

select count (*) as total_sale from retail_sales 

---How many unique customers we have?

select count(distinct customer_id) as total_sale from retail_sales 

select count(distinct category) as total_sale from retail_sales 

select distinct category  from retail_sales 


---- Data Analysis and Business key problems and answers

---- Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select *
from retail_sales
where sale_date='2022-11-05';


---- Write a SQL query to retrive all the transactions where the category is 'clothing' and the quantity sold is more than 4 in the month of nov-2022?


select *
from retail_sales
where 
    category = 'Clothing'
    AND
    TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4


-----Write a SQL query to calculate the total sales(total_sale) for each category


select
     category,
	 SUM(total_sale) as net_sale,
	 COUNT(*) AS total_orders
from retail_sales
GROUP BY 1

---- write a SQL query to find the age of customers who purchased items from the 'beauty' category.


select
   ROUND(AVG(age), 2) as avg_age
   from retail_sales
   where category= 'Beauty'
   

----- write a SQL query to find all the transactions where the total_sale is greater than 1000.


select * from retail_sales
where total_sale > 1000


----- write a SQL query to find the total number of transactions (transacion_id) made by each gender in each category.

select 
category,
gender,
count(*) as  total_trans
from retail_sales
group by category,
gender
order by 1


---- write a SQL query to calculate the average sale for each month. find out best selling month each year.
select 
    year,
	month,
	avg_sale
from
(
   select 
   EXTRACT(year from sale_date) as year,
   EXTRACT(month from sale_date) as month,
   AVG(total_sale) as avg_sale,
   rank() over(partition by EXTRACT(year from sale_date) order by avg(total_sale) desc) as rank
   from retail_sales 
   group by 1,2
) as t1
where rank=1

-----order by 1,3 desc


----- write a SQL query to find the top 5 customers based on the hightest total sales


select
     customer_id,
	 sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5


------ write a SQL query to find the number of unique customers who purchased items from each category.


select
     category,
     count(distinct customer_id) as cnt_unique_cs
	from retail_sales	
group by category



----- write a SQL query to create each shift and number of orders(example morning<12, afternoon between 12 & 17, evening >17).

WITH hourly_sale
as
(
select *,
       CASE 
	       when extract ( hour from sale_time) <12 then 'morning'
		   when  extract ( hour from sale_time) between 12 and 17 then 'afternoon'
		   else 'evening'
		   end as shift
from retail_sales		   
)
select 
      shift,
      count(*) as total_orders
      from hourly_sale
	  group by shift


------select extract (hour from current_time)


-----End of project










