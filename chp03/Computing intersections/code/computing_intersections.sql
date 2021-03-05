select 
r1.gid as gid1,
r2.gid as gid2,
-- get intersection context as text
ST_AsText(ST_Intersection(r1.geom, r2.geom)) as geom
from chp03.rivers r1
join chp03.rivers r2
on ST_Intersects(r1.geom, r2.geom)
where r1.gid != r2.gid;

-- count number of geometry type per different intersections
-- you can use this one as a report of self-cross issues
select count(*),
ST_GeometryType(ST_Intersection(r1.geom, r2.geom)) as geotype
from chp03.rivers r1
join chp03.rivers r2
on ST_Intersects(r1.geom, r2.geom)
where r1.gid != r2.gid
group by geotype;


create or replace view chp03.self_intersection_simple as
select 
r1.gid as gid1,
r2.gid as gid2,
ST_Multi(ST_Intersection(r1.geom, r2.geom)::geometry(Geometry, 4326)) as geom
from chp03.rivers r1
join chp03.rivers r2
on ST_Intersects(r1.geom, r2.geom)
where r1.gid != r2.gid
and ST_GeometryType(ST_Intersection(r1.geom, r2.geom)) != 'ST_GeometryCollection';


create or replace view chp03.self_intersection_all as
select 
r1.gid as gid1,
r2.gid as gid2,

--use ST_CollectionExtract function in SELECTCASE statement to ignore the collection 
--of eventual linestrings
case
	when ST_GeometryType(ST_Intersection(r1.geom, r2.geom)) != 'ST_GeometryCollection'
		then ST_Multi(ST_Intersection(r1.geom, r2.geom)::geometry(Geometry, 4326))
	else ST_CollectionExtract(ST_Intersection(r1.geom, r2.geom),1)
end as geom
from chp03.rivers r1
join chp03.rivers r2
on ST_Intersects(r1.geom, r2.geom)
where r1.gid != r2.gid;

select count(*) as recordes, sum(ST_NPoints(geom)) as points
from chp03.self_intersection_simple;

select count(*) as recordes, sum(ST_NPoints(geom)) as points
from chp03.self_intersection_all;