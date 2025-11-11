
SELECT * FROM travel_routes;

select distinct * from(
SELECT CASE WHEN  t.start_location < t.end_location THEN t.start_location ELSE t.end_location END as start_loc,
CASE WHEN  t.start_location < t.end_location THEN t.end_location ELSE t.start_location END as end_loc,
t.distance
from travel_routes t
)
Order by distance desc;


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


SELECT start_location, end_location, distance
FROM travel_routes t
WHERE start_location <= end_location
   OR NOT EXISTS (
        SELECT 1
        FROM travel_routes t2
        WHERE t2.start_location = t.end_location
          AND t2.end_location = t.start_location
    );
