IF EXISTS( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'SA6_TMP') AND OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
    DROP TABLE SA6_TMP
END
;
SELECT DISTINCT
    R_E_C_N_O_=IDENTITY(INT,1,1)
    ,SUBSTRING(SRA.RA_BCDEPSA,1,3) AS A6_COD
    ,SUBSTRING(SRA.RA_BCDEPSA,4,5) AS A6_AGENCIA
    ,SRA.D_E_L_E_T_
    ,MAX(SRA.R_E_C_N_O_) MAXRECNO
INTO SA6_TMP
FROM SRA010 SRA
WHERE SRA.D_E_L_E_T_=' '
AND SRA.RA_BCDEPSA<>' '
AND NOT EXISTS(
    SELECT DISTINCT 1
    FROM
      SA6010 SA6
        WHERE SA6.A6_COD=SUBSTRING(SRA.RA_BCDEPSA,1,3)
          AND SA6.A6_AGENCIA=SUBSTRING(SRA.RA_BCDEPSA,4,5)
          AND SA6.D_E_L_E_T_=' ' 
) 
GROUP BY
     SUBSTRING(SRA.RA_BCDEPSA,1,3)
    ,SUBSTRING(SRA.RA_BCDEPSA,4,5)
    ,SRA.D_E_L_E_T_
;
INSERT INTO SA6010
(
     A6_COD
    ,A6_AGENCIA
    ,D_E_L_E_T_
    ,R_E_C_N_O_
)
SELECT 
     SA6TMP.A6_COD
    ,SA6TMP.A6_AGENCIA
    ,SA6TMP.D_E_L_E_T_
    ,SA6TMP.R_E_C_N_O_ + ISNULL((SELECT MAX(SA6.R_E_C_N_O_) FROM SA6010 SA6),0) R_E_C_N_O_
FROM SA6_TMP SA6TMP
;
IF EXISTS( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'SA6_TMP') AND OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
    DROP TABLE SA6_TMP
END
;
SELECT DISTINCT
    R_E_C_N_O_=IDENTITY(INT,1,1)
    ,SUBSTRING(SRA.RA_BCDEPSA,1,3) AS A6_COD
    ,SUBSTRING(SRA.RA_BCDEPSA,4,5) AS A6_AGENCIA
    ,SRA.D_E_L_E_T_
    ,MAX(SRA.R_E_C_N_O_) MAXRECNO
INTO SA6_TMP
FROM SRA030 SRA
WHERE SRA.D_E_L_E_T_=' '
AND SRA.RA_BCDEPSA<>' '
AND NOT EXISTS(
    SELECT DISTINCT 1
    FROM
      SA6030 SA6
        WHERE SA6.A6_COD=SUBSTRING(SRA.RA_BCDEPSA,1,3)
          AND SA6.A6_AGENCIA=SUBSTRING(SRA.RA_BCDEPSA,4,5)
          AND SA6.D_E_L_E_T_=' ' 
)
GROUP BY
     SUBSTRING(SRA.RA_BCDEPSA,1,3)
    ,SUBSTRING(SRA.RA_BCDEPSA,4,5)
    ,SRA.D_E_L_E_T_
;
INSERT INTO SA6030
(
     A6_COD
    ,A6_AGENCIA
    ,D_E_L_E_T_
    ,R_E_C_N_O_
)
SELECT 
     SA6TMP.A6_COD
    ,SA6TMP.A6_AGENCIA
    ,SA6TMP.D_E_L_E_T_
    ,SA6TMP.R_E_C_N_O_ + ISNULL((SELECT MAX(SA6.R_E_C_N_O_) FROM SA6030 SA6),0) R_E_C_N_O_
FROM SA6_TMP SA6TMP
;
IF EXISTS( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'SA6_TMP') AND OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
    DROP TABLE SA6_TMP
END

UPDATE SA6010 SET SA6010.A6_NOME=SA6.A6_NOME,SA6010.A6_NREDUZ=SA6.A6_NREDUZ
FROM
(    
  SELECT DISTINCT SA6.A6_COD,SA6.A6_NOME,SA6.A6_NREDUZ
  FROM SA6010 SA6
  WHERE SA6.A6_NOME<>' '
) AS SA6
WHERE SA6.A6_COD=SA6010.A6_COD
  AND SA6010.A6_NOME=' '
;
UPDATE SA6030 SET SA6030.A6_NOME=SA6.A6_NOME,SA6030.A6_NREDUZ=SA6.A6_NREDUZ
FROM
(    
  SELECT DISTINCT SA6.A6_COD,SA6.A6_NOME,SA6.A6_NREDUZ
  FROM SA6030 SA6
  WHERE SA6.A6_NOME<>' '
) AS SA6
WHERE SA6.A6_COD=SA6030.A6_COD
  AND SA6030.A6_NOME=' '

