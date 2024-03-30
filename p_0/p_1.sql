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
     
   -- 4.  Find the names of all employees hired in the month of February (of any year).
        select ename from emp where month(HIREDATE)=2;
        
   -- 5.  Display the employees in descending order of DEPTNO.
       select * from emp order by deptno desc;
       
   -- 6.  Display the employee name and employee number of the employees with the headings as NUMBER and NAME
         select empno number,ename name from emp;
         
   -- 7. Find the names of all employees who were hired on the last day of the month.
		 select * from emp;