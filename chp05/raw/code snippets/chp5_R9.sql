-- RECIPE 9 ********************************************

-- How to do it ***************************************
WITH r AS ( -- union of filtered tiles
        SELECT
                ST_Transform(ST_Union(srtm.rast), 3310) AS rast
        FROM chp05.srtm
        JOIN chp05.sfpoly sf
                ON ST_DWithin(ST_Transform(srtm.rast::geometry, 
                              3310), ST_Transform(sf.geom, 3310), 
                              1000)), 
cx AS ( -- custom extent
        SELECT
                ST_AsRaster(ST_Transform(sf.geom, 3310), r.rast) AS rast
        FROM chp05.sfpoly sf
        CROSS JOIN r
)
SELECT
        ST_Clip(ST_Slope(r.rast, 1, cx.rast),
                ST_Transform(sf.geom, 3310)) AS rast
FROM r
CROSS JOIN cx
CROSS JOIN chp05.sfpoly sf;

---
WITH r AS ( -- union of filtered tiles
        SELECT
                ST_Transform(ST_Union(srtm.rast), 3310) AS rast
        FROM chp05.srtm
        JOIN chp05.sfpoly sf
                ON ST_DWithin(ST_Transform(srtm.rast::geometry, 
                3310), ST_Transform(sf.geom, 3310), 1000)
), cx AS ( -- custom extent
        SELECT
                ST_AsRaster(ST_Transform(sf.geom, 3310), r.rast) AS rast
        FROM chp05.sfpoly sf
        CROSS JOIN r
)
SELECT
        ST_Clip(ST_HillShade(r.rast, 1, cx.rast), 
                ST_Transform(sf.geom, 3310)) AS rast
FROM r
CROSS JOIN cx
CROSS JOIN chp05.sfpoly sf;

---
WITH r AS ( -- union of filtered tiles
        SELECT
                ST_Transform(ST_Union(srtm.rast), 3310) AS rast
        FROM srtm
        JOIN sfpoly sf
                ON ST_DWithin(ST_Transform(srtm.rast::geometry, 3
310), ST_Transform(sf.geom, 3310), 1000)
)
SELECT
        ST_Clip(ST_Slope(r.rast, 1), ST_Transform(sf.geom, 3310)) A
S rast
FROM r
CROSS JOIN sfpoly sf;

