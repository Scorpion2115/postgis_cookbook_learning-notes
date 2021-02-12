### Working with GPS data
  * Import GPS data which typically saved in a .gpx file
      * xml format
      * compose of just one <trk> element
      * the <trk> element contains many <trkpt> elements      
   ![img](./img/GPS%20Data.png)
  
  * Test Spatial Query:
      * ST_MakeLine to generate polylines from point geometries, 
      * ST_Length to compute distance, 
      * ST_Intersects to perform a spatial join operation. 

### Fixing invalid geometries:
  *  Investigate whether or not any geometry is invalid in the table using ST_IsValid and ST_IsValidReason functions
  *  QGIS also has the similar function which can even highlight the faulty shape with a point. 
   ![img](./img/check%20validity.png)

### GIS analysis with spatial joins:
  * ST_Intersects(pol1.geom, pt1.geom): points in polygon
  * ST_DWithin(geography(pt1.geom), geography(pt2.geom), 1): return if the distance between pt1 and pt2 is within 1m

### Simplifying geometries:
  * ST_SimplifyPreserveTopology: reduce the vertex numbers comprised in a certain tolerance. After the command, the polygons, in some cases, are not adjacent any more. It seems ST_SimplifyPreserveTopology only works well with linear features, but produces topological anomalies with polygons
  ![img](./img/simplify.png)
  * Alternative solution: GRASS v.generalize
  * pending issue here: the boundary after v.generalize is too flat

### Measuring distances
 * ST_Distance: to calculate the distances
 * Introduce to Common Table Expression (CTE)
 * ST_DistanceSphere and ST_DistanceSpheroid: to calculate the distance under different CRS

### Merging polygons using a common attribute Computing intersections
* `ST_Union` acts as an aggregate function (such as SUM, COUNT, MIN and MAX) on the geometric field, using the common attribute in the `Group By` clause 

* As is shown, the function aggregate counties into states
![img](./img/Merge_Polygon.png?raw=true "Country to State")

### Compute Intersections

### Clipping geometries to deploy data Simplifying geometries with PostGIS topology