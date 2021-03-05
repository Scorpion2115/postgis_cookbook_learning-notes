# Working with GPS data
## Use Case
* To play with GPS data which typically saved in a .gpx file
## Recipe
  * Investigate the GPS data in `runkeeper-gpx.zip`
      * xml format
      * compose of just one <trk> element
      * the <trk> element contains many <trkpt> elements      
   ![img](./img/GPS%20Data.png)

## Lesson Learnt
* Always remember to create spatial index before query to improve the query performance
* it is essential to include this query -sql "Select ele, time From track_points" to avoid gemmetry type mismatch error while importing to postgis
* Spatial Query:
  1. `ST_MakeLine` to generate polylines from point geometries, 
  2. `ST_Length` to compute distance, 
  3. `ST_Intersects` to perform a spatial join operation. 