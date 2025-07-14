create database pizzhut;

create table orders (
order_id int not null ,
order_date date not null ,
order_time time not null ,
primary key(order_id));


create table orders_details (
order_details_id int not null ,
order_id int not null ,
pizz_id text not null ,
quantiy int not null ,
primary key(order_details_id));

alter table orders_details
change pizz_id pizza_id varchar(50) ;
alter table orders_details
change quantiy quantity int not null ;


-- 1. Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS Total_Orders
FROM
    orders;


-- 2. Calculate the total revenue generated from pizza sales

SELECT 
    ROUND(SUM(orders_details.quantiy * pizzas.price),
            2) AS total_sales
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id
    
 
 
-- 3. Identify the highest-priced pizza

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


-- 4. Identify the most common pizza size ordered.

SELECT 
    quantity, COUNT(order_details_id)
FROM
    orders_details
GROUP BY quantity;



SELECT 
    pizzas.size,
    COUNT(orders_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
LIMIT 1;


-- 5. List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5; 

