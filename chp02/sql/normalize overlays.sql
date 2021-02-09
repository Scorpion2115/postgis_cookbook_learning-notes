CREATE OR REPLACE FUNCTION chp02.polygon_to_line(geometry) 
RETURNS geometry AS

$$
--use ST_MakeLine() to connect list of points to line 
SELECT ST_MakeLine(geom) FROM 
(
--ST_ExteriorRing(geom) just grab the outer boundary of polygons, but it returns polygons
-- so we use ST_DumpPoints() to get a list of points
SELECT (ST_DumpPoints(ST_ExteriorRing((ST_Dump($1)).geom))).geom
     ) AS linpoints
$$

LANGUAGE sql VOLATILE;
ALTER FUNCTION chp02.polygon_to_line(geometry)
OWNER TO evan;


-- ST_Union help to force the link of overlapping lines
SELECT ST_Union(geom) AS geom FROM (
SELECT chp02.polygon_to_line(geom) AS geom FROM
chp02.use_area ) AS unioned;

--Convert lines back to polygon using ST_Polygonize
 SELECT ST_Polygonize(geom) AS geom FROM (
     SELECT ST_Union(geom) AS geom FROM (
SELECT chp02.polygon_to_line(geom) AS geom FROM
chp02.use_area ) AS unioned
   ) as polygonized;
   
--ST_Polygonize will create a single multi polygon, so we can explode this into multiple single polygon 
CREATE TABLE chp02.use_area_alt AS (
SELECT (ST_Dump(geom)).geom AS the_geom FROM (
       SELECT ST_Polygonize(geom) AS geom FROM (
         SELECT ST_Union(geom) AS geom FROM (
SELECT chp02.polygon_to_line(geom) AS geom
FROM chp02.use_area ) AS unioned
       ) as polygonized
     ) AS exploded
);


--Now let's do some spatial queries
--fisrt in first, always remember to create spatial index
CREATE INDEX chp02_use_area_alt_the_geom_gist ON chp02.use_area_alt
USING gist(the_geom);

--we calculate the centroids on the resultant geometry
CREATE TABLE chp02.use_area_alt_p AS
SELECT ST_SetSRID(ST_PointOnSurface(the_geom), 3734) AS
       the_geom FROM
chp02.use_area_alt;

ALTER TABLE chp02.use_area_alt_p ADD COLUMN gid serial; 
ALTER TABLE chp02.use_area_alt_p ADD PRIMARY KEY (gid);

--And as always, create a spatial index using the following query:
CREATE INDEX chp02_use_area_alt_p_the_geom_gist ON chp02.use_area_alt_p
USING gist(the_geom);

--the centroid thenstructure our point-in-polygon relations between the original and resultant polygons
CREATE TABLE chp02.use_area_alt_relation AS SELECT points.gid, cu.location FROM
chp02.use_area_alt_p AS points, chp02.use_area AS cu
WHERE ST_Intersects(points.the_geom, cu.geom);

