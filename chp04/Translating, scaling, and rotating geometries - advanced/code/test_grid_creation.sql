CREATE TABLE chp04.tsr_grid AS
   -- embed inside the function
     SELECT chp04.create_grid(ST_SetSRID(ST_MakePoint(0,0),
     3734), 0) AS the_geom
       UNION ALL
     SELECT chp04.create_grid(ST_SetSRID(ST_MakePoint(0,100),
     3734), 0.274352 * pi()) AS the_geom
       UNION ALL
     SELECT chp04.create_grid(ST_SetSRID(ST_MakePoint(100,0),
     3734), 0.824378 * pi()) AS the_geom
       UNION ALL
     SELECT chp04.create_grid(ST_SetSRID(ST_MakePoint(0,-100), 3734),
     0.43587 * pi()) AS the_geom
       UNION ALL
     SELECT chp04.create_grid(ST_SetSRID(ST_MakePoint(-100,0), 3734),
     1 * pi()) AS the_geom;


CREATE TABLE chp04.ev_grid AS
SELECT chp04.create_grid(ST_SetSRID(ST_MakePoint(16836335,-4007717),
     3857), 0) AS the_geom