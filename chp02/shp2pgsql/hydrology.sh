shp2pgsql -s 3734 -a -i -I -W LATIN1 -g geom /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter02/Chapter02/datasets/hydrology/cuyahoga_hydro_polygon chp02.hydrology_polygon | psql -U evan -d postgis_cookbook

shp2pgsql -s 3734 -a -i -I -W LATIN1 -g geom /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter02/Chapter02/datasets/hydrology/cuyahoga_hydro_polyline chp02.hydrology_linestring | psql -U evan -d postgis_cookbook

shp2pgsql -s 3734 -a -i -I -W LATIN1 -g geom /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter02/Chapter02/datasets/hydrology/cuyahoga_river_centerlines chp02.hydrology_centerlines | psql -U evan -d postgis_cookbook