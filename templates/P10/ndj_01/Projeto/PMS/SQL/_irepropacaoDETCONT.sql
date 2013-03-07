
SELECT PREVREAL.AF8_ORCAME      ,
       PREVREAL.AF8_PROJET      ,
       PREVREAL.AF8_REVISA      ,
       PREVREAL.AF8_DESCRI      ,
       PREVREAL.AF8_XCODDI      ,
       PREVREAL.AF8_XSPON       ,
       PREVREAL.AF8_XGER        ,
       PREVREAL.ORD_TAREFA      ,
       PREVREAL.DESC_TAREFA     ,
       PREVREAL.TOT_TAREFA      ,
       PREVREAL.SUB_ORD_TAREFA  ,
       PREVREAL.SUB_DESC_TAREFA ,
       PREVREAL.AFC_TOTAL       ,
       PREVREAL.AF9_TAREFA      ,
       PREVREAL.AF9_DESCRI      ,
       PREVREAL.AF9_TOTAL       ,
       ISNULL( PREVREAL.D1_XTAREFA, '' ) D1_XTAREFA,
       ISNULL( PREVREAL.D1_XCODSBM, '' ) D1_XCODSBM,
       ISNULL( LTRIM( PREVREAL.D1_XCONTRA ), '' ) D1_XCONTRA,
       ISNULL( PREVREAL.D1_FORNECE, '' ) D1_FORNECE,
       ISNULL( PREVREAL.D1_LOJA   , '' ) D1_LOJA   ,

       ISNULL(
       ( CASE PREVREAL.D1_SERIE
              WHEN 'FOLHA'
              THEN ( SELECT SB1.B1_DESC FROM SB1010 SB1 WHERE SB1.D_E_L_E_T_ = '' AND SB1.B1_COD = PREVREAL.D1_DOC )
              ELSE PREVREAL.DESCFORNECE
         END ), '' ) DESCFORNECE,

       ( CASE ISNULL( ( SELECT SE2.E2_BAIXA
                          FROM SE2010 AS SE2
                         WHERE SE2.D_E_L_E_T_ = ''                  AND
                               SE2.E2_PREFIXO = PREVREAL.D1_SERIE   AND
				               SE2.E2_NUM     = PREVREAL.D1_DOC     AND
				               SE2.E2_FORNECE = PREVREAL.D1_FORNECE AND
				               SE2.E2_LOJA    = PREVREAL.D1_LOJA
				        GROUP BY SE2.E2_BAIXA ), 0 )
		      WHEN 0
		      THEN ( CASE LEN( LTRIM( RTRIM( ISNULL( PREVREAL.D1_XTAREFA, '' ) ) ) )
                          WHEN 0
                          THEN ''
                          ELSE 'Em Aberto'
                     END )
		      ELSE ( SELECT CONVERT( VARCHAR(10), CONVERT( DATETIME, SE2.E2_BAIXA ), 103 )
                       FROM SE2010 AS SE2
                      WHERE SE2.D_E_L_E_T_ = ''                  AND
                            SE2.E2_PREFIXO = PREVREAL.D1_SERIE   AND
				            SE2.E2_NUM     = PREVREAL.D1_DOC     AND
				            SE2.E2_FORNECE = PREVREAL.D1_FORNECE AND
				            SE2.E2_LOJA    = PREVREAL.D1_LOJA
				     GROUP BY SE2.E2_BAIXA )
		 END ) D1_DTDIGIT,

       ISNULL( PREVREAL.D1_DOC  , '' ) D1_DOC  ,
       ISNULL( PREVREAL.D1_SERIE, '' ) D1_SERIE,
       ISNULL( ( CASE PREVREAL.D1_TOTAL
                      WHEN 0
                      THEN NULL
                      ELSE PREVREAL.D1_TOTAL
                 END ), 0 ) D1_TOTAL,
       ISNULL( PREVREAL.ETAPA   , '' ) ETAPA,
       ISNULL( PREVREAL.VAL_EDT_PROJ_PREV, 0.00 ) TOT_EDT_PROJ_PREV,
       ISNULL( PREVREAL.VAL_EDT_PROJ_REAL, 0.00 ) TOT_EDT_PROJ_REAL

  FROM
(
SELECT 'PREVREAL' ETAPA                  ,
       TOTAIS_PROJ_PREV.AF8_ORCAME       ,
	   TOTAIS_PROJ_PREV.AFC_EDT          ORD_TAREFA ,
       TOTAIS_PROJ_PREV.AF8_PROJET       ,
	   TOTAIS_PROJ_PREV.AF8_REVISA       ,
	   TOTAIS_PROJ_PREV.AFC_DESCRI       DESC_TAREFA,
	   TOTAIS_PROJ_PREV.VAL_EDT_PROJ_PREV,
	   TOTAIS_PROJ_REAL.VAL_EDT_PROJ_REAL,
       PROJ_TAREFA.AF8_DESCRI  ,
       PROJ_TAREFA.AF8_XCODDI  ,
       PROJ_TAREFA.AF8_XSPON   ,
       PROJ_TAREFA.AF8_XGER    ,
       PROJ_TAREFA.AF9_EDTPAI  SUB_ORD_TAREFA ,
       PROJ_TAREFA.AF9_TAREFA  ,
       PROJ_TAREFA.AF9_DESCRI  ,
       PROJ_TAREFA.AF9_DESCRI  SUB_DESC_TAREFA,
       PROJ_TAREFA.AFB_TAREFA  ,
       PROJ_TAREFA.VALOR_TAREFA TOT_TAREFA,
       PROJ_TAREFA.VALOR_TAREFA AF9_TOTAL ,
       PROJ_TAREFA.VALOR_TAREFA AFC_TOTAL ,
       SD1.D1_XPROJET,
       SD1.D1_XREVIS ,
       SD1.D1_XTAREFA,
       SD1.D1_XCODSBM,
       SD1.D1_XCONTRA,
       SD1.D1_FORNECE,
       ( SELECT ISNULL( SA2.A2_NOME, '' )
           FROM SA2010 SA2
          WHERE SA2.D_E_L_E_T_  = ''
            AND SA2.A2_COD      = SD1.D1_FORNECE
            AND SA2.A2_LOJA     = SD1.D1_LOJA ) DESCFORNECE,
       SD1.D1_LOJA   ,
       SD1.D1_DTDIGIT,
       SD1.D1_DOC    ,
       SD1.D1_SERIE  ,
       SD1.D1_TOTAL
  FROM ( SELECT AF8.AF8_PROJET ,
			    AF8.AF8_REVISA ,
			    AF8.AF8_ORCAME ,
			    AFC.AFC_EDT    ,
			    AFC.AFC_DESCRI ,
			    SUM( AFB.AFB_VALOR ) VAL_EDT_PROJ_PREV
		   FROM AF8010 AS AF8
			    LEFT JOIN
			    AFC010 AS AFC ON AFC.AFC_PROJET = AF8.AF8_PROJET AND
				 				 AFC.AFC_REVISA = AF8.AF8_REVISA
			    LEFT JOIN
			    AF9010 AS AF9 ON AF9.AF9_PROJET = AFC.AFC_PROJET AND
								 AF9.AF9_REVISA = AFC.AFC_REVISA AND
								 AF9.AF9_EDTPAI = AFC.AFC_EDT
			    LEFT JOIN
			    AFB010 AS AFB ON AFB.AFB_PROJET = AF9.AF9_PROJET AND
								 AFB.AFB_REVISA = AF9.AF9_REVISA AND
								 AFB.AFB_TAREFA = AF9.AF9_TAREFA
		  WHERE AF8.D_E_L_E_T_ = ''
		    AND AFC.D_E_L_E_T_ = ''
		    AND AF9.D_E_L_E_T_ = ''
		    AND AFB.D_E_L_E_T_ = ''
		    AND AF8.AF8_PROJET = $P{CODPROJETO}
            AND AF8.AF8_FASE   = '03'
		 GROUP BY AF8.AF8_PROJET, AF8.AF8_REVISA, AF8.AF8_ORCAME, AFC.AFC_EDT, AFC.AFC_DESCRI
		 )
		 TOTAIS_PROJ_PREV
         LEFT JOIN
         (SELECT SD3TEMP.D1_XPROJET,
				 SD3TEMP.D1_XREVIS ,
				 SD3TEMP.AFC_EDT   ,
				 SUM( SD3TEMP.D1_TOTAL ) VAL_EDT_PROJ_REAL
			FROM
         (SELECT DISTINCT SD2TEMP.*, AFC.AFC_EDT
		    FROM AF8010 AS AF8
			     LEFT JOIN
			     AFC010 AS AFC ON AFC.AFC_PROJET = AF8.AF8_PROJET AND
				 				  AFC.AFC_REVISA = AF8.AF8_REVISA
			     LEFT JOIN
			     AF9010 AS AF9 ON AF9.AF9_PROJET = AFC.AFC_PROJET AND
								  AF9.AF9_REVISA = AFC.AFC_REVISA AND
								  AF9.AF9_EDTPAI = AFC.AFC_EDT
			     LEFT JOIN
			     AFB010 AS AFB ON AFB.AFB_PROJET = AF9.AF9_PROJET AND
								  AFB.AFB_REVISA = AF9.AF9_REVISA AND
								  AFB.AFB_TAREFA = AF9.AF9_TAREFA
				 LEFT JOIN
                 (SELECT AJC.AJC_PROJET  D1_XPROJET,
					     AJC.AJC_REVISA  D1_XREVIS ,
						 AJC.AJC_TAREFA  D1_XTAREFA,
						 'PE'            D1_XCODSBM,
						 ''              D1_XCONTRA,
						 ''              D1_FORNECE,
						 ''              D1_LOJA   ,
						 AJC.AJC_DATA    D1_DTDIGIT,
						 AJC.AJC_COD     D1_DOC    ,
						 'FOLHA'         D1_SERIE  ,
						 AJC.AJC_CUSTO1  D1_TOTAL
				    FROM AJC010 AS AJC
					     LEFT JOIN
						 AF8010 AS AF8B ON AF8B.AF8_PROJET = AJC.AJC_PROJET AND
										   AF8B.AF8_REVISA = AJC.AJC_REVISA
				   WHERE AJC.D_E_L_E_T_  = ''
					 AND AJC.AJC_DATA   >= $P{DATAINI}
					 AND AJC.AJC_DATA   <= $P{DATAFIN}
					 AND AF8B.D_E_L_E_T_ = ''
				  UNION ALL
				  SELECT DISTINCT
				         SD1A.D1_XPROJET,
					     SD1A.D1_XREVIS ,
					     SD1A.D1_XTAREFA,
					     SD1A.D1_XCODSBM,
					     SD1A.D1_XCONTRA,
					     SD1A.D1_FORNECE,
					     SD1A.D1_LOJA   ,
					     SD1A.D1_DTDIGIT,
					     SD1A.D1_DOC    ,
					     SD1A.D1_SERIE  ,
					     SD1A.D1_TOTAL
					     FROM ( SELECT SD1B.D1_XPROJET,
					                   SD1B.D1_XREVIS ,
					                   SD1B.D1_XTAREFA,
					                   SD1B.D1_XCODSBM,
                                       SD1B.D1_XCONTRA,
					                   SD1B.D1_FORNECE,
					                   SD1B.D1_LOJA   ,
					                   SD1B.D1_DTDIGIT,
					                   SD1B.D1_DOC    ,
					                   SD1B.D1_SERIE  ,
                                       SE2.E2_PREFIXO ,
                                       SE2.E2_NUM     ,
                                       SE2.E2_FORNECE ,
                                       SE2.E2_LOJA    ,
                                       SE2.E2_PARCELA ,
					                   ( SUM( SD1B.D1_TOTAL ) + SUM( SE2.E2_ACRESC - SE2.E2_DECRESC ) ) AS D1_TOTAL
				                  FROM SD1010 AS SD1B
                                       LEFT JOIN
					                   SE2010 AS SE2 ON SE2.E2_PREFIXO = SD1B.D1_SERIE   AND
							                            SE2.E2_NUM     = SD1B.D1_DOC     AND
						 	                            SE2.E2_FORNECE = SD1B.D1_FORNECE AND
							                            SE2.E2_LOJA    = SD1B.D1_LOJA
				                 WHERE SD1B.D_E_L_E_T_  = ''
				                   AND SD1B.D1_TES     <> ''
				                   AND SD1B.D1_XPROJET  = $P{CODPROJETO}
				                   AND SD1B.D1_COD     IN ( 'SJSV0015', 'SJSV0036', 'SJSV0037', 'SJSV0038', 'SJSV0039', 'SJSV0040', 'SJSV0041', 'SJSV0042', 'SJSV0043', 'SJSV0044', 'SJSV0045', 'SJSV0049', 'SJSV0050', 'SJSV0051', 'SJSV0052' )
 				                   AND SE2.D_E_L_E_T_   = ''
				                   AND SE2.E2_BAIXA    >= $P{DATAINI}
				                   AND SE2.E2_BAIXA    <= $P{DATAFIN}
                                GROUP BY SD1B.D1_XPROJET, SD1B.D1_XREVIS , SD1B.D1_XTAREFA,
					                     SD1B.D1_XCODSBM,
					                     SD1B.D1_XCONTRA, SD1B.D1_FORNECE, SD1B.D1_LOJA   , SD1B.D1_DTDIGIT,
					                     SD1B.D1_SERIE  , SD1B.D1_DOC    , SD1B.D1_FORNECE, SD1B.D1_LOJA   ,
                                         SE2.E2_PREFIXO , SE2.E2_NUM     , SE2.E2_FORNECE , SE2.E2_LOJA    ,
                                         SE2.E2_PARCELA ) AS SD1A
				 ) AS SD2TEMP ON SD2TEMP.D1_XPROJET = AFB.AFB_PROJET AND
                                 SD2TEMP.D1_XREVIS  = AFB.AFB_REVISA AND
                                 SD2TEMP.D1_XTAREFA = AFB.AFB_TAREFA
           WHERE AF8.D_E_L_E_T_ = ''
             AND AFC.D_E_L_E_T_ = ''
		     AND AF9.D_E_L_E_T_ = ''
		     AND AFB.D_E_L_E_T_ = ''
		     AND AF8.AF8_PROJET = $P{CODPROJETO}
             AND AF8.AF8_FASE   = '03'
             AND SD2TEMP.D1_XPROJET IS NOT NULL
         ) AS SD3TEMP
         GROUP BY SD3TEMP.D1_XPROJET, SD3TEMP.D1_XREVIS, SD3TEMP.AFC_EDT
		 )
		 TOTAIS_PROJ_REAL ON TOTAIS_PROJ_REAL.D1_XPROJET = TOTAIS_PROJ_PREV.AF8_PROJET AND
		                     TOTAIS_PROJ_REAL.D1_XREVIS  = TOTAIS_PROJ_PREV.AF8_REVISA AND
		                     TOTAIS_PROJ_REAL.AFC_EDT    = TOTAIS_PROJ_PREV.AFC_EDT

		 LEFT JOIN
         (SELECT AF8.AF8_PROJET ,
			     AF8.AF8_REVISA ,
			     AF8.AF8_ORCAME ,
                 AF8.AF8_DESCRI ,
                 AF8.AF8_XCODDI ,
                 AF8.AF8_XSPON  ,
                 AF8.AF8_XGER   ,
                 AF9.AF9_EDTPAI ,
                 AF9.AF9_TAREFA ,
                 AF9.AF9_DESCRI ,
                 AFB.AFB_TAREFA ,
                 SUM( AFB.AFB_VALOR ) VALOR_TAREFA
		    FROM AF8010 AS AF8
			     LEFT JOIN
			     AFC010 AS AFC ON AFC.AFC_PROJET = AF8.AF8_PROJET AND
				 				  AFC.AFC_REVISA = AF8.AF8_REVISA
			     LEFT JOIN
			     AF9010 AS AF9 ON AF9.AF9_PROJET = AFC.AFC_PROJET AND
								  AF9.AF9_REVISA = AFC.AFC_REVISA AND
								  AF9.AF9_EDTPAI = AFC.AFC_EDT
			     LEFT JOIN
			     AFB010 AS AFB ON AFB.AFB_PROJET = AF9.AF9_PROJET AND
								  AFB.AFB_REVISA = AF9.AF9_REVISA AND
								  AFB.AFB_TAREFA = AF9.AF9_TAREFA
		   WHERE AF8.D_E_L_E_T_ = ''
		     AND AFC.D_E_L_E_T_ = ''
		     AND AF9.D_E_L_E_T_ = ''
		     AND AFB.D_E_L_E_T_ = ''
		     AND AF8.AF8_PROJET = $P{CODPROJETO}
             AND AF8.AF8_FASE   = '03'
         GROUP BY AF8.AF8_PROJET ,
			      AF8.AF8_REVISA ,
			      AF8.AF8_ORCAME ,
			      AF8.AF8_DESCRI ,
                  AF8.AF8_XCODDI ,
                  AF8.AF8_XSPON  ,
                  AF8.AF8_XGER   ,
                  AF9.AF9_EDTPAI ,
                  AF9.AF9_TAREFA ,
                  AF9.AF9_DESCRI ,
                  AFB.AFB_TAREFA
         ) PROJ_TAREFA ON PROJ_TAREFA.AF8_PROJET = TOTAIS_PROJ_PREV.AF8_PROJET AND
			              PROJ_TAREFA.AF8_REVISA = TOTAIS_PROJ_PREV.AF8_REVISA AND
			              PROJ_TAREFA.AF8_ORCAME = TOTAIS_PROJ_PREV.AF8_ORCAME AND
			              PROJ_TAREFA.AF9_EDTPAI = TOTAIS_PROJ_PREV.AFC_EDT
         LEFT JOIN
         (SELECT D1_XPROJET,
                 D1_XREVIS ,
                 D1_XTAREFA,
                 D1_XCODSBM,
                 D1_XCONTRA,
                 D1_FORNECE,
                 D1_LOJA   ,
                 D1_DTDIGIT,
                 D1_DOC    ,
                 D1_SERIE  ,
                 D1_TOTAL
            FROM (SELECT AJC.AJC_PROJET  D1_XPROJET,
						 AJC.AJC_REVISA  D1_XREVIS ,
						 AJC.AJC_TAREFA  D1_XTAREFA,
						 'PE'            D1_XCODSBM,
						 ''              D1_XCONTRA,
						 ''              D1_FORNECE,
						 ''              D1_LOJA   ,
						 AJC.AJC_DATA    D1_DTDIGIT,
						 AJC.AJC_COD     D1_DOC    ,
						 'FOLHA'         D1_SERIE  ,
						 AJC.AJC_CUSTO1  D1_TOTAL
				    FROM AJC010 AS AJC
					 	 LEFT JOIN
						 AF8010 AS AF8B ON AF8B.AF8_PROJET = AJC.AJC_PROJET AND
										   AF8B.AF8_REVISA = AJC.AJC_REVISA
				   WHERE AJC.D_E_L_E_T_  = ''
					 AND AJC.AJC_DATA   >= $P{DATAINI}
					 AND AJC.AJC_DATA   <= $P{DATAFIN}
					 AND AF8B.D_E_L_E_T_ = ''
				  UNION ALL
				  SELECT DISTINCT
				         SD1A.D1_XPROJET,
					     SD1A.D1_XREVIS ,
					     SD1A.D1_XTAREFA,
					     SD1A.D1_XCODSBM,
					     SD1A.D1_XCONTRA,
					     SD1A.D1_FORNECE,
					     SD1A.D1_LOJA   ,
					     SD1A.D1_DTDIGIT,
					     SD1A.D1_DOC    ,
					     SD1A.D1_SERIE  ,
					     SD1A.D1_TOTAL
					     FROM ( SELECT SD1B.D1_XPROJET,
					                   SD1B.D1_XREVIS ,
					                   SD1B.D1_XTAREFA,
					                   SD1B.D1_XCODSBM,
					                   SD1B.D1_XCONTRA,
					                   SD1B.D1_FORNECE,
					                   SD1B.D1_LOJA   ,
					                   SD1B.D1_DTDIGIT,
					                   SD1B.D1_DOC    ,
					                   SD1B.D1_SERIE  ,
                                       SE2.E2_PREFIXO ,
                                       SE2.E2_NUM     ,
                                       SE2.E2_FORNECE ,
                                       SE2.E2_LOJA    ,
                                       SE2.E2_PARCELA ,
					                   ( SUM( SD1B.D1_TOTAL ) + SUM( SE2.E2_ACRESC - SE2.E2_DECRESC ) ) AS D1_TOTAL
				                  FROM SD1010 AS SD1B
                                       LEFT JOIN
					                   SE2010 AS SE2 ON SE2.E2_PREFIXO = SD1B.D1_SERIE   AND
							                            SE2.E2_NUM     = SD1B.D1_DOC     AND
						 	                            SE2.E2_FORNECE = SD1B.D1_FORNECE AND
							                            SE2.E2_LOJA    = SD1B.D1_LOJA
				                 WHERE SD1B.D_E_L_E_T_  = ''
				                   AND SD1B.D1_TES     <> ''
				                   AND SD1B.D1_XPROJET  = $P{CODPROJETO}
				                   AND SD1B.D1_COD     IN ( 'SJSV0015', 'SJSV0036', 'SJSV0037', 'SJSV0038', 'SJSV0039', 'SJSV0040', 'SJSV0041', 'SJSV0042', 'SJSV0043', 'SJSV0044', 'SJSV0045', 'SJSV0049', 'SJSV0050', 'SJSV0051', 'SJSV0052' )
 				                   AND SE2.D_E_L_E_T_   = ''
				                   AND SE2.E2_BAIXA    >= $P{DATAINI}
				                   AND SE2.E2_BAIXA    <= $P{DATAFIN}
                                GROUP BY SD1B.D1_XPROJET, SD1B.D1_XREVIS , SD1B.D1_XTAREFA,
					                     SD1B.D1_XCODSBM,
					                     SD1B.D1_XCONTRA, SD1B.D1_FORNECE, SD1B.D1_LOJA   , SD1B.D1_DTDIGIT,
					                     SD1B.D1_SERIE  , SD1B.D1_DOC    , SD1B.D1_FORNECE, SD1B.D1_LOJA   ,
                                         SE2.E2_PREFIXO , SE2.E2_NUM     , SE2.E2_FORNECE , SE2.E2_LOJA    ,
                                         SE2.E2_PARCELA ) AS SD1A
		) AS SD1TEMP ) AS SD1 ON SD1.D1_XPROJET = PROJ_TAREFA.AF8_PROJET AND
                                 SD1.D1_XREVIS  = PROJ_TAREFA.AF8_REVISA AND
                                 SD1.D1_XTAREFA = PROJ_TAREFA.AFB_TAREFA
)
PREVREAL
WHERE PREVREAL.D1_TOTAL > 0
ORDER BY AF8_PROJET,
         D1_XCONTRA,
         D1_FORNECE,
         D1_LOJA   ,
         D1_DTDIGIT,
         D1_DOC
         
