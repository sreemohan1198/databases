///1 Display total number of records in Emp table?

select * from EMP;


///2 Display Ename, COMM in emp table. Display zero in place of null.

SELECT ENAME,COMM,ISNULL(COMM,0) FROM EMP

---update EMP set COMM=NULL WHERE COMM=0;


///3 Display Ename,COMM in emp table. Display "Not Eligible" in place of null.

SELECT ENAME,COMM,COALESCE(CAST(COMM AS VARCHAR(20)),'NOT ELIGIBLE') AS COMM_NEW
FROM EMP;


///4 SELECT ALL EMPLOYEES WHERE THEIR SAL IS LESS THAN SCOTT SAL
select * from  EMP;
select * from emp WHERE sal=max(sal) ;

select ENAME,SAL from EMP WHERE SAL<( SELECT SAL FROM EMP WHERE ENAME ='SCOTT');


///5 Write a query to display current date?

select GETDATE();


///6 Show all data of the clerks who have been hired after the Year 1981

select * from emp 
WHERE HIREDATE>('1981')

///7 Show the name, job, salary, and commission of those employees who earn commission. Sort the data by salary in descending order.

select ENAME,JOB,SAL,COMM from EMP 
WHERE COMM IS NOT NULL
ORDER BY SAL DESC;

///8-show all employees that have no commission with a 10% raise salary(round off the salaries)

SELECT ROUND(1.1*SAL,0)as AvgSalary FROM EMP WHERE COMM IS NULL; 

///9 Show the names of all employees together with the number of years and the number of completed months that they have been employed.
 
SELECT ENAME,SAL,HIREDATE,
  ---DATEDIFF(YEAR, HIREDATE, GETDATE()) AS years_employed, 
  DATEDIFF(MONTH, HIREDATE, GETDATE())/12 AS months_employed 
FROM EMP;
SELECT * FROM EMP;

---select ENAME,DATEDIFF(year,HIREDATE,GETDATE()) as 'year',
---DATEDIFF(month,HIREDATE,GETDATE())-(DATEDIFF(year,HIREDATE,GETDATE())*12) as 'month' from EMP;


///10 Show those employees that have a name starting with j,K,L or m.


SELECT * from EMP 
WHERE 
ENAME LIKE 'J%'
OR ENAME LIKE 'K%'
OR ENAME LIKE 'L%'
OR ENAME LIKE 'M%';


///11 Show all employees and indicate with yes or no whether they receive a commission

SELECT ENAME, IIF(COMM IS NOT NULL, 'YES', 'NO') FROM EMP;


///12 How many employees have a name that ends with an n? Create two possible solutions.

select ename from EMP;

SELECT COUNT(*) 
FROM EMP
WHERE ENAME LIKE '%n';


///13 Show all employees who were hired in the first half of the month (before the 16th of the month).

select ENAME,HIREDATE 
from EMP
WHERE MONTH(HIREDATE)<7 and day(HIREDATE) <16;


///14 Show the names, salaries and the number of dollars that all employees earn.

SELECT * FROM EMP;

SELECT ENAME,SAL, CONCAT('$', SAL) AS EMP_EARN_DOLLARS FROM EMP;



///15 Find the second highest salarv.

select * from EMP
WHERE SAL=(select Max(SAL) from EMP); ---to find highest salary

SELECT MAX(SAL) AS MAX_SALARY
From EMP 
WHERE SAL < ( SELECT Max(SAL) FROM EMP); ---to find sec highest salary


///16 How to list the top 10 employees in employee object.

select Top 10* from EMP;

///17 Getting Second highest Salary from table with fields empid, Name and Salary

SELECT SAL,ENAME,EMPNO
From EMP 
WHERE SAL = ( SELECT Max(SAL) 
				FROM EMP
				WHERE SAL < (SELECT MAX(SAL) FROM EMP));


///18 Show Empno, Ename, Job, Comm, Deptname, Salgrade for all employees.

select * from EMP;
select * from SALGRADE;
select * from DEPT;
select e. ENAME, e.JOB, e.SAL, e.COMM, d.DNAME, s.GRADE from EMP e
full join DEPT d on e. DEPTNO = d. DEPTNO
full join SALGRADE s on e.SAL between s. LOSAL and s.HISAL order by s. GRADE desc;



///19 Show Empno, Ename, Job, Comm, Deptname, Salgrade for all employees sort by Deptno and Salary.

select * from EMP;
select * from SALGRADE;
select * from DEPT;

select E.DEPTNO,e. ENAME, e.JOB, e.SAL, e.COMM, d.DNAME, s.GRADE from EMP e
full join DEPT d on e. DEPTNO = d. DEPTNO
full join SALGRADE s on e.SAL between s. LOSAL and s.HISAL
order by D.DEPTNO,E.SAL;


///20 DISPLAY ALL EMPLOYEES AND CORRESPONDING MANAGERS

SELECT ENAME,MGR FROM EMP
WHERE JOB='MANAGER';

SELECT A.ENAME AS EMPLOYEENAME,
B.ENAME AS MANAGER,
A.MGR
FROM 
EMP A,EMP B
WHERE A.ENAME<>B.ENAME AND A.MGR=B.MGR
ORDER BY A.MGR;

///21 DISPLAY ALL EMPLOYEES WHERE JOBS DOES NOT BELONG TO PRESIDENT AND MANAGER

SELECT * FROM EMP
WHERE JOB NOT IN ('PRESIDENT','MANAGER');


///22 DISPLAY ALL THE DEPARTMENTS WHERE DEPARTMENT HAS ATLEAST 4 EMPLOYEES

SELECT DNAME,count(*)
FROM DEPT
INNER JOIN EMP ON DEPT.DEPTNO=EMP.DEPTNO
GROUP BY DNAME
HAVING count(*)>=4;

SELECT DEPTNO FROM EMP WHERE DEPTNO=20;
SELECT DEPTNO FROM EMP WHERE DEPTNO=30;
SELECT * FROM DEPT;
SELECT * FROM EMP;

///23 DISPLAY ALL DEPARTMENTS WITH MINIMUM SALARY AND MAXIMUM SALARY

SELECT MAX(SAL) AS MAXIMUM_SALARY,MIN(SAL) AS MINIMUM_SALARY FROM EMP;

SELECT * FROM SALGRADE;

SELECT D.DNAME,MIN(E.SAL) AS min_salary, 
MAX(E.SAL) AS max_salary
FROM EMP E
JOIN DEPT D ON D.DEPTNO=E.DEPTNO
GROUP BY DNAME;

SELECT * FROM EMP WHERE DEPTNO = 40;

///24 DISPLAY ALL EMPLOYEES THISE WHO ARE NOT MANAGERS

SELECT *
FROM EMP
WHERE JOB IN (
  SELECT DISTINCT JOB
  FROM EMP
  WHERE JOB <> 'MANAGER'
);

SELECT * FROM EMP 
WHERE JOB <> 'MANAGER';

///25 CREATE TABLE EMP1 WITH SAME STRUCTURE OF EMP TABLE.DO NOT COPY THE DATA


CREATE TABLE EMP1 (
  EMPNO INT PRIMARY KEY,
  ENAME VARCHAR(30) NOT NULL,
  JOB VARCHAR(20),
  MGR INT,
  HIREDATE DATE,
  SAL INT,
  COMM INT
);
 SELECT * FROM EMP1;

///26 INCREASE THE SALARY 8% FOR EMPLOYEE THOSE WHO ARE EARNING COMMISSION LESS THAN 900

SELECT ROUND(8%*SAL,2) FROM EMP WHERE COMM<900;



///27 INCREASE $150 COMMISSION FOR BLAKES TEAM

SELECT * FROM EMP;

SELECT COMM,ENAME,
COALESCE(COMM,150) AS BLAKES_TEAM 
FROM EMP 
WHERE ENAME='BLAKE';


UPDATE EMP
SET COMM = COMM + 150
WHERE ENAME = 'Blake';


///28 INCREASE 2% SALARY FOR EMPLOYEE WHO IS MAKING LOWEST SALARY IN DEPT 10


SELECT * FROM EMP WHERE DEPTNO=10;

SELECT EMPNO,ENAME,((SAL*0.02)+SAL) AS NEW_SAL
FROM EMP 
WHERE DEPTNO=10
AND 
SAL=(SELECT MIN(SAL)
FROM EMP
WHERE DEPTNO=10);


///
SELECT ename,job,sal
FROM emp 
WHERE job=(SELECT job 
FROM emp 
WHERE ename='SCOTT');