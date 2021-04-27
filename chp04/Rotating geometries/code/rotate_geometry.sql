CREATE TABLE chp04.tsr_building AS
SELECT ST_Rotate(ST_Envelope(ST_Buffer(geom, 20)), radians(90 - chp04.angle_to_street(addr.geom)), addr.geom)
AS geom FROM chp04.knn_addresses addr
LIMIT 500;