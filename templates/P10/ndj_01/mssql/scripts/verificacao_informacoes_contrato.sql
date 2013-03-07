--Verificando CN9 vs CNA
SELECT
	CN9_NUMERO SEM_ITEM_CNA
FROM
	CN9010
WHERE
	NOT EXISTS(
				SELECT
						1
				FROM
					CNA010
				WHERE
					CNA_CONTRA = CN9_NUMERO
				)
--Verificando CN9 vs CNB
SELECT
	CN9_NUMERO SEM_ITEM_CNB
FROM
	CN9010
WHERE
	NOT EXISTS(
				SELECT
						1
				FROM
					CNB010
				WHERE
					CNB_CONTRA = CN9_NUMERO
				)
		
--Verificando CN9 vs CNC			
SELECT
	CN9_NUMERO SEM_ITEM_CNC
FROM
	CN9010
WHERE
	NOT EXISTS(
				SELECT
						1
				FROM
					CNC010
				WHERE
					CNC_NUMERO = CN9_NUMERO
				)			
				
--Verificando Itens Obrigatorios da CNB
SELECT DISTINCT
	CNB_CONTRA,
	CNB_XSZ2CO,
	CNB_XCODSB,
	CNB_XSBM,
	CNB_XPROJE,
	CNB_XTAREF,
	CNB_XCODOR,
	CNB_XCODCA,
	CNB_XNUMSC,
	CNB_XITMSC,
	CNB_XNUMPC,
	CNB_XITMPC,
	CNB_XSEQPC,
	CNB_XCC,
	CNB_XCONTA,
	CNB_XITCTA,
	CNB_XCLVL
FROM
	CNB010
WHERE
	(
		CNB_XSZ2CO  = ''
	OR
		CNB_XCODSB  = ''
	OR
		CNB_XSBM  = ''
	OR
		CNB_XPROJE  = ''
	OR
		CNB_XTAREF  = ''
	OR
		CNB_XCODOR  = ''
	OR
		CNB_XCODCA  = ''
	OR
		CNB_XNUMSC  = ''
	OR
		CNB_XITMSC  = ''
	OR
		CNB_XNUMPC  = ''
	OR
		CNB_XITMPC  = ''
	OR
		CNB_XSEQPC  = ''
	OR
		CNB_XCC  = ''
	OR
		CNB_XCONTA  = ''
	OR
		CNB_XITCTA  = ''
	OR
		CNB_XCLVL  = ''
	)	
ORDER BY
	CNB_CONTRA	
	

Select * from SB1010	

SELECT * FROM CNB010

-- Verificando o Codigo do Produto na CNB
SELECT DISTINCT
	CNB_PRODUT
FROM
	CNB010
WHERE
	NOT EXISTS
	(
		SELECT 
			1
		FROM
			SB1010
		WHERE
			B1_COD = CNB_PRODUT
	)
	
-- Verificando o Codigo do Produto na CNE
SELECT DISTINCT
	CNE_PRODUT
FROM
	CNE010
WHERE
	NOT EXISTS
	(
		SELECT 
			1
		FROM
			SB1010
		WHERE
			B1_COD = CNE_PRODUT
	)