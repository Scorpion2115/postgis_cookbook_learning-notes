path_in=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp04/Improving\ proximity\ filtering\ with\ KNN\ –\ advanced/data/cuy_streets
path_out=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp04/Improving\ proximity\ filtering\ with\ KNN\ –\ advanced/code

data_in="$path_in"/CUY_STREETS.shp
data_out="$path_out"/street.sql

shp2pgsql -s 3734 -d -i -I -W LATIN1 -g geom "$data_in" chp04.knn_streets > "$data_out"

