/*
we expect this function to:
1. take a geometry
2. return a multipolygon geometry
*/
CREATE OR REPLACE FUNCTION chp04.polygonize_to_multi (geometry) RETURNS
geometry AS $$


-- use WITH statement to construct the series of transformations in geometry
WITH polygonized AS (
     SELECT ST_Polygonize($1) AS geom
),

-- dump it
dumped AS (
     SELECT (ST_Dump(geom)).geom AS geom 
	FROM polygonized
)
-- collect and construct a multi-polygon from dump
SELECT ST_Multi(ST_Collect(geom)) FROM dumped;
$$ LANGUAGE SQL;