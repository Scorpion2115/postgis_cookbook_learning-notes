-- create a function
create or replace function chp04.angle_to_street (geometry) returns double precision AS $$

--use a WITH statement to create a temporary table, which returns the five closest lines to our point of interest
-- why 5? Remember, as the index uses bounding boxes, we don't really know which line is the closest, so we gather a few extra points and then filter them based on distance. 
with index_query as (
select ST_Distance($1, road.geom) as dist,
	degrees(ST_Azimuth($1, ST_ClosestPoint(road.geom, $1))) as azimuth
	from chp04.knn_streets as road
	order by $1 <#> road.geom 
	limit 5
)
--In summary, what returns with our temporary index_query table is the distance to the nearest five lines
--Then we order the results by distance and leave the real nearst one
SELECT azimuth FROM index_query ORDER BY dist
   LIMIT 1;
   $$ LANGUAGE SQL;


-- call the function
create table chp04.knn_address_points_rot as
select addr.*, chp04.angle_to_street (addr.geom)
from chp04.knn_addresses addr;

-- optional
select count(*) from chp04.knn_address_points_rot;
select * from chp04.knn_address_points_rot;
DROP FUNCTION chp04.angle_to_street (geometry);
