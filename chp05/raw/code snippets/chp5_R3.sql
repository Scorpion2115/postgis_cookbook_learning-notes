-- RECIPE 3 ********************************************

-- How to do it ***************************************
WITH stats AS (
        SELECT
                'before' AS state,
                (ST_SummaryStats(rast, 1)).*
        FROM chp05.prism
        WHERE rid = 54
        UNION ALL
        SELECT
                'after' AS state, (
                        ST_SummaryStats(
                                ST_MapAlgebra(rast, 1, '32BF', '([rast]*9/5)+32', -9999),
                                1
                        )
                ).*
        FROM chp05.prism
        WHERE rid = 54
)
SELECT
        state,
        count,
        round(sum::numeric, 2) AS sum,
        round(mean::numeric, 2) AS mean,
        round(stddev::numeric, 2) AS stddev,
        round(min::numeric, 2) AS min,
        round(max::numeric, 2) AS max
FROM stats
ORDER BY state DESC;

---
UPDATE chp05.prism 
SET rast = ST_AddBand(rast,ST_MapAlgebra(rast, 1, '32BF', '([rast]*9/5)+32', -999), 1);

---
SELECT DropRasterConstraints('chp05', 'prism', 'rast'::name);
UPDATE chp05.prism SET
        rast = ST_AddBand(
                rast,
                ST_MapAlgebra(rast, 1, '32BF', ' ([rast]*9/5)+32', -9999),
                1
        );

SELECT AddRasterConstraints('chp05', 'prism', 'rast'::name);

 
---
SELECT
        (ST_Metadata(rast)).numbands
FROM chp05.prism
WHERE rid = 54;

---
SELECT
        1 AS bandnum,
        (ST_BandMetadata(rast, 1)).*
FROM chp05.prism
WHERE rid = 54
UNION ALL
SELECT
        2 AS bandnum,
        (ST_BandMetadata(rast, 2)).*
FROM chp05.prism
WHERE rid = 54
ORDER BY bandnum;

---
WITH stats AS (
        SELECT
                1 AS bandnum,
                (ST_SummaryStats(rast, 1)).*
        FROM chp05.prism
        WHERE rid = 54
        UNION ALL
        SELECT
                2 AS bandnum,
                (ST_SummaryStats(rast, 2)).*
        FROM chp05.prism
        WHERE rid = 54
)
SELECT
        bandnum,
        count,
        round(sum::numeric, 2) AS sum,
        round(mean::numeric, 2) AS mean,
        round(stddev::numeric, 2) AS stddev,
        round(min::numeric, 2) AS min,
        round(max::numeric, 2) AS max
FROM stats
ORDER BY bandnum;
