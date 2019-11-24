WITH EXAMS AS (SELECT M.measurement_concept_id AS EXAME, COUNT(*) AS QTD
	FROM public.measurement M
	INNER JOIN public.person P ON M.person_id = P.person_id
	WHERE (M.measurement_date BETWEEN '2008-01-01' AND '2011-12-31') AND P.gender_concept_id = 8507
	GROUP BY M.measurement_concept_id
	ORDER BY COUNT(*) DESC
	LIMIT 50),
	MinMax AS 
	( SELECT 9 AS NB, Min(exame) Mi, Max(exame) Ma
		FROM EXAMS)

		SELECT Trunc((SELECT Mi FROM MinMax)+
			((Bin-1)*((SELECT Ma FROM MinMax)-(SELECT Mi FROM MinMax))/
				(SELECT NB FROM MinMax)), 2) AS Ini,
			Trunc(((SELECT Mi FROM MinMax) +
				(Bin)*((SELECT Ma FROM MinMax)-(SELECT Mi FROM MinMax))/
				(SELECT NB FROM MinMax)), 2) AS Fim, Conta
		FROM (
			SELECT Width_Bucket(exame, (SELECT Mi FROM MinMax),
				(SELECT Ma FROM MinMax), (SELECT NB FROM MinMax)) AS Bin,
				Count(*) as Conta
			FROM EXAMS
		GROUP BY Bin
		ORDER BY Bin) Histo;

		