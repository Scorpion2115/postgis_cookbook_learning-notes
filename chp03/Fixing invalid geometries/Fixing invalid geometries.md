# Fixing invalid geometries
## Use Case
* Invalid geometries can cause failure or performance issue in the geospatial analysis
* This recipe provide solution to investigate and fix invalid geometries

## Recipe
* Investigate whether or not any geometry is invalid in the table using `ST_IsValid`` and ST_IsValidReason` functions
* Fix all the other invalid geometries with `ST_IsValid`

## Lesson Learnt
  *  QGIS also has the similar function which can even highlight the faulty shape with a point. 
   ![img](./img/check%20validity.png)




