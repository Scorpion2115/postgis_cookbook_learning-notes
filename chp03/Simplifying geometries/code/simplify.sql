CREATE TABLE chp03.states_simplify_topology AS
SELECT ST_SimplifyPreserveTopology(ST_Transform(geom, 2163), 500) FROM chp03.states;