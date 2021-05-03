-- create two new tables
CREATE TABLE chp04.earthq_cent (
     cid integer PRIMARY KEY, geom geometry('POINT',4326)
);
   CREATE TABLE chp04.earthq_circ (
     cid integer PRIMARY KEY, geom geometry('POLYGON',4326)
);


-- Insert into chp04.earthq_cent
INSERT INTO chp04.earthq_cent (geom, cid)
(SELECT DISTINCT ST_SetSRID(ST_Centroid(tab2.ge2), 4326) centroid, tab2.cid  FROM
(SELECT ST_UNION(tab.ge) OVER (partition by tab.cid ORDER BY tab.cid) ge2, tab.cid
FROM
(SELECT ST_ClusterKMeans(e.wkb_geometry, 10) OVER() cid, e.wkb_geometry ge 
FROM chp03.earthquakes e) tab) tab2);

-- Insert into chp04.earthq_circ
-- Just replace ST_Centroid by ST_MinimumBoundingCircle
INSERT INTO chp04.earthq_circ (geom, cid)
(SELECT DISTINCT ST_SetSRID(ST_MinimumBoundingCircle(tab2.ge2), 4326) circle, tab2.cid  FROM
(SELECT ST_UNION(tab.ge) OVER (partition by tab.cid ORDER BY tab.cid) ge2, tab.cid
FROM
(SELECT ST_ClusterKMeans(e.wkb_geometry, 10) OVER() cid, e.wkb_geometry ge 
FROM chp03.earthquakes e) tab) tab2);