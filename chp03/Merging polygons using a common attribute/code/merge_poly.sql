select county, fips, state_fips from chp03.counties
order by county;

CREATE TABLE chp03.states_from_counties
         AS SELECT ST_Multi(ST_Union(the_geom)) as the_geom, state_fips
         FROM chp03.counties GROUP BY state_fips;