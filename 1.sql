-- 1
-- Aleatória

SELECT M.measurement_concept_id, C.concept_name, 
Count(*) as QUANTIDADE
	FROM public.measurement M
	TABLESAMPLE BERNOULLI (.15)
	INNER JOIN public.concept C on M.measurement_concept_id = C.concept_id
	GROUP BY M.measurement_concept_id, C.concept_name;


-- Equi-largura
SELECT Floor(M.measurement_concept_id/5.00)*5 as ID, Count(*) as QUANTIDADE
	FROM public.measurement M
	TABLESAMPLE BERNOULLI (.15)
	INNER JOIN public.concept C on M.measurement_concept_id = C.concept_id
	GROUP BY ID
	ORDER BY ID;

- Equi-altura
SELECT Bin, Min(measurement_concept_id), Max(measurement_concept_id), Count(*)
	FROM (SELECT *, NTILE(10) OVER(ORDER BY measurement_concept_id) AS Bin
	FROM (SELECT * FROM measurement TABLESAMPLE BERNOULLI (.15) ) AS Sample) AS Partes 
	GROUP BY Bin
	ORDER BY Bin;


-- 1.1
SELECT M.measurement_concept_id, C.concept_name, Count(*) as Quantidade
	FROM public.measurement M
	TABLESAMPLE BERNOULLI (.15)
	INNER JOIN public.concept C on M.measurement_concept_id = C.concept_id
	GROUP BY M.measurement_concept_id, C.concept_name;
