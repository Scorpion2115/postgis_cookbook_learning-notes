create or replace view chp03.rivers_clipped_by_country as
select r.name, c.iso2, 
ST_Intersection(r.geom, c.geom)::geometry(Geometry,4326) as geom
From chp03.wborders as c
Join chp03.rivers as r
on ST_Intersects(r.geom, c.geom);

-- Get unique value from column iso2
select DISTINCT(iso2) from chp03.wborders
order by iso2;