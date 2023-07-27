--Inserting the data:
select * from sales_data

--Describe the table: 
select * from information_schema.columns 
where table_name = 'sales_data'

--Use some Functions:
select count(*) from sales_data
select sum(sales) from sales_data
select avg(sales) from sales_data
select count(distinct country) from sales_data
select count(distinct customername) from sales_data

--Check some unique values:
select distinct status from sales_data
select distinct year_id from sales_data
select distinct productline from sales_data

--Remove the unwanted columns:
Alter table sales_data 
drop column phone,city, state, postalcode, territory

select * from sales_data

--Change orderdate format:
alter table  sales_data 
add orderdateupdated Date

update sales_data 
set orderdateupdated=convert(date,orderdate)

select * from sales_data

--Concat 2 tables of Addressline as Address:
select *, addressline1 + ':' + isnull(addressline2,'') as Address from sales_data
 
 --Concat 2 name columns as Contactfullname:
alter table  sales_data 
add CONTACTFULLNAME nvarchar(100)

update sales_data 
set Contactfullname= contactfirstname + ' ' + contactlastname 
where contactfirstname is not null and contactlastname is not null

select * from sales_data

--Analysis:

--1. what is minum and maximum sales?
select max(sales) as max_sales,min(sales) as min_sales from sales_data

--2.Display minimum and maxmimum sales for each status on 2004.
select status, max(sales) as max_sales,min(sales) as min_sales from sales_data where year_id= '2004' group by status

--3.What is monthly sales of each financial year?
select year_id,month_id,sum(sales) as monthly_sales from sales_data group by year_id,month_id order by year_id 

--4.What was the best year for sales?
select year_id,sum(sales) as yearly_sales from sales_data group by year_id

--5.What is time range of data?
select year_id, count(distinct month_id) as no_of_months from sales_data group by year_id

--6.What product sold the most?
select productline, sum(sales) as total_sales,count(ordernumber) as no_of_orders from sales_data  
group by productline order by count(ordernumber) desc

--7.which are the countries gives maximum sales?
select country, sum(sales) from sales_data group by country order by sum(sales) desc

--8.List top 5 customers who had maximum sales.
select top 5 customername, sum(sales) as sum_of_sales from sales_data 
group by customername order by sum(sales) desc

--9.Display status with their sum of sales.
select status,sum(sales) as status_sales, count(status) as count_of_status from sales_data group by status

--10.Display status and Total sales for Australia country.
select status, sum(sales) as total_sales from sales_data where country='Australia' group by status

--11.Display count of contact's lastname is Nelson with status.
select status,count(contactlastname) from sales_data where contactlastname= 'Nelson' group by status

--Stored Procedure:

--1.Create stored procedure to display details of sales by specific productline.
create procedure specific_productline as
begin
select * from sales_data where productline='motorcycles'
end
go

exec specific_productline

--2.Create stored procedure to display details of sales where orderdate is greater than Mar 2003.
create procedure order_date as
begin
select * from sales_data where year(orderdateupdated)=2003 and month(orderdateupdated)>3
end
go

exec order_date




select distinct productcode from sales_data