-- elimina os registros sem Relacionamentos da CNE com a CND
DELETE
FROM
	CNE010
WHERE
	NOT EXISTS
	(
		SELECT
			1
		FROM
			CND010
		WHERE
			CNE_CONTRA = CND_CONTRA
		AND
			CNE_REVISA = CND_REVISA
		AND
			CNE_NUMERO = CND_NUMERO
		AND
			CNE_NUMMED = CND_NUMMED
	)