-- RECIPE 7 ********************************************

-- How to do it ***************************************
SELECT  ST_Transform(ST_Clip(m.rast, ST_Transform(sf.geom, 96974)), 2163)
FROM chp05.modis m
CROSS JOIN chp05.sfpoly sf;

---
SELECT  ST_Transform(ST_Clip(m.rast, ST_Transform(sf.geom, 96974)), 
prism.rast, 'cubic', 0.05)
FROM chp05.modis m
CROSS JOIN chp05.prism
CROSS JOIN chp05.sfpoly sf
WHERE prism.rid = 1;

---
WITH meta AS (
        SELECT
                (ST_Metadata(rast)).*
        FROM chp05.modis
)
SELECT
        ST_Rescale(modis.rast, meta.scalex * 4., meta.scaley * 4., '
cubic') AS rast
FROM chp05.modis
CROSS JOIN meta;
