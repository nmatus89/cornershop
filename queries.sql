-- Notes
-- Creation of tables in Postgresql

CREATE TABLE Orders (
    order_id varchar,
    lat float,
    lng float,
    dow int,
    promised_time time,
    actual_time time,
    on_demand varchar,
    picker_id varchar,
    driver_id varchar,
    store_branch_id varchar,
    total_minutes float);

CREATE TABLE Order_Product (
    order_id varchar,
    product_id varchar,
    quantity float,
    quantity_found float,
    buy_unit varchar);

CREATE TABLE Shoppers (
    picker_id varchar,
    seniority varchar,
    found_rate float,
    picking_speed float,
    accepted_rate float,
    rating float);

CREATE TABLE Storebranch (
    store_branch_id varchar,
    store varchar,
    lat float,
    lng float);

-- Tableau connection queries
-- Question 1 Calculate the number of orders per day of the week, distinguishing if the orders are on_demand.
SELECT dow, count(on_demand)
FROM orders
JOIN order_product
ON orders.order_id = order_product.order_id
WHERE on_demand = 'true' 
group by dow
order by dow;

SELECT dow, count(on_demand)
FROM orders
JOIN order_product
ON orders.order_id = order_product.order_id
WHERE on_demand = 'false' 
group by dow
order by dow;

--Question 2 Calculate the average quantity of distinct products that each order has, grouped by store
select store, avg(quantity)
from order_product
join orders
on orders.order_id = order_product.order_id
join storebranch
on orders.store_branch_id = storebranch.store_branch_id
group by store
order by avg(quantity) asc;

-- Question 3 Calculate the average found rate(*) of the orders grouped by the product format and day of the week.
select dow, avg(shoppers.found_rate), buy_unit
from shoppers
join orders
on orders.picker_id = shoppers.picker_id
join order_product
on orders.order_id = order_product.order_id
group by dow, buy_unit
order by buy_unit asc;