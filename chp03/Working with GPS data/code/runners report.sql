-- Create the chp03.rk_track_points table
-- Below is the snapshot of the input dataset
-- <trkpt lat="41.842603000" lon="12.490049000"><ele>37.0</ele><time>2010-05-21T14:34:13Z</time></trkpt>

CREATE TABLE chp03.rk_track_points (
           fid serial NOT NULL, --
           the_geom geometry(Point,4326), --create point from lat,long
           ele double precision, -- <ele> element
           "time" timestamp with time zone, --<time> element
           CONSTRAINT activities_pk PRIMARY KEY (fid)
);

--always remember to create spatial index before query to improve the query performance
create index rk_track_points_geom_idx on chp03.rk_track_points using gist(the_geom);


SELECT ST_MakeLine(the_geom) AS the_geom,run_date::date,
   MIN(run_time) as start_time,
   MAX(run_time) as end_time
INTO chp03.tracks FROM 
(
SELECT the_geom, "time"::date as run_date, "time" as run_time
FROM chp03.rk_track_points ORDER BY run_time
   ) AS foo GROUP BY run_date;

create index tracks_geom_idx on chp03.tracks using gist(the_geom);

--query the tracks table to get a report of the total distance run (in km) by the runner for each month
SELECT
EXTRACT(year FROM run_date) AS run_year,
EXTRACT(MONTH FROM run_date) as run_month, SUM(ST_Length(geography(the_geom)))/1000 AS distance
FROM chp03.tracks
GROUP BY run_year, run_month ORDER BY run_year, run_month;

--Using a spatial join to query the distance by runner per country
SELECT
c.name, SUM(ST_Length(geography(t.the_geom)))/1000 AS run_distance
FROM chp03.tracks AS t
JOIN chp01.countries AS c
ON ST_Intersects(t.the_geom, c.geom)
GROUP BY c.name 
ORDER BY run_distance DESC;

