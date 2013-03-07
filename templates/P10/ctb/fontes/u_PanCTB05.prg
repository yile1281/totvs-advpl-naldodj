#INCLUDE "PAN-AMERICANA.CH"
#INCLUDE "U_PanCTB05.CH"

/*/
	1) Registro Cabe�alho

	Posi��o 08 - 10    :    N�mero sequencial do arquivo
	Posi��o 10 - 17    :    Data para o Lan�amento Cont�bil
	Posi��o 18 - 19    :    Constante "FP" para indicar que � um arquivo da Folha de Pagamento
	Posi��o 25 - 26    :    Filial do Lan�amento
 
	2) Registro Detalhe (corresponde a cada lan�amento cont�bil CT2)

	Posi��o 08 - 16    :    N�mero da Conta Cont�bil
	Posi��o 19 - 22    :    Centro de Custo
	Posi��o 23 - 36    :    Valor do Lan�amento
	Posi��o 37 - 37    :    Tipo (D�bito ou Cr�dito)
	Posi��o 38 - 41    :    Hist�rico Padr�o (c�digo do hist�rico no sistema Acol)
	Posi��o 42 - 72    :    Hist�rico Complementar

	3) Registro Total (somente para efeito de valida��o)

	Posi��o 06 - 20    : Total de lan�amentos a d�bito
	Posi��o 21 - 35    : Total de lan�amentos a cr�dito
/*/

/*/
�����������������������������������������������������������������������Ŀ
�Programa  �U_PanCTB05�Autor�Marinaldo de Jesus       � Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Contabilizacao de Arquivo CSV/RM           					�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                                                    �
�����������������������������������������������������������������������Ĵ
�            ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL           �
�����������������������������������������������������������������������Ĵ
�Programador �Data      �Nro. Ocorr.�Motivo da Alteracao                �
�����������������������������������������������������������������������Ĵ
�            �          �           �                                   �
�������������������������������������������������������������������������/*/
User Function PanCTB05()

	Local aArea			:= GetArea()
	Local aAreaCT1		:= CT1->( GetArea() )
	Local aAreaCT2		:= CT2->( GetArea() )
	Local aAreaCT8		:= CT8->( GetArea() )
	Local bProcess		:= { |oProcess| PanCTB05( oProcess , @lError ) }

	Local cPerg			:= "U_PANCTB05"
	Local cDescri		:= OemToAnsi( STR0001 )	//"Este Programa Ir� efetuar a Contabiliza��o da Folha de Pagamento RM conforme Par�metros Selecionados"
	Local cProcess		:= "RMTOCTB"
	
	Local dSvDataBase	:= dDataBase

	Local lError		:= .F.
    
	Local oProcess

	Private aRotina 	:= {;
								{ "" , "" , 0 , 1 },;
								{ "" , "" , 0 , 2 },;
								{ "" , "" , 0 , 3 },;
								{ "" , "" , 0 , 4 };
					   		}

	Private Inclui 		:= .T.							

	Private cCadastro	:= OemtoAnsi( STR0002 )  //"Contabiliza��o de Arquivos Folha de Pagamento RM"

	oProcess			:= tNewProcess():New( cProcess , cCadastro , bProcess , cDescri , cPerg , NIL , NIL , NIL , NIL , .T. , .T. )

	IF ( lError )
		//"Ocorreram Erros Durante o Processo de Contabiliza��o. Retorne a Rotina para Visualizar o LOG de Processo"###
		MsgAlert( STR0026 , "AVISO!!!" )
	EndIF

	dDataBase := dSvDataBase

	RestArea( aAreaCT1 )
	RestArea( aAreaCT2 )
	RestArea( aAreaCT8 )
	RestArea( aArea )

Return( NIL )

/*/
������������������������������������������������������������������������Ŀ
�Fun��o    �PanCTB05      �Autor �Marinaldo de Jesus   � Data �01/12/2009�
������������������������������������������������������������������������Ĵ
�Descri��o �Executar a Contabilizacao da Folha de Pagamento RM           �
������������������������������������������������������������������������Ĵ
�Sintaxe   �U_PanCTB05()												 �
������������������������������������������������������������������������Ĵ
�Parametros�<Vide Parametros Formais>									 �
������������������������������������������������������������������������Ĵ
�Retorno   �uRet                                                 	     �
������������������������������������������������������������������������Ĵ
�Observa��o�                                                      	     �
������������������������������������������������������������������������Ĵ
�Uso       �U_PanCTB05()												 �
��������������������������������������������������������������������������/*/
Static Function PanCTB05( oProcess , lError )

	Local oException

	oProcess:SaveLog( OemToAnsi( STR0003 ) )	//"Inicio da Contabiliza��o"

	TRYEXCEPTION 

		IF !PgsExclusive()
		   UserException( GetHelp( "PGSEXC" ) )
		EndIF

		IF ( FindFunction("CTBSERIALI") )
			While !( CTBSerialI("CTBPROC","ON") )
			End While
		EndIF

		RMToCTB( oProcess , @lError )

		IF ( FindFunction("CTBSERIALF") )
			CTBSerialF("CTBPROC","ON")
		EndIF

	CATCHEXCEPTION USING oException

		lError := .T.
		oProcess:SaveLog( "ERRO: " + OemToAnsi( oException:Description )  )

	ENDEXCEPTION

	PgsShared()

	oProcess:SaveLog( OemToAnsi( STR0004  ) )	//"Final da Contabiliza��o"

Return( NIL  )

/*/
������������������������������������������������������������������������Ŀ
�Fun��o    �RMToCTB		  �Autor �Marinaldo de Jesus   � Data �01/12/2009�
������������������������������������������������������������������������Ĵ
�Descri��o �Executar a Contabilizacao da Folha de Pagamento RM           �
������������������������������������������������������������������������Ĵ
�Sintaxe   �U_PanCTB05()												 �
������������������������������������������������������������������������Ĵ
�Parametros�<Vide Parametros Formais>									 �
������������������������������������������������������������������������Ĵ
�Retorno   �uRet                                                 	     �
������������������������������������������������������������������������Ĵ
�Observa��o�                                                      	     �
������������������������������������������������������������������������Ĵ
�Uso       �U_PanCTB05()												 �
��������������������������������������������������������������������������/*/
Static Function RMToCTB( oProcess , lError )

	Local aDet			:= {}
	Local aFile			:= {}
	Local aDetCab		:= {}
	Local aDetRoda		:= {}
	Local aRMVars		:= {}

	Local cLine			:= ""
	Local cFile			:= MV_PAR03
	Local cTpReg
	Local cLote			:= GpeLotCont( "GPE" , cFilAnt )
	Local cPadrao		:= MV_PAR05
	Local cX2CT2Modo	:= PosAlias( "SX2" , "CT2" , NIL , "X2_MODO" , 1 , .F. )

	Local cCC
	Local cIsFP
	Local cTPDC
	Local cHist
	Local cConta
	Local cValor
	Local cHistPD
	Local cCT1Fil		:= xFilial( "CT1" )
	Local cCT8Fil		:= xFilial( "CT8" )
	Local cCTTFil		:= xFilial( "CTT" )
	Local cOrigem
	Local cHistCom
	Local cFilContab
	Local cDiaContab
	Local cMesContab
	Local cAnoContab

	Local dSvDtBase		:= dDataBase

	Local lHead			:= .F.
	Local lPadrao		:= VerPadrao( cPadrao )
	Local lAglut		:= ( MV_PAR02 == 1 )
	Local lDigita		:= ( MV_PAR01 == 1 )
	Local lQuebra		:= ( MV_PAR04 == 1 )

	Local nVar
	Local nVars
	Local nLoop
	Local nLoops
	Local nTotal
	Local nValor
	Local nHdlPrv
	Local nCT1Order		:= RetOrder( "CT1" , "CT1_FILIAL+CT1_CONTA" )
	Local nCT8Order		:= RetOrder( "CT8" , "CT8_FILIAL+CT8_HIST" )
	Local nCTTOrder		:= RetOrder( "CTT" , "CTT_FILIAL+CTT_CUSTO" )

	Local oException

	TRYEXCEPTION

		IF Empty( cFile )
			UserException( GetHelp("NOFLEIMPOR") + " " + OemToAnsi( STR0005 + cFile + " " + STR0006 )  )	//"Arquivo : "###"N�o Encontrado"
		EndIF
		oProcess:SaveLog( STR0028 + cLote ) //"Contabilizando o Arquivo: "

		IF Empty( cLote )
			UserException( GetHelp("NOCT210LOT") + " " +  OemToAnsi( STR0007 + cLote + STR0008 )  ) //"Lote Cont�bil ("###
		EndIF
		oProcess:SaveLog( STR0028 + cLote ) //"Contabilizando no Lote: "

		IF !( lPadrao )
			UserException( GetHelp("NOLANCPADRAO") + " " +  OemToAnsi( STR0009 + cPadrao + STR0010 )  )  //"Lan�amento Padr�o ("###") Inv�lido"
		EndIF

		aFile	:= u_InPanVld("FileToArr", { cFile } )
		IF ( Empty( aFile ) )
			UserException( OemToAnsi( STR0011 + cFile + STR0012 )  ) //"O arquivo Informado ("###") n�o poss�i conte�do para Contabiliza��o"
		EndIF

		nLoops := Len( aFile )

		oProcess:SetRegua1( nLoops )

		For nLoop := 1 To nLoops

			oProcess:IncRegua1( STR0014 ) //"Obtendo Informa��es para a Contabiliza��o. Aguarde..."
			IF ( oProcess:lEnd )
				UserException( cCancel )
			EndIF

			cLine  := aFile[ nLoop ]
			cTpReg := SubStr( cLine , 1 , 1 ) 
			IF ( cTpReg == "1"  )
				aAdd( aDetCab , cLine )
			ElseIF ( cTpReg == "2"  )
				aAdd( aDet , cLine )
			ElseIF ( cTpReg == "3"  )
				aAdd( aDetRoda , cLine )
			EndIF

		Next nLoop

		aAdd( aRMVars , { "RM_FILIAL"	, "CT2_FILIAL"	, .F. } )
		aAdd( aRMVars , { "RM_TPDC" 	, "CT5_DC"		, .T. } )
		aAdd( aRMVars , { "RM_CREDITO" 	, "CT1_CONTA"	, .T. } )
		aAdd( aRMVars , { "RM_DEBITO" 	, "CT1_CONTA"	, .T. } )
		aAdd( aRMVars , { "RM_VLR01" 	, "CT2_VALOR"	, .T. } )
		aAdd( aRMVars , { "RM_HP"	 	, "CT2_HP"		, .T. } )
		aAdd( aRMVars , { "RM_HIST"	 	, "CT2_HIST"	, .T. } )
		aAdd( aRMVars , { "RM_HIST"	 	, "CT2_HIST"	, .T. } )
		aAdd( aRMVars , { "RM_CCC"	 	, "CTT_CUSTO"	, .T. } )
		aAdd( aRMVars , { "RM_CCD"	 	, "CTT_CUSTO"	, .T. } )
		aAdd( aRMVars , { "RM_ORIGEM" 	, "CT2_ORIGEM"	, .F. } )

		nVars := Len( aRMVars )
		For nVar := 1 To nVars
			SetMemVar( aRMVars[nVar][1]  , GetValType( GetSx3Cache( aRMVars[nVar][2]	, "X3_TIPO" ) , GetSx3Cache( aRMVars[nVar][2] , "X3_TAMANHO" ) ) , .T. )
		Next nVar

        cIsFP		:= SubStr( aDetCab[ 1 ] , 18 , 2 )
        IF !( cIsFP == "FP" )
        	UserException( STR0018 ) //"O arquivo Informado n�o � um Arquivo provenitente da Folha de Pagamento"
        EndIF

		cFilContab	:= SubStr( aDetCab[ 1 ] , 25 , 2 )
		IF (;
				( cX2CT2Modo == "E" );
				.and.;
				!( cFilContab == cFilAnt );
			)
			//"Filial do Arquivo para Contabiliza��o Diferente da Filial Corrente"###"Filial do Arquivo : '"
			UserException( STR0015 + CRLF + CRLF + STR0015 + cFilContab + "'" ) 
		EndIF		

		SetMemVar( "RM_FILIAL" 	, cFilContab )

		cDiaContab	:= SubStr( aDetCab[ 1 ] , 10 , 2 )
		cMesContab  := SubStr( aDetCab[ 1 ] , 12 , 2 )
		cAnoContab  := SubStr( aDetCab[ 1 ] , 14 , 4 )

		dDataBase	:= Ctod(  cDiaContab + "/" + cMesContab + "/" + cAnoContab , "DDMMYYYY" )  
		IF Empty( dDataBase )
			UserException( STR0016 + " " + Dtoc( dDataBase ) ) //"Data Para Contabiliza��o do Arquivo Inv�lida!"  
		EndIF

		oProcess:SetRegua1( nLoops )

		nLoops	:= Len( aDet )
		For nLoop := 1 To nLoops

			oProcess:IncRegua1( STR0019 )	//"Validando as Informa��es do Arquivo. Aguarde..."
			IF ( oProcess:lEnd )
				UserException( cCancel )
			EndIF

			cLine	:= aDet[ nLoop ]
			cHistPD := SubStr( cLine , 38 , 4 )
			IF ( "0" $ SubStr( cHistPD , 1 , 1 ) )
				cHistPD := SubStr( cHistPD , 2 )
			EndIF
			IF !( PosAlias( "CT8" , cHistPD , cCT8Fil , NIL , nCT8Order , .F. ) )
				//UserException( STR0020 + ": " + cHistPD  ) //"C�digo de Hist�rico Padr�o N�o Localizado na Tabela CT8" 
			EndIF
			cConta	:= SubStr( cLine ,  8 , 9 )
			IF !( PosAlias( "CT1" , cConta , cCT1Fil , NIL , nCT1Order , .F. ) )
				UserException( STR0021 ) //"C�digo da Conta Cont�bil N�o Localizado na Tabela CT1" 
			EndIF
			cCC		:= SubStr( cLine , 19 , 4 )
			IF ( "0" $ SubStr( cCC , 1 , 1 ) )
				cCC := SubStr( cCC , 2 )
			EndIF
			IF (;
					( Empty( StrTran( cCC , "0", "" ) ) );
					 .or.;
					 !( PosAlias( "CTT" , cCC , cCTTFil , NIL , nCTTOrder , .F. ) );
				)
				IF ( PosAlias( "CT1" , cConta , cCT1Fil , "CT1_CCOBRG" , nCT1Order , .F. ) == "1" )
					UserException( STR0040 + cConta + STR0041 ) //"Para essa conta ("###")o C�digo de Centro de Custo � de Preenchimento Obrigat�rio" 
				ElseIF !Empty( StrTran( cCC , "0", "" ) )
					UserException( STR0021 + " : " + cCC ) //"C�digo de Centro de Custo N�o Localizado na Tabela CTT" 					
				EndIF
			Else
				IF ( PosAlias( "CT1" , cConta , cCT1Fil , "CT1_ACCUST" , nCT1Order , .F. ) == "2" )
					UserException( STR0024 + ": " + cConta ) //"Esta conta n�o permite a informa��o de Centro de Custo" 
				EndIF	
			EndIF
		Next nLoop

		nTotal	:= 0

		oProcess:SetRegua1( nLoops )

		cOrigem := " "
		cOrigem += "Usuario: "
		cOrigem += AllTrim( UsrRetName( __cUserId ) )
		cOrigem += " "
		cOrigem += "Data: " 
		cOrigem += DtoC(MsDate())
		cOrigem += " "
		cOrigem += "Hora: "
		cOrigem += Time()

		SetMemVar( "RM_ORIGEM" , cOrigem )

		For nLoop := 1 To nLoops

			oProcess:IncRegua1( STR0017 )	//"Efetuando a Contabiliza��o. Aguarde..."
			IF ( oProcess:lEnd )
				UserException( cCancel )
			EndIF

			cLine		:= aDet[ nLoop ]

			cTPDC		:= SubStr( cLine , 37 , 1 )
			SetMemVar( "RM_TPDC" 	, cTPDC )

			cConta		:= SubStr( cLine ,  8 , 9 )
			cCC			:= SubStr( cLine , 19 , 4 )
			IF ( "0" $ SubStr( cCC , 1 , 1 ) )
				cCC := SubStr( cCC , 2 )
			EndIF
			IF Empty( StrTran( cCC , "0", "" ) )
				cCC := GetValType( GetSx3Cache( "CTT_CUSTO"	, "X3_TIPO" ) , GetSx3Cache( "CTT_CUSTO" , "X3_TAMANHO" ) )
			EndIF
			
			cValor		:= SubStr( cLine , 23 , 14 )
			nValor		:= ( Val( cValor ) / 100 )
			cHistPD 	:= SubStr( cLine , 38 , 4 )
			IF ( "0" $ SubStr( cHistPD , 1 , 1 ) )
				cHistPD := SubStr( cHistPD , 2 )
			EndIF
			cHistCom	:= AllTrim( SubStr( cLine , 42 , 30 ) )
			IF !( PosAlias( "CT8" , cHistPD , cCT8Fil , NIL , nCT8Order , .F. ) )
				cHist	:= cHistCom
			Else
				cHist	:= AllTrim( PosAlias( "CT8" , cHistPD , cCT8Fil , "CT8_DESC" , nCT8Order , .F. ) ) + " :: " + cHistCom
			EndIF

			IF ( cTPDC == "D" )
				SetMemVar( "RM_DEBITO" 	, cConta 	)
				SetMemVar( "RM_CCD"		, cCC 		)
				SetMemVar( "RM_VLR01"  	, nValor 	)
			ElseIF ( cTPDC == "C" )
				SetMemVar( "RM_CREDITO" , cConta 	)		
				SetMemVar( "RM_CCC"		, cCC 		)
				SetMemVar( "RM_VLR01"  	, nValor 	)
			Else
				SetMemVar( "RM_DEBITO" 	, cConta 	)				
				SetMemVar( "RM_CREDITO" , cConta 	)		
				SetMemVar( "RM_CCC"		, cCC 		)
				SetMemVar( "RM_CCD"		, cCC 		)
				SetMemVar( "RM_VLR01"  	, nValor	)
			EndIF

			SetMemVar( "RM_HP"		, cHistPD 	)
			SetMemVar( "RM_HIST"	, cHist 	)
			SetMemVar( "RM_HISTAGL" , cHist 	)

			IF !( lHead )
				lHead	:= .T.
				nHdlPrv	:= HeadProva( cLote , FunName() , SubStr( cUsuario , 7 , 6 ) , @cFile )
			EndIF
			nTotal += DetProva( nHdlPrv , cPadrao , FunName() , cLote )
			IF ( lQuebra )	//Cada linha contabilizada sera um documento
				RodaProva( @nHdlPrv , @nTotal )
				cA100Incl( @cFile , @nHdlPrv , 3 , @cLote , @lDigita , @lAglut )
				lHead	:= .F.
			EndIF

			For nVar := 1 To nVars
				IF ( aRMVars[nVar][3] )
					SetMemVar( aRMVars[nVar][1] , GetValType( GetSx3Cache( aRMVars[nVar][2] , "X3_TIPO" ) , GetSx3Cache( aRMVars[nVar][2] , "X3_TAMANHO" ) ) )
				EndIF	
			Next nVar

		Next nLoop

		IF ( lHead )
			RodaProva( @nHdlPrv , @nTotal )
			cA100Incl( @cFile , @nHdlPrv , 3 , @cLote , @lDigita , @lAglut )
		EndIF
		
		oProcess:SaveLog( STR0029 +  cFile )	//"Arquivo Contabilizado: "

		/*/
		��������������������������������������������������������������Ŀ
		� Move o arquivo contabilizado para a pasta de "backup"		   �
		����������������������������������������������������������������/*/
		BackupFile( oProcess , cFile , FilePath( cFile ) , FileNoPath( cFile ) )

	CATCHEXCEPTION USING oException

		lError := .T.
		oProcess:SaveLog( "ERRO: " + OemToAnsi( oException:Description )  )

	ENDEXCEPTION

	dDataBase := dSvDtBase

Return( NIL )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �BackupFile	  �Autor�Marinaldo de Jesus   � Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Mover o Arquivo contabilizado para a pasta \back            �
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �U_PanCTB05                     								�
�������������������������������������������������������������������������/*/
Static Function BackupFile( oProcess , cPathFile , cPath , cFile )

	Local cNewPath
	Local cNewPathFile
	
	Begin Sequence

		/*/
		��������������������������������������������������������������Ŀ
		� Define o "Path" para "Backup" das imagens					   �
		����������������������������������������������������������������/*/
		cNewPath := ( cPath + "back_ctb_rm\" )
	
		/*/
		��������������������������������������������������������������Ŀ
		� Verifica se o "Path" para "Backup" existe e, se nao  existir,�
		� cria-o													   �
		����������������������������������������������������������������/*/
		IF !( MyMakeDir( cNewPath ) )
			oProcess:SaveLog( OemToAnsi( STR0022 + " " + cNewPath )  ) //"N�o Foi Poss�vel Criar o Diret�rio para Backup do Arquivo Processado"
			Break
		EndIF
	
		/*/
		��������������������������������������������������������������Ŀ
		� Define o novo "Path" e nome do arquivo. 					   �
		����������������������������������������������������������������/*/
		cNewPathFile := ( cNewPath + cFile )
	
		/*/
		��������������������������������������������������������������Ŀ
		� Move o arquivo para o "Path" de "Backup"					   �
		����������������������������������������������������������������/*/
		IF MoveFile( cPathFile , cNewPathFile )
			oProcess:SaveLog( OemToAnsi( STR0005 + cPathFile + STR0013 + cNewPathFile  )  ) //"Arquivo: "###"Contabilizado e Salvo como: "
		Else
			oProcess:SaveLog( STR0023 + ": " + cNewPathFile ) //"N�o foi poss�vel Salvar o arquivo Contabilizado"
		EndIF
	
	End Sequence

Return( NIL )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �MyMakeDir     �Autor�Marinaldo de Jesus   � Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Cria um Diretorio                                           �
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                      								�
�������������������������������������������������������������������������/*/
Static Function MyMakeDir( cMakeDir , nTimes , nSleep )

	Local lMakeOk
	Local nMakeOk
	
	IF !( lMakeOk := lIsDir( cMakeDir ) )
		MakeDir( cMakeDir )
		nMakeOk			:= 0
		DEFAULT nTimes	:= 10
		DEFAULT nSleep	:= 1000
		While (;
				!( lMakeOk := lIsDir( cMakeDir ) );
				.and.;
				( ++nMakeOk <= nTimes );
		   )
			Sleep( nSleep )
			MakeDir( cMakeDir )
		End While
	EndIF

Return( lMakeOk )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �MoveFile      �Autor�Marinaldo de Jesus   � Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Mover um arquivo de Diretorio                               �
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                      								�
�������������������������������������������������������������������������/*/
Static Function MoveFile( cOldPathFile , cNewPathFile , lErase , nFullPath , lEqualFile )

	Local lMoveFile
	
	Begin Sequence
	
		DEFAULT lEqualFile := .F.
		IF !(;
				lMoveFile := (;
								( __CopyFile( cOldPathFile , cNewPathFile , nFullPath ) );
								.and.;
								File( cNewPathFile , nFullPath );
								.and.;
								IF( lEqualFile , EqualFile( cOldPathFile , cNewPathFile , nFullPath ) , .T. );
							 );
			)
			Break
		EndIF
	
		DEFAULT lErase := .T.
		IF ( lErase )
			FileErase( cOldPathFile )
		EndIF	
	
	End Sequence

Return( lMoveFile )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �FilePath	  �Autor�Marinaldo de Jesus   � Data �10/06/2005�
�����������������������������������������������������������������������Ĵ
�Descri��o �Obtem o Path do arquivo      								�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                      								�
�������������������������������������������������������������������������/*/
Static Function FilePath( cFile )

	Local cFilePath
	Local nPos
	
	IF ( ( nPos := rAt( "\" , cFile ) ) != 0 )
		cFilePath := SubStr( cFile , 1 , nPos )
	Else
		cFilePath := ""
	EndIF

Return( cFilePath )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �FileNoPath    �Autor�Marinaldo de Jesus   � Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Extrai o arquivo             								�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                      								�
�������������������������������������������������������������������������/*/
Static Function FileNoPath( cPathFile )
Return( RetFileName( @cPathFile ) )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �RetFileName   �Autor�Marinaldo de Jesus   � Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna o Nome do Arquivo sem a Extensao e sem o Path		�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                      								�
�������������������������������������������������������������������������/*/
Static Function RetFileName( cFile )
	Local n  := rAt( "." , cFile )
	Local nI := rAt("\",cFile)
Return( SubStr( cFile , IF( nI > 0 , nI + 1 , 1 ) ,IF( n > 0 , n-1 , Len( cFile ) - nI ) ) )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �FileErase		 �Autor�Marinaldo de Jesus� Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Exclui Arquivo e Retorna nErr por Referencia				�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<Vide Parametros Formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<Vide Parametros Formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                     								�
�������������������������������������������������������������������������/*/
Static Function FileErase( cFile , nErr )

	Local lEraseOk := .F.
	
	Local nEraseOk
	
	IF ( lEraseOk	:= File( cFile ) )
		fErase( cFile )
		nEraseOk := 0
		While (;
					( ( nErr := fError() ) <> 0 );
					.and.;
					( ++nEraseOk <= 50 );
				)
			Sleep( 1000 )
			IF ( fErase( cFile ) <> -1 )
				Exit
			EndIF
		End While
		lEraseOk	:= !( File( cFile ) )
	EndIF

Return( lEraseOk )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �EqualFile     �Autor�Marinaldo de Jesus   � Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Verifica se Dois Arquivos sao Iguais                        �
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                      								�
�������������������������������������������������������������������������/*/
Static Function EqualFile( cFile1 , cFile2 , nFullPath )

	Local lIsEqualFile	:= .F.

	Local nfhFile1	:= fOpen( cFile1 , NIL , nFullPath )
	Local nfhFile2	:= fOpen( cFile2 , NIL , nFullPath )

	Begin Sequence

		IF (;
				( nfhFile1 <= 0 );
				.or.;
				( nfhFile2 <= 0 );
			)
			Break
		EndIF

		lIsEqualFile := ArrayCompare( GetAllTxtFile( nfhFile1 ) , GetAllTxtFile( nfhFile2 ) )

		fClose( nfhFile1 )
		fClose( nfhFile2 )

	End Sequence

Return( lIsEqualFile )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �GpeLotCont    �Autor�Marinaldo de Jesus   � Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna o Lote Cont�bil para o GPE							�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                      								�
�������������������������������������������������������������������������/*/
Static Function GpeLotCont( cChave , cFil )
	
	Local aArea		:= GetArea()
	Local aAreaSX5	:= SX5->( GetArea() ) 	
	Local cLote
	
	Local nSX5Order := RetOrder( "SX5" , "X5_FILIAL+X5_TABELA+X5_CHAVE" )
	
	DEFAULT cChave	:= "GPE"
	DEFAULT cFil	:= cFilAnt
	
	IF CtbInUse()
		cLote := fDesc( "SX5" , "09" + AllTrim( cChave ) , "X5Descri()" , 6 , cFil , nSX5Order )
	Else
		cLote := fDesc( "SX5" , "09" + AllTrim( cChave ) , "X5Descri()" , 4 , cFil , nSX5Order )
	EndIF
	
	RestArea( aAreaSX5 )
	RestArea( aArea )

Return( cLote )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �GetHelp       �Autor�Marinaldo de Jesus   � Data �01/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna a Descri��o do Help       							�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico                      								�
�������������������������������������������������������������������������/*/
Static Function GetHelp( cHelp )
Return( StrTran( Ap5GetHelp(cHelp) , CRLF , " " ) )

/*/
������������������������������������������������������������������������Ŀ
�Fun��o    �U_InRm2Ctb    �Autor �Marinaldo de Jesus   � Data �02/12/2009�
������������������������������������������������������������������������Ĵ
�Descri��o �Executar Funcoes Dentro de U_PANCTB05						 �
������������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( cExecIn , aFormParam )						 	 �
������������������������������������������������������������������������Ĵ
�Parametros�<Vide Parametros Formais>									 �
������������������������������������������������������������������������Ĵ
�Retorno   �uRet                                                 	     �
������������������������������������������������������������������������Ĵ
�Observa��o�                                                      	     �
������������������������������������������������������������������������Ĵ
�Uso       �Generico 													 �
��������������������������������������������������������������������������/*/
User Function InRm2Ctb( cExecIn , aFormParam )
         
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
�Fun��o    �CT5Vlr01Cre   �Autor�Marinaldo de Jesus   � Data �02/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna Valor de Credito para o Lancamento Padrao			�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( "CT5Vlr01Cre" )						 		    �
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Lancamento Padrao para Contabilizacao da Folha RM			�
�������������������������������������������������������������������������/*/
Static Function CT5Vlr01Cre()
	
	Local nValor	:= 0

	IF (;
			( IsMemVar("RM_VLR01") ) ;
			.and.;
			( IsMemVar("RM_TPDC") ) ;
			.and.;
			( GetMemVar("RM_TPDC") == "C" ) ;
		)	
		nValor := GetMemVar("RM_VLR01")
	EndIF	

Return( nValor  )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �CT5Vlr01Deb   �Autor�Marinaldo de Jesus   � Data �02/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna Valor de Debito para o Lancamento Padrao			�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( "CT5Vlr01Deb" )						 		    �
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Lancamento Padrao para Contabilizacao da Folha RM			�
�������������������������������������������������������������������������/*/
Static Function CT5Vlr01Deb()
	
	Local nValor	:= 0

	IF (;
			( IsMemVar("RM_VLR01") ) ;
			.and.;
			( IsMemVar("RM_TPDC") ) ;
			.and.;
			( GetMemVar("RM_TPDC") == "D" ) ;
		)	
		nValor := GetMemVar("RM_VLR01")
	EndIF	

Return( nValor  )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �CT5Credito    �Autor�Marinaldo de Jesus   � Data �02/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna a Conta de Credito para o Lancamento Padrao			�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( "CT5Credito" )						 		    �
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Lancamento Padrao para Contabilizacao da Folha RM			�
�������������������������������������������������������������������������/*/
Static Function CT5Credito()

	Local cCta := 	""
	
	IF (;
			( IsMemVar("RM_CREDITO") ) ;
			.and.;
			( IsMemVar("RM_TPDC") ) ;
			.and.;
			( GetMemVar("RM_TPDC") == "C" ) ;
		)	
		cCta := GetMemVar("RM_CREDITO")
	EndIF	

Return( cCta  )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �CT5Debito     �Autor�Marinaldo de Jesus   � Data �02/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna a Conta de Credito para o Lancamento Padrao			�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( "CT5Debito" )						 		    �
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Lancamento Padrao para Contabilizacao da Folha RM			�
�������������������������������������������������������������������������/*/
Static Function CT5Debito()

	Local cCta := 	""
	
	IF (;
			( IsMemVar("RM_DEBITO") ) ;
			.and.;
			( IsMemVar("RM_TPDC") ) ;
			.and.;
			( GetMemVar("RM_TPDC") == "D" ) ;
		)	
		cCta := GetMemVar("RM_DEBITO")
	EndIF	

Return( cCta  )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �CT5CCC        �Autor�Marinaldo de Jesus   � Data �02/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna o Centro de Custo Credito para o Lancamento Padrao	�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( "CT5CCC" )							 		    �
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Lancamento Padrao para Contabilizacao da Folha RM			�
�������������������������������������������������������������������������/*/
Static Function CT5CCC()
	
	Local cCC := ""

	IF (;
			( IsMemVar("RM_CCC") ) ;
			.and.;
			( IsMemVar("RM_TPDC") ) ;
			.and.;
			( GetMemVar("RM_TPDC") == "C" ) ;
		)	
		cCC := GetMemVar("RM_CCC")
	EndIF	

Return( cCc  )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �CT5CCD        �Autor�Marinaldo de Jesus   � Data �02/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna o Centro de Custo Debito para o Lancamento Padrao	�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( "CT5CCD" )							 		    �
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Lancamento Padrao para Contabilizacao da Folha RM			�
�������������������������������������������������������������������������/*/
Static Function CT5CCD()

	Local cCC := ""

	IF (;
			( IsMemVar("RM_CCD") ) ;
			.and.;
			( IsMemVar("RM_TPDC") ) ;
			.and.;
			( GetMemVar("RM_TPDC") == "D" ) ;
		)	
		cCC := GetMemVar("RM_CCD")
	EndIF	

Return( cCc  )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �CT5Hist       �Autor�Marinaldo de Jesus   � Data �02/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna Historico para o Lancamento Padrao					�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( "CT5Hist" )							 		    �
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Lancamento Padrao para Contabilizacao da Folha RM			�
�������������������������������������������������������������������������/*/
Static Function CT5Hist()
	Local cHist := IF(IsMemVar("RM_HIST"),GetMemVar("RM_HIST"),"")
Return( cHist )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �CTGHistAgl    �Autor�Marinaldo de Jesus   � Data �02/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna Historico Aglutinado para o Lancamento Padrao		�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( "CTGHistAgl" )							 		�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Lancamento Padrao para Contabilizacao da Folha RM			�
�������������������������������������������������������������������������/*/
Static Function CTGHistAgl()
	Local cHAglu := IF(IsMemVar("RM_HISTAGL"),GetMemVar("RM_HISTAGL"),"")
Return( cHAglu )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �CT5Origem     �Autor�Marinaldo de Jesus   � Data �02/12/2009�
�����������������������������������������������������������������������Ĵ
�Descri��o �Retorna a Origem do Lancamento para o Lancamento Padrao		�
�����������������������������������������������������������������������Ĵ
�Sintaxe   �U_InRm2Ctb( "CT5Origem" )							 		�
�����������������������������������������������������������������������Ĵ
�Parametros�<vide parametros formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Lancamento Padrao para Contabilizacao da Folha RM			�
�������������������������������������������������������������������������/*/
Static Function CT5Origem()
	Local cOrigem := IF(IsMemVar("RM_ORIGEM"),GetMemVar("RM_ORIGEM"),"")
Return( cOrigem )

Static Function __Dummy( lRecursa )
	Local oException
	TRYEXCEPTION
        lRecursa := .F.
		IF !( lRecursa )
			BREAK
		EndIF
    	lRecursa	:= __Dummy( .F. )
		CT5CCC()
	    CT5CCD()
	    CT5CREDITO()
	    CT5DEBITO()
	    CT5HIST()
	    CT5ORIGEM()
	    CT5VLR01CRE()
	    CT5VLR01DEB()
	    CTGHISTAGL()
	CATCHEXCEPTION USING oException
	ENDEXCEPTION
Return( lRecursa )