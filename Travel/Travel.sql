-- Create table
CREATE TABLE travel_routes (
    start_location VARCHAR2(50),
    end_location   VARCHAR2(50),
    distance       NUMBER
);

-- Insert sample data
INSERT INTO travel_routes (start_location, end_location, distance) VALUES ('Delhi', 'Pune', 1400);
INSERT INTO travel_routes (start_location, end_location, distance) VALUES ('Pune', 'Delhi', 1400);
INSERT INTO travel_routes (start_location, end_location, distance) VALUES ('Bangalore', 'Chennai', 350);
INSERT INTO travel_routes (start_location, end_location, distance) VALUES ('Mumbai', 'Ahmedabad', 500);
INSERT INTO travel_routes (start_location, end_location, distance) VALUES ('Chennai', 'Bangalore', 350);
INSERT INTO travel_routes (start_location, end_location, distance) VALUES ('Patna', 'Ranchi', 300);

Commit;


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

Select * from travel_routes
WHERE (start_location<end_location and start_location in(select end_location from travel_routes ) )
or start_location not in (select end_location from travel_routes);