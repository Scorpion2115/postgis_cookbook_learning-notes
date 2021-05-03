-- RECIPE 2 ********************************************

-- How to do it ***************************************

SELECT
        r_table_name,
        r_raster_column,
        srid,
        scale_x,
        scale_y,
        blocksize_x,
        blocksize_y,
        same_alignment,
        regular_blocking,
        num_bands,
        pixel_types,
        nodata_values,
        out_db,
        ST_AsText(extent) AS extent
FROM raster_columns WHERE r_table_name = 'prism';

---
SELECT  rid,  (ST_Metadata(rast)).*
FROM chp05.prism
WHERE month_year = '2017-03-01'::date
LIMIT 1;

---
SELECT  rid,  (ST_BandMetadata(rast, 1)).*
FROM chp05.prism
WHERE rid = 54;

---
WITH stats AS (
  SELECT (ST_SummaryStats(rast, 1)).*  
  FROM prism  
  WHERE rid = 54
)
SELECT  count,  sum,  round(mean::numeric, 2) AS mean, round(stddev::numeric, 2) AS stddev,  min,  max
FROM stats;

---
WITH hist AS (
        SELECT
                (ST_Histogram(rast, 1)).*
        FROM chp05.prism
        WHERE rid = 54
)
SELECT
        round(min::numeric, 2) AS min,
        round(max::numeric, 2) AS max,
        count,
        round(percent::numeric, 2) AS percent
FROM hist
ORDER BY min;

---
SELECT
        (ST_Quantile(rast, 1)).*
FROM chp05.prism
WHERE rid = 54;

---
SELECT
        (ST_ValueCount(rast, 1)).*
FROM chp05.prism
WHERE rid = 54
ORDER BY count DESC, value
LIMIT 10;