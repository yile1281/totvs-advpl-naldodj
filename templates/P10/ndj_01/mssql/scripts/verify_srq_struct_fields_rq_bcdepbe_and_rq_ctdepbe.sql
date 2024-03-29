SELECT SRQ.RQ_BCDEPBE AS BCO_AG,SRQ.RQ_CTDEPBE AS CC FROM SRQ010 SRQ WHERE RQ_SEQUENC='01'
;
SELECT SRQ.RQ_BCDEPBE AS BCO_AG,SRQ.RQ_CTDEPBE AS CC FROM SRQ030 SRQ WHERE RQ_SEQUENC='01'
;
SELECT
        *
FROM 
        INFORMATION_SCHEMA.COLUMNS
WHERE
        TABLE_NAME IN ( 'SRQ010' , 'SRQ030' )
AND
        COLUMN_NAME IN ( 'RQ_BCDEPBE' , 'RQ_CTDEPBE' )

;
SELECT 'Banco/Agencia/Conta: ' + SubString(SRQ.RQ_BCDEPBE+'/'+SRQ.RQ_CTDEPBE,1,3)+'/'+SubString(SRQ.RQ_BCDEPBE+SRQ.RQ_CTDEPBE,4,5)+'/'+SubString(SRQ.RQ_BCDEPBE+SRQ.RQ_CTDEPBE,9,12) FROM SRQ010 SRQ WHERE SRQ.RQ_SEQUENC = '01'
;
SELECT 'Banco/Agencia/Conta: ' + SubString(SRQ.RQ_BCDEPBE+'/'+SRQ.RQ_CTDEPBE,1,3)+'/'+SubString(SRQ.RQ_BCDEPBE+SRQ.RQ_CTDEPBE,4,5)+'/'+SubString(SRQ.RQ_BCDEPBE+SRQ.RQ_CTDEPBE,9,12) FROM SRQ030 SRQ WHERE SRQ.RQ_SEQUENC = '01'