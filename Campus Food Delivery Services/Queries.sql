#a)  display the max, min and average ratings for each feature when given 
#    a restaurant ID for all orders for that restaurant
select restaurant_id, order_id, max(restaurant_review) as max_rr,
min(restaurant_review) as min_rr,
avg(restaurant_review) as avg_rr,
max(driver_review) as max_dr,
min(driver_review) as min_dr,
avg(driver_review) as avg_dr
from ratings
where restaurant_id = 1;


-- b) display a count of the orders made by a customer for a specified date 
-- range when given a customer id
SELECT count(o.person_id) FROM campus_eats_fall2020.order o 
Join order_items oi 
on o.order_id = oi.order_id 
where o.person_id = 1
and date between '2020-10-22' and '2021-10-22'
group by o.person_id;


-- c) display total price of the orders by each customer (distinct) for a 
-- specified date range
SELECT sum(o.total_price) FROM campus_eats_fall2020.order o 
Join order_items oi 
on o.order_id = oi.order_id
where date between '2020-10-22' and '2021-10-22'
group by o.person_id;


-- d) display a particular customer’s rating for a restaurant
Select p.person_name,res.restaurant_name,rat.restaurant_review 
from campus_eats_fall2020.restaurant res
Join campus_eats_fall2020.ratings rat
on res.restaurant_id = rat.restaurant_id
Join campus_eats_fall2020.order o
on rat.order_id = o.order_id
Join campus_eats_fall2020.person p
on p.person_id = o.person_id
where p.person_id=1
and res.restaurant_id=1
group by o.order_id;


-- e)  Have one of the above requirements represented in a View--Query1
CREATE VIEW rate AS
select restaurant_id, order_id, max(restaurant_review) as max_rr,
min(restaurant_review) as min_rr,
avg(restaurant_review) as avg_rr,
max(driver_review) as max_dr,
min(driver_review) as min_dr,
avg(driver_review) as avg_dr
from ratings
where restaurant_id = 1;


-- f) stored procedure- total orders by customer
DROP PROCEDURE IF EXISTS total_order_by_customer
DELIMITER //
CREATE PROCEDURE total_order_by_customer ( in cus_id int, in datea VARCHAR(100), in dateb
VARCHAR(100), out total_order int)
BEGIN
SELECT COUNT(*)
INTO total_order
FROM campus_eats_fall2020.order o
Join order_items oi 
on o.order_id = oi.order_id 
WHERE o.person_id = cus_id 
AND date BETWEEN datea AND dateb;
END //
DELIMITER ;
set @cus_id=1, @datea='2020-10-22', @dateb='2021-10-22';
CALL total_order_by_customer(@cus_id, @datea, @dateb, @total_order);
select @total_order;