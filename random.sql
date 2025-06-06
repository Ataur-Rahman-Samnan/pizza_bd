CREATE TABLE customers(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
email VARCHAR(100)
);
INSERT INTO customers (customer_id, customer_name, email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com'),
(4, 'David', 'david@example.com'),
(5, 'Eva', 'eva@example.com');
CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1001, 1, '2025-01-01'),s
(1002, 2, '2025-01-05'),
(1003, 3, '2025-01-10'),
(1004, 2, '2025-01-15');
CREATE TABLE order_items (
order_item_id INT PRIMARY KEY,
order_id INT,
product_name VARCHAR(100),
quantity INT,
price DECIMAL(10, 2),
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
INSERT INTO order_items (order_item_id, order_id, product_name, quantity, price) VALUES
(1, 1001, 'Laptop', 1, 1000.00),
(2, 1001, 'Headphones', 2, 150.00),
(3, 1002, 'Smartphone', 1, 700.00),
(4, 1003, 'Tablet', 1, 300.00),
(5, 1004, 'Smartwatch', 3, 200.00);






#1



select  o.order_id, o.order_date, c.customer_name
from orders o
inner join customers c ON o.customer_id = c.customer_id



#2


 
 select order_item_id, order_id  , product_name , quantity, price , c.customer_name 
 from
(select order_item_id, oi.order_id  , product_name , quantity, price , o.customer_id
from order_items oi 
left join orders o 
on o.order_id =oi.order_id) as t1
left join customers c 
on t1.customer_id =c.customer_id 


#3
select  c.customer_id,
c.customer_name,
c.email,
ifnull(o.order_id,'no order') as order_id,
IFNULL(o.order_date,'no order') as order_date
from customers c
left join orders o 
on c.customer_id = o.customer_id

#4
select product_name , IFNULL(quantity , 'No order') as order_quantity
from order_items oi 
where quantity = 0

#5
select c.customer_id, c.customer_name from customers c 
left join orders o 
on c.customer_id = o.customer_id
where o.order_id is null

#6
select c.customer_id, c.customer_name, count(oi.order_item_id) AS total_item
from customers c
inner join orders o 
ON c.customer_id = o.customer_id
inner join order_items oi 
ON o.order_id = oi.order_id
group by c.customer_id, c.customer_name
having count(oi.order_item_id) > 1


