-- 4)

SELECT * FROM public.person PE
	INNER JOIN public.procedure_occurrence PR ON PR.person_id = PE.person_id
	INNER JOIN public.visit_occurrence V ON PR.visit_occurrence_id = V.visit_occurrence_ID
	WHERE PE.person_id <= 100
	ORDER BY PE.person_id;
