use [WaleMart Sales]

select *
from  [WalmartSalesData.csv]

ALTER TABLE [dbo].[WalmartSalesData.csv]
ALTER COLUMN [Quantity] FLOAT
------------------in this project we will but scope in branch ,customer , product and payment 
------------- first we will analyse branch operation 
---1. how many branches we have
select distinct branch
from [WalmartSalesData.csv]

---2. how many revenue from each branch 
select branch ,SUM(Total) as total_revenue
from [WalmartSalesData.csv]
group by Branch 

---3.which the most product line sold in each branch and total quantity
select Branch, [Product line],
COUNT([Product line]) as no_of_product_sold,
SUM(Quantity) AS Total_Quantity
from [WalmartSalesData.csv]
group by Branch,[Product line] 
order by no_of_product_sold desc



---with revenue
select Branch,
[Product line],
COUNT([Product line]) as no_of_product_sold,
SUM(Quantity) AS Total_Quantity,
round(SUM(Total),2) as total_Revenue,
city
from [WalmartSalesData.csv]
group by Branch,[Product line],city 
order by no_of_product_sold desc



---secound product 
---1.wich product line more profitable 
---------note the most profitability is more price and low tax to get high margin 
--
select [Product line],
sum([gross income]) as total_amt
from [WalmartSalesData.csv]
group by [Product line]
order by total_amt desc
---wich customer type order more 
select [Gender] , SUM([Quantity]) as total_qty,round(SUM([gross income]),2) as total_amt
from [WalmartSalesData.csv]
group by gender
order by total_amt desc

--- who many trx does each customer do 
select [Gender] , COUNT([Invoice ID]) as total_trx
from [WalmartSalesData.csv]
group by gender
order by total_trx desc

---wich payment method every customer do
select Gender,  Payment , COUNT(*) as Type_of_payment
from [WalmartSalesData.csv]
group by Payment, Gender
order by Type_of_payment desc
--per every city
select City,  Payment , COUNT(*) as Type_of_payment
from [WalmartSalesData.csv]
group by Payment, City
order by Type_of_payment desc


--total profits come from payment
select payment ,round(SUM( [gross income]),2) as total_profit_from
from [dbo].[WalmartSalesData.csv]
group by payment
order by total_profit_from desc
--- which product for each customer 
select [Product line],
[Gender],
COUNT(*) as totoal_product,
Branch
from [WalmartSalesData.csv]
group by branch,[Product line],[Gender]
order by totoal_product desc
---- customer gender no in each branch 
select Branch , 
		Gender,
		COUNT(*) as no_of_gender
from [WalmartSalesData.csv]
group by Branch,Gender
order by no_of_gender desc

--------------------customers VS Rate by city 
-------which city have good customer 
select City ,SUM(rating) as total_rating, Gender 
from [WalmartSalesData.csv]
group by City,Gender
order by total_rating


-------------------------in this section we will detect the other customers perfomance if them member or not 
select [Customer type],SUM(rating) tot_rating
from [WalmartSalesData.csv]
group by [Customer type]
order by tot_rating desc

select [Customer type],[Product line]
from [WalmartSalesData.csv]
