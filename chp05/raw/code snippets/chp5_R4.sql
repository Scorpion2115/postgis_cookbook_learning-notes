-- RECIPE 4 ********************************************

-- How to do it ***************************************

SELECT (
	ST_SummaryStats(
		ST_Union(
			ST_Clip(
				prism.rast, 1, ST_Transform(sf.geom, 4269), TRUE
			)
        ),
        1
    )
).mean
FROM chp05.prism
JOIN chp05.sfpoly sf
ON ST_Intersects(prism.rast, ST_Transform(sf.geom, 4269))
WHERE prism.month_year = '2017-03-01'::date;

---
SELECT
        prism.month_year, (
                ST_SummaryStats(
                        ST_Union(
                                ST_Clip(prism.rast, 1, ST_Transform(sf.geom, 4269), TRUE)
                        ),
                        1
                )
        ).mean
FROM chp05.prism
JOIN chp05.sfpoly sf
ON ST_Intersects(prism.rast, ST_Transform(sf.geom, 4269))
GROUP BY prism.month_year
ORDER BY prism.month_year;
