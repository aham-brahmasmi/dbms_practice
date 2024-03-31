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

select emp_info('rahul');

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

  delimiter //
create procedure updatejobtitle(in e_id int,in j_title varchar(60))
begin
	update employees
    set job_title=j_title
    where emp_id=e_id;
end;
//
delimiter ;

-- 10. Write a stored procedure that returns a list of all employees who have been with the company for more than a
--     specified number of years. The procedure should take an input parameter for the number of years.
use hr;
select * from employees;

delimiter //
create procedure empList(in year_spend int)
begin
	 select * from employees
     where timestampdiff(year,hire_date,now())>year_spend;
end;
//
delimiter ;

call empList(10);


-- 11. Write a stored function that takes an employee ID as an input parameter and returns the employee's salary.
 
 delimiter //
create function sal(emp_id int)
returns int
deterministic 
begin
	declare temp_sal int;
	select salary into temp_sal from employees
    where employee_id=emp_id;
    return temp_sal;
end;
// 
delimiter ;


-- 12. Write a stored function that takes an employee ID as an input parameter and returns the number of years the
--     employee has been with the company.

delimiter //
create function expr(emp_id int)
returns int
deterministic
begin
     declare exp int;
	 select timestampdiff(year,hire_date,now()) into exp from employees
     where employee_id=emp_id;
     return exp;
end;
//
delimiter ;

select expr(100);

-- 13. Write a stored function that takes a department ID as an input parameter and returns the total salary of all
--     employees in that department.

select * from employees;
select * from departments;

delimiter //
create function tot_sal(dep_id int)
returns int
deterministic
begin
	declare total int;
    select sum(salary) into total from employees
    where department_id=dep_id;
    return total;
end;
//
delimiter ;
use hr;
select tot_sal(90);


-- 14. Write a stored function that takes an employee ID as an input parameter and returns the employee's manager's name.

use practice_set;

delimiter //
create function emp_man(em_id int)
returns varchar(40)
deterministic
begin
	declare full_name varchar(70);
	select d.manager into full_name from departments d
    join employees e on e.emp_id=d.e_id
    where e.emp_id=em_id;
    return full_name;
end;
//
delimiter ;
select emp_man(7);

#######################################################################################################################################################
 -- Triggers
 
-- 1. How can MySQL triggers be used to automatically update employee records when a department is hanged?

# In this question updating employees table means changing the department_id from employees table when we do change the department_id in
# in departments table.

use hr;
delimiter //
create trigger update_emp_if_dept
before update on departments
for each row 
begin
update employees set department_id=new.department_id where department_id=Old.department_id;
end;
// 
delimiter ;

update departments set department_id=65 where department_id=60;

-- 2. What MySQL trigger can be used to prevent an employee from being deleted if they are currently assigned to a department?

delimiter //
create trigger prevent_del
before delete on employees
for each row
begin
 if old.DEPARTMENT_ID!=0 then
 signal sqlstate '45000' set message_text= 'cant delete employee with department ';
end if;
end;
//
delete from employees where employee_id=100;

-- 3. How can a MySQL trigger be used to send an email notification to HR when an employee is hired or terminated?
show triggers;

create table message(message varchar(50),emp_id int);

delimiter //
create trigger hire_mes
after insert on employee
for each row
begin
insert into message values("new emoloyee hired",new.id);
end;
//
delimiter ;


delimiter //
create trigger del_mes
before delete on employee
for each row
begin
insert into message values("employee terminated",old.id);
end;
//
delimiter ;

insert into employee values(545,"smitesh",1);
delete from employee where id=545;

