# Merging polygons using a common attribute
## Use Case
* There are many cases in GIS workflows where you need to merge a polygonal dataset based on a common attribute.
## Recipe
* `ST_Union` acts as an aggregate function (such as SUM, COUNT, MIN and MAX) on the geometric field, using the common attribute in the `Group By` clause 

* As is shown, the function aggregate counties into states
![img](./img/Merge_Polygon.png?raw=true "Country to State")

## Lesson Learnt
* Handle ACMA spectrum map with dofferemt level of HCIS grid




