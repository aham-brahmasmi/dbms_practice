show tables;

create table employees(
                     emp_id int primary key,
                     ename varchar(20) not null,
                     age int not null,
                     hobbies varchar(50) not null,
                     salary int not null check (salary>0),
                     address varchar(100) not null,
                     zip int not null unique
                     );
create table departments(
                      dept_id int primary key,
                      dept_name varchar(50),
                      e_id int,
                      manager varchar(50),
                      foreign key (e_id) references employees(emp_id)
                      on delete cascade on update cascade
                      );
                      
insert into employees values( 1,"mohit",23,"dancing", 10000,"Mumbai",500049),
(2,"aniket",27,"painting", 20000, "mumbai",500149),
(3,"ajay",31,"singing", 35000, "delhi",273008),
(4,"priyanka",42,"dancing", 55000, "delhi",123876),
(5,"deepika",26,"dancing", 10000, "delhi",500786),
(6,"saloni",28,"singing", 50000, "Mumbai",400149),
(7,"yash",34,"photography", 40000, "Mumbai",450049),
(8,"vinay",45,"painting", 70000, "Mumbai",273006);

insert into departments values (1,"ec",8, "virat"),
(2,"cs",7, "sachin"),
(3,"it",6, "rahul"),
(4,"it",5, "rahul"),
(5,"cs",4, "sachin"),
(6,"ec",3, "virat"),
(7,"ec",2, "virat"),
(8,"ec",1, "virat");


drop table employees;
drop table departments;
select * from employees;
select * from departments;
-- 1. Query to count No. of employees
     select count(distinct ename) total_emp from employees;
     
-- 2. Query to get unique department of employees
     select distinct dept_name from departments;
     
-- 3. Query to get min,max,avg,sum of salary for all employees
	  select min(salary) min_sal,max(salary) max_sal,avg(salary) avg_sal,sum(salary) total_sal from employees;
      
-- 4. Query for sum of salary where address starts with 'M' or 'd
      select sum(salary) from employees where address like "M%" or address like "D%";
    
-- 5. Get all employee details with their department details
   select e.*,d.* from employees e
   join departments d on e.emp_id=d.e_id;
   
-- 6. QUERY TO FIND employees age between 20 and 30
     select * from employees where age between 20 and 30;
     
-- 8. get highest salary of an individual based on hobbies
      select max(salary),hobbies from employees group by hobbies;

-- 7. function to return name,emp_id,dept_name,hobbies,age by passing manager name

delimiter //
create function emp_info(m_name varchar(50))
returns varchar(3000)
deterministic
begin
declare e_info varchar(3000);
	select group_concat(concat(e.ename," ",e.emp_id," ",d.dept_name," ",e.hobbies," ",e.age)separator ',') into e_info from employees e 
    join departments d on e.emp_id=d.e_id 
    where d.manager=m_name;
    return e_info;
end;
//
delimiter ;


-- 8.Write a stored procedure that deletes all employees who have a salary less than a specified amount. The
--   procedure should take an input parameter for the minimum salary.

delimiter //
create procedure delEMpLEssThanGivenSalary(in defSal float)
begin
	delete from employees
    where salary < defSal;
end;
// delimiter ;

call delEMpLEssThanGivenSalary(11000);


-- 9. Write a stored procedure that updates the job title for a given employee ID. The procedure should take input
--    parameters for the employee ID and the new job title.

