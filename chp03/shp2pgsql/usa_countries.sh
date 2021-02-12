path=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp03/data/co2000p020_nt00157 

data=$path/co2000p020.shp

ogr2ogr -f "PostgreSQL" -s_srs EPSG:4269 -t_srs EPSG:4326 -lco GEOMETRY_NAME=geom -nln chp03.counties -nlt MULTIPOLYGON -lco OVERWRITE=YES PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234"" $data