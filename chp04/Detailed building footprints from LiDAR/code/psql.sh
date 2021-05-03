path=/Users/evan/Ev/Python/postgis_cookbook_learning-notes/chp04/Detailed\ building\ footprints\ from\ LiDAR/data/lidar_buildings
data="$path"/lidar_buildings.sql

psql -U evan postgis_cookbook -f "$data"