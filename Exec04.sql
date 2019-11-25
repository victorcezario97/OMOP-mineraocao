-- 4)

CREATE OR REPLACE FUNCTION procedures_by_delimiter_id(delimiter integer) 
RETURNS SETOF public.procedure_occurrence 
AS $fun$
	BEGIN
	RETURN QUERY 
		SELECT * FROM public.procedure_occurrence P
			WHERE P.person_id <= delimiter
			ORDER BY P.person_id;
	END;
$fun$ LANGUAGE plpgsql;

SELECT * FROM procedures_by_delimiter_id(100);
