-- First, we will create a parent table with the fields common to all the tables

CREATE TABLE chp02.hydrology ( 
	gid SERIAL PRIMARY KEY, 
	"name" text,
	hyd_type text,
     geom_type   text,
	-- we also added a geometry field as all of our shapefiles implicitly have this commonality.
     geom    geometry
   );

-- To establish inheritance for a given table, we need to declare only the additional fields that the child table contains using the following query:
CREATE TABLE chp02.hydrology_centerlines ( 
	"length" numeric
) INHERITS (chp02.hydrology);

CREATE TABLE chp02.hydrology_polygon ( 
	area numeric,
perimeter numeric
) INHERITS (chp02.hydrology);

CREATE TABLE chp02.hydrology_linestring ( 
	sinuosity numeric
) INHERITS (chp02.hydrology_centerlines);
