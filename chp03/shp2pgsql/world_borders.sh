path_in=/Users/evan/Ev/Python/PostGIS-Cookbook/Chapter03/wborders
path_out=/Users/evan/Ev/Python/PostGIS-Cookbook/ev/shp2pgsql

data_in=$path_in/wborders.shp
data_out=$path_out/wborders.sql

shp2pgsql -s 4326 -g geom -W LATIN1 -I $data_in chp03.wborders > $data_out