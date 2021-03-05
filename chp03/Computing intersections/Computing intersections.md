# Computing intersections
## Use Case
* Perform a self_spatial join using `ST_Intersects`
## Recipe
* Find intersection in the join context with the `ST_Intersection`
* There are 3 geometry types of intersections:
  1. `ST_POINT`: two linear geometries intersect each other once
  2. `ST_MultiPoint`: two linear geometroes intersect each other multiple times
  3. `ST_GeometryCollection`: two multilinestring objects intetsect and share part of the line
* In case we only want to show points, we can use `ST_CollectionExtract` function in the context of a `SELECTCASE` statement.


## Lesson Learnt


