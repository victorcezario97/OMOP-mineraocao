-- 1
-- Aleatória

SELECT M.measurement_concept_id, C.concept_name, 
Count(*) as QUANTIDADE
	FROM public.measurement M
	TABLESAMPLE BERNOULLI (.15)
	INNER JOIN public.concept C on M.measurement_concept_id = C.concept_id
	GROUP BY M.measurement_concept_id, C.concept_name;


-- Equi-largura
SELECT Bins.B AS ID,
	CASE WHEN Tab.Conta IS NULL THEN 0
		ELSE Tab.Conta END
	FROM 
		(WITH Lim AS (
			SELECT Min(M.measurement_concept_id) Mi, Max(M.measurement_concept_id) Ma
				FROM public.measurement M)
			SELECT Generate_Series(Lim.Mi + 1, Lim.Ma - 1, 100000) 
				AS B FROM Lim) AS Bins
				LEFT OUTER JOIN
			(SELECT Floor(M1.measurement_concept_id / 100000)*100000 AS ID, Count(*) AS CONTA
				FROM public.measurement M1
				TABLESAMPLE BERNOULLI (.15)
				GROUP BY ID) as Tab
					ON (Bins.B <= Tab.ID AND Tab.ID < (Bins.B + 100000));

-- Equi-altura
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
