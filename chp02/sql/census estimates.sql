-- For any given intersection of buffered area and block group, 
-- we want to find the proportion that the intersection is over the overall block group. 
-- Then this value should be multiplied by the value we want to scale.

CREATE OR REPLACE FUNCTION chp02.proportional_sum(geometry,geometry, numeric)
  RETURNS numeric AS
$$

 SELECT $3 * areacalc FROM
     (SELECT (ST_Area(ST_Intersection($1, $2)) / ST_Area($2)):: numeric AS
   areacalc
     ) AS areac;

$$
  LANGUAGE sql VOLATILE;
  
-- Investigate the total population in the given census table 
select round(sum(b.pop)) from chp02.trail_census as b;


--Query total population of census blocks that intersect with target area.
SELECT ROUND(SUM(b.pop)) FROM
chp02.trail_buffer AS a, 
chp02.trail_census as b 
WHERE ST_Intersects(a.geom, b.geom) GROUP BY a.gid;

--Query the extimate population by aplying scale factor
select round(sum(chp02.proportional_sum(a.geom, b.geom, b.pop))) from
chp02.trail_buffer AS a, 
chp02.trail_census as b;

--Seems the last line WHERE ST_Intersects(a.geom, b.geom) GROUP BY a.gid is redudanted
SELECT ROUND(SUM(chp02.proportional_sum(a.geom, b.geom, b.pop))) FROM
chp02.trail_buffer AS a, 
chp02.trail_census as b 
WHERE ST_Intersects(a.geom, b.geom) GROUP BY a.gid;

