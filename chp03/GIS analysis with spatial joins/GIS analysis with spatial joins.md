# GIS analysis with spatial joins
## Use Case
* Join spatial data to correlate information from different layers
## Recipe
  * Points in polygon: `ST_Intersects(pol1.geom, pt1.geom)`
  * Check if the distance between pt1 and pt2 is within 1m:  `ST_DWithin(geography(pt1.geom), geography(pt2.geom), 1)`
  * Find the actual distance: `ST_Distance(geography(a.geom), geography(b.geom))` 

## Lesson Learnt
* You can perform a re-projection with `ogr2ogr` command when ingesting data


