create table subscribers(customer_id int, subscription_date date, plan_value int);

insert into subscribers values(1,to_date('2023-03-02','yyyy-mm-dd'),799);  
insert into subscribers values(1,to_date('2023-04-01','yyyy-mm-dd'),599);  
insert into subscribers values(1,to_date('2023-05-01','yyyy-mm-dd'),499);  
  
insert into subscribers values(2,to_date('2023-04-02','yyyy-mm-dd'),799);  
insert into subscribers values(2,to_date('2023-07-01','yyyy-mm-dd'),599);  
insert into subscribers values(2,to_date('2023-09-01','yyyy-mm-dd'),499);  
  
insert into subscribers values(3,to_date('2023-01-01','yyyy-mm-dd'),499);  
insert into subscribers values(3,to_date('2023-04-01','yyyy-mm-dd'),599);  
insert into subscribers values(3,to_date('2023-07-02','yyyy-mm-dd'),799);  
  
insert into subscribers values(4,to_date('2023-04-01','yyyy-mm-dd'),499);  
insert into subscribers values(4,to_date('2023-09-01','yyyy-mm-dd'),599);  
insert into subscribers values(4,to_date('2023-10-02','yyyy-mm-dd'),499);  
insert into subscribers values(4,to_date('2023-11-02','yyyy-mm-dd'),799);  
  
insert into subscribers values(5,to_date('2023-10-02','yyyy-mm-dd'),799);  
insert into subscribers values(5,to_date('2023-11-02','yyyy-mm-dd'),799);
  
insert into subscribers values(6,to_date('2023-03-01','yyyy-mm-dd'),499); 


with cte1 as(
SELECT CUSTOMER_ID,subscription_date,plan_value,
lead(plan_value,1) over(partition by customer_id order by subscription_date) as upgrade_flag_s,
Case when plan_value > lead(plan_value) over(partition by customer_id order by subscription_date) then 1 else 0 end as upgrade_flag,
Case when plan_value < lead(plan_value) over(partition by customer_id order by subscription_date) then 1 else 0 end as downgrade_flag
FROM subscribers),
cte2 as (Select CUSTOMER_ID,max(upgrade_flag) as has_upgrade,max(downgrade_flag) as has_downgrade from cte1 group by CUSTOMER_ID)
select CUSTOMER_ID, CASE WHEN has_upgrade = 1 THEN 'YES' ELSE 'NO' END  as has_upgrade,
CASE WHEN has_downgrade = 1 THEN 'YES' ELSE 'NO' END  as has_downgrade
from cte2;


with cte1 as (
SELECT CUSTOMER_ID,SUBSCRIPTION_DATE,PLAN_VALUE,
CASE WHEN Exists (SELECT 1 FROM subscribers s2 WHERE s1.CUSTOMER_ID = s2.CUSTOMER_ID 
                    and s1.SUBSCRIPTION_DATE > s2.SUBSCRIPTION_DATE  and s1.plan_value < s2.plan_value) THEN 1 ELSE 0 END AS has_upgrade,
CASE WHEN Exists (SELECT 1 FROM subscribers s2 WHERE s1.CUSTOMER_ID = s2.CUSTOMER_ID 
                    and s1.SUBSCRIPTION_DATE > s2.SUBSCRIPTION_DATE  and s1.plan_value > s2.plan_value) THEN 1 ELSE 0 END AS has_downgrade                    
FROM subscribers s1),
cte2 as (select CUSTOMER_ID,MAX(has_upgrade) as has_upgrade, MAX(has_downgrade)AS has_downgrade from cte1 GROUP BY CUSTOMER_ID)
select CUSTOMER_ID, Case WHEN has_upgrade = 0 THEN 'NO' ELSE 'YES' END as has_upgrade,
 Case WHEN has_downgrade = 0 THEN 'NO' ELSE 'YES' END as has_downgrade
from cte2
order by customer_id;