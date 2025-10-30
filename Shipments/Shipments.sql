with cte1 as (
select origin_location as location from shipments
union
select destination_location as location from shipments
),cte2 as (
   select origin_location as location,count(*) as total_pickups 
   from shipments
   group by origin_location
),cte3 as (
   select destination_location as location,count(*) as total_deliveries
     from shipments
    group by destination_location
)
select cte1.location,   
       nvl(cte2.total_pickups,0) as total_pickups,
       nvl(cte3.total_deliveries,0) as total_deliveries
  from cte1
  left join cte2 on cte1.location = cte2.location
  left join cte3 on cte1.location = cte3.location;