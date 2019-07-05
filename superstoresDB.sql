#TASK 1:

#The database name is superstoresdb
#This database contains sales details and transactions of a superstore. 
#The database has 5 tables:
# 1. cust_dimen : Contains details about customer and their respective locations.
# 2. prod_dimen : Contains product category and their subcategories. 
# 3. orders_dimen : Contains order no, date, and priority.
# 4. shipping_dimen : Contains ship date, order and shipping mode.
# 5. market_fact : Contains orderwise customerwise marketwise orderquantity, sales value, discount profit and shipping cost details.

#Using proper database design these tables will give us information which can be helpful
#and give numerous insights about profitablity and sales about various products using
#market and customer-wise comparisons by quering with the right code.
#They also have useful numeric facts.


#Primary and Foreign keys for different tables:

# 1. cust_dimen - Cust_id as Primary Key, no foreign key
# 2. prod_dimen - Prod_id as Primary Key, no foreign key 
# 3. orders_dimen - Ord_id as Primary Key, no foreign key
# 4. shipping_dimen - Shipping id as primary key, Order_ID as foreign key.
# 5. market_fact -  No Primary Key, Ord_id, Prod_id, Ship_id and Cust_id as foreign key.



#TASK 2: (BASIC ANALYSIS)


#1. Find the total and the average sales (display total_sales and avg_sales) 

select round(sum(Sales),2) as "TOTAL SALES", Round(avg(Sales),2) as "AVERAGE SALES" from market_fact;

#2.  Display the number of customers in each region in decreasing order of no_of_customers. The result should be a table with columns Region, no_of_customers 

select Region, count(Cust_id) as "No. of Customers" from cust_dimen group by Region order by count(Cust_id);

#3. Find the region having maximum customers (display the region name and max(no_of_customers)

select Region, count(Cust_id) as "No. of Customers" from cust_dimen group by Region order by count(Cust_id) DESC LIMIT 1;

#4. Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold) 

select Prod_id, sum(Order_Quantity) as "no_of_products sold" from market_fact group by Prod_id order by sum(Order_Quantity) DESC;

#5. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased) 

select c.Region as "Region", c.Customer_Name as "Customer Name", 
		p.Product_Sub_Category as "Product Sub Category", 
        sum(m.Order_Quantity) as "Order Quantity"
from market_fact m 
		join cust_dimen c on m.Cust_id = c.Cust_id
        join prod_dimen p on m.Prod_id = p.Prod_id
where c.Region = "ATLANTIC" and p.Product_Sub_Category = "TABLES"
group by c.Customer_Name
Order by sum(m.Order_Quantity) DESC;



#TASK 3: (ADVANCED ANALYSIS)


#1. Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?

select p.Product_Category as "Product Category", round(sum(m.Profit), 2) as "Profits"
from market_fact m 
        join prod_dimen p on m.Prod_id = p.Prod_id
group by p.Product_Category
Order by sum(m.Profit) DESC;

#2. Display the product category, product sub-category and the profit within each subcategory in three columns.

select p.Product_Category as "Product Category", p.Product_Sub_Category as "Product Sub Category",
		round(sum(m.Profit), 2) as "Total Profits"
from market_fact m 
        join prod_dimen p on m.Prod_id = p.Prod_id
group by p.Product_Sub_Category
Order by p.Product_Category;

#3. Where is the least profitable product subcategory shipped the most? For the least profitable product sub-category, display the  region-wise no_of_shipments and the profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region) 

select c.Region as "Region",count(m.Ship_id) as "No of Shipments", 
		round(sum(m.Profit),2) as "Profit in each region"
from market_fact m 
		join cust_dimen c on m.Cust_id = c.Cust_id
        join prod_dimen p on m.Prod_id = p.Prod_id
Where Product_Sub_Category = (
				Select p.Product_Sub_Category 
				from market_fact m 
					join prod_dimen p on m.Prod_id = p.Prod_id
					group by Product_Sub_Category
					order by sum(m.Profit)
					LIMIT 1) 
group by c.Region
order by sum(m.Profit);


#########################################END OF TASK#######################################