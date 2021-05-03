path_in=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp04/Detailed\ building\ footprints\ from\ LiDAR/data/lidar_buildings
path_out=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp04/Detailed\ building\ footprints\ from\ LiDAR/data/lidar_buildings




# Having taken so much pain in exporting the variable correctly, always make sure that you double quote the variable when you reference it in shell ie do:
data_in="$path_in"/lidar_buildings.shp
data_out="$path_out"/lidar_buildings.sql

shp2pgsql -s 3734 -d -i -I -W LATIN1 -g geom "$data_in" chp04.lidar_buildings > "$data_out"

shp2pgsql -s 3734 -d -i -I -W LATIN1 -g the_geom lidar_buildings chp04.lidar_buildings

