SELECT * FROM customertransactions;

----Write a SQL query to calculate the difference in transaction 
--amount between the current and previous transaction for each customer, ordered by date.

With cte as(
SELECT t.*, lag(Amount,1,0) Over(Partition by customerid order by transactiondate)as perv_trans FROM customertransactions t)
Select cte.*, cte.amount - cte.perv_trans as Diff from cte; 