create table A ( fruitid number ,fruit varchar2(10));
create table B ( fruitid number ,fruit varchar2(10));

insert into A values (3,'Orange');
insert into A values(2,'Mango');
insert into A values(1,'Apple');

insert into B values (3,'Orange');
insert into B values(2,'Mango');
insert into B values(4,'Guava');

Commit;

SELECT * FROM A;
SELECT * FROM B;

With n1 as(
SELECT FRUITID,FRUIT from A
MINUS
SELECT FRUITID,FRUIT from B),
n2 as(
SELECT FRUITID,FRUIT from B
MINUS
SELECT FRUITID,FRUIT from A)
Select * from n1
UNION ALL
Select * from n2;