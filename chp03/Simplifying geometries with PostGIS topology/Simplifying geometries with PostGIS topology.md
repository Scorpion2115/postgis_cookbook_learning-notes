# Simplifying geometries with PostGIS topology
## Use Case
1. Use PosyGIS topology support to simplify geometries

## Recipe
1. Install postgis_topology extension using the following SQL CREATE EXTENSION command. Then you will see a new scheme named `topology` in the database
```sql
postgis_cookbook=# CREATE EXTENSION postgis_topology;
```
2. Import shapefile
3. Simplifying geometries with PostGIS topology:
    * create new topologies (`edge_data, face, node, relation`) with desired tolerance.
    * create new tables to store the topological administrative boundaries.
    * add topological geometry column to the above tables.
    * insert the polygons from the original (non-topological) table to topoligical tables

## Lesson Learnt
1. The results vary from different tolerance settings
2. You can verify these topolygies `edge_data, face, node, relation` of simplified table in QGIS
