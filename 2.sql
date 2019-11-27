SELECT C.concept_name as NOME, M.measurement_date as DATA_REALIZADA
FROM 
  public.measurement M
  INNER JOIN public.concept C on M.measurement_concept_id = C.concept_id
  WHERE M.measurement_date BETWEEN '2008-01-01' AND '2011-12-31'
  ORDER BY M.measurement_date;

SELECT P.gender_concept_id AS GENERO,
	( COUNT(*)*100.0 /
		(SELECT COUNT(*) from public.measurement M2
		WHERE M2.measurement_date BETWEEN '2008-01-01' AND '2011-12-31')
	) AS PORCENTAGEM
	FROM public.measurement M
	INNER JOIN public.person P ON M.person_id = P.person_id
	WHERE M.measurement_date BETWEEN '2008-01-01' AND '2011-12-31'
	GROUP BY P.gender_concept_id;

SELECT P.gender_concept_id AS GENERO,
	( COUNT(*)*100.0 /
		(SELECT COUNT(*) from public.measurement M2 
		WHERE M2.measurement_date BETWEEN '2008-01-01' AND '2011-12-31')
	) AS PORCENTAGEM,
	EXTRACT(YEAR FROM M.measurement_date)
	FROM public.measurement M
	INNER JOIN public.person P ON M.person_id = P.person_id
	WHERE M.measurement_date BETWEEN '2008-01-01' AND '2011-12-31'
	GROUP BY P.gender_concept_id, EXTRACT(YEAR FROM M.measurement_date)
	ORDER BY EXTRACT(YEAR FROM M.measurement_date), P.gender_concept_id;	