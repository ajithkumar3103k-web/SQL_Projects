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