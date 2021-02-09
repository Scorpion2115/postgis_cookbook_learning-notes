--Use the ST_Distance function to calculate the distances between cities in the USA that have more than 1 million inhabitants 
--Use the Spherical Mercator planar projection coordinate system
--Use the ST_Transform function to convert distance unit from degree to meter
explain(format json)
(
SELECT c1.name, c2.name, 
ST_Distance(ST_Transform(c1.geom, 3857), ST_Transform(c2.geom, 3857))/1000 AS distance_3857 
FROM chp03.cities AS c1
CROSS JOIN chp03.cities AS c2
WHERE c1.pop_2000 > 1000000 AND c2.pop_2000 > 1000000
AND c1.name < c2.name -- be aware of the logic operator here. If using "!=", you will see NY-LA and LA-NY
ORDER BY distance_3857 DESC);

--Write the same query with PostgreSQL Common Table Expression (CTE)

--https://www.postgresql.org/docs/13/queries-with.html
--WITH provides a way to write auxiliary statements for use in a larger query
WITH cities AS (
SELECT name, geom FROM chp03.cities WHERE pop_2000 > 1000000 )

SELECT c1.name, c2.name, ST_Distance(ST_Transform(c1.geom, 900913), ST_Transform(c2.geom, 900913))/1000 AS distance_900913 
FROM cities c1 
CROSS JOIN cities c2
where c1.name < c2.name
ORDER BY distance_900913 DESC;

--now try different crs
WITH cities AS (
SELECT name, geom FROM chp03.cities WHERE pop_2000 > 1000000 )

SELECT c1.name, c2.name, 
ST_Distance(ST_Transform(c1.geom, 900913), ST_Transform(c2.geom, 900913))/1000 AS distance_900913,
ST_DistanceSphere(c1.geom, c2.geom)/1000 AS d_4326_sphere,
ST_DistanceSpheroid(c1.geom, c2.geom, 'SPHEROID["GRS_1980",6378137,298.257222101]')/1000AS d_4326_spheroid,
ST_Distance(geography(c1.geom),geography(c2.geom))/1000 AS d_4326_geography
FROM cities c1 
CROSS JOIN cities c2
where c1.name < c2.name
ORDER BY distance_900913 DESC;