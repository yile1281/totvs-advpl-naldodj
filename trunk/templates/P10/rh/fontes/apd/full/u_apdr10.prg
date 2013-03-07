#INCLUDE "PROTHEUS.CH"
#INCLUDE "TRYEXCEPTION.CH"
/*/
��������������������������������������������������������������������������������Ŀ
�Programa  �APDR10    �Autor�Marinaldo de Jesus		           �Data  �20/11/2009�
��������������������������������������������������������������������������������Ĵ
�Descricoes�Relat�rio de Avalia��o Funcion�rio por �rea/Departamento			 �
��������������������������������������������������������������������������������Ĵ
�Uso       �SINAF																 �
��������������������������������������������������������������������������������Ĵ
�            ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                    �
��������������������������������������������������������������������������������Ĵ
�Programador �Data      �Nro. Ocorr.�Motivo da Alteracao                         �
��������������������������������������������������������������������������������Ĵ
�            �          �           �                    						 �
����������������������������������������������������������������������������������/*/
User Function APDR10()
	
	/*/
	��������������������������������������������������������������Ŀ
	� Mascara do Relatorio (220 Colunas)                           �
	����������������������������������������������������������������
	    		10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
		1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	  	EMPRESA: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/XXXXXXXXXXXXXXXX/XXXXXXXXXXXXXXXX        NOTA M�DIA DA AVALIA��O INDIVIDUAL DOS COLABORADORES DA EMPRESA:      AUTO AVALIA��O: 999.99  AVALIA��O: 999.99  CONSENSO: 999.99
	    �REA: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                                        NOTA M�DIA DA AVALIA��O INDIVIDUAL DOS COLABORADORES DA �REA:        AUTO AVALIA��O: 999.99  AVALIA��O: 999.99  CONSENSO: 999.99
	    AVALIA��O: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                               NOTA DA AVALIA��O DE DESEMPENHO DA �REA:                                                                        999.99
		----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
                                                              NOTA 		  % S/ NOTA   % S/ NOTA   % S/ NOTA  |   NOTA    % S/ NOTA   % S/ NOTA  % S/ NOTA   |        NOTA         % S/ NOTA  % S/ NOTA  % S/ NOTA
	  	MATRICULA/CODIGO NOME                            AUTO AVALIA��O    (EMPRESA)    (�REA)   (AVALIA��O) | AVALIA��O  (EMPRESA)    (�REA)   (AVALIA��O) | AVALIA��O CONSENSO   (EMPRESA)   (�REA)   (AVALIA��O)
	  	   999999/999999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX      999.99          999.99     999.99     999.99    |  999.99     999.99      999.999    999.99    |       999.99          999.99     999.99     999.99
	/*/

	Local aArea		:= GetArea()
	Local aOrd		:= {}
	Local aImpress	:= aClone( __aImpress )
	
	Local cDesc1	:= OemToAnsi( "Relat�rio de Avalia��o Funcion�rio por �rea/Departamento" )
	Local cDesc2	:= OemToAnsi( "Ser� impresso de acordo com os par�metros solicitados pelo" )
	Local cDesc3	:= OemToAnsi( "usu�rio." )
	Local cAlias	:= "RD0"	//Alias do arquivo Principal ( Base )
	Local cPerg		:= Padr( "U_APDR10" , Len( SX1->X1_GRUPO ) )
	
	Local wnRel
	Local cMsgAlert
	
	Private aReturn  := {;
							"Zebrado"		,;	//01 -> "Zebrado" -> Descricao do Tipo de Formulario que aparecera na Pasta Opcionais
							NIL				,;  //02 -> Reservado...
							"Administra��o"	,;	//03 -> "Administra��o" -> Descricao do Destinatario que aparecera na Pasta Opcionais
							2				,;  //04 -> Orientacao do Relatorio 1=Retrato;2=Paisagem
							NIL				,;  //05 -> Local da Impressao
							NIL				,;	//06 -> Nome com que o arquivo sera salvo
							NIL				,;	//07 -> Filtro DEFAULT do Relatorio que sera utilizado na Pasta Filtro
							1		 		;	//08 -> Ordem DEFAULT do Relatorio que srea utilizado na Pasta Ordem
						}
	
	Private NomeProg := FunName()
	Private Titulo   := cDesc1
	Private nTamanho := "G"
	Private wCabec0  := 3
	Private wCabec1  := "EMPRESA:"
	Private wCabec2  := "�REA:"
	Private wCabec3  := "AVALIA��O:"
	
	Private ContFl   := 1
	Private Li       := 0
	Private nLastKey := 0

	Private cAPDRAva
	Private cAPDRDep
	Private cAPDREmp
	Private cAPDRFil
	
	BEGIN SEQUENCE

		Pergunte( cPerg , .F. )

		APDR10AvaVld(.F.)
		APDR10DepVld(.F.)
		APDR10EmpVld(.F.)
		APDR10FilVld(.F.)
    
		__aImpress[1] := 1

		/*/
		��������������������������������������������������������������Ŀ
		� Envia controle para a funcao SETPRINT                        �
		����������������������������������������������������������������/*/
		wnRel := NomeProg
		wnRel := SetPrint(;
							""			,;	//01 -> cAlias:			Alias da Tabela
							wnRel		,;	//02 -> cNome: 			Nome do Relatorio
							cPerg		,;	//03 -> cPerg: 			Grupo de Perguntas
							@Titulo 	,;	//04 -> cDesc: 			Descricao do Relatorio
							cDesc1		,;	//05 -> cCnt1: 			1a. Descricao que aparecera no Rodape da Pasta Impressao
							cDesc2		,;	//06 -> cCnt2: 			2a. Descricao que aparecera no Rodape da Pasta Impressao	
							cDesc3		,;	//07 -> cCnt3: 			3a. Descricao que aparecera no Rodape da Pasta Impressao
							.F.			,;	//08 -> lDic:  			Se Disponibilizara Pasta para Selecao dos Campos
							aOrd		,;	//09 -> aOrd:  			Array com a Descricao das Ordens para Selecao	
							.T.			,;	//10 -> lCompres: 		Se habilitara compressao do Relatorio
							nTamanho    ,;	//11 -> cSize: 			Tamanho do Relatorio "P=80Colunas";"M=132Colunas";"G=220Colunas"
							NIL			,;	//12 -> aFilter: 		Array com expressao de Filtro
							.F.			,;	//13 -> lFiltro: 		Se habilitara a Pasta Filtro
							.F.			,;	//14 -> lCrystal: 		Se relatorio esta integrado ao Crystal Report
							NIL			,;	//15 -> cNameDrv: 		Nome do Drive que sera utilizado para a impressao
							NIL			,;	//16 -> lNoAsc: 		Se mostrara a Caixa de Dialogo para a SetPrint
							NIL			,;	//17 -> lServer: 		Se a impressao sera no servidor
							NIL			 ;	//18 -> cPortToPrint:	Porta para a Impressao
						)
	
		/*/
		��������������������������������������������������������������Ŀ
		� Se pressionou a Tecla "ESC" abandona                         �
		����������������������������������������������������������������/*/
		IF ( nLastKey == 27 )
			Break
		EndIF
	
		/*/
		��������������������������������������������������������������Ŀ
		� Chamada a SetDefault para carga das Informacoes do  Seleciona�
		� das na SetPrint()											   �
		����������������������������������������������������������������/*/
		SetDefault(;
						@aReturn	,;	//01 -> aRet:		Array com a Estrutura do aReturn	
						cAlias		,;	//02 -> cAlias:		Alias do Arquivo
						NIL			,;	//03 -> lPortr:		Se Retrato 
						NIL			,;	//04 -> lNoAsk:		Se tera Display
						@nTamanho	,;	//05 -> cSize:		Tamanho do Relatorio
						2			 ;	//06 -> nOrienta:	Orientacao do Relatorio ( 1-Retrato; 2-Paisagem )
					)
	
		/*/
		��������������������������������������������������������������Ŀ
		� Se pressionou a Tecla "ESC" abandona                         �
		����������������������������������������������������������������/*/
		IF ( nLastKey == 27 )
		   Break
		EndIF
		
		Pergunte( cPerg , .F. )

		IF !( APDR10AvaVld() )
			Break
		EndIF
		
		IF !( APDR10DepVld() )
			Break
		EndIF
		
		IF !( APDR10EmpVld() )
			Break
		EndIF
		
		IF !( APDR10FilVld() )
			Break
		EndIF
		
		/*/
		��������������������������������������������������������������Ŀ
		� Chamda a execussao da Impressao							   �
		����������������������������������������������������������������/*/
		RptStatus( { |lEnd| PrintRel( @lEnd , @wnRel , @cPerg ) } , Titulo )
		
	END SEQUENCE
	
	/*/
	��������������������������������������������������������������Ŀ
	� Restaura os Ponteiros de Entrada							   �
	����������������������������������������������������������������/*/
	__aImpress := aClone( aImpress )
	RestArea( aArea )

Return( NIL )

/*/
������������������������������������������������������������������������Ŀ
�Fun��o    �U_InAPDR10    �Autor �Marinaldo de Jesus   � Data �20/11/2009�
������������������������������������������������������������������������Ĵ
�Descri��o �Executar Funcoes Dentro de APDR010                           �
������������������������������������������������������������������������Ĵ
�Sintaxe   �U_InAPDR10( cExecIn , aFormParam )						 	 �
������������������������������������������������������������������������Ĵ
�Parametros�<Vide Parametros Formais>									 �
������������������������������������������������������������������������Ĵ
�Retorno   �uRet                                                 	     �
������������������������������������������������������������������������Ĵ
Observa��o�                                                      	     �
������������������������������������������������������������������������Ĵ
�Uso       �Generico 													 �
��������������������������������������������������������������������������/*/
User Function InAPDR10( cExecIn , aFormParam )
         
Local uRet

DEFAULT cExecIn		:= ""
DEFAULT aFormParam	:= {}

IF !Empty( cExecIn )
	cExecIn	:= BldcExecInFun( cExecIn , aFormParam )
	uRet	:= &( cExecIn )
EndIF

Return( uRet )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �PrintRel    � Autor �Marinaldo de Jesus   � Data �20/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Imprime Detalhes do Relatorio								�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function PrintRel( lEnd , wnRel , cPerg )

	Local cAlsQry0		:= GetNextAlias()
	
	Local cDet			:= ""
	Local cDetCab0		:= OemToAnsi( "                                                       NOTA       % S/ NOTA   % S/ NOTA   % S/ NOTA  |   NOTA    % S/ NOTA   % S/ NOTA  % S/ NOTA   |        NOTA         % S/ NOTA  % S/ NOTA  % S/ NOTA" )
	Local cDetCab1		:= OemToAnsi( "MATRICULA/CODIGO NOME                            AUTO AVALIA��O    (EMPRESA)    (�REA)   (AVALIA��O) | AVALIA��O  (EMPRESA)    (�REA)   (AVALIA��O) | AVALIA��O CONSENSO   (EMPRESA)   (�REA)   (AVALIA��O)" )
	
	Local cCodAva		:= MV_PAR01
	Local cCodDep   	:= MV_PAR02
	Local cCodEmp   	:= MV_PAR03
	Local cCodFil   	:= MV_PAR04
	
	Local cSvEmpAnt		:= cEmpAnt
	Local cSvFilAnt		:= cFilAnt
	
	Local nEmpAut		:= 0
	Local nEmpAva		:= 0
	Local nEmpCon		:= 0

	Local nDepAut		:= 0
	Local nDepAva		:= 0
	Local nDepCon		:= 0

	Local nAdoAut		:= 0
	Local nAdoAva		:= 0
	Local nAdoCon		:= 0
	
	Local nRd6Media		:= 0
	
	Local oException    
	
	TRYEXCEPTION
		
		SM0->( dbSetOrder( 1 ) )
		IF SM0->( !dbSeek( cCodEmp + cCodFil ) )
			UserExeption( "Empresa ou Filial n�o Cadastrada no SIGAMAT.EMP!" )
		EndIF

		IF ( cCodEmp <> cEmpAnt )
			GetEmpr( cCodEmp + cCodFil ) 
		EndIF
	
		BEGINSQL ALIAS cAlsQry0
			SELECT
				RDD.RDD_CODAVA,
				RDD.RDD_TIPOAV,
				ISNULL(ROUND(AVG(RDD.RDD_RESOBT),2),0.00) RDD_RESOBT
			FROM
				%table:RDD% RDD,
				%table:RDZ% RDZ,
				%table:RD6% RD6
			WHERE
				RDD.%NotDel% AND
				RDZ.%NotDel% AND
				RD6.%NotDel% AND
				RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)% AND
				RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
				RDZ.RDZ_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
				RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
				RD6.RD6_CODIGO = %exp:cCodAva% AND
				RDD.RDD_CODAVA = RD6.RD6_CODIGO	
			GROUP BY
				RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_TIPOAV                          
		ENDSQL
	
		SetRegua( 0 )
	
		While ( cAlsQry0 )->( !Eof() )
			IncRegua()
			DO CASE
				CASE ( ( cAlsQry0 )->RDD_TIPOAV == "1" ) ; nEmpAut	+= ( cAlsQry0 )->RDD_RESOBT
				CASE ( ( cAlsQry0 )->RDD_TIPOAV == "2" ) ; nEmpAva	+= ( cAlsQry0 )->RDD_RESOBT
				CASE ( ( cAlsQry0 )->RDD_TIPOAV == "3" ) ; nEmpCon	+= ( cAlsQry0 )->RDD_RESOBT
			END CASE
			( cAlsQry0 )->( dbSkip() )
		End While
	
		( cAlsQry0 )->( dbCloseArea() )
		
		BEGINSQL ALIAS cAlsQry0
			SELECT
				RDD.RDD_CODAVA,
				RDD.RDD_TIPOAV,
				SRA.RA_DEPTO,
				ISNULL(ROUND(AVG(RDD.RDD_RESOBT),2),0.00) RDD_RESOBT
			FROM
				%table:RDD% RDD,
				%table:RDZ% RDZ,
				%table:RD6% RD6,
				%table:SRA% SRA
			WHERE
				RDD.%NotDel% AND
				RDZ.%NotDel% AND
				RD6.%NotDel% AND
				SRA.%NotDel% AND
				RDZ.%NotDel% AND
				RDZ.%NotDel% AND
				RDZ.RDZ_FILIAL = %exp:xFilial("RDZ",cCodFil)% AND
				RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
				RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)% AND
				RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
				SRA.RA_FILIAL  = %exp:xFilial("SRA",cCodFil)% AND
				RDZ.RDZ_CODRD0 = RDD.RDD_CODADO AND
				RD6.RD6_CODIGO = %exp:cCodAva% AND
				RDD.RDD_CODAVA = RD6.RD6_CODIGO	AND
				SRA.RA_FILIAL+SRA.RA_MAT = RDZ.RDZ_CODENT AND
				SRA.RA_DEPTO = %exp:cCodDep%
			GROUP BY
				RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_TIPOAV,SRA.RA_DEPTO
		ENDSQL
		
		SetRegua( 0 )
	
		While ( cAlsQry0 )->( !Eof() )
			IncRegua()
			DO CASE
				CASE ( ( cAlsQry0 )->RDD_TIPOAV == "1" ) ; nDepAut	+= ( cAlsQry0 )->RDD_RESOBT
				CASE ( ( cAlsQry0 )->RDD_TIPOAV == "2" ) ; nDepAva	+= ( cAlsQry0 )->RDD_RESOBT
				CASE ( ( cAlsQry0 )->RDD_TIPOAV == "3" ) ; nDepCon	+= ( cAlsQry0 )->RDD_RESOBT
			END CASE
			( cAlsQry0 )->( dbSkip() )
		End While
	
		( cAlsQry0 )->( dbCloseArea() )
	
		wCabec1 	+= SM0->( M0_NOMECOM + "/" + M0_FILIAL + "/" + M0_NOME )
		wCabec1 	+= "        "
		wCabec1 	+= "NOTA M�DIA DA AVALIA��O INDIVIDUAL DOS COLABORADORES DA EMPRESA:"
		wCabec1 	+= "      "
		wCabec1 	+= "AUTO AVALIA��O: " + TransForm( nEmpAut , "@E 999.99" )
		wCabec1 	+= "  "
		wCabec1 	+= "AVALIA��O: " + TransForm( nEmpAva , "@E 999.99" )
		wCabec1 	+= "  "
		wCabec1 	+= "CONSENSO: " + TransForm( nEmpCon , "@E 999.99" )
		wCabec1		:= OemToAnsi( wCabec1 )
	
		wCabec2 	+= GetCache( "SQB" , cCodDep , xFilial("SQB",cCodFil) , "QB_DESCRIC" , RetOrder( "SQB" , "QB_FILIAL+QB_DEPTO" ) , .F. )
		wCabec2 	+= "                                                      "
		wCabec2 	+= "NOTA M�DIA DA AVALIA��O INDIVIDUAL DOS COLABORADORES DA �REA:"
		wCabec2 	+= "        "
		wCabec2 	+= "AUTO AVALIA��O: "  + TransForm( nDepAut , "@E 999.99" )
		wCabec2 	+= "  "
		wCabec2 	+= "AVALIA��O: "  + TransForm( nDepAva , "@E 999.99" )
		wCabec2 	+= "  "
		wCabec2 	+= "CONSENSO: "  + TransForm( nDepCon , "@E 999.99" )
		wCabec2		:= OemToAnsi( wCabec2 )
	
		nRd6Media	:= GetCache( "RD6" , cCodAva , xFilial("RD6",cCodFil) , "RD6_NMEDIA" , RetOrder( "RD6" , "RD6_FILIAL+RD6_CODIGO" ) , .F. )
		
		wCabec3 	+= GetCache( "RD6" , cCodAva , xFilial("RD6",cCodFil) , "RD6_DESC" , RetOrder( "RD6" , "RD6_FILIAL+RD6_CODIGO" ) , .F. )  
		wCabec3 	+= "                             "
		wCabec3 	+= "NOTA DA AVALIA��O DE DESEMPENHO DA �REA:"
		wCabec3 	+= "                                                                        "
		wCabec3 	+= TransForm( nRd6Media  , "@E 999.99" )
		wCabec3		:= OemToAnsi( wCabec3 )
		
		BEGINSQL ALIAS cAlsQry0
			SELECT
				SRA.RA_MAT,
				RD0.RD0_CODIGO,
				RD0.RD0_NOME,
				ISNULL((
						SELECT
							ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
						FROM
							RDD000 RDD
						WHERE
							RDD.%NotDel% AND
							RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)% AND
							RDD.RDD_TIPOAV = '1' AND
							RDD.RDD_CODADO = RD0.RD0_CODIGO AND
							RDD.RDD_CODAVA = %exp:cCodAva%
						GROUP BY
							RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_CODADO
						),0.00) TPAV1,
				ISNULL((
						SELECT
							ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
						FROM
							RDD000 RDD
						WHERE
							RDD.%NotDel% AND
							RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)% AND
							RDD.RDD_TIPOAV = '2' AND
							RDD.RDD_CODADO = RD0.RD0_CODIGO AND
							RDD.RDD_CODAVA = %exp:cCodAva%
						GROUP BY
							RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_CODADO
						),0.00) TPAV2,
				ISNULL((
						SELECT
							ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
						FROM
							RDD000 RDD
						WHERE
							RDD.%NotDel% AND
							RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)% AND
							RDD.RDD_TIPOAV = '3' AND
							RDD.RDD_CODADO = RD0.RD0_CODIGO AND
							RDD.RDD_CODAVA = %exp:cCodAva%
						GROUP BY
							RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_CODADO
						),0.00) TPAV3
			FROM
				SRA000 SRA,
				RD0000 RD0,
				RDZ000 RDZ,
				RD6000 RD6
			WHERE
				SRA.%NotDel% AND
				RD0.%NotDel% AND
				RDZ.%NotDel% AND
				RD6.%NotDel% AND
				RDZ.RDZ_FILIAL = %exp:xFilial("RDZ",cCodFil)% AND
				RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
				RDZ.RDZ_FILENT = %exp:cCodFil% AND
				SRA.RA_FILIAL  = %exp:xFilial("SRA",cCodFil)% AND
				RD0.RD0_FILIAL = %exp:xFilial("RD0",cCodFil)% AND
				RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
				RDZ.RDZ_CODRD0 = RD0.RD0_CODIGO AND
				RD6.RD6_CODIGO = %exp:cCodAva% AND
				SRA.RA_FILIAL+SRA.RA_MAT = RDZ.RDZ_CODENT AND
				SRA.RA_DEPTO = %exp:cCodDep% AND
				(
					0 < (
							SELECT
								ISNULL(ROUND(AVG(RDD.RDD_RESOBT),2),0.00) RDD_RESOBT
							FROM
								RDD000 RDD,
							WHERE
								RDD.%NotDel% AND
								RDD.RDD_CODADO = RD0.RD0_CODIGO AND
								RDD.RDD_CODAVA = %exp:cCodAva%
							GROUP BY
								RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_CODADO
						)
				)
			ORDER BY
				RA_FILIAL,RA_MAT
		ENDSQL
		
		Impr( cDetCab0 )
		Impr( cDetCab1 ) 
		Impr( "" )
		
		SetRegua( 0 )
	
		While (cAlsQry0)->( !Eof() )
	
			IncRegua()
			
			IF ( lEnd )
				Impr( OemToAnsi( cCancel ) )
				Exit
			EndIF

			nAdoAut	:= (cAlsQry0)->TPAV1
			nAdoAva	:= (cAlsQry0)->TPAV2
			nAdoCon	:= (cAlsQry0)->TPAV3
	
			cDet := "   "
			cDet += (cAlsQry0)->(RA_MAT+"/"+RD0_CODIGO)
			cDet += " "
			cDet += (cAlsQry0)->RD0_NOME
			cDet += "      "
			cDet += TransForm( nAdoAut , "@E 999.99" )
	        cDet += "          "
	        cDet += TransForm( ( ( nAdoAut / nEmpAut ) * 100 ) , "@E 999.99" )
	        cDet += "     "
	        cDet += TransForm( ( ( nAdoAut / nDepAut ) * 100 ) , "@E 999.99" )
	        cDet += "     "
	        cDet += TransForm( ( ( nAdoAut / nRd6Media ) * 100 ) , "@E 999.99" )
	        cDet += "    |  "
	        cDet += TransForm( nAdoAva , "@E 999.99" )
	        cDet += "     "
	        cDet += TransForm( ( ( nAdoAva / nEmpAva ) * 100 ) , "@E 999.99" )
	        cDet += "      "
	        cDet += TransForm( ( ( nAdoAva / nDepAva ) * 100 ) , "@E 999.99" )
	        cDet += "    "
	        cDet += TransForm( ( ( nAdoAva / nRd6Media ) * 100 ) , "@E 999.99" )
	        cDet += "    |       "
	        cDet += TransForm( nAdoCon , "@E 999.99" )
	        cDet += "          "
	        cDet += TransForm( ( ( nAdoCon / nEmpCon ) * 100 ) , "@E 999.99" )
	        cDet += "     "
	        cDet += TransForm( ( ( nAdoCon / nDepCon ) * 100 ) , "@E 999.99" )
	        cDet += "     "
	        cDet += TransForm( ( ( nAdoCon / nRd6Media ) * 100 ) , "@E 999.99" )
	
			IF ( Li == 57 )
				++LI
				Impr( cDetCab0 )
				Impr( cDetCab1 )
				Impr( "" )
			EndIF 
	
			Impr( OemToAnsi( cDet ) )
			
			(cAlsQry0)->( dbSkip() )
			
		End While
		
		(cAlsQry0)->( dbCloseArea() )
	
		SET DEVICE TO SCREEN
		IF ( aReturn[5] == 1 )
			SET PRINTER TO
			dbCommit()
			OurSpool( wnRel )
		EndIF
		
		Ms_Flush()
	
	CATCHEXCEPTION USING oException
	
		MsgAlert( oException:Description , "Alerta!" )

	ENDEXCEPTION

	IF !( cSvEmpAnt == cEmpAnt )
		GetEmpr( cSvEmpAnt+cSvFilAnt )		
	EndIF
	
Return( NIL  )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �APDR10AvaVld� Autor �Marinaldo de Jesus   � Data �20/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Valida o Codigo da Avalia��o								�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function APDR10AvaVld( lValid )
	
	Local lRet := .T.
	Local oException
	
	cAPDRAva := MV_PAR01
	
	TRYEXCEPTION
		DEFAULT lValid := .T.
		IF ( lValid )
			RD6->( dbSetOrder( RetOrder( "RD6" , "RD6_FILIAL+RD6_CODIGO" ) ) )
			IF RD6->( !dbSeek( xFilial( "RD6" ) + cAPDRAva ) )
				UserException( "C�digo de Avalia��o Informado N�o Existente na Tabela RD6" )
			EndIF
		EndIF	
	CATCHEXCEPTION USING oException
		lRet := .F.
		MsgAlert( oException:Description , "Alerta!" )
	ENDEXCEPTION

Return( lRet )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �APDR10DepVld� Autor �Marinaldo de Jesus   � Data �20/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Valida o Codigo do Departamento								�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function APDR10DepVld( lValid )

	Local lRet := .T.
	Local oException

	cAPDRDep := MV_PAR02

	TRYEXCEPTION
		DEFAULT lValid := .T.
		IF ( lValid )
			SQB->( dbSetOrder( RetOrder( "SQB" , "QB_FILIAL+QB_DEPTO" ) ) )
			IF SQB->( !dbSeek( xFilial( "SQB" ) + cAPDRDep ) )
				UserException( "C�digo do Departamento Informado N�o Existente na Tabela SQB" )
			EndIF
		EndIF	
	CATCHEXCEPTION USING oException
		lRet := .F.
		MsgAlert( oException:Description , "Alerta!" )
	ENDEXCEPTION

Return( lRet )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �APDR10EmpVld� Autor �Marinaldo de Jesus   � Data �20/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Valida o Codigo da Empresa  								�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function APDR10EmpVld( lValid )

	Local lRet := .T.
	Local oException

	cAPDREmp := MV_PAR03

	TRYEXCEPTION
		DEFAULT lValid := .T.
		IF ( lValid )
			SM0->( dbSetOrder( 1 ) )
			SM0->( dbSeek( cAPDREmp , .T. ) )
			IF !( SM0->M0_CODIGO == cAPDREmp )
				UserException( "C�digo da Empresa Informado Inv�lido" )
			EndIF
		EndIF	
	CATCHEXCEPTION USING oException
		lRet := .F.
		MsgAlert( oException:Description , "Alerta!" )
	ENDEXCEPTION

Return( lRet )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �APDR10FilVld� Autor �Marinaldo de Jesus   � Data �20/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Valida o Codigo da Filial									�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function APDR10FilVld( lValid )

	Local lRet := .T.
	Local oException

	cAPDREmp := MV_PAR03
	cAPDRFil := MV_PAR04

	TRYEXCEPTION
		DEFAULT lValid := .T.
		IF ( lValid )
			SM0->( dbSetOrder( 1 ) )
			IF SM0->( !dbSeek( cAPDREmp + cAPDRFil ) )
				UserException( "Filial Inv�lida" )
			EndIF
		ENDIF	
	CATCHEXCEPTION USING oException
		lRet := .F.
		MsgAlert( oException:Description  , "Alerta!" )
	ENDEXCEPTION

Return( lRet )