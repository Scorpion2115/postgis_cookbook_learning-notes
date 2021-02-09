* Importing nonspatial tabular data (CSV) using PostGIS functions Importing nonspatial tabular data (CSV) using GDAL
    * refer to function csv2points in chp01.ipynb
    
* Importing shapefiles with shp2pgsql
    * Not learning
    
* Importing and exporting data with the ogr2ogr GDAL command
    * refer to ogr2ogr scripts
    * Not Working on GDAL2.3.3
    * Use QGIS Exort to PostGIS plugin as an alternatively solution
    
* Handling batch importing and exporting of datasets
   * Not learning

* Exporting data to a shapefile with the pgsql2shp PostGIS command 
   * Not learning

* Importing OpenStreetMap data with the osm2pgsql command Importing raster data with the raster2pgsql PostGIS command
    * install hstore extension in postgresql database
    * refer to osm2pgsql scripts
    * refer to sql scripts to create view table
    * In QGIS, double click the view table will recevie an error. Alternatively, go to Layer -> Add Layer -> Add PostGIS Layer
![QGIS](https://github.com/Scorpion2115/postgis_cookbook_learning-notes/blob/main/chp01/QGIS_load_view_table.png)
    
* Importing multiple rasters at a time
   * raster2pgsql
* Exporting rasters with the gdal_translate and gdalwarp GDAL commands
   * Later
