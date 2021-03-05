# testing. import a single gpx file.
# it is essential to include this query -sql "Select ele, time From track_points" to avoid gemmetry type mismatch error while importing to postgis
ogr2ogr -update -append -f "PostgreSQL" PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234""  /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter03/runkeeper-gpx/2010-05-21-1934.gpx  -nln chp03.test -sql "Select ele, time From track_points"

ogr2ogr -update -append -f "PostgreSQL" PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234""  /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter03/runkeeper-gpx/2010-05-23-1302.gpx  -nln chp03.test -sql "Select ele, time From track_points"



for file in `find /Users/evan/Ev/Python/PostGIS-Cookbook/Chapter03/runkeeper-gpx/*.gpx`
do 
echo "Importing $file now"
ogr2ogr -update -append -f "PostgreSQL" PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234""  $file -nln chp03.rk_track_points -sql "Select ele, time From track_points"
done
