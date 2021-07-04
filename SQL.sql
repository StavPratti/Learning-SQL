/* first try*/

SELECT * FROM array;

/* alter user it219151 identified by password; */

CREATE TABLE employee (
employeeid NUMBER(4),
employeename VARCHAR(50),
employeeposition VARCHAR(50),
title VARCHAR(5),
birthdate DATE,
hiredate DATE,
address VARCHAR(50),
city VARCHAR(50),
country VARCHAR(50)
);

DROP TABLE title; /*erases table and data*/ 
/* dunno use*/

DESC employee;
/* about the same*/
SELECT * FROM employee; 

INSERT INTO employee VALUES (19, 'Maria Adams', null, 'Ms', null, null, null,'Athens','Gr');

SELECT * FROM employee;

SELECT table_name FROM user_tables;

COMMMIT; /*saves*/

ROLLBACK; /*undo*/

/* second lab*/ 
ALTER SESSION SET NLS_DATE_FORMAT='DD-MΜ-YYYY ';

CREATE TABLE employee (
 employeeid NUMBER(4) PRIMARY KEY,
 employeeName VARCHAR(50) NOT NULL,
 employeeposition VARCHAR(50) NOT NULL,
 title VARCHAR(5),
 birthdate DATE NOT NULL,
 hiredate DATE,
 address VARCHAR(50),
 city VARCHAR(50),
 country VARCHAR(50)
);

INSERT INTO employee VALUES(19,'Cathi Payne','Sales Reprsesentative','Ms','8-12-1948','1-05-1992',null,'Seatle','USA');

INSERT INTO employee VALUES (20, 'Peter Green', 'Vice President', 'Mr', TO_DATE ('08-01 1978', 'MM/DD YYYY'), null, null,'Athens','Gr'); /* the month now is saved as January and the day 3 and it is the opposite from default*/

SELECT * FROM employee; /*two times this employee is added if its not UNIQUE */

SELECT employeeid, birthdate, TO_CHAR(birthdate, 'DAY MON YYYY') FROM employee; /*the third changes the structure of the birthdate and it is appearred as a string*/

SELECT employeeid, birthdate, TO_CHAR(08/01/2001, 'DAY MON YYYY') FROM employee; /*error*/

--TO_DATE doesnt follow the rules of alter session
--pairnei keratakia!

/* MON = January
MM = 01
DAY = Monday
DD = 08
*/

SELECT * FROM employee;

DROP TABLE employee;

--COMPLEX PRIMARY KEY
CREATE TABLE employee (
 employeeid NUMBER(4) ,
 employeeName VARCHAR(50) ,
 employeeposition VARCHAR(50) ,
 title VARCHAR(5),
 birthdate DATE NOT NULL,
 hiredate DATE NOT NULL,
 address VARCHAR(50),
 city VARCHAR(50),
 country VARCHAR(50),
 CONSTRAINT employee_pk /*name of the key*/ PRIMARY KEY (employeeName, employeeposition) --complex key
);

DROP TABLE employee;

--CHECK
CREATE TABLE employee (
 employeeid NUMBER(4) PRIMARY KEY CHECK (employeeid < 1000), --INEQUALITY
 employeeName VARCHAR(50) NOT NULL,
 employeeposition VARCHAR(50) NOT NULL,
 title VARCHAR(5) CHECK (title IN('Dr','Mr','Ms')), --LIST
 birthdate DATE NOT NULL CHECK (birthdate>'1/1/1980'),
 hiredate DATE NOT NULL,
 address VARCHAR(50),
 city VARCHAR(50),
 country VARCHAR(50),
 CONSTRAINT employee_chk_country CHECK (country IN ('US','UK'))
);

DROP TABLE employee;

CREATE TABLE employee (
 employeeid NUMBER(4) PRIMARY KEY,
 employeeName VARCHAR(50) NOT NULL,
 employeeposition VARCHAR(50) DEFAULT 'Worker' NOT NULL, --se ypoxrewtika pedia mporw na kanw kataxwrhseis akoma kai ama den moy dwsoyne timh
 title VARCHAR(5),
 birthdate DATE NOT NULL,
 hiredate DATE,
 address VARCHAR(50),
 city VARCHAR(50),
 country VARCHAR(50)
);

INSERT INTO employee(employeeid, employeeposition, employeeName, birthdate /*BIRTHDATE IS NOT NULL*/) VALUES(21, 'Vice President','John Doe', '1/5/1990');
INSERT INTO employee(employeeid, employeeName, birthdate /*BIRTHDATE IS NOT NULL*/) VALUES(22,'Maria Papa', '17/6/1993');
--INSERT INTO employee(employeeid, employeeposition, employeeName, birthdate /*BIRTHDATE IS NOT NULL*/) VALUES(23, '','George Micheal', '14/1/1989'); --wrong
INSERT INTO employee(employeeid, employeeposition, employeeName, birthdate /*BIRTHDATE IS NOT NULL*/) VALUES(23, default, 'George Micheal', '14/1/1989');

SELECT * FROM employee;

/*third lab */

DESC employee; --structure of table

SELECT * FROM employee; -- contents of table

ALTER TABLE employee --add column
ADD (Department NUMBER(3));

--προσθέτω την υποχρεωτική στήλη SALARY με 2 δεκαδικά και 4 ακέραια ψηφία
--1st way
ALTER TABLE employee
ADD (Salary NUMBER(6,2) DEFAULT 0 NOT NULL); --not null without default is wrong

--2nd way
UPDATE employee set salary =500;

ALTER TABLE employee --erases salary
DROP (salary);

--3rd way
ALTER TABLE employee
ADD (Salary NUMBER(6,2));
UPDATE employee set salary =500;
ALTER TABLE employee
--MODIFY (Salary NUMBER(6,2) DEFAULT 0 NOT NULL);
MODIFY (salary NOT NULL);
--ALTER TABLE employee MODIFY (salary NULL);

--duplicate the price of position
ALTER TABLE employee
MODIFY (employeeposition VARCHAR(120));

--too low price is not allowed
ALTER TABLE employee
MODIFY (employeeposition VARCHAR(13));

--erases columns city and salary
ALTER TABLE employee
DROP (city);
ALTER TABLE employee
DROP (salary);

ALTER TABLE employee
MODIFY (country VARCHAR(3) DEFAULT 'USA'); --for new data

--main table
CREATE TABLE employee (
 employeeid NUMBER(4) PRIMARY KEY,
 employeeName VARCHAR(50) NOT NULL,
 employeeposition VARCHAR(50) DEFAULT 'Worker' NOT NULL,
 title VARCHAR(5),
 birthdate DATE NOT NULL,
 hiredate DATE ,
 address VARCHAR(50),
 city VARCHAR(50),
 country VARCHAR(50)
);

DROP TABLE employee;

SELECT table_name FROM user_tables; --shows tables name
SELECT * FROM user_constraints;

INSERT INTO employee VALUES(19,'Cathi Payne','Sales Reprsesentative','Ms','8-12-1948','1-05-1992',null,'Seatle','USA');

DELETE FROM EMPLOYEE;

--secondary table
CREATE TABLE department (
 department_id    NUMBER(3)   PRIMARY KEY,
 deptName VARCHAR(2) NOt NULL,
 deptLocation VARCHAR(10) NOT NULL
);

INSERT INTO department VALUES(101,'HQ','Athens');

--recreate employee with new column
CREATE TABLE employee (
 employeeid NUMBER(4) PRIMARY KEY,
 employeeName VARCHAR(50) NOT NULL,
 employeeposition VARCHAR(50) DEFAULT 'Worker' NOT NULL,
 title VARCHAR(5),
 birthdate DATE NOT NULL,
 hiredate DATE ,
 address VARCHAR(50),
 city VARCHAR(50),
 country VARCHAR(50),
 deptno    NUMBER(3) NOT NULL,
 CONSTRAINT employee_department_fk FOREIGN KEY (deptno) REFERENCES department(department_id)
);

INSERT INTO employee VALUES(19,'Cathi Payne','Sales Reprsesentative','Ms','8-12-1948','1-05-1992',null,'Seatle','USA',101);
INSERT INTO employee VALUES(20,'Maria Papa','Sales Reprsesentative','Ms','8-12-1948','1-05-1992',null,'Seatle','USA',107); --wrong 

SELECT * FROM employee;
SELECT * FROM department;
