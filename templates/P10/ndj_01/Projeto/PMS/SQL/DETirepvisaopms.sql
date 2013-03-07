
SELECT @DATAINI DATAINI,
       @DATAFIN DATAFIN,
       AF1_ORCAME,
       AF8_PROJET,
       AF8_REVISA,
       AF8_XCODOR,       
       AF1_DESCRI,
       AF1_XCODOR,
       AF1_XDORIG,
       Item,
       AF8_DESCRI,
       AF8_XDORIG,
       AF8_XCODTE,
       AF8_XTEMA,
       AF8_XCODTA,
       AF8_XDESTA,
       AF8_XCODIN,
       AF8_XCODSP,
       AF8_XSPON,
       AF8_XCODGE,
       AF8_XGER,
       AF8_XCODDI,
       AF1_XDIR,
       AF1_XUNIOR,
       AF1_XSPON,
       AF1_XGER,
       AF1_XDESTA,
       AF1_XMACRO,  	   
       AF8_XCODMA,
       AF8_XMACRO,
       AF8_XIND,
       AF1_XIND,
       AF1_XINDS,
       AF1_XPMORG,
       AF1_XTEMA,
       AF1_XDESC,
       AF1_XDPROG,
       ( ISNULL( PREVPESJUR             , 0.00 ) ) PREVPESJUR ,				
       ( ISNULL( REALPESJUR             , 0.00 ) ) REALPESJUR ,                 
       ( ISNULL( PREVPESSOAL            , 0.00 ) ) PREVPESSOAL,
       ( ISNULL( REALPESSOAL, 0.00 ) + ISNULL( AJCTOT, 0.00 ) ) REALPESSOAL,
       ( ISNULL( PREVPESFIS             , 0.00 ) ) PREVPESFIS ,
       ( ISNULL( REALPESFIS             , 0.00 ) ) REALPESFIS ,      
       ( ISNULL( PREVOPERADM            , 0.00 ) ) PREVOPERADM, 
       ( ISNULL( REALOPERADM            , 0.00 ) ) REALOPERADM,
       ( ISNULL( PREVCAPITAL            , 0.00 ) ) PREVCAPITAL,
       ( ISNULL( REALCAPITAL            , 0.00 ) ) REALCAPITAL,
       ( ISNULL( PREVVIAGEM             , 0.00 ) ) PREVVIAGEM ,
       ( ISNULL( REALVIAGEM             , 0.00 ) ) REALVIAGEM ,
       ( ISNULL( PREVTOTORC             , 0.00 ) ) PREVTOTORC ,
       ( ISNULL( REALTOTORC , 0.00 ) + ISNULL( AJCTOT, 0.00 ) ) REALTOTORC ,

       PREVTOTPROJ,						                      
       
       ISNULL( ( SELECT 1 WHERE dbo.FormatDinheiro( PREVTOTORC ) = dbo.FormatDinheiro( PREVTOTPROJ ) ), 0 ) ORC_DIF_PREV,

       ( CASE ISNULL( ( SELECT 1 WHERE dbo.FormatDinheiro( PREVTOTORC ) = dbo.FormatDinheiro( PREVTOTPROJ ) ), 0 )
              WHEN 0
              THEN 'OS PREVISTOS DO OR�AMENTO (' + dbo.FormatDinheiro( PREVTOTORC ) + ') E DO PROJETO (' + dbo.FormatDinheiro( PREVTOTPROJ ) + ') N�O EST�O IGUAIS, FAVOR VERIFICAR E ENTRAR EM CONTATO COM A CONTROLADORIA.'
              ELSE ''
         END ) ALERTA,

       AF1_XDATIN,
       AF1_XDATFI,
       DESCSTATUS, 
       AF1_FASE,
       DESCFASE,       
       AF1_XPRIO

  FROM 
(  
SELECT AF1.AF1_ORCAME,
       AF8.AF8_PROJET,
       AF8.AF8_REVISA,
       AF8.AF8_XCODOR,       
       AF1.AF1_DESCRI,
       AF1.AF1_XCODOR,
       AF1.AF1_XDORIG,
       RIGHT( REPLICATE( '0', 6 ) + CONVERT( VARCHAR, ROW_NUMBER() OVER( ORDER BY AF8_PROJET, AF8_REVISA, AF1_ORCAME ) ), 6 ) 'Item',
       AF8.AF8_DESCRI,
       AF8.AF8_XDORIG,
       AF8.AF8_XCODTE,
       AF8.AF8_XTEMA,
       AF8.AF8_XCODTA,
       AF8.AF8_XDESTA,
       AF8.AF8_XCODIN,
       AF8.AF8_XIND,
       AF1.AF1_XIND,
       AF1.AF1_XINDS,
       AF8.AF8_XCODSP,
       AF8.AF8_XSPON,
       AF8.AF8_XCODGE,
       AF8.AF8_XGER,
       AF8.AF8_XCODDI,
       AF1.AF1_XDIR,
       AF1.AF1_XUNIOR,
       AF1.AF1_XSPON,
       AF1.AF1_XGER,
       AF1.AF1_XDESTA,
       AF1.AF1_XMACRO,  	   
       AF8.AF8_XCODMA,
       AF8.AF8_XMACRO,
       AF1.AF1_XPMORG,
       AF1.AF1_XTEMA,
       AF1.AF1_XDESC,
       AF1.AF1_XDPROG,

       ( SELECT SUM( AF4_VALOR )
				  FROM AF4010 AS AF4
				 WHERE AF4.D_E_L_E_T_ = ''
				   AND AF4.AF4_ORCAME = AF1.AF1_ORCAME 
				   AND AF4.AF4_TIPOD IN ( 'SJ', 'MO' )
				GROUP BY AF4.AF4_ORCAME ) AS 'PREVPESJUR',
				
       ( SELECT SD1TOTAL
                  FROM ( SELECT SD1.D1_XPROJET, SD1.D1_XREVIS, SUM( SD1.D1_TOTAL ) AS SD1TOTAL
						   FROM SD1010 AS SD1 
						  WHERE SD1.D_E_L_E_T_  = '' 
							AND SD1.D1_TES     <> ''
							AND SD1.D1_XPROJET  = AF8.AF8_PROJET 
							AND SD1.D1_XREVIS   = AF8.AF8_REVISA            
 							AND SD1.D1_XCODSBM IN ( 'SJ', 'MO' )
							AND SD1.D1_DTDIGIT >= @DATAINI 
							AND SD1.D1_DTDIGIT <= @DATAFIN         														 							
						 GROUP BY SD1.D1_XPROJET, SD1.D1_XREVIS ) AS SD1T1 ) AS 'REALPESJUR',

       ( SELECT SUM( AF4_VALOR )
				  FROM AF4010 AS AF4
				 WHERE AF4.D_E_L_E_T_ = ''
				   AND AF4.AF4_ORCAME = AF1.AF1_ORCAME 
				   AND AF4.AF4_TIPOD IN ( 'PE' )
				GROUP BY AF4.AF4_ORCAME ) AS 'PREVPESSOAL',

       ( SELECT SD1TOTAL
                  FROM ( SELECT SD1.D1_XPROJET, SD1.D1_XREVIS, SUM( SD1.D1_TOTAL ) AS SD1TOTAL
						   FROM SD1010 AS SD1 
						  WHERE SD1.D_E_L_E_T_  = '' 
							AND SD1.D1_TES     <> ''
							AND SD1.D1_XPROJET  = AF8.AF8_PROJET 
							AND SD1.D1_XREVIS   = AF8.AF8_REVISA            
 							AND SD1.D1_XCODSBM IN ( 'PE' )
							AND SD1.D1_DTDIGIT >= @DATAINI 
							AND SD1.D1_DTDIGIT <= @DATAFIN         														 							
						 GROUP BY SD1.D1_XPROJET, SD1.D1_XREVIS ) AS SD1T2 ) AS 'REALPESSOAL',

       ( SELECT SUM( AF4_VALOR )
				  FROM AF4010 AS AF4
				 WHERE AF4.D_E_L_E_T_ = ''
				   AND AF4.AF4_ORCAME = AF1.AF1_ORCAME 
				   AND AF4.AF4_TIPOD IN ( 'SF' )
				GROUP BY AF4.AF4_ORCAME ) AS 'PREVPESFIS',

       ( SELECT SD1TOTAL
                  FROM ( SELECT SD1.D1_XPROJET, SD1.D1_XREVIS, SUM( SD1.D1_TOTAL ) AS SD1TOTAL
						   FROM SD1010 AS SD1 
						  WHERE SD1.D_E_L_E_T_  = '' 
							AND SD1.D1_TES     <> ''
							AND SD1.D1_XPROJET  = AF8.AF8_PROJET 
							AND SD1.D1_XREVIS   = AF8.AF8_REVISA            
 							AND SD1.D1_XCODSBM IN ( 'SF' )
							AND SD1.D1_DTDIGIT >= @DATAINI 
							AND SD1.D1_DTDIGIT <= @DATAFIN         														 							
						 GROUP BY SD1.D1_XPROJET, SD1.D1_XREVIS ) AS SD1T2 ) AS 'REALPESFIS',
      
       ( SELECT SUM( AF4_VALOR )
				  FROM AF4010 AS AF4
				 WHERE AF4.D_E_L_E_T_ = ''
				   AND AF4.AF4_ORCAME = AF1.AF1_ORCAME 
				   AND AF4.AF4_TIPOD IN ( 'OA' )
				GROUP BY AF4.AF4_ORCAME ) AS 'PREVOPERADM', 

       ( SELECT ( SD1TOTAL )
                  FROM ( SELECT SD1.D1_XPROJET, SD1.D1_XREVIS, SUM( SD1.D1_TOTAL ) AS SD1TOTAL
						   FROM SD1010 AS SD1 
						  WHERE SD1.D_E_L_E_T_  = '' 
							AND SD1.D1_TES     <> ''
							AND SD1.D1_XPROJET  = AF8.AF8_PROJET 
							AND SD1.D1_XREVIS   = AF8.AF8_REVISA           
 							AND SD1.D1_XCODSBM IN ( 'OA' )
							AND SD1.D1_DTDIGIT  >= @DATAINI 
							AND SD1.D1_DTDIGIT  <= @DATAFIN         														 							
						 GROUP BY SD1.D1_XPROJET, SD1.D1_XREVIS ) AS SD1T4 ) AS 'REALOPERADM',

       ( SELECT SUM( AF4_VALOR )
				  FROM AF4010 AS AF4
				 WHERE AF4.D_E_L_E_T_ = ''
				   AND AF4.AF4_ORCAME = AF1.AF1_ORCAME 
				   AND AF4.AF4_TIPOD IN ( 'MU', 'HW', 'MA', 'SW', 'BO' )
				GROUP BY AF4.AF4_ORCAME ) AS 'PREVCAPITAL',

       ( SELECT SD1TOTAL
                  FROM ( SELECT SD1.D1_XPROJET, SD1.D1_XREVIS, SUM( SD1.D1_TOTAL ) AS SD1TOTAL
						   FROM SD1010 AS SD1 
						  WHERE SD1.D_E_L_E_T_  = '' 
							AND SD1.D1_TES     <> ''
							AND SD1.D1_XPROJET  = AF8.AF8_PROJET 
							AND SD1.D1_XREVIS   = AF8.AF8_REVISA            
 							AND SD1.D1_XCODSBM IN ( 'MU', 'HW', 'MA', 'SW', 'BO' )
							AND SD1.D1_DTDIGIT  >= @DATAINI 
							AND SD1.D1_DTDIGIT  <= @DATAFIN         														 							
						 GROUP BY SD1.D1_XPROJET, SD1.D1_XREVIS ) AS SD1T5 ) AS 'REALCAPITAL',

       ( SELECT SUM( AF4_VALOR )
				  FROM AF4010 AS AF4
				 WHERE AF4.D_E_L_E_T_ = ''
				   AND AF4.AF4_ORCAME = AF1.AF1_ORCAME 
				   AND AF4.AF4_TIPOD IN ( 'VI', 'VN' )
				GROUP BY AF4.AF4_ORCAME ) AS 'PREVVIAGEM',

       ( SELECT ( SD1TOTAL )
                  FROM ( SELECT SD1.D1_XPROJET, SD1.D1_XREVIS, SUM( SD1.D1_TOTAL ) AS SD1TOTAL
						   FROM SD1010 AS SD1 
						  WHERE SD1.D_E_L_E_T_  = '' 
							AND SD1.D1_TES     <> ''
							AND SD1.D1_XPROJET  = AF8.AF8_PROJET 
							AND SD1.D1_XREVIS   = AF8.AF8_REVISA           
 							AND SD1.D1_XCODSBM IN ( 'VI', 'VN' )
							AND SD1.D1_DTDIGIT  >= @DATAINI 
							AND SD1.D1_DTDIGIT  <= @DATAFIN         														 							
						 GROUP BY SD1.D1_XPROJET, SD1.D1_XREVIS ) AS SD1T6 ) AS 'REALVIAGEM',

       ( SELECT SUM( AF4_VALOR )
				  FROM AF4010 AS AF4
				 WHERE AF4.D_E_L_E_T_ = ''
				   AND AF4.AF4_ORCAME = AF1.AF1_ORCAME 
				GROUP BY AF4.AF4_ORCAME ) AS 'PREVTOTORC',

       ( SELECT SD1TOTAL
                  FROM ( SELECT SD1.D1_XPROJET, SD1.D1_XREVIS, SUM( SD1.D1_TOTAL ) AS SD1TOTAL
						   FROM SD1010 AS SD1 
						  WHERE SD1.D_E_L_E_T_  = '' 
							AND SD1.D1_TES     <> ''
							AND SD1.D1_XPROJET  = AF8.AF8_PROJET 
							AND SD1.D1_XREVIS   = AF8.AF8_REVISA            
							AND SD1.D1_DTDIGIT  >= @DATAINI 
							AND SD1.D1_DTDIGIT  <= @DATAFIN         														
						 GROUP BY SD1.D1_XPROJET, SD1.D1_XREVIS ) AS SD1T7 ) AS 'REALTOTORC',
						 
       ( SELECT ( AJCTOTAL )
				  FROM ( SELECT AJC.AJC_PROJET, AJC.AJC_REVISA, SUM( AJC.AJC_CUSTO1 ) AS AJCTOTAL
						   FROM AJC010 AS AJC 
						  WHERE AJC.D_E_L_E_T_  = '' 
							AND AJC.AJC_PROJET = AF8.AF8_PROJET 
							AND AJC.AJC_REVISA = AF8.AF8_REVISA  
							AND AJC.AJC_DATA  >= @DATAINI 
							AND AJC.AJC_DATA  <= @DATAFIN         
						 GROUP BY AJC.AJC_PROJET, AJC.AJC_REVISA ) AS AJCT ) AS 'AJCTOT',

       ( SELECT SUM( AFB.AFB_VALOR )
           FROM AF8010 AS AF8A
		        LEFT JOIN
			    AFC010 AS AFC ON AFC.AFC_PROJET = AF8A.AF8_PROJET AND
				   			     AFC.AFC_REVISA = AF8A.AF8_REVISA
			    LEFT JOIN
			    AF9010 AS AF9 ON AF9.AF9_PROJET = AFC.AFC_PROJET AND
								 AF9.AF9_REVISA = AFC.AFC_REVISA AND
								 AF9.AF9_EDTPAI = AFC.AFC_EDT
			    LEFT JOIN
			    AFB010 AS AFB ON AFB.AFB_PROJET = AF9.AF9_PROJET AND
								 AFB.AFB_REVISA = AF9.AF9_REVISA AND
								 AFB.AFB_TAREFA = AF9.AF9_TAREFA
		  WHERE AF8.D_E_L_E_T_  = ''
                    AND AFC.D_E_L_E_T_  = ''
  		    AND AF9.D_E_L_E_T_  = ''
		    AND AFB.D_E_L_E_T_  = ''
		    AND AF8A.AF8_PROJET = AF8.AF8_PROJET
            AND AF8A.AF8_REVISA = AF8.AF8_REVISA
		 GROUP BY AF8A.AF8_PROJET, AF8A.AF8_REVISA, AF8A.AF8_ORCAME ) PREVTOTPROJ,						 
       
      CONVERT( VARCHAR, CONVERT( DATETIME, CONVERT( VARCHAR, AF1_XDATIN ) ), 103 ) AF1_XDATIN,
      CONVERT( VARCHAR, CONVERT( DATETIME, CONVERT( VARCHAR, AF1_XDATFI ) ), 103 ) AF1_XDATFI,

       ( CASE AF1.AF1_XSTATU 
              WHEN '1' THEN 'NOVO' 
                       ELSE 'EM CURSO' END ) DESCSTATUS, 
       AF1.AF1_FASE,
       ( SELECT AE9.AE9_DESCRI 
           FROM AE9010 AS AE9 
          WHERE AE9.AE9_COD = AF1.AF1_FASE ) DESCFASE,       
       AF1.AF1_XPRIO
       
  FROM AF1010 AS AF1 
       LEFT JOIN
       AF8010 AS AF8 ON AF8.AF8_ORCAME = AF1.AF1_ORCAME
                                                
 WHERE AF1.D_E_L_E_T_ = ''
   AND AF8.D_E_L_E_T_ = ''  
   AND AF8.AF8_FASE   = '03'         
   
) AS PROJETOS     

