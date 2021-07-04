/* sixth lab*/

SELECT *  
FROM Employee
WHERE Fname='John';

SELECT fname,lname
FROM Employee;

SELECT fname,lname
FROM Employee
WHERE salary>30000 AND bdate>'1/1/1970';

SELECT *  
FROM Employee
WHERE salary BETWEEN 20000 and 40000;

SELECT *
FROM Employee
WHERE Fname IN ('John','Giannis','Jean');

SELECT *  
FROM Employee
WHERE Fname LIKE 'Ja%';

SELECT *
FROM Employee
WHERE superssn IS NULL;

SELECT fname as name, lname as surname
FROM Employee
WHERE salary>30000;

SELECT fname,lname
FROM Employee
WHERE salary>30000
ORDER BY salary DESC; --fuinoysa seira

SELECT dnumber
FROM Dept_Locations
WHERE dlocation='Houston'
UNION
SELECT dnum
FROM Project
WHERE plocation='Houston';

-- 1 --
SELECT FName,LNAME --as fullname
--conacat(fname,lname) --takes only 2 arguments 
--fname||' '||lname fullname, fname, lname
FROM Employee;

-- 2 --
SELECT Pname,Plocation
FROM PROJECT;

-- 3 --
SELECT *
FROM Employee
WHERE BDATE >'01-01-1965';

-- 4 --
SELECT DEPENDENT_NAME,SEX,relationship
FROM DEPENDENT
WHERE essn= 333445555;

-- 5 --
SELECT ESSN,HOURS
FROM WORKS_ON
WHERE PNO=10;

 -- Αν θέλω να εμφανίζει και το όνομα του υπαλλήλου
SELECT ESSN,HOURS,e.fname
FROM WORKS_ON w JOIN Employee e ON w.essn=e.ssn
WHERE PNO=10;
   
-- 6 --
SELECT FNAME
FROM Employee
WHERE BDATE >'01-01-1965'
UNION
SELECT DEPENDENT_NAME
FROM DEPENDENT
WHERE BDATE >'01-01-1965';

-- 7 --
SELECT SSN
FROM WORKS_ON w JOIN Employee e ON w.ESSN=e.SSN
WHERE w.PNO=30 AND e.SEX='M';
--intersect

-- 8 --
SELECT DEPENDENT_NAME
FROM DEPENDENT
WHERE SEX='F' AND DEPENDENT_NAME LIKE 'A%';

-- 9 --
SELECT DNUMBER
FROM Dept_Locations
WHERE DLOCATION='Houston'
UNION
SELECT DNO
FROM Employee
WHERE SEX='F';

-- 10 --
SELECT ESSN
FROM WORKS_ON
WHERE (hours between 20 and 30) OR (PNO=10 AND hours>15);

/* seventh lab*/

SELECT *  
FROM Employee, Department
WHERE Employee.dno=Department.dnumber;

SELECT *  
FROM Employee JOIN Department ON Employee.dno=Department.dnumber;

SELECT *  
FROM Employee  E, Department D
WHERE E.dno=D.dnumber AND (D.dname='Research' OR E.salary>50000);

SELECT *  
FROM Employee E JOIN Department D ON E.dno=D.dnumber
WHERE D.dname='Research' OR E.salary>50000;

SELECT e.fname||' '|| e.lname fullname
FROM Employee e JOIN Department d ON e.dno=d.dnumber  
                              JOIN Dept_locations  dl ON d.dnumber=dl.dnumber
WHERE dl.dlocation='Houston';

-- 1 --
SELECT DNO
FROM EMPLOYEE
WHERE SEX='F'
UNION
SELECT DNUMBER
FROM Dept_Locations
WHERE DLOCATION='Houston';

-- 2 --
SELECT e.fname,e.lname,p.pNAME,p.PLOCATION,w.HOURS
FROM WORKS_ON w JOIN Employee e ON e.ssn=w.essn
                JOIN PROJECT p ON p.PNUMBER=w.PNO
WHERE (w.hours between 20 and 30) OR (w.PNO=10 AND w.hours>15);

-- 3 --
SELECT distinct d.DNAME,p.PNAME
FROM DEPARTMENT d JOIN PROJECT p ON d.DNUMBER=p.DNUM
                  JOIN Dept_locations dl ON d.dnumber=dl.dnumber
WHERE p.PLOCATION<>dl.DLOCATION;

-- 4 --
SELECT yf.fname, pro.lname
FROM Employee yf JOIN Employee pro ON pro.ssn = yf.Superssn
WHERE yf.salary>pro.salary;

-- 5 --
SELECT fname,lname,dependent_name
FROM Employee e LEFT OUTER JOIN DEPENDENT d ON e.SSN=d.ESSN
WHERE d.RELATIONSHIP='SPOUSE' OR d.RELATIONSHIP is null;

--or

SELECT fname,lname,dependent_name
FROM Employee e LEFT OUTER JOIN( SELECT *
                                 FROM DEPENDENT d
                                 WHERE d.RELATIONSHIP='SPOUSE') sp ON e.ssn = sp.essn;
                                 
-- 6 --
SELECT d.dnumber,d.dname,count(e.ssn) ypalliloi
FROM employee e JOIN department d ON e.dno=d.dnumber
                JOIN Dept_locations dl ON d.dnumber=dl.dnumber
WHERE dlocation='Houston' --the count of employees that work in Houston
GROUP BY d.dnumber,d.dname --always group by the key, always the same as select
HAVING count(e.ssn)>=2;

SELECT ssn,fname,lname,count(*) children --count(dp.relationship)
FROM Employee e LEFT OUTER JOIN DEPENDENT d ON e.SSN=d.ESSN
WHERE d.RELATIONSHIP IN('SON','DAUGHTER')
GROUP BY ssn,fname,lname
HAVING count(*)=2;

-- 7 --
create view mesosmisthos (mesos) as --as always
SELECT avg(salary)
FROM Employee;
--select * from mesosmisthos;
SELECT fname,lname,salary
FROM employee
WHERE salary>(select mesos from mesosmisthos); --(SELECT avg(salary) FROM employee)
drop view mesosmisthos;

create view mesosmisthosAnatmima (dno, mesos, synolikos) as --three columns as the "select"
SELECT dno,avg(salary), sum(salary) --three "select" as the columns
FROM Employee
GROUP BY dno; --ana
--select * from mesosmisthosAnatmima;
SELECT *
FROM employee e JOIN mesosmisthosAnatmima m ON e.dno=m.dno
WHERE e.salary>m.mesos;

/* eighth lab*/

-- 1 --
SELECT p.pname,w.hours
FROM employee e JOIN WORKS_ON w ON e.SSN=w.ESSN
                JOIN PROJECT p ON p.pnumber=w.pno
WHERE e.FNAME='Alicia' AND e.LNAME='Zelaya';

-- 2 --
SELECT yf.fname,yf.lname
FROM Employee yf JOIN Employee pro ON pro.ssn = yf.Superssn
WHERE pro.fname='James' AND pro.lname='Borg';

-- 3 --
SELECT e.fname,e.lname,d.dname,dp.dependent_name,dp.relationship
FROM Employee e JOIN Department d ON e.dno=d.dnumber
                JOIN Dependent dp ON dp.essn=e.ssn;
       
-- 4 --
SELECT d.dname,d.dnumber,count(e.ssn)
FROM department d JOIN employee e ON d.dnumber=e.dno
                  JOIN Dependent dp ON dp.essn=e.ssn
GROUP BY d.dnumber,d.dname;

-- 5 --
SELECT  dp.relationship,d.dname,count(e.ssn)
FROM Department d JOIN Employee e ON d.dnumber=e.dno
                  JOIN dependent dp ON dp.essn=e.ssn
GROUP BY d.dnumber,d.dname,dp.relationship;

-- 6 --
SELECT p.pname,p.plocation,sum(w.HOURS)
FROM Project p JOIN Works_On w ON p.pnumber=w.pno
GROUP BY p.pname,p.plocation
ORDER BY sum(w.HOURS) DESC;

-- 7 --
SELECT fname,lname,dependent_name
FROM Employee e LEFT OUTER JOIN DEPENDENT d ON e.SSN=d.ESSN
WHERE d.RELATIONSHIP='SPOUSE' OR d.RELATIONSHIP is null;

-- 8 --
SELECT d.dname,count(e.ssn)
FROM Department d JOIN Employee e ON e.dno=d.dnumber
WHERE e.sex='M'
group by d.dname
having count(e.ssn)>=3;

-- Επαναληπτικές ερωτήσεις
SELECT LNAME ||'-$'|| SALARY
FROM Employee;

SELECT *
FROM Employee
WHERE DNO IN(1,2);



