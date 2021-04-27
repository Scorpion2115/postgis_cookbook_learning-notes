/*
input: geometry and float value
return: geometry
*/
CREATE OR REPLACE FUNCTION chp04.create_grid (geometry, float) 
RETURNS geometry AS 
$$
/*
To construct the 5 x 2 subplots, we need:
1. three lines running parallel to the X axis
2. six lines running parallel to the y axis
*/
WITH middleline AS (
     SELECT ST_MakeLine(ST_Translate($1, -10, 0),
       ST_Translate($1, 40.0, 0)) AS the_geom
   ),
   topline AS (
     SELECT ST_MakeLine(ST_Translate($1, -10, 10.0),
       ST_Translate($1, 40.0, 10)) AS the_geom
   ),
   bottomline AS (
     SELECT ST_MakeLine(ST_Translate($1, -10, -10.0),
       ST_Translate($1, 40.0, -10)) AS the_geom
   ),
   oneline AS (
     SELECT ST_MakeLine(ST_Translate($1, -10, 10.0),
       ST_Translate($1, -10, -10)) AS the_geom
   ),
   twoline AS (
     SELECT ST_MakeLine(ST_Translate($1, 0, 10.0),
       ST_Translate($1, 0, -10)) AS the_geom
   ),
   threeline AS (
     SELECT ST_MakeLine(ST_Translate($1, 10, 10.0),
       ST_Translate($1, 10, -10)) AS the_geom
   ),
   fourline AS (
     SELECT ST_MakeLine(ST_Translate($1, 20, 10.0),
       ST_Translate($1, 20, -10)) AS the_geom
   ),
   fiveline AS (
     SELECT ST_MakeLine(ST_Translate($1, 30, 10.0),
       ST_Translate($1, 30, -10)) AS the_geom
   ),
   sixline AS (
     SELECT ST_MakeLine(ST_Translate($1, 40, 10.0),
	 ST_Translate($1, 40, -10)) AS the_geom
   ),
   
/*
A UNION ALL function will combine these lines in a single record
*/
combined AS (
     SELECT ST_Union(the_geom) AS the_geom FROM
     (
       SELECT the_geom FROM middleline
         UNION ALL
       SELECT the_geom FROM topline
         UNION ALL
       SELECT the_geom FROM bottomline
         UNION ALL
       SELECT the_geom FROM oneline
         UNION ALL
       SELECT the_geom FROM twoline
         UNION ALL
       SELECT the_geom FROM threeline
         UNION ALL
       SELECT the_geom FROM fourline
         UNION ALL
       SELECT the_geom FROM fiveline
         UNION ALL
       SELECT the_geom FROM sixline
     ) AS alllines
)
/*
But we have not created polygons yet, just lines. 
The final step, using our polygonize_to_multi function, finishes the work for us:
*/
SELECT chp04.polygonize_to_multi(ST_Rotate(the_geom, $2, $1)) AS the_geom
FROM combined;
$$ 
LANGUAGE SQL;