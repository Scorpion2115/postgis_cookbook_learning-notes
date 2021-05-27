# check metadata
gdalinfo PRISM_tmin_provisional_4kmM2_201703_asc.asc

# load PRISM
path_out=/Users/evan/Ev/Database/Postgis/postgis_cookbook_learning-notes/chp05/Getting\ and\ loading\ rasters/code
data_out="$path_out"/prism.sql

raster2pgsql -s 4269 -t 100x100 -F -I -C -Y PRISM_tmin_provisional_4kmM2_*_asc.asc chp05.prism > "$data_out"





# Load SRTM
path_in=/Users/evan/Ev/Database/Postgis/postgis_cookbook_learning-notes/chp05/Getting\ and\ loading\ rasters/data/SRTM
path_out=/Users/evan/Ev/Database/Postgis/postgis_cookbook_learning-notes/chp05/Getting\ and\ loading\ rasters/code

data_in="$path_in"/N37W123.hgt
data_out="$path_out"/srtm.sql

raster2pgsql -s 4326 -t 100x100 -F -I -C -Y "$data_in" chp05.srtm > "$data_out"




 