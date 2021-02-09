 1. Using geospatial views
 * Views in PostgreSQL allow the ad hoc representation of data and data relationships in alternate forms. 
 * we'll be using views to allow for the automatic creation of point data based on tabular inputs.
 * We can imagine a case where the input stream of data is non-spatial, but includes longitude and latitude or some other coordinates. We would like to automatically show this data as points in space.
 
 2. Using triggers to populate the geometry column 
 * Skip
 
 3. Structuring spatial data with table inheritance
 * we imagine that we have ever increasing data in our database, which needs spatial representation; 
 * however, in this case we want a hardcoded geometry column to be updated each time an insertion happens on the database, converting our x and y values to geometry as and when they are inserted into the database.
 * we have three separate but related datasets:
        * cuyahoga_hydro_polygon
        * cuyahoga_hydro_polyline
        * cuyahoga_river_centerlines
        
 * Investigate the table and we see three common field, which we can apply inheritance to completely structure our data.
   * name
   * hyd_type
   * geom_type
   
 * After apply inheritance, we can see 
   * parent (polygons): hydrology child (polygons): cuyahoga_hydro_polygon, 
   * parent (polylines): hydrologychild (polylines): cuyahoga_hydro_polyline + cuyahoga_river_centerlines
 ![QGIS](https://github.com/Scorpion2115/postgis_cookbook_learning-notes/blob/main/chp02/hydrology_inheritance.png)

   
 * Lesson Learnt:
  * Initially, I use QGIS Export to PostGIS function to transfer the shp files. But the inheritance does not work.
  * Here is the Error Message: Error importing to PostGIS Creation of data source "chp02"."hydrology_polygon" failed: ERROR: relation "hydrology_polygon" already exists 
  * Questions to be soloved: Can QGIS Export file to PostGIS inheritance table?
  
  
  4. Extending inheritance – table partitioning
  * Table partitioning is an approach specific to PostgreSQL 
  * The advantages of partitioning include:
   * improved query performance due to smaller indexes and target scans of data
   * bulk loads and deletes that bypass the cost of vacuuming
   
  * Lesson Learnt:
    * Once you create inherits (9 in the example), you have to upload corresponding shp file to each of the child table, otherwise, the parent table wouldn't show in QGIS.
    * In the beginning, I create all 9 inherits as per the sample codes but only import 3 shp. Consequently, the parent table shows empty in QGIS, although I can query valid contens from it.
    * See below snapshow. After importing 9 shp, the parent table is visible from QGIS, then I can truncate any child table to optimise the size of the parent table
    ![QGIS](https://github.com/Scorpion2115/postgis_cookbook_learning-notes/blob/main/chp02/contour.png)

  5. Normalizing imports
  * Write a function that will aid in transforming the data from whaterver format into a format that is useful for our application
  * This is particularly the case when going from flat file formats, such as shapefiles, to relational databases such as PostgreSQL.
  * In this example, we normalize the column "Label_Name" which is messed up with varity characters
  
  
 6. Normalizing internal overlays
  * Geodata from external source can have issues too.
  * For example, if new dataset has polygons that overlaps with internal overlays, then the query for area, perimeter and other metric can be wrong
  * Tasks:
    * 6.1. Convert polygons to linestrings:
      * 6.1.1. Extract points only from polygons using ST_ExteriorRing
      * 6.1.2. Convert those parts to points using ST_DumPoints
      * 6.1.3. Connect those points back into lines using ST_Makeline
    * 6.2. Convert linestrings back to polygons
    ![QGIS](https://github.com/Scorpion2115/postgis_cookbook_learning-notes/blob/main/chp02/normalize%20overlay.png)
     * 6.3. Find the center points of the resultant polygons
     * 6.4. Use the resultant points to query tabular relationships
    


7. Using polygon overlays for proportional census estimatesq
  * Spatial summarization
  * In our case, we want to know the population within 1 mile of the trail (trail_alignment_prop)
  * Things to do:
    * 7.1. Create 1 mile buffer alongside the trail
    * 7.2. Select all census blocks intersect the buffer
    * 7.3. We can assume that for give census block groups, if x% of the block is within the target area, we can attribute x% of the population of that block to our estimation
   ![QGIS](https://github.com/Scorpion2115/postgis_cookbook_learning-notes/blob/main/chp02/census.png)
   
    
