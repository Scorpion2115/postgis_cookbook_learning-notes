-- create contours table

CREATE TABLE chp02.contours (
     gid serial NOT NULL,
     elevation integer,
     __gid double precision,
     geom geometry(MultiLineStringZM,3734),
     CONSTRAINT contours_pkey PRIMARY KEY (gid)
) 
WITH (
     OIDS=FALSE
   );
   
-- Now we may begin to create tables that inherit from our parent table. 
--nIn the process, we will create a CHECK constraint specifying the limits of our associated geometry using the following query:
-- there used to be a comma on the first coordinates 2260000, 630000, which casue error when importing shp.
-- Fxxk the initial scripts creator!!!

CREATE TABLE chp02.contour_N2260630 (CHECK
       (ST_CoveredBy(geom,ST_GeomFromText
         ('POLYGON((2260000 630000, 2260000 635000, 
		  			2265000 635000, 2265000 630000, 2260000 630000))',3734) )) )INHERITS (chp02.contours);


-- and others
CREATE TABLE chp02.contour_N2260635 (CHECK
       (ST_CoveredBy(geom,ST_GeomFromText
         ('POLYGON((2260000 635000, 2260000 640000,
                    2265000 640000, 2265000 635000, 2260000 635000))', 3734)
)
)) INHERITS (chp02.contours);

CREATE TABLE chp02.contour_N2260640 (CHECK
       (ST_CoveredBy(geom,ST_GeomFromText
         ('POLYGON((2260000 640000, 2260000 645000, 2265000 645000,
                    2265000 640000, 2260000 640000))', 3734)
)
)) INHERITS (chp02.contours);

CREATE TABLE chp02.contour_N2265630 (CHECK
       (ST_CoveredBy(geom,ST_GeomFromText
         ('POLYGON((2265000 630000, 2265000 635000, 2270000 635000,
                    2270000 630000, 2265000 630000))', 3734)
)
)) INHERITS (chp02.contours);


CREATE TABLE chp02.contour_N2265635 (CHECK
       (ST_CoveredBy(geom,ST_GeomFromText
         ('POLYGON((2265000 635000, 2265000 640000, 2270000 640000,
2270000 635000, 2265000 635000))', 3734) ))) INHERITS (chp02.contours);
									 
									 
CREATE TABLE chp02.contour_N2265640 (CHECK
       (ST_CoveredBy(geom,ST_GeomFromText
         ('POLYGON((2265000 640000, 2265000 645000, 2270000 645000,
                    2270000 640000, 2265000 640000))', 3734)
)
)) INHERITS (chp02.contours);


CREATE TABLE chp02.contour_N2270630 (CHECK
       (ST_CoveredBy(geom,ST_GeomFromText
         ('POLYGON((2270000 630000, 2270000 635000, 2275000 635000,
                    2275000 630000, 2270000 630000))', 3734)
)
)) INHERITS (chp02.contours);


CREATE TABLE chp02.contour_N2270635 (CHECK
       (ST_CoveredBy(geom,ST_GeomFromText
         ('POLYGON((2270000 635000, 2270000 640000, 2275000 640000,
                    2275000 635000, 2270000 635000))', 3734)
)
)) INHERITS (chp02.contours);


CREATE TABLE chp02.contour_N2270640 (CHECK
       (ST_CoveredBy(geom,ST_GeomFromText
         ('POLYGON((2270000 640000, 2270000 645000, 2275000 645000,
2275000 640000, 2270000 640000))', 3734) )) )INHERITS (chp02.contours);