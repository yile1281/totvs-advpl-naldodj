#INCLUDE "PROTHEUS.CH"
#INCLUDE "TRYEXCEPTION.CH"
/*/
��������������������������������������������������������������������������������Ŀ
�Programa  �APDR30    �Autor�Marinaldo de Jesus		           �Data  �21/11/2009�
��������������������������������������������������������������������������������Ĵ
�Descricoes�Relat�rio de Avalia��o por Grupo de Cargo							 �
��������������������������������������������������������������������������������Ĵ
�Uso       �SINAF																 �
��������������������������������������������������������������������������������Ĵ
�            ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                    �
��������������������������������������������������������������������������������Ĵ
�Programador �Data      �Nro. Ocorr.�Motivo da Alteracao                         �
��������������������������������������������������������������������������������Ĵ
�            �          �           �                    						 �
����������������������������������������������������������������������������������/*/
User Function APDR30()
	
	/*/
	��������������������������������������������������������������Ŀ
	� Mascara do Relat�rio (220 Colunas)                           �
	����������������������������������������������������������������
	    		10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
		1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	  	EMPRESA: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/XXXXXXXXXXXXXXXX/XXXXXXXXXXXXXXXX        NOTA MEDIA DA AVALIA��O INDIVIDUAL DOS COLABORADORES DA EMPRESA:      AUTO AVALIA��O: 999.99  AVALIA��O: 999.99  CONSENSO: 999.99
	    �REA: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                                        NOTA MEDIA DA AVALIA��O INDIVIDUAL DOS COLABORADORES DA �REA:        AUTO AVALIA��O: 999.99  AVALIA��O: 999.99  CONSENSO: 999.99
	    AVALIA��O: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                               NOTA DA AVALIA��O DE DESEMPENHO DA �REA (A):                                                                    999.99
	    1       10        20        30        40
		----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
                                                          |                     AUTO AVALIA��O                     |                        AVALIA��O                       |                       CONSENSO                        
                                                (B)       |  (C)      %       %       (D)     %       %       %    |  (E)      %       %       (F)     %       %       %    |  (G)      %       %       (H)     %       %       %   
        C�DIGO GRUPO DO CARGO              M�DIA ESPERADA |  NOTA   (C->A)  (C->B)   GRUPO  (D->A)  (D->B)  (C->D) |  NOTA   (E->A)  (E->B)   GRUPO  (F->A)  (F->B)  (E->F) |  NOTA   (G->A)  (G->B)   GRUPO  (H->A)  (H->B)  (G->H) 
	  	99     XXXXXXXXXXXXXXX                 999.99     | 999.99  999.99  999.99  999.99  999.99  999.99  999.99 | 999.99  999.99  999.99  999.99  999.99  999.99  999.99 | 999.99  999.99  999.99  999.99  999.99  999.99  999.99
	/*/

	Local aArea		:= GetArea()
	Local aOrd		:= {}
	Local aImpress	:= aClone( __aImpress )
	
	Local cDesc1	:= OemToAnsi( "Relat�rio de Avalia��o por Grupo de Cargo" )
	Local cDesc2	:= OemToAnsi( "Ser� impresso de acordo com os par�metros solicitados pelo" )
	Local cDesc3	:= OemToAnsi( "usu�rio." )
	Local cAlias	:= "RD0"	//Alias do arquivo Principal ( Base )
	Local cPerg		:= Padr( "U_APDR30" , Len( SX1->X1_GRUPO ) )
	
	Local wnRel
	Local cMsgAlert
	
	Private aReturn  := {;
							"Zebrado"		,;	//01 -> "Zebrado" -> Descricao do Tipo de Formulario que aparecera na Pasta Opcionais
							NIL				,;  //02 -> Reservado...
							"Administra��o"	,;	//03 -> "Administra��o" -> Descricao do Destinatario que aparecera na Pasta Opcionais
							2				,;  //04 -> Orientacao do Relat�rio 1=Retrato;2=Paisagem
							NIL				,;  //05 -> Local da Impressao
							NIL				,;	//06 -> Nome com que o arquivo sera salvo
							NIL				,;	//07 -> Filtro DEFAULT do Relat�rio que sera utilizado na Pasta Filtro
							1		 		;	//08 -> Ordem DEFAULT do Relat�rio que srea utilizado na Pasta Ordem
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

		APDR30AvaVld(.F.)
		APDR30DepVld(.F.)
		APDR30EmpVld(.F.)
		APDR30FilVld(.F.)
    
		__aImpress[1] := 1

		/*/
		��������������������������������������������������������������Ŀ
		� Envia controle para a funcao SETPRINT                        �
		����������������������������������������������������������������/*/
		wnRel := NomeProg
		wnRel := SetPrint(;
							""			,;	//01 -> cAlias:			Alias da Tabela
							wnRel		,;	//02 -> cNome: 			Nome do Relat�rio
							cPerg		,;	//03 -> cPerg: 			Grupo de Perguntas
							@Titulo 	,;	//04 -> cDesc: 			Descricao do Relat�rio
							cDesc1		,;	//05 -> cCnt1: 			1a. Descricao que aparecera no Rodape da Pasta Impressao
							cDesc2		,;	//06 -> cCnt2: 			2a. Descricao que aparecera no Rodape da Pasta Impressao	
							cDesc3		,;	//07 -> cCnt3: 			3a. Descricao que aparecera no Rodape da Pasta Impressao
							.F.			,;	//08 -> lDic:  			Se Disponibilizara Pasta para Selecao dos Campos
							aOrd		,;	//09 -> aOrd:  			Array com a Descricao das Ordens para Selecao	
							.T.			,;	//10 -> lCompres: 		Se habilitara compressao do Relat�rio
							nTamanho    ,;	//11 -> cSize: 			Tamanho do Relat�rio "P=80Colunas";"M=132Colunas";"G=220Colunas"
							NIL			,;	//12 -> aFilter: 		Array com expressao de Filtro
							.F.			,;	//13 -> lFiltro: 		Se habilitara a Pasta Filtro
							.F.			,;	//14 -> lCrystal: 		Se Relat�rio esta integrado ao Crystal Report
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
						@nTamanho	,;	//05 -> cSize:		Tamanho do Relat�rio
						2			 ;	//06 -> nOrienta:	Orientacao do Relat�rio ( 1-Retrato; 2-Paisagem )
					)
	
		/*/
		��������������������������������������������������������������Ŀ
		� Se pressionou a Tecla "ESC" abandona                         �
		����������������������������������������������������������������/*/
		IF ( nLastKey == 27 )
		   Break
		EndIF
		
		Pergunte( cPerg , .F. )

		IF !( APDR30AvaVld() )
			Break
		EndIF
		
		IF !( APDR30DepVld() )
			Break
		EndIF
		
		IF !( APDR30EmpVld() )
			Break
		EndIF
		
		IF !( APDR30FilVld() )
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
�Fun��o    �U_InAPDR30    �Autor �Marinaldo de Jesus   � Data �21/11/2009�
������������������������������������������������������������������������Ĵ
�Descri��o �Executar Funcoes Dentro de APDR010                           �
������������������������������������������������������������������������Ĵ
�Sintaxe   �U_InAPDR30( cExecIn , aFormParam )						 	 �
������������������������������������������������������������������������Ĵ
�Parametros�<Vide Parametros Formais>									 �
������������������������������������������������������������������������Ĵ
�Retorno   �uRet                                                 	     �
������������������������������������������������������������������������Ĵ
�Observa��o�                                                      	     �
������������������������������������������������������������������������Ĵ
�Uso       �Generico 													 �
��������������������������������������������������������������������������/*/
User Function InAPDR30( cExecIn , aFormParam )
         
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
�Fun��o    �PrintRel    � Autor �Marinaldo de Jesus   � Data �21/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Imprime Detalhes do Relat�rio								�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function PrintRel( lEnd , wnRel , cPerg )

	Local cAlsQry		:= GetNextAlias()
	
	Local cDet			:= ""
	Local cDetCab0		:= OemToAnsi("                                                  |                     AUTO AVALIA��O                     |                        AVALIA��O                       |                       CONSENSO                        ")
	Local cDetCab1		:= OemToAnsi("                                        (B)       |  (C)      %       %       (D)     %       %       %    |  (E)      %       %       (F)     %       %       %    |  (G)      %       %       (H)     %       %       %   ")
	Local cDetCab2		:= OemToAnsi("C�DIGO GRUPO DO CARGO              M�DIA ESPERADA |  NOTA   (C->A)  (C->B)   GRUPO  (D->A)  (D->B)  (C->D) |  NOTA   (E->A)  (E->B)   GRUPO  (F->A)  (F->B)  (E->F) |  NOTA   (G->A)  (G->B)   GRUPO  (H->A)  (H->B)  (G->H)")
	
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

	Local nSQ0Media		:= 0
	Local nRd6Media		:= 0

	Local nTp1AvgDep	:= 0
	Local nTp1AvgEmp	:= 0

	Local nTp2AvgDep	:= 0
	Local nTp2AvgEmp	:= 0

	Local nTp3AvgDep	:= 0
	Local nTp3AvgEmp	:= 0

	Local nCA 			:= 0
	Local nCB 			:= 0
	Local nDA 			:= 0
	Local nDB 			:= 0
	Local nCD 			:= 0
	Local nEA 			:= 0
	Local nEB 			:= 0
	Local nFA 			:= 0
	Local nFB 			:= 0
	Local nEF 			:= 0
	Local nGA 			:= 0
	Local nGB 			:= 0
	Local nHA 			:= 0
	Local nHB 			:= 0
	Local nGH 			:= 0
	
	Local oException    
	
	TRYEXCEPTION

		SM0->( dbSetOrder( 1 ) )
		IF SM0->( !dbSeek( cCodEmp + cCodFil ) )
			UserExeption( "Empresa ou Filial n�o Cadastrada no SIGAMAT.EMP!" )
		EndIF

		IF ( cCodEmp <> cEmpAnt )
			GetEmpr( cCodEmp + cCodFil ) 
		EndIF

		BEGINSQL ALIAS cAlsQry
			SELECT
				RDD.RDD_CODAVA,
				RDD.RDD_TIPOAV,
				ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
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
	
		While ( cAlsQry )->( !Eof() )
			IncRegua()
			DO CASE
				CASE ( ( cAlsQry )->RDD_TIPOAV == "1" ) ; nEmpAut	+= ( cAlsQry )->RDD_RESOBT
				CASE ( ( cAlsQry )->RDD_TIPOAV == "2" ) ; nEmpAva	+= ( cAlsQry )->RDD_RESOBT
				CASE ( ( cAlsQry )->RDD_TIPOAV == "3" ) ; nEmpCon	+= ( cAlsQry )->RDD_RESOBT
			END CASE
			( cAlsQry )->( dbSkip() )
		End While
	
		( cAlsQry )->( dbCloseArea() )
		
		BEGINSQL ALIAS cAlsQry
			SELECT
				RDD.RDD_CODAVA,
				RDD.RDD_TIPOAV,
				SRA.RA_DEPTO,
				ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
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
	
		While ( cAlsQry )->( !Eof() )
			IncRegua()
			DO CASE
				CASE ( ( cAlsQry )->RDD_TIPOAV == "1" ) ; nDepAut	+= ( cAlsQry )->RDD_RESOBT
				CASE ( ( cAlsQry )->RDD_TIPOAV == "2" ) ; nDepAva	+= ( cAlsQry )->RDD_RESOBT
				CASE ( ( cAlsQry )->RDD_TIPOAV == "3" ) ; nDepCon	+= ( cAlsQry )->RDD_RESOBT
			END CASE
			( cAlsQry )->( dbSkip() )
		End While
	
		( cAlsQry )->( dbCloseArea() )

		wCabec1 	+= SM0->( M0_NOMECOM + "/" + M0_FILIAL + "/" + M0_NOME )
		wCabec1 	+= "        "
		wCabec1 	+= "NOTA MEDIA DA AVALIA��O INDIVIDUAL DOS COLABORADORES DA EMPRESA:"
		wCabec1 	+= "      "
		wCabec1 	+= "AUTO AVALIA��O: " + TransForm( nEmpAut , "@E 999.99" )
		wCabec1 	+= "  "
		wCabec1 	+= "AVALIA��O: " + TransForm( nEmpAva , "@E 999.99" )
		wCabec1 	+= "  "
		wCabec1 	+= "CONSENSO: " + TransForm( nEmpCon , "@E 999.99" )
		wCabec1		:= OemToAnsi( wCabec1 )
	
		wCabec2 	+= GetCache( "SQB" , cCodDep , xFilial("SQB",cCodFil) , "QB_DESCRIC" , RetOrder( "SQB" , "QB_FILIAL+QB_DEPTO" ) , .F. )
		wCabec2 	+= "                                                      "
		wCabec2 	+= "NOTA MEDIA DA AVALIA��O INDIVIDUAL DOS COLABORADORES DA �REA:"
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
		wCabec3 	+= "NOTA DA AVALIA��O DE DESEMPENHO DA �REA (A):"
		wCabec3 	+= "                                                                    "
		wCabec3 	+= TransForm( nRd6Media  , "@E 999.99" )
		wCabec3		:= OemToAnsi( wCabec3 )
		
		BEGINSQL ALIAS cAlsQry
			SELECT 
				SQ0.Q0_GRUPO,
				SQ0.Q0_DESCRIC,
				SQ0.Q0_NMEDIA,
				ISNULL((
						SELECT
							ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
						FROM
							%table:RDD% RDD,
							%table:RDZ% RDZ,
							%table:RD6% RD6,
							%table:SRA% SRA,
							%table:SRJ% SRJ,
							%table:SQ3% SQ3,
							%table:SQB% SQB
						WHERE
							RDD.%NotDel% AND
							RDZ.%NotDel% AND
							RD6.%NotDel% AND
							SRA.%NotDel% AND
							SRJ.%NotDel% AND
							SQ3.%NotDel% AND
							SQB.%NotDel% AND
							RDZ.RDZ_FILIAL = %exp:xFilial("RDZ",cCodFil)% AND
							RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
							RDZ.RDZ_FILENT = %exp:cCodFil% AND
							RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)%AND
							RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
							SRA.RA_FILIAL = %exp:xFilial("SRA",cCodFil)% AND
							SRJ.RJ_FILIAL = %exp:xFilial("SRJ",cCodFil)% AND
							SQ3.Q3_FILIAL = %exp:xFilial("SQ3",cCodFil)% AND
							SQB.QB_FILIAL = %exp:xFilial("SQB",cCodFil)% AND
							RDZ.RDZ_CODRD0 = RDD.RDD_CODADO AND
							RD6.RD6_CODIGO = %exp:cCodAva% AND
							RDD.RDD_CODAVA = RD6.RD6_CODIGO	AND
							RDD.RDD_TIPOAV = '1' AND
							SRA.RA_FILIAL+SRA.RA_MAT = RDZ.RDZ_CODENT AND
							SRJ.RJ_FUNCAO = SRA.RA_CODFUNC AND
							SQ3.Q3_CARGO = SRJ.RJ_CARGO AND
							( SQ3.Q3_DEPTO = %exp:cCodDep% OR SRA.RA_DEPTO = %exp:cCodDep% ) AND 
							SQ3.Q3_GRUPO = SQ0.Q0_GRUPO AND
							SQB.QB_DEPTO = %exp:cCodDep%
						GROUP BY
							RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_TIPOAV
					  ),0.00) TP1AVGDEP,
				ISNULL((
						SELECT
							ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
						FROM
							%table:RDD% RDD,
							%table:RDZ% RDZ,
							%table:RD6% RD6,
							%table:SRA% SRA,
							%table:SRJ% SRJ,
							%table:SQ3% SQ3,
							%table:SQB% SQB
						WHERE
							RDD.%NotDel% AND
							RDZ.%NotDel% AND
							RD6.%NotDel% AND
							SRA.%NotDel% AND
							SRJ.%NotDel% AND
							SQ3.%NotDel% AND
							SQB.%NotDel% AND
							RDZ.RDZ_FILIAL = %exp:xFilial("RDZ",cCodFil)% AND
							RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
							RDZ.RDZ_FILENT = %exp:cCodFil% AND
							RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)%AND
							RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
							SRA.RA_FILIAL = %exp:xFilial("SRA",cCodFil)% AND
							SRJ.RJ_FILIAL = %exp:xFilial("SRJ",cCodFil)% AND
							SQ3.Q3_FILIAL = %exp:xFilial("SQ3",cCodFil)% AND
							SQB.QB_FILIAL = %exp:xFilial("SQB",cCodFil)% AND
							RDZ.RDZ_CODRD0 = RDD.RDD_CODADO AND
							RD6.RD6_CODIGO = %exp:cCodAva% AND
							RDD.RDD_CODAVA = RD6.RD6_CODIGO	AND
							RDD.RDD_TIPOAV = '1' AND
							SRA.RA_FILIAL+SRA.RA_MAT = RDZ.RDZ_CODENT AND
							SRJ.RJ_FUNCAO = SRA.RA_CODFUNC AND
							SQ3.Q3_CARGO = SRJ.RJ_CARGO AND
							SQ3.Q3_GRUPO = SQ0.Q0_GRUPO
						GROUP BY
							RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_TIPOAV
					),0.00) TP1AVGEMP,
				ISNULL((
						SELECT
							ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
						FROM
							%table:RDD% RDD,
							%table:RDZ% RDZ,
							%table:RD6% RD6,
							%table:SRA% SRA,
							%table:SRJ% SRJ,
							%table:SQ3% SQ3,
							%table:SQB% SQB
						WHERE
							RDD.%NotDel% AND
							RDZ.%NotDel% AND
							RD6.%NotDel% AND
							SRA.%NotDel% AND
							SRJ.%NotDel% AND
							SQ3.%NotDel% AND
							SQB.%NotDel% AND
							RDZ.RDZ_FILIAL = %exp:xFilial("RDZ",cCodFil)% AND
							RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
							RDZ.RDZ_FILENT = %exp:cCodFil% AND
							RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)%AND
							RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
							SRA.RA_FILIAL = %exp:xFilial("SRA",cCodFil)% AND
							SRJ.RJ_FILIAL = %exp:xFilial("SRJ",cCodFil)% AND
							SQ3.Q3_FILIAL = %exp:xFilial("SQ3",cCodFil)% AND
							SQB.QB_FILIAL = %exp:xFilial("SQB",cCodFil)% AND
							RDZ.RDZ_CODRD0 = RDD.RDD_CODADO AND
							RD6.RD6_CODIGO = %exp:cCodAva% AND
							RDD.RDD_CODAVA = RD6.RD6_CODIGO	AND
							RDD.RDD_TIPOAV = '2' AND
							SRA.RA_FILIAL+SRA.RA_MAT = RDZ.RDZ_CODENT AND
							SRJ.RJ_FUNCAO = SRA.RA_CODFUNC AND
							SQ3.Q3_CARGO = SRJ.RJ_CARGO AND
							( SQ3.Q3_DEPTO = %exp:cCodDep% OR SRA.RA_DEPTO = %exp:cCodDep% ) AND 
							SQ3.Q3_GRUPO = SQ0.Q0_GRUPO AND
							SQB.QB_DEPTO = %exp:cCodDep%
						GROUP BY
							RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_TIPOAV
					),0.00) TP2AVGDEP,
				ISNULL((
						SELECT
							ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
						FROM
							%table:RDD% RDD,
							%table:RDZ% RDZ,
							%table:RD6% RD6,
							%table:SRA% SRA,
							%table:SRJ% SRJ,
							%table:SQ3% SQ3,
							%table:SQB% SQB
						WHERE
							RDD.%NotDel% AND
							RDZ.%NotDel% AND
							RD6.%NotDel% AND
							SRA.%NotDel% AND
							SRJ.%NotDel% AND
							SQ3.%NotDel% AND
							SQB.%NotDel% AND
							RDZ.RDZ_FILIAL = %exp:xFilial("RDZ",cCodFil)% AND
							RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
							RDZ.RDZ_FILENT = %exp:cCodFil% AND
							RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)%AND
							RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
							SRA.RA_FILIAL = %exp:xFilial("SRA",cCodFil)% AND
							SRJ.RJ_FILIAL = %exp:xFilial("SRJ",cCodFil)% AND
							SQ3.Q3_FILIAL = %exp:xFilial("SQ3",cCodFil)% AND
							SQB.QB_FILIAL = %exp:xFilial("SQB",cCodFil)% AND
							RDZ.RDZ_CODRD0 = RDD.RDD_CODADO AND
							RD6.RD6_CODIGO = %exp:cCodAva% AND
							RDD.RDD_CODAVA = RD6.RD6_CODIGO	AND
							RDD.RDD_TIPOAV = '2' AND
							SRA.RA_FILIAL+SRA.RA_MAT = RDZ.RDZ_CODENT AND
							SRJ.RJ_FUNCAO = SRA.RA_CODFUNC AND
							SQ3.Q3_CARGO = SRJ.RJ_CARGO AND
							SQ3.Q3_GRUPO = SQ0.Q0_GRUPO
						GROUP BY
							RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_TIPOAV
					),0.00) TP2AVGEMP,
				ISNULL((
						SELECT
							ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
						FROM
							%table:RDD% RDD,
							%table:RDZ% RDZ,
							%table:RD6% RD6,
							%table:SRA% SRA,
							%table:SRJ% SRJ,
							%table:SQ3% SQ3,
							%table:SQB% SQB
						WHERE
							RDD.%NotDel% AND
							RDZ.%NotDel% AND
							RD6.%NotDel% AND
							SRA.%NotDel% AND
							SRJ.%NotDel% AND
							SQ3.%NotDel% AND
							SQB.%NotDel% AND
							RDZ.RDZ_FILIAL = %exp:xFilial("RDZ",cCodFil)% AND
							RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
							RDZ.RDZ_FILENT = %exp:cCodFil% AND
							RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)%AND
							RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
							SRA.RA_FILIAL = %exp:xFilial("SRA",cCodFil)% AND
							SRJ.RJ_FILIAL = %exp:xFilial("SRJ",cCodFil)% AND
							SQ3.Q3_FILIAL = %exp:xFilial("SQ3",cCodFil)% AND
							SQB.QB_FILIAL = %exp:xFilial("SQB",cCodFil)% AND
							RDZ.RDZ_CODRD0 = RDD.RDD_CODADO AND
							RD6.RD6_CODIGO = %exp:cCodAva% AND
							RDD.RDD_CODAVA = RD6.RD6_CODIGO	AND
							RDD.RDD_TIPOAV = '3' AND
							SRA.RA_FILIAL+SRA.RA_MAT = RDZ.RDZ_CODENT AND
							SRJ.RJ_FUNCAO = SRA.RA_CODFUNC AND
							SQ3.Q3_CARGO = SRJ.RJ_CARGO AND
							( SQ3.Q3_DEPTO = %exp:cCodDep% OR SRA.RA_DEPTO = %exp:cCodDep% ) AND 
							SQ3.Q3_GRUPO = SQ0.Q0_GRUPO AND
							SQB.QB_DEPTO = %exp:cCodDep%
						GROUP BY
							RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_TIPOAV
					),0.00) TP3AVGDEP,
				ISNULL((
						SELECT
							ROUND(AVG(RDD.RDD_RESOBT),2) RDD_RESOBT
						FROM
							%table:RDD% RDD,
							%table:RDZ% RDZ,
							%table:RD6% RD6,
							%table:SRA% SRA,
							%table:SRJ% SRJ,
							%table:SQ3% SQ3,
							%table:SQB% SQB
						WHERE
							RDD.%NotDel% AND
							RDZ.%NotDel% AND
							RD6.%NotDel% AND
							SRA.%NotDel% AND
							SRJ.%NotDel% AND
							SQ3.%NotDel% AND
							SQB.%NotDel% AND
							RDZ.RDZ_FILIAL = %exp:xFilial("RDZ",cCodFil)% AND
							RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
							RDZ.RDZ_FILENT = %exp:cCodFil% AND
							RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)%AND
							RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
							SRA.RA_FILIAL = %exp:xFilial("SRA",cCodFil)% AND
							SRJ.RJ_FILIAL = %exp:xFilial("SRJ",cCodFil)% AND
							SQ3.Q3_FILIAL = %exp:xFilial("SQ3",cCodFil)% AND
							SQB.QB_FILIAL = %exp:xFilial("SQB",cCodFil)% AND
							RDZ.RDZ_CODRD0 = RDD.RDD_CODADO AND
							RD6.RD6_CODIGO = %exp:cCodAva% AND
							RDD.RDD_CODAVA = RD6.RD6_CODIGO	AND
							RDD.RDD_TIPOAV = '3' AND
							SRA.RA_FILIAL+SRA.RA_MAT = RDZ.RDZ_CODENT AND
							SRJ.RJ_FUNCAO = SRA.RA_CODFUNC AND
							SQ3.Q3_CARGO = SRJ.RJ_CARGO AND
							SQ3.Q3_GRUPO = SQ0.Q0_GRUPO
						GROUP BY
							RDD.RDD_FILIAL,RDD.RDD_CODAVA,RDD.RDD_TIPOAV
					),0.00) TP3AVGEMP
			FROM
				%table:SQ0% SQ0
			WHERE
				SQ0.%NotDel% AND
				SQ0.Q0_FILIAL = %exp:xFilial("SQ0",cCodFil)% AND
				(
					0 < ( 
							SELECT
								SUM(RDD.RDD_RESOBT) RDD_RESOBT
							FROM
								%table:RDD% RDD,
								%table:RDZ% RDZ,
								%table:RD6% RD6,
								%table:SRA% SRA,
								%table:SRJ% SRJ,
								%table:SQ3% SQ3,
								%table:SQB% SQB
							WHERE
								RDD.%NotDel% AND
								RDZ.%NotDel% AND
								RD6.%NotDel% AND
								SRA.%NotDel% AND
								SRJ.%NotDel% AND
								SQ3.%NotDel% AND
								SQB.%NotDel% AND
								RDZ.RDZ_FILIAL = %exp:xFilial("RDZ",cCodFil)% AND
								RDZ.RDZ_EMPENT = %exp:cCodEmp% AND
								RDZ.RDZ_FILENT = %exp:cCodFil% AND
								RDD.RDD_FILIAL = %exp:xFilial("RDD",cCodFil)%AND
								RD6.RD6_FILIAL = %exp:xFilial("RD6",cCodFil)% AND
								SRA.RA_FILIAL = %exp:xFilial("SRA",cCodFil)% AND
								SRJ.RJ_FILIAL = %exp:xFilial("SRJ",cCodFil)% AND
								SQ3.Q3_FILIAL = %exp:xFilial("SQ3",cCodFil)% AND
								SQB.QB_FILIAL = %exp:xFilial("SQB",cCodFil)% AND
								RDZ.RDZ_CODRD0 = RDD.RDD_CODADO AND
								RD6.RD6_CODIGO = %exp:cCodAva% AND
								RDD.RDD_CODAVA = RD6.RD6_CODIGO	AND
								RDD.RDD_TIPOAV IN ( '1' , '2' , '3' ) AND
								SRA.RA_FILIAL+SRA.RA_MAT = RDZ.RDZ_CODENT AND
								SRJ.RJ_FUNCAO = SRA.RA_CODFUNC AND
								SQ3.Q3_CARGO = SRJ.RJ_CARGO AND
								SQ3.Q3_DEPTO = %exp:cCodDep% AND 
								SQ3.Q3_GRUPO = SQ0.Q0_GRUPO AND
								SQB.QB_DEPTO = %exp:cCodDep%
							GROUP BY
								RDD.RDD_FILIAL,RDD.RDD_CODAVA
						)
				)
			ORDER BY
				SQ0.Q0_FILIAL,SQ0.Q0_GRUPO

		ENDSQL
		
		Impr( cDetCab0 )
		Impr( cDetCab1 )
		Impr( cDetCab2 )  
		Impr( "" )
		
		SetRegua( 0 )

		While (cAlsQry)->( !Eof() )
	
			IncRegua()
			
			IF ( lEnd )
				Impr( OemToAnsi( cCancel ) )
				Exit
			EndIF

			nSQ0Media	:= (cAlsQry)->Q0_NMEDIA
			
			nTp1AvgDep	:= (cAlsQry)->TP1AVGDEP

			nCA := ( ( nTp1AvgDep / nRd6Media ) * 100 )
			nCA := NoRound( nCA , 2 )
			
			nCB := ( ( nTp1AvgDep / nSQ0Media ) * 100 )
			nCB := NoRound( nCB , 2 )

			nTp1AvgEmp	:= (cAlsQry)->TP1AVGEMP

			nDA := ( ( nTp1AvgEmp / nRd6Media ) * 100 )
			nDA := NoRound( nDA , 2 )
			
			nDB := ( ( nTp1AvgEmp / nSQ0Media ) * 100 )
			nDB := NoRound( nDB , 2 )

			nCD := ( (  nTp1AvgDep / nTp1AvgEmp ) * 100 )
			nCD := NoRound( nCD , 2 )

			nTp2AvgDep	:= (cAlsQry)->TP2AVGDEP

			nEA := ( ( nTp2AvgDep / nRd6Media ) * 100 )
			nEA := NoRound( nEA , 2 )
			
			nEB := ( ( nTp2AvgDep / nSQ0Media ) * 100 )
			nEB := NoRound( nEB , 2 )

			nTp2AvgEmp	:= (cAlsQry)->TP2AVGEMP

			nFA := ( ( nTp2AvgEmp / nRd6Media ) * 100 )
			nFA := NoRound( nFA , 2 )
			
			nFB := ( ( nTp2AvgEmp / nSQ0Media ) * 100 )
			nFB := NoRound( nFB , 2 )

			nEF := ( (  nTp2AvgDep / nTp2AvgEmp ) * 100 )
			nEF := NoRound( nEF , 2 )

			nTp3AvgDep	:= (cAlsQry)->TP3AVGDEP

			nGA := ( ( nTp3AvgDep / nRd6Media ) * 100 )
			nGA := NoRound( nGA , 2 )
			
			nGB := ( ( nTp3AvgDep / nSQ0Media ) * 100 )
			nGB := NoRound( nGB , 2 )

			nTp3AvgEmp	:= (cAlsQry)->TP3AVGEMP

			nHA := ( ( nTp3AvgEmp / nRd6Media ) * 100 )
			nHA := NoRound( nHA , 2 )
			
			nHB := ( ( nTp3AvgEmp / nSQ0Media ) * 100 )
			nHB := NoRound( nHB , 2 )

			nGH := ( (  nTp3AvgDep / nTp3AvgEmp ) * 100 )
			nGH := NoRound( nGH , 2 )
		
			cDet := (cAlsQry)->Q0_GRUPO

			cDet += "     "

			cDet += (cAlsQry)->Q0_DESCRIC

			cDet += "                 "
			
			cDet += TransForm( nSQ0Media , "@E 999.99" )

	        cDet += "     | "
	        
	        cDet += TransForm( nTp1AvgDep , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nCA , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nCB , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nTp1AvgEmp , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nDA , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nDB , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nCD , "@E 999.99" )

			cDet += " | "

	        cDet += TransForm( nTp2AvgDep , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nEA , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nEB , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nTp2AvgEmp , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nFA , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nFB , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nEF , "@E 999.99" )

			cDet += " | "

	        cDet += TransForm( nTp3AvgDep , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nGA , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nGB , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nTp3AvgEmp , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nHA , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nHB , "@E 999.99" )
	        cDet += "  "
	        cDet += TransForm( nGH , "@E 999.99" )
	
			IF ( Li == 57 )
				++LI
				Impr( cDetCab0 )
				Impr( cDetCab1 )
				Impr( cDetCab2 )
				Impr( "" )
			EndIF 
	
			Impr( OemToAnsi( cDet ) )
			
			(cAlsQry)->( dbSkip() )
			
		End While
		
		(cAlsQry)->( dbCloseArea() )
	    
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
�Fun��o    �APDR30AvaVld� Autor �Marinaldo de Jesus   � Data �21/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Valida o Codigo da Avalia��o								�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function APDR30AvaVld( lValid )
	
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
�Fun��o    �APDR30DepVld� Autor �Marinaldo de Jesus   � Data �21/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Valida o Codigo do Departamento								�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function APDR30DepVld( lValid )

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
�Fun��o    �APDR30EmpVld� Autor �Marinaldo de Jesus   � Data �21/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Valida o Codigo da Empresa									�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function APDR30EmpVld( lValid )

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
�Fun��o    �APDR30FilVld� Autor �Marinaldo de Jesus   � Data �21/11/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Valida o Codigo da Filial									�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �SIGAAPD														�
�������������������������������������������������������������������������/*/
Static Function APDR30FilVld( lValid )

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