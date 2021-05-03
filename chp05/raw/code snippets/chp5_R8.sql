-- RECIPE 8 ********************************************

-- How to do it ***************************************

CREATE OR REPLACE FUNCTION chp05.modis_evi(value double precision[][][], "position" int[][], VARIADIC userargs text[])
RETURNS double precision
AS $$
DECLARE
        L double precision;
        C1 double precision;
        C2 double precision;
        G double precision;
        _value double precision[3];
        _n double precision;
        _d double precision;
BEGIN
        -- userargs provides coefficients
        L := userargs[1]::double precision;
        C1 := userargs[2]::double precision;
        C2 := userargs[3]::double precision;
        G := userargs[4]::double precision;
        -- rescale values, optional
        _value[1] := value[1][1][1] * 0.0001;
        _value[2] := value[2][1][1] * 0.0001;
        _value[3] := value[3][1][1] * 0.0001;
        -- value can't be NULL
        IF
                _value[1] IS NULL OR
                _value[2] IS NULL OR
                _value[3] IS NULL
        THEN
                RETURN NULL;
        END IF;
        -- compute numerator and denominator
        _n := (_value[3] - _value[1]);
        _d := (_value[3] + (C1 * _value[1]) - (C2 * _value[2]) + L
);
        -- prevent division by zero
        IF _d::numeric(16, 10) = 0.::numeric(16, 10) THEN
                RETURN NULL;
        END IF;
        RETURN G * (_n / _d);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

---
SELECT
        ST_MapAlgebra(
                rast,
                ARRAY[1, 3, 4]::int[], -- only use the red, blue and near infrared bands
                'chp05.modis_evi(double precision[], int[], text[])'::regprocedure, -- signature for callback function
                '32BF', -- output pixel type
                'FIRST',
                NULL,
                0, 0,
                '1.', -- L
                '6.', -- C1
                '7.5', -- C2
                '2.5' -- G
        ) AS rast
FROM modis m;

---
CREATE OR REPLACE FUNCTION chp05.modis_evi2(value1 double 
precision, value2 double precision, pos int[], VARIADIC userargs text[])
RETURNS double precision
AS $$
DECLARE
        L double precision;
        C double precision;
        G double precision;
        _value1 double precision;
        _value2 double precision;
        _n double precision;
        _d double precision;
BEGIN
        -- userargs provides coefficients
        L := userargs[1]::double precision;
        C := userargs[2]::double precision;
        G := userargs[3]::double precision;
        -- value can't be NULL
        IF
                value1 IS NULL OR
                value2 IS NULL
        THEN
                RETURN NULL;
        END IF;
        _value1 := value1 * 0.0001;
        _value2 := value2 * 0.0001;
        -- compute numerator and denominator
        _n := (_value2 - _value1);
        _d := (L + _value2 + (C * _value1));
        -- prevent division by zero
        IF _d::numeric(16, 10) = 0.::numeric(16, 10) THEN
                RETURN NULL;
        END IF;
        RETURN G * (_n / _d);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

---
SELECT
        ST_MapAlgebraFct(
                rast, 1, -- red band
                rast, 4, -- NIR band
                'modis_evi2(double precision, double precision, int[], text[])'::regprocedure, -- signature for callback function
                '32BF', -- output pixel type
                'FIRST',
                '1.', -- L
                '2.4', -- C
                '2.5' -- G
        ) AS rast
FROM chp05.modis m;


