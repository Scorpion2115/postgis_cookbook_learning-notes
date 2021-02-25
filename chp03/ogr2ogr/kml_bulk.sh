# import all
ogr2ogr -append -f "PostgreSQL" PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234""  /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter03/2012_Earthquakes_ALL.kml  -nln chp03.earthquakes_overall


# import in loop
# I do not see any difference with the previous solution
for ((i = 1; i < 9 ; i++)) ; 
do 
echo "Importing earthquakes with magnitude $i to chp03.earthquakes PostGIS table..."
ogr2ogr -append -f "PostgreSQL" PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234""  /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter03/2012_Earthquakes_ALL.kml  -nln chp03.earthquakes -sql "SELECT name, description, CAST($i AS integer) AS magnitude FROM \"Magnitude $i\""
done



#be aware of the re-projection
ogr2ogr -append -f "PostgreSQL" -s_srs EPSG:4269 -t_srs EPSG:4326 PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234""  /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter03/citiesx020_nt00007/citiesx020.shp  -nln chp03.cities -lco GEOMETRY_NAME=geom
ogr2ogr -append -f "PostgreSQL" -s_srs EPSG:4269 -t_srs EPSG:4326 PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234""  /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter03/statesp020_nt00032/statesp020.shp -nlt MULTIPOLYGON -nln chp03.states -lco GEOMETRY_NAME=geom
