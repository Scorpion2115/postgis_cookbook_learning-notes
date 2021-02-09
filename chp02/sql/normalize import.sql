--browse the unique value in label_name colummn
SELECT DISTINCT label_name FROM chp02.trails WHERE label_name LIKE '%&%' LIMIT 10;

-- 1st thing to do is find all the fields that don't have ampersands and use those as our unique list of available trails
SELECT DISTINCT label_name, res FROM chp02.trails
WHERE label_name NOT LIKE '%&%' ORDER BY label_name, res;

--Next, we want to search for all the records that match any of these unique trail names.
SELECT '%' || label_name || '%' AS label_name, label_name as label, res
FROM
(SELECT DISTINCT label_name, res FROM chp02.trails
WHERE label_name NOT LIKE '%&%' ORDER BY label_name, res
) AS label;


--Finally, we'll use this in the context of a WITH block to do the normalization itself. 
CREATE TABLE chp02.trails_names AS
  WITH labellike AS
(
SELECT '%' || label_name || '%' AS label_name, label_name as   label, res FROM
  (
  SELECT DISTINCT label_name, res
    FROM chp02.trails
    WHERE label_name NOT LIKE '%&%'
    ORDER BY label_name, res
  ) AS label
)
SELECT t.id, ll.label, ll.res
  FROM chp02.trails AS t, labellike AS ll
  WHERE t.label_name LIKE ll.label_name
  AND
  t.res = ll.res
  ORDER BY id;

