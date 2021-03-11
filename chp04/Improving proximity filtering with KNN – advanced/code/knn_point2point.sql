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