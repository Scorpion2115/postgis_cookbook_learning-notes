
folder=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp03/data/HUN_adm
data=$folder/HUN_adm1.shp

ogr2ogr -f "PostgreSQL" -t_srs EPSG:3857 -nlt MULTIPOLYGON -lco GEOMETRY_NAME=geom -nln chp03.hungary -lco OVERWRITE=YES PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234"" $data