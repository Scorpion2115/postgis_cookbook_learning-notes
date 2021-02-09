DROP TABLE IF EXISTS chp02.xwhyzed1 CASCADE; 

CREATE TABLE chp02.xwhyzed1
(
     x numeric,
     y numeric,
     z numeric
)
WITH (OIDS=FALSE);

ALTER TABLE chp02.xwhyzed1 OWNER TO evan;

ALTER TABLE chp02.xwhyzed1 ADD COLUMN gid serial; 
ALTER TABLE chp02.xwhyzed1 ADD PRIMARY KEY (gid);

-- adding points
INSERT INTO chp02.xwhyzed1 (x, y, z)
VALUES (random()*5, random()*7, random()*106);
INSERT INTO chp02.xwhyzed1 (x, y, z)
VALUES (random()*5, random()*7, random()*106);
INSERT INTO chp02.xwhyzed1 (x, y, z)
VALUES (random()*5, random()*7, random()*106);
INSERT INTO chp02.xwhyzed1 (x, y, z)
VALUES (random()*5, random()*7, random()*106);

-- Now we need a geometry column to populate. 
-- By default, the geometry column will be populated with null values. 
-- We populate a geometry column using the following query:

SELECT AddGeometryColumn ('chp02','xwhyzed1','geom',3734,'POINT',2);

--Since all the geometry values are currently null, we will populate them using an UPDATE statement as follows:
UPDATE chp02.xwhyzed1
SET geom = ST_SetSRID(ST_MakePoint(x,y), 3734);

--Now, we need to create a trigger in order to continue to populate this information once the table is in use
CREATE OR REPLACE FUNCTION chp02.before_insertXYZ() RETURNS trigger AS
   $$
   BEGIN
   if (TG_OP='INSERT') then
if (NEW.geom is null) then
NEW.geom = ST_SetSRID(ST_MakePoint(NEW.x,NEW.y), 3734);
     end if;
   ELSEIF (TG_OP='UPDATE') then
NEW.geom = ST_SetSRID(ST_MakePoint(NEW.x,NEW.y), 3734); end if;

RETURN NEW;
   END;
   $$
   LANGUAGE 'plpgsql';
   
-- apply the function as a trigger when insert a new row
CREATE TRIGGER popgeom_insert
BEFORE INSERT ON chp02.xwhyzed1
FOR EACH ROW EXECUTE PROCEDURE chp02.before_insertXYZ();  

-- apply the function as a trigger when update an existing row
CREATE trigger popgeom_update
BEFORE UPDATE ON chp02.xwhyzed1
FOR EACH ROW
WHEN (OLD.X IS DISTINCT FROM NEW.X OR OLD.Y IS DISTINCT FROM
NEW.Y)
EXECUTE PROCEDURE chp02.before_insertXYZ();
   
 -- repeat adding points
INSERT INTO chp02.xwhyzed1 (x, y, z)
VALUES (random()*5, random()*6, random()*106);
INSERT INTO chp02.xwhyzed1 (x, y, z)
VALUES (random()*5, random()*6, random()*106);
INSERT INTO chp02.xwhyzed1 (x, y, z)
VALUES (random()*5, random()*6, random()*106);
INSERT INTO chp02.xwhyzed1 (x, y, z)
VALUES (random()*5, random()*6, random()*106);
