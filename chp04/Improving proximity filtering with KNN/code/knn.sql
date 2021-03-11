--native approach 
--POI: -81.868539, 41.363804
--Suppose we were interested in finding the 10 records closest to the POI
select ST_Distance(searchpoint.geom, addr.geom) as dist, * from chp04.knn_addresses as addr,
(select ST_Transform(ST_SetSRID(ST_MakePoint(-81.868539, 41.363804),4326),3734) as geom) searchpoint
order by ST_Distance(searchpoint.geom, addr.geom)
limit 10;

--alternative approach, setup a searching ring
select ST_Distance(searchpoint.geom, addr.geom) as dist, * from chp04.knn_addresses as addr,
(select ST_Transform(ST_SetSRID(ST_MakePoint(-81.868539, 41.363804),4326),3734) as geom) searchpoint
where ST_DWithin(searchpoint.geom, addr.geom, 1000)
order by ST_Distance(searchpoint.geom, addr.geom)
limit 10;

--knn
select ST_Distance(searchpoint.geom, addr.geom) as dist, * from chp04.knn_addresses as addr,
(select ST_Transform(ST_SetSRID(ST_MakePoint(-81.868539, 41.363804),4326),3734) as geom) searchpoint
order by addr.geom <-> searchpoint.geom
limit 10;