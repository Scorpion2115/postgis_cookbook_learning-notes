CREATE OR REPLACE VIEW rome_trees AS 

-- to create an increamental key as object_id in the view table, which is required by QGIS
SELECT row_number() over (order by way) as object_id, way, tags
FROM planet_osm_polygon WHERE (tags -> 'landcover') = 'trees';

