-- RECIPE 1 ********************************************

-- Getting ready ***************************************

CREATE SCHEMA chp05;

-- How to do it ****************************************

SELECT srid, auth_name, auth_srid, srtext, proj4text FROM 
spatial_ref_sys WHERE proj4text LIKE '%NAD83%'
---
ALTER TABLE chp05.prism ADD COLUMN month_year DATE;
UPDATE chp05.prism 
SET  month_year = ( SUBSTRING(split_part(filename, '_', 5), 0, 5) || '-' ||  SUBSTRING(split_part(filename, '_', 5), 5, 4) || '-01' ) :: DATE;
