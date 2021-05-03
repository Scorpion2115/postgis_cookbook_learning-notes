CREATE TABLE chp04.knn_addresses_voronoi AS
SELECT ST_CollectionExtract(ST_SetSRID(ST_VoronoiPolygons(points.geom),3734), 3)
FROM
(SELECT ST_Collect(geom) geom FROM chp04.knn_addresses) points;
------------------------------------------------------------Sandpit------------------------------------------------------------

/*
We will create a small arbitrary point dataset to feed into our function around which we will calculate the Voronoi diagram:
*/
CREATE TABLE chp04.voronoi_test_points(x numeric, y numeric )
   WITH (OIDS=FALSE);
   ALTER TABLE chp04.voronoi_test_points ADD COLUMN gid serial;
   ALTER TABLE chp04.voronoi_test_points ADD PRIMARY KEY (gid);
   INSERT INTO chp04.voronoi_test_points (x, y)
     VALUES (random() * 5, random() * 7);
   INSERT INTO chp04.voronoi_test_points (x, y)
     VALUES (random() * 2, random() * 8);
   INSERT INTO chp04.voronoi_test_points (x, y)
     VALUES (random() * 10, random() * 4);
   INSERT INTO chp04.voronoi_test_points (x, y)
     VALUES (random() * 1, random() * 15);
   INSERT INTO chp04.voronoi_test_points (x, y)
     VALUES (random() * 4, random() * 9);
   INSERT INTO chp04.voronoi_test_points (x, y)
     VALUES (random() * 8, random() * 3);
   INSERT INTO chp04.voronoi_test_points (x, y)
     VALUES (random() * 5, random() * 3);
   INSERT INTO chp04.voronoi_test_points (x, y)
     VALUES (random() * 20, random() * 0.1);
   INSERT INTO chp04.voronoi_test_points (x, y)
     VALUES (random() * 5, random() * 7);


SELECT AddGeometryColumn ('chp04','voronoi_test_points','geom',3734,'POINT',2);

UPDATE chp04.voronoi_test_points
SET geom = ST_SetSRID(ST_MakePoint(x,y), 3734)
WHERE geom IS NULL;


/* 
create the table that will contain the MultiPolygon
*/
CREATE TABLE chp04.voronoi_diagram(
     gid serial PRIMARY KEY,
     geom geometry(MultiPolygon, 3734)
   );

/*
calculate the Voronoi diagram
*/
INSERT INTO chp04.voronoi_diagram(geom)(
SELECT ST_CollectionExtract(ST_SetSRID(ST_VoronoiPolygons(points.geom),3734), 3)
FROM( 
SELECT ST_Collect(geom) geom FROM chp04.voronoi_test_points) points);