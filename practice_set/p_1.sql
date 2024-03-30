create table dept(deptno int(2),dname varchar(14),loc varchar(13),primary key(deptno));
desc dept;
insert into dept values(10,"ACCOUNTING","NEW YORK"),(20,"RESEARCH","DALLAS"),(30, "SALES", "CHICAGO"),(40,"OPERATIONS","BOSTON");
select * from dept;

create table emp(empno int(4),ename varchar(10),job varchar(9),hiredate date,sal float(7,2),
comm float(7,2), deptno int(2),foreign key(deptno) references dept(deptno) on update cascade on delete cascade);

INSERT INTO EMP (EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO)
VALUES
    (7369, 'SMITH', 'CLERK', '1980-12-17', 800, NULL, 20),
    (7499, 'ALLEN', 'SALESMAN', '1981-02-20', 1600, 300, 30),
    (7521, 'WARD', 'SALESMAN', '1981-02-22', 1250, 500, 30),
    (7566, 'JONES', 'MANAGER', '1981-04-02', 2975, NULL, 20),
    (7654, 'MARTIN', 'SALESMAN', '1981-09-28', 1250, NULL, 30),
    (7698, 'BLAKE', 'MANAGER', '1981-05-01', 2850, NULL, 30),
    (7782, 'CLARK', 'MANAGER', '1981-06-09', 2450, NULL, 10),
    (7788, 'SCOTT', 'ANALYST', '1982-12-09', 3000, NULL, 20),
    (7839, 'KING', 'PRESIDENT', '1981-11-17', 5000, NULL, 10),
    (7844, 'TURNER', 'SALESMAN', '1981-09-08', 1500, 0, 30),
    (7876, 'ADAMS', 'CLERK', '1983-01-12', 1100, NULL, 20),
    (7900, 'JAMES', 'CLERK', '1981-12-03', 950, NULL, 30),
    (7902, 'FORD', 'ANALYST', '1981-12-03', 3000, NULL, 20),
    (7934, 'MILLER', 'CLERK', '1982-01-23', 1300, NULL, 10);
	
    
    select * from emp;
    select * from dept;
    
    -- 1. Display only the EMPNO and ENAME columns from EMP table
    select empno,ename from emp;
    
    -- 2.Display all employees who are CLERKs and the MANAGERs.
    select empno,ename,job from emp where job in("CLERK","MANAGER");
    
    -- 3. Display the ENAME and JOB for all employees who belong to the same DEPTNO as employee ‘KING’.
     select e.ename,e.job,e.deptno from emp e
     join emp ee on(ee.ename="king")
     where e.deptno=ee.deptno;
     
     select e.ename,e.job,e.deptno from emp e
     join emp ee on e.deptno=ee.deptno
	 where ee.ename="king";
     
    
     
   -- 4.  Find the names of all employees hired in the month of February (of any year).
        select ename from emp where month(HIREDATE)=2;
        
   -- 5.  Display the employees in descending order of DEPTNO.
       select * from emp order by deptno desc;
       
   -- 6.  Display the employee name and employee number of the employees with the headings as NUMBER and NAME
         select empno number,ename name from emp;
         
   -- 7. Find the names of all employees who were hired on the last day of the month.
	     select ename from emp where day(hiredate)=day(LAST_DAY(HIREDATE));
        
   -- 8.  Find the name of the employee who is receiving the maximum salary
         select ename,sal from emp where SAL=(select max(SAL) from emp);
         
   -- 9.  Display the sum of SAL for all the employees belonging to DEPTNO 10.
          select sum(sal) total,deptno from emp where deptno=10 group by deptno;
         
   -- 10. Display the rows where JOB column ends with the letter ‘T’
          select * from emp where job like "%t";
		  
   -- 11. Write a stored procedure to convert a temperature in Fahrenheit (F) to its equivalent in Celsius (C). The
   --     required formula is:- C= (F-32)*5/9
   --     Insert the temperature in Centigrade into TEMPP table. Calling program for the stored procedure need not be written.	   

         create table tempp(id int primary key auto_increment,ce_temp float,far_temp float);
         
         delimiter //
         create procedure temp_convert(in temp_in_far float)
         begin
         declare temp_in_cel float;
         set temp_in_cel=(temp_in_far-32)*5/9;
         insert into tempp(ce_temp,far_temp)values(temp_in_cel,temp_in_far);
         end;
         //
         delimiter ;
         
		call temp_convert(33.8);
        select * from tempp;
        
	-- 12.  Write a stored function by the name of Num_cube. The stored function should return the cube of a  
	--      number ‘N’. The number ‘N’ should be passed to the stored function as a parameter. Calling program for
    --      the stored function need not be written.
    
    delimiter //
    create function num_cube(num float)
    returns float
    deterministic
    begin
    declare cube_of_num float;
    set cube_of_num=pow(num,3);
    return cube_of_num;
    end;
    //
    delimiter ;
    
    select num_cube(5.5);
    
    INSERT INTO EMP (EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO)
VALUES
    (8700, 'SMITH', 'CLERK', '1980-12-17', 800, NULL, 20);
    
    select * from emp;
