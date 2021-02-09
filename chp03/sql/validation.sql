--First, investigate whether or not any geometry is invalid in the imported table
SELECT gid, name, ST_IsValidReason(geom) FROM chp03.wborders
WHERE ST_IsValid(geom)=false;

--Fix all the other invalid geometries with ST_IsValid
UPDATE chp03.wborders 
SET geom = ST_MakeValid(geom) 
WHERE ST_IsValid(geom) = false;