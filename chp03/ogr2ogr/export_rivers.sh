
#create a new folder named rivers
path = /Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp03
mkdir $path/rivers

# -sql command must be in the same line with previous context
for f in `ogrinfo PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234"" -sql "select DISTINCT(iso2) from chp03.wborders order by iso2" | grep iso2 | awk '{print $4}'`
do
echo "Exporting river shapefile for $f country..."
# be aware of the folder path for exporting
ogr2ogr rivers/rivers_$f.shp PG:"host="127.0.0.1" user="evan" dbname="postgis_cookbook" password="Toptiger1234"" -sql "select * from chp03.rivers_clipped_by_country where iso2 = '$f'"
done
