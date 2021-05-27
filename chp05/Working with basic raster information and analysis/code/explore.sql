-- The same as run gdalinfo in command line
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
     FROM raster_columns 
     WHERE r_table_name ='prism';



SELECT  rid,  (ST_Metadata(rast)).* FROM chp05.prism

SELECT  rid,  (ST_BandMetadata(rast)).* FROM chp05.prism


WITH stats AS (SELECT (ST_SummaryStats(rast, 1)).*  FROM chp05.prism  WHERE rid =54)
SELECT  count,  sum,  
round(mean::numeric, 2) mean,
round(stddev::numeric, 2) stddev,  min,  max
FROM stats;