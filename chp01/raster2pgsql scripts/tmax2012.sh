# load a single file
raster2pgsql -I -C -F -t 100x100 -s 4326 /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter01/data/tmax_10m_bil/tmax01.bil chp01.tmax01 > /Users/evan/Ev/Python/PostGIS-Cookbook/ev/tmax01.sql 
psql -d postgis_cookbook -U evan -f /Users/evan/Ev/Python/PostGIS-Cookbook/ev/tmax01.sql


# use wildcard for bulk upload
raster2pgsql -I -C -F -t 100x100 -s 4326 /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter01/data/tmax_10m_bil/tmax*.bil chp01.tmax_2012 > /Users/evan/Ev/Python/PostGIS-Cookbook/ev/tmax_2012.sql 
psql -d postgis_cookbook -U evan -f /Users/evan/Ev/Python/PostGIS-Cookbook/ev/tmax_2012.sql

