-- 4)

CREATE OR REPLACE FUNCTION fun(limiter integer) 
RETURNS SETOF public.procedure_occurrence 
AS $fun$
	BEGIN
	RETURN QUERY 
		SELECT * FROM public.procedure_occurrence P
			WHERE P.person_id <= limiter
			ORDER BY P.person_id;
	END;
$fun$ LANGUAGE plpgsql;

SELECT * FROM fun(100);