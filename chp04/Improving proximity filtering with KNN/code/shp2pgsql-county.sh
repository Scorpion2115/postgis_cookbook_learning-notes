path_in=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp04/Improving\ proximity\ filtering\ with\ KNN/data/cuy_address_points_subset
path_out=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp04/Improving\ proximity\ filtering\ with\ KNN/code

# Having taken so much pain in exporting the variable correctly, always make sure that you double quote the variable when you reference it in shell ie do:
data_in="$path_in"/CUY_ADDRESS_POINTS_subset.shp
data_out="$path_out"/county_subset.sql

shp2pgsql -s 3734 -d -i -I -W LATIN1 -g geom "$data_in" chp04.knn_addresses > "$data_out"

