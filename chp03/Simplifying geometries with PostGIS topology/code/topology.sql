CREATE EXTENSION postgis_topology;

--Add the scheme `topology` to the search path to avoid prefixing it 
--before every topology function or object:
--set search_path to chp03, topology, public;

--create a new topology with 1m, 500m and 10km tolerance
select topology.CreateTopology('hu_topo_1m', 3857,1, false);
select topology.CreateTopology('hu_topo_500m', 3857, 500, false);
select topology.CreateTopology('hu_topo_10km', 3857, 10000, false);

--verify the new topology
select * from topology.topology;
select topologysummary('hu_topo_1m');
select topologysummary('hu_topo_500m');
select topologysummary('hu_topo_10km');

--create a new table to store the topological administrative boundaries
create table chp03.hu_topo_polygons_1(gid serial primary key, name_1 varchar(75));
create table chp03.hu_topo_polygons_500(gid serial primary key, name_1 varchar(75));
create table chp03.hu_topo_polygons_10k(gid serial primary key, name_1 varchar(75));

--add a topological geometry column to this table
select topology.AddTopoGeometryColumn('hu_topo_1m', 'chp03', 'hu_topo_polygons_1', 
							 'geom_topo', 'MULTIPOLYGON') as layer_id;
							 
							 
select topology.AddTopoGeometryColumn('hu_topo_500m', 'chp03', 'hu_topo_polygons_500', 
							 'geom_topo', 'MULTIPOLYGON') as layer_id;
							 

select topology.AddTopoGeometryColumn('hu_topo_10km', 'chp03', 'hu_topo_polygons_10k', 
							 'geom_topo', 'MULTIPOLYGON') as layer_id;
							 
							 
--insert the polygons from non-topological hungary table to the topological table
insert into chp03.hu_topo_polygons_1(name_1, geom_topo)
select name_1, toTopoGeom(geom, 'hu_topo_1m', 1)
from chp03.hungary;

insert into chp03.hu_topo_polygons_500(name_1, geom_topo)
select name_1, toTopoGeom(geom, 'hu_topo_500m', 1)
from chp03.hungary;

insert into chp03.hu_topo_polygons_10k(name_1, geom_topo)
select name_1, toTopoGeom(geom, 'hu_topo_10km', 1)
from chp03.hungary;

select topologysummary('hu_topo_1m');
select topologysummary('hu_topo_500m');
select topologysummary('hu_topo_10km');


SELECT sum(ST_NPoints(geom)) FROM chp03.hungary;
SELECT sum(ST_NPoints(geom_topo)) FROM chp03.hu_topo_polygons_1;
SELECT sum(ST_NPoints(geom_topo)) FROM chp03.hu_topo_polygons_500;
SELECT sum(ST_NPoints(geom_topo)) FROM chp03.hu_topo_polygons_10k;

