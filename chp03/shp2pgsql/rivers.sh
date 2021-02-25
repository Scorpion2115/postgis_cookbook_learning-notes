path_in=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp03/data/10m-rivers-lake-centerlines
path_out=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp03/sql

data_in=$path_in/ne_10m_rivers_lake_centerlines.shp
data_out=$path_out/rivers.sql


shp2pgsql -s 4326 -g geom -W LATIN1 -I $data_in chp03.rivers > $data_out