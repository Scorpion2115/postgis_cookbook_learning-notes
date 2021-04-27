# Improving ST_Polygonize
## Use Case
Use `ST_Polygonize` to construct polygon and formalizing it into a function for reuse.

## Recipe
1. Use `ST_Dump` to handle geometry collections.
2. The dump type is a special PostGIS type that is a combination of the geometries and an index number for the geometries.

## Lesson Learnt

