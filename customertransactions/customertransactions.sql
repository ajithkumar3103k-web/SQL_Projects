create table customertransactions(customerid number(3), transactiondate date, amount number(3));

insert into customertransactions values(101, to_date('2024-01-01','yyyy-mm-dd'),200);
insert into customertransactions values(101, to_date('2024-01-10','yyyy-mm-dd'),350);
insert into customertransactions values(101, to_date('2024-01-20','yyyy-mm-dd'),400);
insert into customertransactions values(102, to_date('2024-01-03','yyyy-mm-dd'),150);
insert into customertransactions values(102, to_date('2024-01-12','yyyy-mm-dd'),175);

Commit;

SELECT * FROM customertransactions;

----Write a SQL query to calculate the difference in transaction 
--amount between the current and previous transaction for each customer, ordered by date.

With cte as(
SELECT t.*, lag(Amount,1,0) Over(Partition by customerid order by transactiondate)as perv_trans FROM customertransactions t)
Select cte.*, cte.amount - cte.perv_trans as Diff from cte; 