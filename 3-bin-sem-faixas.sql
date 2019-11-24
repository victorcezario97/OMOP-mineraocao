WITH EXAMS AS (SELECT M.measurement_concept_id AS EXAME, COUNT(*) AS QTD
	FROM public.measurement M
	INNER JOIN public.person P ON M.person_id = P.person_id
	WHERE (M.measurement_date BETWEEN '2008-01-01' AND '2011-12-31') AND P.gender_concept_id = 8507
	GROUP BY M.measurement_concept_id
	ORDER BY COUNT(*) DESC
	LIMIT 50),
	MinMax AS ( SELECT Min(exame) Mi, Max(exame) Ma
		FROM EXAMS)

		SELECT exame, 
			Width_bucket(exame, (SELECT Mi FROM MinMax), 
			(SELECT Ma FROM MinMax), 4) as Bin,
			Count(*)
		FROM EXAMS
		GROUP BY exame
		Order by exame;
		