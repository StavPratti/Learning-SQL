/* ninth lab*/

--���������� ���� index

/*CREATE [UNIQUE] INDEX ���������������
�� ����������� (�����������)*/

CREATE INDEX emp_fname ON employee(lname);

--�������� �������� ��� select from another table

CREATE TABLE male_emp(
ssn number(10) primary key,
fname VARCHAR(20),
lname VARCHAR(20)
);

INSERT INTO MALE_EMP(ssn,fname,lname)
(
SELECT ssn,fname,lname
FROM employee
WHERE sex='M'
);
commit;
select * from male_emp;

-- ������������ ��� ��������� ��� SSN ��� ��� fname ��� MALE_EMP
CREATE INDEX male_mp_index_fname ON male_emp(fname);
--CREATE INDEX male_mp_index_ssn ON male_emp(ssn);
--��� ������ ������ ����� ��� create ������ �� ssn primary key ��� ���� ������������ ��� ��������

/**/

--���������� ����������� SQL function

create or replace function bonus(ssn int) return float is
--always is

--declare part
   numprojects int;
   bonus float;
   BEGIN
      bonus :=100;
      select count(*) into numprojects from works_on where ssn=essn;
      if numprojects >=3 then
         bonus:=1000;
--elsif         
      end if;
      return bonus;
   END;
   /
   
SELECT fname, lname, salary+bonus(12345678) from employee;
select fname,lname,bonus(ssn) from employee;

-- ��������

create or replace trigger male_emp
before insert on employee
for each row
declare bonus....
begin
  bonus:=bonus(ssn)
  if bonus...
  end if;
  insert into male_emp.....
end; 

/**/