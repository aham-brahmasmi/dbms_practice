create database practice_set;
use practice_set;

DROP TABLE IF EXISTS `customers`;
create TABLE customers (
customer_Id int(11) NOT NULL,
First_Name varchar(50) NOT NULL,
Last_Name varchar(50) NOT NULL,
phone varchar(50) NOT NULL,
creditLimit decimal(10,2) DEFAULT NULL,
PRIMARY KEY (`customer_Id`)
);
insert into customers(customer_Id,First_Name,Last_Name,phone,creditLimit) values
(103,'Atelier','Schmitt','08-7896 6578','21000.00'),(112,'Signal','King','7025551838','71800.00'),
(114,'Ferguson','Peter','03-952’4555','117300.00'),
(119,'Labrune','Janine ','40.67.8555','118200.00'),
(121,'Bergulfsen','Jonas','07-989555','81700.00'),
(124,'Nelson','Susan','4155551450','210500.00'),
(125,'Piestrzeniewicz','Zbyszek ','(26) 642-7555','0.00'),
(128,'Keitel','Roland','+49 69 66 90 2555','59700.00'),
(129,'Murphy','Julie','6505555787','64600.00'),
(131,'Lee','Kwai','2125557818','114900.00'),
(141,'Freyre','Diego ','(91) 555 94 44','227600.00'),
(144,'Berglund','Christina ','0921-12 3555','53100.00'),
(145,'Petersen','Jytte','31123555','83400.00'),
(146,'Saveley','Mary ','78.32.5555','123900.00'),
(148,'Eric','Jecob','+65 221 7555','103800.00'),
(151,'Young','Jeff','2125557413','138500.00');
DROP TABLE IF EXISTS `orders`;
CREATE TABLE orders(
order_Id int(11) NOT NULL,
order_Date date NOT NULL,
shipped_Date date DEFAULT NULL,
Deliver varchar(15) NOT NULL,
customer_Id int(11) NOT NULL,
PRIMARY KEY (order_Id),
FOREIGN KEY (customer_Id) REFERENCES customers(customer_Id)
on delete cascade
);
insert into orders(order_Id,order_Date,shipped_Date,Deliver,customer_Id) values
(10100,'2003-01-06','2003-01-13','Shipped',114),(10101,'2003-01-09','2003-01-18','Shipped',125),
(10102,'2003-01-10','2003-01-18','Shipped',129),(10103,'2003-01-29','2003-02-07','Shipped',121),
(10104,'2003-01-31','2003-02-09','Shipped',141),(10105,'2003-02-11','2003-02-21','Shipped',145);


show tables;
select * from customers;
select * from orders;
drop database practice_set;

-- 1. Write a Query to add a column package_stat to the table orders.
alter table orders add column package_stat varchar(500) default "-";

-- 2. Write a Query to change the package_stat column of orders table with 'not available' for all orders.
update orders set package_stat="not available";

-- 3. Write a Query to delete a row from customers table where credit_limit is 0.00
alter table orders add foreign key (customer_Id) references customers(customer_Id) on delete cascade;
delete from customers where creditLimit=0;
desc orders;

-- 4. Write a Query to display the first_name with the occurrence of ‘el’ in the customers tables
select first_name from customers where first_name like "%el%";

-- 5. Write a Query to prepare a list with customer name ,customer_id ,order_id for the customers whose 
#delivery status is shipped.

select c.customer_id,concat(c.first_name," ",c.last_name) full_name,o.order_id from customers c
join orders o on c.customer_id=o.customer_id
where o.deliver="Shipped";

-- 6.  Write a Query to get the number of customers with the creditLimit greater than 50000
select count(customer_id) total from customers where creditLimit>50000;

-- 7.  Write a Query to display the customer_id, name ( first name and last name ), order_id and deliver
#for all customers
select c.customer_id,concat(c.first_name," ",c.last_name) full_name,o.order_id,o.deliver from customers c
left join orders o on c.customer_id=o.customer_id;

-- 8.Write a Query to customer name in order of creditLimit smallest to highest.
select concat(first_name," ",last_name) full_name,creditLimit from customers order by creditLimit asc;
select * from customers;

-- 9.  Write a stored procedure by name order_day. The procedure should show the customer_id and the
# day on which he had made the order.
desc customers;
desc orders;
-- for single customer->
delimiter //
create procedure order_day(in id int)
begin
select c.customer_id,o.order_date from customers c
join orders o on c.customer_id=o.customer_id
where c.customer_id=id;
end;
//
delimiter ;

call order_day(114);

-- for all customer who had placed order->
delimiter //
create procedure order_dday()
begin
select c.customer_id,o.order_date from customers c
join orders o on c.customer_id=o.customer_id;
end;
//
delimiter ;
call order_dday();

-- 10.  Write a stored function by the name of cutomer_search. The stored function should return the
#maximum creditLimit made by any customer.
desc customers;
desc orders;

delimiter //
create function customer_search(id int)
returns int
deterministic
begin
declare max_credit_limit int;
select max(creditLimit) into max_credit_limit from customers where customer_id=id ;
return max_credit_limit;
end;
//
delimiter ;

select customer_search(114);

