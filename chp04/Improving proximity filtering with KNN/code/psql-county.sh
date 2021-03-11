path=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp04/Improving\ proximity\ filtering\ with\ KNN/code
data="$path"/county_subset.sql

psql -U evan postgis_cookbook -f "$data"