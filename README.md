# postgis_cookbook_learning-notes

1. The default environment (base) has gdal 2.3.3 ($ gdalinfo --version)which doesn't work properly with PostgreSQL 12 for ogr2ogr script. To fix it, I create a new environment named (postgis) which have gdal 3.2.0. Remember to activate postgis ($ conda activate postgis) before running any ogr2ogr scripts



## Foolproof Scripts Template

OS: MacOS or Linux

`ogr2ogr`
```shell
# do not use any space!!!
folder=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp03/data/HUN_adm
data=$folder/HUN_adm1.shp

ogr2ogr -f "PostgreSQL" -t_srs EPSG:3857 -nlt MULTIPOLYGON -lco GEOMETRY_NAME=geom -nln chp03.hungary -lco OVERWRITE=YES PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234"" $data
```

`shp2phsql`
```shell
path_in=/Users/evan/Ev/Python/PostGIS-Cookbook/Chapter03/wborders
path_out=/Users/evan/Ev/Python/PostGIS-Cookbook/ev/shp2pgsql

data_in=$path_in/wborders.shp
data_out=$path_out/wborders.sql

shp2pgsql -s 4326 -g geom -W LATIN1 -I $data_in chp03.wborders > $data_out
```


## Useful case
* [Translating, scaling, and rotating geometries - advanced](https://github.com/Scorpion2115/postgis_cookbook_learning-notes/tree/master/chp04/Translating%2C%20scaling%2C%20and%20rotating%20geometries%20-%20advanced): Provides an extremely useful cases to create a set of grid around points of interest