-- RECIPE 5 ********************************************

-- How to do it ***************************************
WITH geoms AS (
        SELECT
                ST_DumpAsPolygons(
                        ST_Union(
                                ST_Clip(prism.rast, 1, S
T_Transform(sf.geom, 4269), TRUE)
                        ),
                        1
                ) AS gv
        FROM chp05.prism
        JOIN chp05.sfpoly sf
                ON ST_Intersects(prism.rast, ST_Transform(sf.geom, 4269))
        WHERE prism.month_year = '2017-03-01'::date
)
SELECT
        (gv).val,
        ST_AsText((gv).geom) AS geom
FROM geoms;

---
WITH geoms AS (
        SELECT (
                ST_PixelAsPolygons(
                        ST_Union(
                                ST_Clip(prism.rast, 1, ST_Transform(sf.geom, 4269), TRUE)
                        ),
                        1
                )
        ) AS gv
        FROM chp05.prism
        JOIN chp05.sfpoly sf
                ON ST_Intersects(prism.rast, ST_Transform(sf.geom, 4269))
        WHERE prism.month_year = '2017-03-01'::date
)
SELECT
        (gv).val,
        ST_AsText((gv).geom) AS geom
FROM geoms;

---
SELECT
        ST_AsRaster(
                sf.geom,
                100., -100.,
                ARRAY['8BUI', '8BUI', '8BUI', '8BUI']::text[],
                ARRAY[29, 194, 178, 255]::double precision[],
                ARRAY[0, 0, 0, 0]::double precision[]
        )
FROM sfpoly sf;


---
SELECT
        ST_AsRaster(
                sf.geom, prism.rast,
                ARRAY['8BUI', '8BUI', '8BUI', '8BUI']::text[],
                ARRAY[29, 194, 178, 255]::double precision[],
                ARRAY[0, 0, 0, 0]::double precision[]
        )
FROM chp05.sfpoly sf
CROSS JOIN chp05.prism
WHERE prism.rid = 1;

