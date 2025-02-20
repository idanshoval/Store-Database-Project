-- DDL creating a fact table view
CREATE VIEW GOLD.Sales_information as 
select c.cart_id,c.userid,U.firstname,U.lastname,U.continent,U.country,U.city,U.email,p.id as product_id,P.title,P.category,P.price,c.quantity,c.purchase_date
from SILVER.Store_Cart_Sales c INNER JOIN SILVER.Store_Users U on c.userid=U.userid
INNER JOIN SILVER.Store_Products p on p.id=c.item


--Rank the most profitable customers for the company
Create view GOLD.Rank_Revenu_By_Customers_Report as 
select RANK() over(order by sum(price) desc) as 'Customer Profitability Rank', t.firstname,t.lastname,t.email,sum(price) as Revenu_By_Customer
from  GOLD.Sales_information t
group by t.userid,t.firstname,t.lastname,t.email

-- Which country is the most profitable based on the number of months
Create  View GOLD.Most_profitable_Country_By_Month as 
select  rank() over(partition by month(purchase_date) order by  sum(price*quantity) desc) as rank_ ,country,continent,sum(price*quantity) as sales, month(purchase_date) as month
from GOLD.Sales_information
group by  month(purchase_date),country,continent


-- What is the most profitable category by month
Create Procedure most_profitable_category_by_month
(@month_  int) 
as 
	begin
	select RANK() over(order by sum(t.price*t.quantity) desc ) as rank_best_category,t.category,sum(t.price*t.quantity) as sales
	from GOLD.Sales_information t
	where month(t.purchase_date)=@month_
	group by t.category
	end


-- checking store Procedure

exec most_profitable_category_by_month 3