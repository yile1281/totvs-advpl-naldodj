UPDATE
	SF1010
SET
	SF1010.F1_XATESTO = 'S'	
FROM
	SD1010
WHERE			
	SD1010.D1_DOC = SF1010.F1_DOC
AND
	SD1010.D1_SERIE = SF1010.F1_SERIE
AND
	SD1010.D1_FORNECE = SF1010.F1_FORNECE
AND
	SD1010.D1_LOJA = SF1010.F1_LOJA
AND
	SD1010.D1_EMISSAO = SF1010.F1_EMISSAO
AND
	SD1010.D1_XATESTO <> SF1010.F1_XATESTO
AND
	SD1010.D1_XATESTO = 'S'				