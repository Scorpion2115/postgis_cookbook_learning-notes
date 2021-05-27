path=/Users/evan/Ev/Database/Postgis/postgis_cookbook_learning-notes/chp05/Getting\ and\ loading\ rasters/code
data="$path"/prism.sql

psql -U evan postgis_cookbook -f "$data"

path=/Users/evan/Ev/Database/Postgis/postgis_cookbook_learning-notes/chp05/Getting\ and\ loading\ rasters/code
data="$path"/srtm.sql

psql -U evan postgis_cookbook -f "$data"