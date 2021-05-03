-- RECIPE 9 ********************************************

-- Getting ready **************************************

SET postgis.gdal_enabled_drivers = 'ENABLE_ALL';

SELECT short_name
FROM ST_GDALDrivers();


-- How to do it ***************************************

WITH months AS ( -- extract monthly rasters clipped to San 
Francisco
        SELECT
                prism.month_year,
                ST_Union(
                        ST_Clip(prism.rast, 2, ST_Transform(sf.geom, 4269), TRUE)
                ) AS rast
        FROM chp05.prism
        JOIN chp05.sfpoly sf
                ON ST_Intersects(prism.rast, ST_Transform(sf.geom, 4269))
        WHERE prism.month_year BETWEEN '2017-06-01'::date AND '
2017-08-01'::date
        GROUP BY prism.month_year
       ORDER BY prism.month_year
), summer AS ( -- new raster with each monthly raster as a band
        SELECT
                ST_AddBand(NULL::raster, array_agg(rast)) AS rast
        FROM months
)
SELECT -- export as GeoTIFF
        ST_AsTIFF(rast) AS content
FROM summer;

---
WITH r AS (
        SELECT
                ST_Transform(ST_Union(srtm.rast), 3310) AS rast
        FROM chp05.srtm
        JOIN chp05.sfpoly sf
                ON ST_DWithin(ST_Transform(srtm.rast::geometry, 3310), ST_Transform(sf.geom, 3310), 1000)
), cx AS (
        SELECT
                ST_AsRaster(ST_Transform(sf.geom, 3310), r.rast) AS rast
        FROM sfpoly sf
        CROSS JOIN r
)
SELECT
        ST_AsPNG(
                ST_ColorMap(
                        ST_Clip(
                                ST_Slope(r.rast, 1, cx.rast),
                                ST_Transform(sf.geom, 3310)
                        ),
                        'bluered'
                )
        ) AS rast
FROM r
CROSS JOIN cx
CROSS JOIN chp05.sfpoly sf;
