--Table Script:
create table food(food1 varchar(50),food2 varchar(50),price int);

---Insert Script:
insert into food values('idli','vada',50);
insert into food values('vada','idli',50);
insert into food values('dosa','idli',60);
insert into food values('idli','dosa',60);
insert into food values('vada','pav',70);
insert into food values('Biryani','Kabab',100);

Commit;

--Write a SQL query to remove duplicate combinations and keep only one version.


SELECT * FROM travel_routes;


SELECT DISTINCT
    CASE 
                WHEN start_location < end_location THEN start_location 
        ELSE end_location 
    END AS start_location,
    CASE 
        WHEN start_location < end_location THEN end_location 
        ELSE start_location 
    END AS end_location,
    distance
FROM travel_routes;

with cte as(
Select Case when food1 > food2 then food2 else food1 end as food1,
Case when food1 > food2 then food1 else food2 end as food2,price from food)
Select food1,food2,price from(Select cte.*, row_number () OVER(Partition by food1,food2 order by price) rn from cte) 
where rn = 1;

SELECT start_location, end_location, distance
FROM travel_routes t
WHERE start_location <= end_location
   OR NOT EXISTS (
        SELECT 1
        FROM travel_routes t2
        WHERE t2.start_location = t.end_location
          AND t2.end_location = t.start_location
    );
