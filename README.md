# postgis_cookbook_learning-notes
The default environment (base) has gdal 2.3.3 ($ gdalinfo --version)which doesn't work properly with PostgreSQL 12 for ogr2ogr script. To fix it, I create a new environment named (postgis) which have gdal 3.2.0. Remember to activate postgis ($ conda activate postgis) before running any ogr2ogr scripts
Outgun
• Import multiple gpx files in bulk to Postgresql. Refer to chp03 GPS.sh • WITH Queries (Common Table Expressions) provide a way to write auxiliary statements for use in a larger query. Refer to chp03 distance.sql
