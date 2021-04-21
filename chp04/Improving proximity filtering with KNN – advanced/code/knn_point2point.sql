-- create a function
-- use RETURNS table() to return multiple columns
CREATE OR REPLACE FUNCTION chp04.KNN(k int,src_id int) RETURNS table (tar_id integer, dist_feet double precision) AS $$
-- the order matters! 
SELECT  tar.gid AS tar_id, src.geom <#> tar.geom as dist_feet
  FROM chp04.knn_addresses AS src, chp04.knn_addresses AS tar
  WHERE src.gid = src_id AND src.gid != tar.gid
  GROUP BY tar_id, src.geom
  ORDER BY src.geom <#> tar.geom
  LIMIT k
$$ LANGUAGE sql


-- call the function
SELECT s.gid as src_id, chp04.KNN(3,s.gid)
FROM chp04.knn_addresses AS s 
ORDER BY s.gid;

-- call the function
--Functions returning a table (or setof) should be used in the FROM clause:
SELECT s.gid as src_id, r.*
FROM chp04.knn_addresses AS s, chp04.KNN(3,s.gid) as r
ORDER BY s.gid;


-- optional
DROP FUNCTION chp04.knn(k int,src_id int);



-- Using JOIN LATERAL
CREATE TABLE small_cell.knn_l08_200 AS 
(SELECT c.lactac, c.enodebid, c.cellid, c.avg_rx, c.n_users, c.n_samples,
       t."site id", t."batch info", t.activation, t.geom sc_geom,
	   ST_Distance(c.geom::geography, t.geom::geography) dist
FROM umlaut.raw_tpg_4g_bs_l08 As c
JOIN LATERAL (
  SELECT s.ogc_fid, s."site id", s."batch info", s.activation, s.geom
  FROM small_cell.site_status AS s
  WHERE c.avg_rx <= -100
  ORDER BY c.geom <-> s.geom
  LIMIT 1
) AS t
ON true
WHERE ST_Distance(c.geom::geography, t.geom::geography) <= 200);