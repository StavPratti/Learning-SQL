/*forth lab*/

ALTER TABLE department 
DROP CONSTRAINT dept_employee_fk;

DROP TABLE works_on;
DROP TABLE project;
DROP TABLE dependent;
DROP TABLE dept_locations;
DROP TABLE employee;
DROP TABLE department;

CREATE TABLE department(
 DNAME VARCHAR(20),
 DNUMBER NUMBER(1) PRIMARY KEY,
 MGRSSN NUMBER(10),
 MGRSTARTDATE DATE
 --CONSTRAINT department_employee_fk FOREIGN KEY (MGRSSN) REFERENCES employee(SSN)
);

CREATE TABLE employee (
 FName VARCHAR(20),
 MINIT VARCHAR(1),
 LNAME VARCHAR(20),
 SSN NUMBER(10) PRIMARY KEY,
 BDATE DATE,
 ADDRESS VARCHAR(50),
 SEX VARCHAR(1),
 SALARY NUMBER(10),
 SUPERSSN NUMBER(10),
 DNO NUMBER(1),
 CONSTRAINT employee_department_fk FOREIGN KEY (DNO) REFERENCES department(DNUMBER),
 CONSTRAINT employee_employee_fk FOREIGN KEY (SUPERSSN) REFERENCES employee(SSN)
);

CREATE TABLE dept_locations(
 DNUMBER NUMBER(1),
 DLOCATION VARCHAR(20),
 CONSTRAINT dept_locations_pk PRIMARY KEY(DNUMBER,DLOCATION),
 CONSTRAINT dept_locations_fk FOREIGN KEY(DNUMBER) REFERENCES department(DNUMBER)
);

CREATE TABLE dependent(
 ESSN NUMBER(10),
 DEPENDENT_NAME VARCHAR(20),
 SEX VARCHAR(1),
 BDATE DATE,
 RELATIONSHIP VARCHAR(20),
 CONSTRAINT dependent_pk PRIMARY KEY(ESSN,DEPENDENT_NAME),
CONSTRAINT dependent_employee_fk FOREIGN KEY(ESSN) REFERENCES employee(SSN)
);

CREATE TABLE project(
 PNAME VARCHAR(20),
 PNUMBER NUMBER(2) PRIMARY KEY,
 PLOCATION VARCHAR(20),
 DNUM NUMBER(1),
 CONSTRAINT project_department_fk FOREIGN KEY (DNUM) REFERENCES department(DNUMBER)
);

CREATE TABLE works_on(
 ESSN VARCHAR(10),
 PNO NUMBER(2),
 HOURS NUMBER(8,2),
 CONSTRAINT works_on_pk PRIMARY KEY (ESSN,PNO),
 CONSTRAINT works_on_project_fk FOREIGN KEY (PNO) REFERENCES project(PNUMBER),
 CONSTRAINT works_on_employee_fk FOREIGN KEY (ESSN) REFERENCES employee(SSN)
);

ALTER TABLE department
ADD
CONSTRAINT dept_employee_fk FOREIGN KEY (MGRSSN) REFERENCES employee(SSN);

--INSERT INTO department VALUES('Researh',5,null,'22-05-1988'); --null to manager because we haven’t insert the values of table employee
--UPDATE department SET MGRSSN=333445555 WHERE DNUMBER=5;

ALTER TABLE department 
DROP CONSTRAINT dept_employee_fk;
DROP TABLE works_on;
DROP TABLE project;
DROP TABLE dependent;
DROP TABLE dept_locations;
DROP TABLE employee;
DROP TABLE department;

/*fifth lab*/
--Έχουμε τους ίδιους πίνακες με το προηγούμενο εργαστήριο
--Επιλέγουμε να βάλουμε πρώτα τιμές στο department και βάζουμε ΠΡΟΣ ΤΟ ΠΑΡΟΝ null στη θέση του διευθυντή υπαλλήλου μέχρι να κάνω insert τον employee

INSERT INTO department VALUES('Researh',5,null,'22-05-1988');
INSERT INTO department VALUES('Administration',4,null,'01-01-1995');
INSERT INTO department VALUES('Headquarters',1,null,'19-06-1981');
SELECT * FROM department;

-- it is important the sequence of the employees
INSERT INTO employee VALUES('James','E','Borg',888665555,'10-11-1937','450 Stone,Houston,TX','M',55000,null,1); --first this guy because he hasn’t a supervisor
INSERT INTO employee VALUES('Franklin','T','Wong',333445555,'08-12-1955','638 Voss,Houston,TX','M',4000,888665555,5); --he has supervisor James Borg so hes sec at inserts
INSERT INTO employee VALUES('Jennifer','S','Wallace',987654321,'20-06-1941','291 Berry,Bellaire,TX','F',4300,888665555,4); --she has supervisor James Borg so shes sec at inserts
--all the others have supervisors Franklin or Jennifer
INSERT INTO employee VALUES('John','B','Smith',123456789,'09-01-1965','731 Fondren,Houston,TX','M',3000,333445555,5);
INSERT INTO employee VALUES('Ramesh','K','Narayan',666884444,'15-09-1962','975 Fire Oal,Humble,TX','M',3800,333445555,5);
INSERT INTO employee VALUES('Joyce','A','English',453453453,'31-07-1972','5631 Rice,Houston,TX','F',2500,333445555,5);
INSERT INTO employee VALUES('Ahmad','E','Jabbar',987987987,'29-03-1969','980 Dallas,Houston,TX','M',2500,987654321,4);
INSERT INTO employee VALUES('Alicia','J','Zelaya',999887777,'19-07-1968','3321 Castle,Spring,TX','F',2500,987654321,4);

--commit;
--DELETE FROM employee 
--WHERE SSN=123456789;
--rollback;

SELECT * FROM employee WHERE DNO=5;
SELECT * FROM employee;

--IMPORTANT
UPDATE department SET MGRSSN=333445555 WHERE dnumber=5;
UPDATE department SET MGRSSN=987654321 WHERE dnumber=4;
UPDATE department SET MGRSSN=888665555 WHERE dnumber=1;
SELECT * FROM department;

INSERT INTO dept_locations VALUES(1,'Houston');
INSERT INTO dept_locations VALUES(4,'Stafford');
INSERT INTO dept_locations VALUES(5,'Bellaire');
INSERT INTO dept_locations VALUES(5,'Sugarland');
INSERT INTO dept_locations VALUES(5,'Houston');
SELECT * FROM dept_locations;

INSERT INTO project VALUES('ProductX',1,'Bellaire',5);
INSERT INTO project VALUES('ProductY',2,'Sugarlabd',5);
INSERT INTO project VALUES('ProductZ',3,'Houston',5);
INSERT INTO project VALUES('Computerization',10,'Stafford',4);
INSERT INTO project VALUES('Reorganization',20,'Houston',1);
INSERT INTO project VALUES('Newbenefits',30,'Stafford',4);
SELECT * FROM project;

INSERT INTO dependent VALUES('333445555','Alice','F','05-04-1986','DAUGHTER');
INSERT INTO dependent VALUES('333445555','Theodore','M','25-10-1983','SON');
INSERT INTO dependent VALUES('333445555','Joy','F','03-05-1958','SPOUSE');
INSERT INTO dependent VALUES('987654321','Abner','M','28-02-1942','SPOUSE');
INSERT INTO dependent VALUES('123456789','Michael','M','04-01-1988','SON');
INSERT INTO dependent VALUES('123456789','Alice','F','30-12-1988','DAUGHTER');
INSERT INTO dependent VALUES('123456789','Elizabeth','F','05-05-1967','SPOUSE');
SELECT * FROM dependent;

INSERT INTO works_on VALUES('123456789',1,32.5);
INSERT INTO works_on VALUES('123456789',2,7.5);
INSERT INTO works_on VALUES('666884444',3,40.0);
INSERT INTO works_on VALUES('453453453',1,20.0);
INSERT INTO works_on VALUES('453453453',2,20.0);
INSERT INTO works_on VALUES('333445555',2,10.0);
INSERT INTO works_on VALUES('333445555',3,10.0);
INSERT INTO works_on VALUES('333445555',10,10.0);
INSERT INTO works_on VALUES('333445555',20,10.0);
INSERT INTO works_on VALUES('999887777',30,30.0);
INSERT INTO works_on VALUES('999887777',10,10.0);
INSERT INTO works_on VALUES('987987987',10,35.0);
INSERT INTO works_on VALUES('987987987',30,20.0);
INSERT INTO works_on VALUES('987654321',30,20.0);
INSERT INTO works_on VALUES('987654321',20,15.0);
INSERT INTO works_on VALUES('888665555',20,null);
SELECT * FROM works_on;
