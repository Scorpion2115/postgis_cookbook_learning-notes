--point vs polygon
--number of registered earthquake in 2012
SELECT s.state, COUNT(*) AS hq_count FROM chp03.states AS s
JOIN chp03.earthquakes AS e
ON ST_Intersects(s.geom, e.wkb_geometry) 
GROUP BY s.state
ORDER BY hq_count DESC;

--point vs point
--earthquacks no further than 200 km from the cities in the USA that have more than 1 million inhabitants
SELECT c.name, e.magnitude, COUNT(*) AS hq_count FROM chp03.cities AS c
JOIN chp03.earthquakes AS e
ON ST_DWithin(geography(c.geom), geography(e.wkb_geometry), 200000)
Where c.pop_2000 > 1000000
GROUP BY c.name, e.magnitude
ORDER BY hq_count DESC;

--Find the actual distance
SELECT c.name, e.magnitude, 
ST_Distance(geography(c.geom), geography(e.wkb_geometry)) as distance
FROM chp03.cities AS c
JOIN chp03.earthquakes AS e
ON ST_DWithin(geography(c.geom), geography(e.wkb_geometry), 200000)
Where c.pop_2000 > 1000000
ORDER BY distance ASC;


--point vs polygon
--Query number of cities and population in each states
Select s.state, 
count(*) as city_count,
sum(pop_2000) as pop_2000
from chp03.states as s
Join chp03.cities as c
ON ST_Intersects(s.geom, c.geom)
Where c.pop_2000 > 0
Group by s.state
Order by pop_2000 DESC;


--point vs polygon
--update the earthquake table with info from states
ALTER TABLE chp03.earthquakes ADD COLUMN state_fips character varying(2);

Update chp03.earthquakes as e
Set state_fips = s.state_fips
from chp03.states as s
where ST_Intersects(s.geom, e.wkb_geometry);