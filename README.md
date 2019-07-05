# MYSQL_assignment
Upgrad assignment no. 1

TASK 1:

#The database name is superstores_db
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
