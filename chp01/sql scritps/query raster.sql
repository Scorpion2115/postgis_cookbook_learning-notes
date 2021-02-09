-- query raster_column

SELECT r_raster_column, srid,
         ROUND(scale_x::numeric, 2) AS scale_x,
         ROUND(scale_y::numeric, 2) AS scale_y, blocksize_x,
         blocksize_y, num_bands, pixel_types, nodata_values, out_db
         FROM raster_columns where r_table_schema='chp01'
         AND r_table_name ='tmax_2012';
		 
-- query raster metadata		 
SELECT rid, (foo.md).*
FROM (SELECT rid, ST_MetaData(rast) As md FROM chp01.tmax_2012) As foo;


-- basic stats on original table
SELECT COUNT(*) AS num_raster, MIN(filename) as original_file 
FROM chp01.tmax_2012 GROUP BY filename ORDER BY filename;